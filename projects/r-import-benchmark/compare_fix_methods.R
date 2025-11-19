# Fast CSV Reading Benchmark - Simplified Version
# Comparing different methods with available packages

# Create a moderately large test dataset (1M rows to simulate performance)
create_test_data <- function(n_rows = 1000000) {
  set.seed(42)
  data.frame(
    id = 1:n_rows,
    category = sample(LETTERS[1:5], n_rows, replace = TRUE),
    region = sample(c("North", "South", "East", "West"), n_rows, replace = TRUE),
    value1 = round(rnorm(n_rows, 100, 25), 2),
    value2 = round(runif(n_rows, 0, 1000), 2),
    value3 = round(rexp(n_rows, 0.1), 2),
    flag = sample(c(TRUE, FALSE), n_rows, replace = TRUE),
    date_col = sample(seq(as.Date("2020-01-01"), as.Date("2023-12-31"), by = "day"), n_rows, replace = TRUE),
    notes = sample(c("Good", "Fair", "Poor", "Excellent"), n_rows, replace = TRUE),
    stringsAsFactors = FALSE
  )
}

# Simple benchmark function
simple_benchmark <- function(expr, times = 3) {
  results <- numeric(times)
  for (i in 1:times) {
    gc()  # Clean memory
    start_time <- Sys.time()
    result <- eval(expr)
    end_time <- Sys.time()
    results[i] <- as.numeric(end_time - start_time)
    rm(result)  # Clean up
  }
  return(list(
    mean_time = mean(results),
    min_time = min(results),
    max_time = max(results),
    times = results
  ))
}

# Check available packages
available_packages <- c()
package_status <- data.frame(
  package = character(),
  available = logical(),
  stringsAsFactors = FALSE
)

packages_to_check <- c("data.table", "readr", "arrow", "polars", "duckdb")

for (pkg in packages_to_check) {
  is_available <- suppressWarnings(requireNamespace(pkg, quietly = TRUE))
  package_status <- rbind(package_status, data.frame(
    package = pkg,
    available = is_available,
    stringsAsFactors = FALSE
  ))
  if (is_available) {
    available_packages <- c(available_packages, pkg)
  }
}

cat("Package availability:\n")
print(package_status)
cat("\n")

# Generate test data
cat("Generating test data...\n")
test_data <- create_test_data(1000000)  # 1M rows
cat("Generated", nrow(test_data), "x", ncol(test_data), "dataset\n")

# Save test file
cat("Saving CSV file...\n")
write.csv(test_data, "data/test_data.csv", row.names = FALSE)
file_size_mb <- file.size("data/test_data.csv") / (1024^2)
cat("CSV file size:", round(file_size_mb, 2), "MB\n")

# Also create compressed version
cat("Creating compressed version...\n")
write.csv(test_data, gzfile("data/test_data.csv.gz"), row.names = FALSE)
gz_size_mb <- file.size("data/test_data.csv.gz") / (1024^2)
cat("Compressed file size:", round(gz_size_mb, 2), "MB\n")

# Benchmark reading methods
results <- list()

# Base R read.csv
cat("\nTesting base R read.csv...\n")
results$base_read_csv <- simple_benchmark(quote(read.csv("data/test_data.csv")))
cat("Base read.csv - Mean time:", round(results$base_read_csv$mean_time, 3), "seconds\n")

# Test data.table if available
if ("data.table" %in% available_packages) {
  cat("\nTesting data.table fread...\n")
  library(data.table, quietly = TRUE)
  results$fread <- simple_benchmark(quote(fread("data/test_data.csv")))
  cat("data.table fread - Mean time:", round(results$fread$mean_time, 3), "seconds\n")
  
  # Test compressed CSV with fread (with error handling)
  cat("Testing fread with compressed CSV...\n")
  tryCatch({
    results$fread_gz <- simple_benchmark(quote(fread("data/test_data.csv.gz")))
    cat("fread compressed - Mean time:", round(results$fread_gz$mean_time, 3), "seconds\n")
  }, error = function(e) {
    cat("fread compressed failed:", e$message, "\n")
    cat("Skipping compressed CSV test for fread\n")
  })
}

