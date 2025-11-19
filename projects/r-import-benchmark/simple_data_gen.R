# Simple Data Generation for CSV Benchmark
# Using only base R to ensure compatibility

# Set seed for reproducibility
set.seed(42)

# Target approximately 1GB CSV file
# Estimate: ~11-13 million rows with 12 columns to get ~1GB CSV
n_rows <- 10000000  # 10 million rows
cat("Generating", n_rows, "rows of data...\n")

# Generate realistic dummy data using base R only
dummy_data <- data.frame(
  id = 1:n_rows,
  category = sample(c("A", "B", "C", "D", "E"), n_rows, replace = TRUE),
  region = sample(c("North", "South", "East", "West", "Central"), n_rows, replace = TRUE),
  product = paste0("Product_", sample(1:1000, n_rows, replace = TRUE)),
  value1 = round(rnorm(n_rows, mean = 100, sd = 25), 2),
  value2 = round(runif(n_rows, min = 0, max = 1000), 2),
  value3 = round(rexp(n_rows, rate = 0.1), 2),
  value4 = round(rnorm(n_rows, mean = 50, sd = 15), 2),
  flag1 = sample(c(TRUE, FALSE), n_rows, replace = TRUE),
  flag2 = sample(c(TRUE, FALSE), n_rows, replace = TRUE),
  date_col = sample(seq(as.Date("2020-01-01"), as.Date("2023-12-31"), by = "day"), n_rows, replace = TRUE),
  notes = sample(c("Good", "Average", "Poor", "Excellent", "Fair"), n_rows, replace = TRUE)
)

cat("Data generation complete. Shape:", nrow(dummy_data), "x", ncol(dummy_data), "\n")

# Save as CSV using base R
cat("Writing CSV file...\n")
start_time <- Sys.time()
write.csv(dummy_data, "benchmark_data_simple.csv", row.names = FALSE)
csv_time <- as.numeric(Sys.time() - start_time)
csv_size <- file.size("benchmark_data_simple.csv") / (1024^3)  # Size in GB

cat("CSV written in", round(csv_time, 2), "seconds\n")
cat("File size:", round(csv_size, 3), "GB\n")

# Also save a compressed version using gzip
cat("Writing compressed CSV...\n")
start_time <- Sys.time()
write.csv(dummy_data, gzfile("benchmark_data_simple.csv.gz"), row.names = FALSE)
csvgz_time <- as.numeric(Sys.time() - start_time)
csvgz_size <- file.size("benchmark_data_simple.csv.gz") / (1024^3)

cat("Compressed CSV written in", round(csvgz_time, 2), "seconds\n")
cat("Compressed file size:", round(csvgz_size, 3), "GB\n")

# Create a summary
summary_data <- data.frame(
  format = c("CSV", "CSV.GZ"),
  write_time_sec = c(csv_time, csvgz_time),
  file_size_gb = c(csv_size, csvgz_size),
  compression_ratio = c(csv_size / csv_size, csvgz_size / csv_size)
)

cat("\nFile Summary:\n")
print(summary_data)

cat("\nFiles created:\n")
cat("- benchmark_data_simple.csv (", round(csv_size, 3), "GB)\n")
cat("- benchmark_data_simple.csv.gz (", round(csvgz_size, 3), "GB)\n")

rm(dummy_data)  # Clean up memory
gc()  # Force garbage collection