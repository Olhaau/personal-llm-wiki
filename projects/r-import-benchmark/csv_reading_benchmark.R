# Comprehensive CSV Reading Benchmark in R
# Comparing: data.table, arrow, polars, readr, duckdb, base R
# Author: OpenCode  
# Date: 2025-11-19

# Load required libraries
suppressPackageStartupMessages({
  library(data.table)
  library(readr)
  library(arrow)
  library(polars)  # Note: Requires polars to be installed
  library(duckdb)  # Note: Requires duckdb to be installed
  library(qs)
  library(microbenchmark)
  library(ggplot2)
  library(dplyr)
})

# Set options for consistent output
options(digits = 4)

# Helper function to format bytes
format_bytes <- function(bytes) {
  if (bytes >= 1024^3) {
    paste0(round(bytes / 1024^3, 2), " GB")
  } else if (bytes >= 1024^2) {
    paste0(round(bytes / 1024^2, 2), " MB")
  } else if (bytes >= 1024) {
    paste0(round(bytes / 1024, 2), " KB")
  } else {
    paste0(bytes, " B")
  }
}

# Function to safely run benchmark with error handling
safe_benchmark <- function(expr_list, times = 3) {
  result_list <- list()
  
  for (i in seq_along(expr_list)) {
    expr_name <- names(expr_list)[i]
    expr <- expr_list[[i]]
    
    cat("Testing:", expr_name, "...\n")
    
    tryCatch({
      # Test if the expression works first
      test_result <- eval(expr)
      rm(test_result)  # Clean up
      gc()  # Garbage collect
      
      # Run the actual benchmark
      bench_result <- microbenchmark(
        eval(expr),
        times = times,
        unit = "s"
      )
      
      result_list[[expr_name]] <- bench_result
      
    }, error = function(e) {
      cat("Error in", expr_name, ":", e$message, "\n")
      result_list[[expr_name]] <- NA
    })
  }
  
  return(result_list)
}

# Function to extract timing statistics
extract_stats <- function(benchmark_results) {
  stats_df <- data.frame()
  
  for (name in names(benchmark_results)) {
    if (!is.na(benchmark_results[[name]])) {
      times <- benchmark_results[[name]]$time / 1e9  # Convert to seconds
      stats_df <- rbind(stats_df, data.frame(
        method = name,
        mean_time = mean(times),
        median_time = median(times),
        min_time = min(times),
        max_time = max(times),
        sd_time = sd(times)
      ))
    } else {
      stats_df <- rbind(stats_df, data.frame(
        method = name,
        mean_time = NA,
        median_time = NA,
        min_time = NA,
        max_time = NA,
        sd_time = NA
      ))
    }
  }
  
  return(stats_df)
}

# Check if files exist
files_to_check <- c("benchmark_data.csv", "benchmark_data.csv.gz", 
                   "benchmark_data.parquet", "benchmark_data.qs")

missing_files <- !file.exists(files_to_check)
if (any(missing_files)) {
  cat("Missing files:", paste(files_to_check[missing_files], collapse = ", "), "\n")
  cat("Please run generate_benchmark_data.R first.\n")
  stop("Required data files not found.")
}

# Get file sizes
file_info <- data.frame(
  filename = files_to_check,
  size_bytes = sapply(files_to_check, file.size),
  size_formatted = sapply(files_to_check, function(f) format_bytes(file.size(f)))
)
print(file_info)

cat("\n=== BENCHMARK 1: CSV READING PERFORMANCE ===\n")

# Define expressions for CSV reading
csv_expressions <- list(
  "base_read.csv" = quote(read.csv("benchmark_data.csv")),
  "readr_read_csv" = quote(read_csv("benchmark_data.csv", show_col_types = FALSE)),
  "data.table_fread" = quote(fread("benchmark_data.csv")),
  "arrow_read_csv" = quote(read_csv_arrow("benchmark_data.csv")),
  "polars_read_csv" = quote(pl$read_csv("benchmark_data.csv")$to_data_frame()),
  "duckdb_read_csv" = quote({
    con <- dbConnect(duckdb::duckdb())
    df <- dbGetQuery(con, "SELECT * FROM read_csv_auto('benchmark_data.csv')")
    dbDisconnect(con)
    df
  })
)

# Run CSV benchmarks
csv_results <- safe_benchmark(csv_expressions, times = 3)
csv_stats <- extract_stats(csv_results)

cat("\nCSV Reading Results (seconds):\n")
print(csv_stats)

cat("\n=== BENCHMARK 2: COMPRESSED CSV READING ===\n")

# Define expressions for compressed CSV reading  
csvgz_expressions <- list(
  "base_read.csv_gz" = quote(read.csv("benchmark_data.csv.gz")),
  "readr_read_csv_gz" = quote(read_csv("benchmark_data.csv.gz", show_col_types = FALSE)),
  "data.table_fread_gz" = quote(fread("benchmark_data.csv.gz")),
  "arrow_read_csv_gz" = quote(read_csv_arrow("benchmark_data.csv.gz")),
  "duckdb_read_csv_gz" = quote({
    con <- dbConnect(duckdb::duckdb())
    df <- dbGetQuery(con, "SELECT * FROM read_csv_auto('benchmark_data.csv.gz')")
    dbDisconnect(con)
    df
  })
)

