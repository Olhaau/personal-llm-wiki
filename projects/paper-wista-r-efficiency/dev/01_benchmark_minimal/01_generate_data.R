#!/usr/bin/env Rscript
# Generate synthetic BTP data in multiple formats for benchmarking ----

# Configuration ----
N_ROWS <- 1e6  # Target 1 million rows
N_UNITS <- 150000  # Number of unique firms (will generate ~1M rows with unbalanced panel)
SEED <- 42
OUTPUT_DIR <- "data"
N_PARTITIONS <- 10  # Number of partitions for multi-parquet

# Load required packages ----
suppressPackageStartupMessages({
  library(data.table)
  library(arrow)
  library(fs)
})

# Source synth_btp function ----
synth_btp_path <- "../experiment/00_gen_btp/synth_btp.R"
if (!file.exists(synth_btp_path)) {
  stop("synth_btp.R not found at: ", synth_btp_path)
}
source(synth_btp_path)

# Check if btp_variables.json exists ----
json_path <- "../experiment/00_gen_btp/btp_variables.json"
dist_path <- "../experiment/00_gen_btp/btp_obs_distribution.csv"

if (!file.exists(json_path)) {
  stop("btp_variables.json not found at: ", json_path)
}
if (!file.exists(dist_path)) {
  warning("btp_obs_distribution.csv not found at: ", dist_path, 
          " - will use fallback probabilities")
}

# Set working directory to find JSON files ----
old_wd <- getwd()
setwd("../experiment/00_gen_btp")

# Generate data ----
cat("\n========================================\n")
cat("Generating Synthetic BTP Data\n")
cat("========================================\n")
cat(sprintf("Target rows: %s\n", format(N_ROWS, big.mark = ",")))
cat(sprintf("Number of units: %s\n", format(N_UNITS, big.mark = ",")))
cat(sprintf("Seed: %d\n", SEED))
cat(sprintf("Statistics: all\n"))
cat(sprintf("Panel type: unbalanced\n\n"))

start_time <- Sys.time()

# Generate data with all statistics
btp_data <- synth_btp(
  obs = N_UNITS,
  years = 2013:2019,
  select = "all",
  balanced = FALSE,
  seed = SEED
)

gen_time <- Sys.time() - start_time

cat(sprintf("\nGeneration completed in %.2f seconds\n", 
            as.numeric(gen_time, units = "secs")))
cat(sprintf("Actual rows: %s\n", format(nrow(btp_data), big.mark = ",")))
cat(sprintf("Columns: %d\n\n", ncol(btp_data)))

# Restore working directory ----
setwd(old_wd)

# Ensure output directory exists ----
if (!dir.exists(OUTPUT_DIR)) {
  dir.create(OUTPUT_DIR, recursive = TRUE)
}

# Convert to data.table for efficient operations ----
dt <- as.data.table(btp_data)

# Save in different formats ----
cat("\n========================================\n")
cat("Saving Data in Multiple Formats\n")
cat("========================================\n\n")

# 1. CSV (uncompressed) ----
cat("1. Saving as CSV (uncompressed)...\n")
csv_path <- file.path(OUTPUT_DIR, "btp_synth.csv")
t1 <- Sys.time()
fwrite(dt, csv_path)
t2 <- Sys.time()
csv_size <- as.numeric(file_size(csv_path))
csv_time <- as.numeric(difftime(t2, t1, units = "secs"))
cat(sprintf("   Saved: %s (%.1f MB) in %.2f seconds\n\n", 
            csv_path, csv_size / 1e6, csv_time))

# 2. CSV.GZ (compressed) ----
cat("2. Saving as CSV.GZ (gzip compressed)...\n")
csvgz_path <- file.path(OUTPUT_DIR, "btp_synth.csv.gz")
t1 <- Sys.time()
fwrite(dt, csvgz_path, compress = "auto")
t2 <- Sys.time()
csvgz_size <- as.numeric(file_size(csvgz_path))
csvgz_time <- as.numeric(difftime(t2, t1, units = "secs"))
cat(sprintf("   Saved: %s (%.1f MB) in %.2f seconds\n", 
            csvgz_path, csvgz_size / 1e6, csvgz_time))
cat(sprintf("   Compression ratio: %.1f%%\n\n", 
            (1 - csvgz_size / csv_size) * 100))

# 3. Parquet (single file) ----
cat("3. Saving as Parquet (single file)...\n")
parquet_path <- file.path(OUTPUT_DIR, "btp_synth.parquet")
t1 <- Sys.time()
write_parquet(dt, parquet_path, compression = "snappy")
t2 <- Sys.time()
parquet_size <- as.numeric(file_size(parquet_path))
parquet_time <- as.numeric(difftime(t2, t1, units = "secs"))
cat(sprintf("   Saved: %s (%.1f MB) in %.2f seconds\n", 
            parquet_path, parquet_size / 1e6, parquet_time))
