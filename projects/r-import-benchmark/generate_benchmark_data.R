# Generate 1GB Dummy Dataset for CSV Reading Benchmarks
# Author: OpenCode
# Date: 2025-11-19

library(data.table)
library(arrow)
library(qs)

# Function to estimate file size in memory
estimate_size_mb <- function(n_rows, n_cols_numeric = 5, n_cols_character = 3, avg_char_length = 10) {
  # Rough estimate: numeric = 8 bytes, character = avg_char_length bytes
  numeric_size <- n_rows * n_cols_numeric * 8
  character_size <- n_rows * n_cols_character * avg_char_length
  total_bytes <- numeric_size + character_size
  total_mb <- total_bytes / (1024 * 1024)
  return(total_mb)
}

# Target approximately 1GB when saved as CSV
# Estimate rows needed for ~1GB file size
target_size_mb <- 1024  # 1GB
n_cols_numeric <- 8
n_cols_character <- 4
avg_char_length <- 15

# Estimate rows needed (this is approximate due to CSV overhead)
estimated_rows <- round(target_size_mb * 1024 * 1024 / (n_cols_numeric * 8 + n_cols_character * avg_char_length))
n_rows <- estimated_rows

cat("Generating dataset with", n_rows, "rows...\n")
cat("Estimated size:", estimate_size_mb(n_rows, n_cols_numeric, n_cols_character, avg_char_length), "MB\n")

# Generate realistic dummy data
set.seed(42)  # For reproducibility

# Create a large data.table
dummy_data <- data.table(
  id = 1:n_rows,
  timestamp = as.POSIXct("2020-01-01") + sample(0:(365*24*3600), n_rows, replace = TRUE),
  category = sample(c("A", "B", "C", "D", "E"), n_rows, replace = TRUE, prob = c(0.3, 0.25, 0.2, 0.15, 0.1)),
  region = sample(c("North", "South", "East", "West", "Central"), n_rows, replace = TRUE),
  product_name = paste0("Product_", sample(1:1000, n_rows, replace = TRUE)),
  value1 = round(rnorm(n_rows, mean = 100, sd = 25), 2),
  value2 = round(runif(n_rows, min = 0, max = 1000), 2),
  value3 = round(rexp(n_rows, rate = 0.1), 2),
  value4 = round(rlnorm(n_rows, meanlog = 4, sdlog = 1), 2),
  value5 = round(rbeta(n_rows, shape1 = 2, shape2 = 5) * 100, 2),
  value6 = round(rgamma(n_rows, shape = 2, rate = 0.1), 2),
  flag1 = sample(c(TRUE, FALSE), n_rows, replace = TRUE, prob = c(0.3, 0.7)),
  flag2 = sample(c(TRUE, FALSE), n_rows, replace = TRUE, prob = c(0.6, 0.4))
)

cat("Data generation complete. Dataset shape:", nrow(dummy_data), "x", ncol(dummy_data), "\n")

# Save in various formats
cat("Saving data in multiple formats...\n")

# CSV format
cat("Writing CSV file...\n")
start_time <- Sys.time()
fwrite(dummy_data, "data/benchmark_data.csv")
csv_time <- as.numeric(Sys.time() - start_time)
csv_size <- file.size("data/benchmark_data.csv") / (1024^3)  # Size in GB
cat("CSV written in", round(csv_time, 2), "seconds. File size:", round(csv_size, 3), "GB\n")

# Compressed CSV
cat("Writing compressed CSV file...\n")
start_time <- Sys.time()
fwrite(dummy_data, "data/benchmark_data.csv.gz")
csvgz_time <- as.numeric(Sys.time() - start_time)
csvgz_size <- file.size("data/benchmark_data.csv.gz") / (1024^3)  # Size in GB
cat("CSV.GZ written in", round(csvgz_time, 2), "seconds. File size:", round(csvgz_size, 3), "GB\n")

# Parquet format (using Arrow)
cat("Writing Parquet file...\n")
start_time <- Sys.time()
write_parquet(dummy_data, "data/benchmark_data.parquet")
parquet_time <- as.numeric(Sys.time() - start_time)
parquet_size <- file.size("data/benchmark_data.parquet") / (1024^3)  # Size in GB
cat("Parquet written in", round(parquet_time, 2), "seconds. File size:", round(parquet_size, 3), "GB\n")

# QS format (fast serialization)
cat("Writing QS file...\n")
start_time <- Sys.time()
qsave(dummy_data, "benchmark_data.qs")
qs_time <- as.numeric(Sys.time() - start_time)
qs_size <- file.size("benchmark_data.qs") / (1024^3)  # Size in GB
cat("QS written in", round(qs_time, 2), "seconds. File size:", round(qs_size, 3), "GB\n")

# Create summary
file_summary <- data.table(
  format = c("CSV", "CSV.GZ", "Parquet", "QS"),
  write_time_sec = round(c(csv_time, csvgz_time, parquet_time, qs_time), 2),
  file_size_gb = round(c(csv_size, csvgz_size, parquet_size, qs_size), 3),
  compression_ratio = round(c(csv_size, csvgz_size, parquet_size, qs_size) / csv_size, 3)
)

print(file_summary)

# Save summary
fwrite(file_summary, "file_generation_summary.csv")

cat("\nData generation complete! Files ready for benchmarking:\n")
cat("- benchmark_data.csv\n")
cat("- benchmark_data.csv.gz\n") 
cat("- benchmark_data.parquet\n")
cat("- benchmark_data.qs\n")
cat("- file_generation_summary.csv\n")