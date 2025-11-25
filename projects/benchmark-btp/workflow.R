# workflow.R
# Benchmark workflow for testing different read functions on BTP data
# ----

library(here)
suppressPackageStartupMessages(library(arrow))

# Source functions ----
source(here("source", "benchmark.R"))
source(here("source", "system_info.R"))

# Collect and save system information ----
save_system_info()

# Load and run operations from operations folder ----
operations_dir <- here("source", "operations")
operation_files <- list.files(operations_dir, pattern = "\\.R$", full.names = TRUE)

if (length(operation_files) == 0) {
  stop("No operation files found in: ", operations_dir)
}

cat(sprintf("Found %d operation files:\n", length(operation_files)))
for (file in operation_files) {
  cat(sprintf("  - %s\n", basename(file)))
}
cat("\n")

# Run benchmarks for each operation ----
for (operation_file in operation_files) {
  cat(sprintf("Loading operation: %s\n", basename(operation_file)))
  
  # Source the operation file to load input, method, and operation_name
  source(operation_file)
  
  # Validate that required variables are defined
  if (!exists("input") || !exists("method") || !exists("operation_name")) {
    warning(sprintf("Skipping %s: missing required variables (input, method, operation_name)", 
                   basename(operation_file)))
    next
  }
  
  # Run benchmarks for each input file defined in the operation
  for (input_file in input) {
    if (file.exists(input_file)) {
      cat(sprintf("Benchmarking: %s with %s\n", basename(input_file), operation_name))
      benchmark(input_file, method, expr_name = operation_name)
    } else {
      warning(sprintf("Input file not found: %s", input_file))
    }
  }
  
  # Clean up variables for next iteration
  if (exists("input")) rm(input)
  if (exists("method")) rm(method)
  if (exists("operation_name")) rm(operation_name)
  
  cat("\n")
}

# Aggregate benchmark results ----
source(here("source", "aggregate_benchmarks.R"))
aggregate_benchmarks()

# Summary ----
cat("\n=== Benchmark Workflow Complete ===\n")
cat(sprintf("Total JSON files: %d\n", length(list.files("results", pattern = "\\.json$"))))
cat(sprintf("Total CSV files: %d\n", length(list.files("results", pattern = "\\.csv$"))))
cat("\nResults saved in: results/\n")
cat("  - JSON files: Full detailed results\n")
cat("  - CSV files: One-line tabular format for easy aggregation\n\n")

# Example: Single benchmark call ----
# benchmark(here("data", "btp_obs10", "data.csv"), read.csv, expr_name = "read.csv")