cat(sprintf("   Compression ratio: %.1f%%\n\n", 
            (1 - parquet_size / csv_size) * 100))

# 4. Partitioned Parquet (multiple files by year) ----
cat("4. Saving as Partitioned Parquet (by year)...\n")
parquet_part_dir <- file.path(OUTPUT_DIR, "btp_synth_partitioned")
if (dir.exists(parquet_part_dir)) {
  unlink(parquet_part_dir, recursive = TRUE)
}
t1 <- Sys.time()
write_dataset(
  dt, 
  parquet_part_dir,
  format = "parquet",
  partitioning = "jahr",
  compression = "snappy"
)
t2 <- Sys.time()
# Calculate total size of partitioned directory
parquet_part_size <- as.numeric(dir_info(parquet_part_dir, recurse = TRUE)$size |> sum())
parquet_part_files <- dir_ls(parquet_part_dir, recurse = TRUE, type = "file")
parquet_part_time <- as.numeric(difftime(t2, t1, units = "secs"))
cat(sprintf("   Saved: %s/ (%d partitions, %.1f MB) in %.2f seconds\n", 
            parquet_part_dir, length(parquet_part_files), 
            parquet_part_size / 1e6, parquet_part_time))
cat(sprintf("   Compression ratio: %.1f%%\n\n", 
            (1 - parquet_part_size / csv_size) * 100))

# 5. Partitioned Parquet (hash-based, N partitions) ----
cat(sprintf("5. Saving as Partitioned Parquet (hash-based, %d partitions)...\n", N_PARTITIONS))
parquet_hash_dir <- file.path(OUTPUT_DIR, "btp_synth_hash_partitioned")
if (dir.exists(parquet_hash_dir)) {
  unlink(parquet_hash_dir, recursive = TRUE)
}
dir.create(parquet_hash_dir, recursive = TRUE)

t1 <- Sys.time()
# Add partition column based on hash of id
dt[, partition := id %% N_PARTITIONS]

# Write each partition
for (p in 0:(N_PARTITIONS - 1)) {
  partition_path <- file.path(parquet_hash_dir, sprintf("partition_%02d.parquet", p))
  write_parquet(dt[partition == p], partition_path, compression = "snappy")
}

# Remove temporary partition column
dt[, partition := NULL]

t2 <- Sys.time()
# Calculate total size
parquet_hash_size <- as.numeric(dir_info(parquet_hash_dir, recurse = TRUE)$size |> sum())
parquet_hash_files <- dir_ls(parquet_hash_dir, recurse = TRUE, type = "file")
parquet_hash_time <- as.numeric(difftime(t2, t1, units = "secs"))
cat(sprintf("   Saved: %s/ (%d partitions, %.1f MB) in %.2f seconds\n", 
            parquet_hash_dir, length(parquet_hash_files), 
            parquet_hash_size / 1e6, parquet_hash_time))
cat(sprintf("   Compression ratio: %.1f%%\n\n", 
            (1 - parquet_hash_size / csv_size) * 100))

# Summary table ----
cat("\n========================================\n")
cat("Summary\n")
cat("========================================\n\n")

summary_df <- data.frame(
  Format = c("CSV", "CSV.GZ", "Parquet", "Parquet (year-partitioned)", 
             sprintf("Parquet (hash-%d-partitioned)", N_PARTITIONS)),
  Size_MB = c(csv_size, csvgz_size, parquet_size, parquet_part_size, parquet_hash_size) / 1e6,
  Time_Sec = c(csv_time, csvgz_time, parquet_time, parquet_part_time, parquet_hash_time),
  Compression_Pct = c(0, (1 - csvgz_size / csv_size) * 100, 
                      (1 - parquet_size / csv_size) * 100,
                      (1 - parquet_part_size / csv_size) * 100,
                      (1 - parquet_hash_size / csv_size) * 100)
)

print(summary_df, row.names = FALSE)

cat("\n========================================\n")
cat("Data Generation Complete!\n")
cat("========================================\n")
cat(sprintf("\nOutput directory: %s\n", normalizePath(OUTPUT_DIR)))
cat(sprintf("Total rows: %s\n", format(nrow(dt), big.mark = ",")))
cat(sprintf("Total columns: %d\n", ncol(dt)))
cat(sprintf("Total generation time: %.2f seconds\n", 
            as.numeric(gen_time, units = "secs")))
cat(sprintf("Total export time: %.2f seconds\n\n",
            csv_time + csvgz_time + parquet_time + parquet_part_time + parquet_hash_time))