# Run compressed CSV benchmarks
csvgz_results <- safe_benchmark(csvgz_expressions, times = 3)
csvgz_stats <- extract_stats(csvgz_results)

cat("\nCompressed CSV Reading Results (seconds):\n")
print(csvgz_stats)

cat("\n=== BENCHMARK 3: ALTERNATIVE FORMATS ===\n")

# Define expressions for alternative formats
alt_expressions <- list(
  "arrow_read_parquet" = quote(read_parquet("benchmark_data.parquet")),
  "qs_qread" = quote(qread("benchmark_data.qs"))
)

# Run alternative format benchmarks
alt_results <- safe_benchmark(alt_expressions, times = 3)
alt_stats <- extract_stats(alt_results)

cat("\nAlternative Format Reading Results (seconds):\n")
print(alt_stats)

cat("\n=== BENCHMARK 4: AGGREGATION PERFORMANCE ===\n")

# Load data once for aggregation tests
cat("Loading data with fastest method for aggregation tests...\n")
dt_data <- fread("benchmark_data.csv")

cat("Data loaded. Shape:", nrow(dt_data), "x", ncol(dt_data), "\n")
cat("Running aggregation benchmarks...\n")

# Define aggregation expressions (cross-tabulation)
agg_expressions <- list(
  "data.table_agg" = quote({
    dt_data[, .(
      mean_value1 = mean(value1, na.rm = TRUE),
      sum_value2 = sum(value2, na.rm = TRUE),
      count = .N
    ), by = .(category, region)]
  }),
  
  "dplyr_agg" = quote({
    dt_data %>%
      group_by(category, region) %>%
      summarise(
        mean_value1 = mean(value1, na.rm = TRUE),
        sum_value2 = sum(value2, na.rm = TRUE),
        count = n(),
        .groups = 'drop'
      )
  }),
  
  "base_aggregate" = quote({
    aggregate(cbind(value1, value2) ~ category + region, 
              data = dt_data, 
              FUN = function(x) c(mean = mean(x, na.rm = TRUE), sum = sum(x, na.rm = TRUE)))
  })
)

# Run aggregation benchmarks
agg_results <- safe_benchmark(agg_expressions, times = 5)
agg_stats <- extract_stats(agg_results)

cat("\nAggregation Performance Results (seconds):\n")
print(agg_stats)

cat("\n=== BENCHMARK SUMMARY ===\n")

# Combine all results
all_stats <- rbind(
  data.frame(csv_stats, test_type = "CSV_Reading", stringsAsFactors = FALSE),
  data.frame(csvgz_stats, test_type = "CSV_GZ_Reading", stringsAsFactors = FALSE),
  data.frame(alt_stats, test_type = "Alternative_Formats", stringsAsFactors = FALSE),
  data.frame(agg_stats, test_type = "Aggregation", stringsAsFactors = FALSE)
)

# Save detailed results
fwrite(all_stats, "benchmark_results_detailed.csv")

# Create summary table for each test type
create_summary <- function(stats_df, test_name) {
  if (nrow(stats_df) == 0) return(NULL)
  
  valid_stats <- stats_df[!is.na(stats_df$mean_time), ]
  if (nrow(valid_stats) == 0) return(NULL)
  
  valid_stats <- valid_stats[order(valid_stats$mean_time), ]
  valid_stats$rank <- 1:nrow(valid_stats)
  valid_stats$relative_speed <- round(valid_stats$mean_time / min(valid_stats$mean_time, na.rm = TRUE), 2)
  
  summary_df <- data.frame(
    test_type = test_name,
    rank = valid_stats$rank,
    method = valid_stats$method,
    mean_time_sec = round(valid_stats$mean_time, 3),
    relative_speed = valid_stats$relative_speed,
    stringsAsFactors = FALSE
  )
  
  return(summary_df)
}

# Create summaries
csv_summary <- create_summary(csv_stats, "CSV Reading")
csvgz_summary <- create_summary(csvgz_stats, "CSV.GZ Reading") 
alt_summary <- create_summary(alt_stats, "Alternative Formats")
agg_summary <- create_summary(agg_stats, "Aggregation")

# Combine summaries
final_summary <- rbind(csv_summary, csvgz_summary, alt_summary, agg_summary)

cat("\nFINAL RANKING SUMMARY:\n")
print(final_summary)

# Save summary
fwrite(final_summary, "benchmark_summary.csv")

# Memory usage info
cat("\n=== MEMORY USAGE INFO ===\n")
mem_info <- gc()
print(mem_info)

cat("\nBenchmark files created:\n")
cat("- benchmark_results_detailed.csv (detailed results)\n")
cat("- benchmark_summary.csv (summary rankings)\n")

cat("\nBenchmark completed successfully!\n")