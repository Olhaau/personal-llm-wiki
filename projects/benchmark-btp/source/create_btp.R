# create_btp.R
# Generate synthetic BTP data with configurable observations in multiple formats
# ----

# PARAMETERS ----
obs <- 100000  # Number of observations to generate

# Load required packages ----
suppressPackageStartupMessages({
  library(here)
  library(data.table)
  library(arrow)
})

# Set project root using here package ----
cat(sprintf("Project root: %s\n", here()))

# Source the synthetic BTP generator ----
source(here("source", "00_gen_synth_btp", "synth_btp.R"))

# Generate synthetic BTP data ----
cat(sprintf("Generating synthetic BTP data with %d observations...\n", obs))
btp_data_full <- synth_btp(
  obs = obs,
  years = 2013:2019,
  select = "all",
  balanced = TRUE,
  seed = 42
)

# Keep only 10 variables ----
# Select core variables: id, jahr, ags, and 7 numeric variables from different sources
selected_vars <- c(
  "id",                      # Panel identifier
  "jahr",                    # Year
  "ags",                     # Municipality code
  "verk",                    # Linkage variable
  "urs_we_umsatz",          # Turnover (enterprise register)
  "urs_we_tp_stichtag",     # Active persons (enterprise register)
  "g_k2110",                 # Gewerbesteuer variable
  "k_c13110",                # Körperschaftsteuer variable
  "v_ef48",                  # VAT variable
  "e_c25100"                 # Einnahmenüberschussrechnung variable
)

# Filter to selected variables (only keep those that exist)
vars_exist <- selected_vars[selected_vars %in% names(btp_data_full)]
btp_data <- btp_data_full[, vars_exist, drop = FALSE]

cat(sprintf("Kept %d variables from original %d variables\n", 
            ncol(btp_data), 
            ncol(btp_data_full)))

# Create output directory ----
# Ensure data/ directory exists
data_dir <- here("data")
if (!dir.exists(data_dir)) {
  dir.create(data_dir)
  cat("Created directory: data\n")
}

# Create subdirectory for this obs count
output_dir <- here("data", sprintf("btp_obs%d", obs))
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat(sprintf("Created directory: %s\n", output_dir))
}

# 1. Save as CSV ----
cat("\n1. Saving as CSV...\n")
csv_file <- here("data", sprintf("btp_obs%d", obs), "data.csv")
write.csv(btp_data, csv_file, row.names = FALSE)
cat(sprintf("   Saved: %s (%.2f MB)\n", 
            csv_file, 
            file.size(csv_file) / (1024^2)))

# 2. Save as CSV.GZ (compressed CSV) ----
cat("\n2. Saving as CSV.GZ...\n")
csvgz_file <- here("data", sprintf("btp_obs%d", obs), "data.csv.gz")
gz_con <- gzfile(csvgz_file, "w")
write.csv(btp_data, gz_con, row.names = FALSE)
close(gz_con)
cat(sprintf("   Saved: %s (%.2f MB)\n", 
            csvgz_file, 
            file.size(csvgz_file) / (1024^2)))

# 3. Save as single Parquet file ----
cat("\n3. Saving as single Parquet file...\n")
parquet_file <- here("data", sprintf("btp_obs%d", obs), "data.parquet")
write_parquet(btp_data, parquet_file)
cat(sprintf("   Saved: %s (%.2f MB)\n", 
            parquet_file, 
            file.size(parquet_file) / (1024^2)))

# 4. Save as Parquet partitioned by year (parquet_nach_jahr) ----
cat("\n4. Saving as Parquet partitioned by year...\n")
parquet_jahr_dir <- here("data", sprintf("btp_obs%d", obs), "parquet_nach_jahr")
if (dir.exists(parquet_jahr_dir)) {
  unlink(parquet_jahr_dir, recursive = TRUE)
}
write_dataset(
  btp_data,
  parquet_jahr_dir,
  format = "parquet",
  partitioning = "jahr"
)
# Calculate total size of partitioned directory
jahr_size <- sum(file.size(list.files(parquet_jahr_dir, recursive = TRUE, full.names = TRUE)))
cat(sprintf("   Saved: %s (%.2f MB, %d partitions)\n", 
            parquet_jahr_dir, 
            jahr_size / (1024^2),
            length(unique(btp_data$jahr))))

# 5. Save as equally partitioned Parquet (parquet_gleich_aufgeteilt) ----
cat("\n5. Saving as equally partitioned Parquet...\n")
parquet_gleich_dir <- here("data", sprintf("btp_obs%d", obs), "parquet_gleich_aufgeteilt")
if (dir.exists(parquet_gleich_dir)) {
  unlink(parquet_gleich_dir, recursive = TRUE)
}

# Create equal partitions based on row groups
# Adjust number of partitions based on number of observations
n_partitions <- max(2, min(4, floor(nrow(btp_data) / 20)))
btp_dt <- as.data.table(btp_data)
btp_dt[, partition_id := cut(
  1:.N, 
  breaks = n_partitions, 
  labels = FALSE
)]

write_dataset(
  btp_dt,
  parquet_gleich_dir,
  format = "parquet",
  partitioning = "partition_id"
)

# Remove partition_id from data
btp_dt[, partition_id := NULL]

# Calculate total size of equally partitioned directory
gleich_size <- sum(file.size(list.files(parquet_gleich_dir, recursive = TRUE, full.names = TRUE)))
cat(sprintf("   Saved: %s (%.2f MB, %d partitions)\n", 
            parquet_gleich_dir, 
            gleich_size / (1024^2),
            n_partitions))

# Summary ----
cat("\n=== Summary ===\n")
cat(sprintf("Dataset: %d observations, %d rows, %d variables\n",
            length(unique(btp_data$id)),
            nrow(btp_data),
            ncol(btp_data)))
cat(sprintf("Output directory: %s\n", output_dir))
cat("\nFile formats created:\n")
cat(sprintf("  1. CSV:                      %s\n", basename(csv_file)))
cat(sprintf("  2. CSV.GZ:                   %s\n", basename(csvgz_file)))
cat(sprintf("  3. Parquet (single):         %s\n", basename(parquet_file)))
cat(sprintf("  4. Parquet (by year):        %s/\n", basename(parquet_jahr_dir)))
cat(sprintf("  5. Parquet (equal parts):    %s/\n", basename(parquet_gleich_dir)))
cat(sprintf("\nVariables included: %s\n", paste(names(btp_data), collapse = ", ")))
cat("\nAll files saved successfully!\n")