# Test readr if available
if ("readr" %in% available_packages) {
  cat("\nTesting readr read_csv...\n")
  library(readr, quietly = TRUE)
  results$readr <- simple_benchmark(quote(read_csv("test_data.csv", show_col_types = FALSE)))
  cat("readr read_csv - Mean time:", round(results$readr$mean_time, 3), "seconds\n")
}

# Test arrow if available
if ("arrow" %in% available_packages) {
  cat("\nTesting arrow read_csv_arrow...\n")
  library(arrow, quietly = TRUE)
  results$arrow <- simple_benchmark(quote(read_csv_arrow("data/test_data.csv")))
  cat("arrow read_csv_arrow - Mean time:", round(results$arrow$mean_time, 3), "seconds\n")
}

# Test polars if available
if ("polars" %in% available_packages) {
  cat("\nTesting polars read_csv...\n")
  library(polars, quietly = TRUE)
  results$polars <- simple_benchmark(quote(as.data.frame(pl$read_csv("data/test_data.csv"))))
  cat("polars read_csv - Mean time:", round(results$polars$mean_time, 3), "seconds\n")
}

# Test DuckDB if available
if ("duckdb" %in% available_packages) {
  cat("\nTesting DuckDB read_csv...\n")
  library(duckdb, quietly = TRUE)
  results$duckdb <- simple_benchmark(quote({
    con <- dbConnect(duckdb::duckdb())
    df <- dbGetQuery(con, "SELECT * FROM read_csv_auto('data/test_data.csv')")
    dbDisconnect(con)
    df
  }))
  cat("DuckDB read_csv_auto - Mean time:", round(results$duckdb$mean_time, 3), "seconds\n")
}

# Create results summary
cat("\n=== BENCHMARK RESULTS SUMMARY ===\n")
summary_df <- data.frame(
  Method = character(),
  Mean_Time_Seconds = numeric(),
  Relative_Speed = numeric(),
  stringsAsFactors = FALSE
)

for (method in names(results)) {
  summary_df <- rbind(summary_df, data.frame(
    Method = method,
    Mean_Time_Seconds = round(results[[method]]$mean_time, 4),
    Relative_Speed = NA,  # Will calculate after
    stringsAsFactors = FALSE
  ))
}

# Calculate relative speed (compared to fastest)
if (nrow(summary_df) > 0) {
  fastest_time <- min(summary_df$Mean_Time_Seconds)
  summary_df$Relative_Speed <- round(summary_df$Mean_Time_Seconds / fastest_time, 2)
  summary_df <- summary_df[order(summary_df$Mean_Time_Seconds), ]
  summary_df$Rank <- 1:nrow(summary_df)
}

print(summary_df)

# Test aggregation performance if data.table is available
if ("data.table" %in% available_packages) {
  cat("\n=== AGGREGATION PERFORMANCE TEST ===\n")
  dt_data <- fread("data/test_data.csv")
  
  cat("Testing data.table aggregation...\n")
  agg_dt <- simple_benchmark(quote({
    dt_data[, .(
      mean_val1 = mean(value1),
      sum_val2 = sum(value2),
      count = .N
    ), by = .(category, region)]
  }))
  
  cat("data.table aggregation - Mean time:", round(agg_dt$mean_time, 4), "seconds\n")
  
  # Test base R aggregation for comparison
  cat("Testing base R aggregation...\n")
  df_data <- as.data.frame(dt_data)
  agg_base <- simple_benchmark(quote({
    aggregate(cbind(value1, value2) ~ category + region, df_data, 
              function(x) c(mean = mean(x), sum = sum(x)))
  }))
  
  cat("base R aggregation - Mean time:", round(agg_base$mean_time, 4), "seconds\n")
  
  speedup <- agg_base$mean_time / agg_dt$mean_time
  cat("data.table is", round(speedup, 1), "x faster for aggregation\n")
}

# Save results
if (nrow(summary_df) > 0) {
  write.csv(summary_df, "benchmark_comparison.csv", row.names = FALSE)
  cat("\nResults saved to benchmark_comparison.csv\n")
}

# Cleanup
cat("\nCleaning up temporary files...\n")
if (file.exists("data/test_data.csv")) file.remove("data/test_data.csv")
if (file.exists("data/test_data.csv.gz")) file.remove("data/test_data.csv.gz")

cat("Benchmark completed!\n")