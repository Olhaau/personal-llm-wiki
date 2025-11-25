# aggregate_benchmarks.R
# Aggregate benchmark results into a single CSV table
# ----

#' Aggregate Benchmark Results to CSV
#'
#' Reads all benchmark JSON files from the results directory and
#' aggregates them into a single CSV table with key metrics.
#'
#' @param results_dir Character string. Directory containing benchmark JSON files.
#'   Default is "results"
#' @param output_csv Character string. Path to save the aggregated CSV.
#'   Default is "results/benchmark_summary.csv"
#'
#' @return A data.frame containing aggregated benchmark results
#'
#' @export
aggregate_benchmarks <- function(results_dir = "results", 
                                   output_csv = "results/benchmark_summary.csv") {
  # Load required packages
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required. Install with: install.packages('jsonlite')")
  }
  
  # Get all benchmark JSON files (exclude system_info.json)
  json_files <- list.files(
    results_dir, 
    pattern = "^bm_.*\\.json$", 
    full.names = TRUE
  )
  
  if (length(json_files) == 0) {
    stop("No benchmark files found in: ", results_dir)
  }
  
  message("Found ", length(json_files), " benchmark files")
  
  # Read and aggregate all benchmark results
  results_list <- lapply(json_files, function(file) {
    tryCatch({
      data <- jsonlite::read_json(file, simplifyVector = TRUE)
      
      # Extract filename components
      basename_file <- basename(file)
      # Pattern: bm_<input>_<runtime>_<expression>_<timestamp>.json
      parts <- strsplit(sub("\\.json$", "", basename_file), "_")[[1]]
      
      # Find indices for parsing (runtime is 4 digits)
      runtime_idx <- which(nchar(parts) == 4 & grepl("^[0-9]+$", parts))[1]
      
      if (is.na(runtime_idx)) {
        warning("Could not parse filename: ", basename_file)
        return(NULL)
      }
      
      # Extract components
      input_name <- paste(parts[2:(runtime_idx - 1)], collapse = "_")
      runtime_ms <- as.numeric(parts[runtime_idx])
      
      # Find timestamp (starts with "20")
      timestamp_idx <- which(grepl("^20[0-9]{6}$", parts))[1]
      expression_name <- paste(parts[(runtime_idx + 1):(timestamp_idx - 1)], collapse = "_")
      timestamp <- paste(parts[timestamp_idx:length(parts)], collapse = "_")
      
      # Create result row
      data.frame(
        input = input_name,
        expression = expression_name,
        runtime_ms = runtime_ms,
        runtime_seconds = data$runtime_seconds,
        max_memory_mb = data$max_memory_mb,
        filesize_mb = data$filesize_mb,
        timestamp = data$timestamp,
        stringsAsFactors = FALSE
      )
    }, error = function(e) {
      warning("Error reading file ", file, ": ", e$message)
      return(NULL)
    })
  })
  
  # Remove NULL entries
  results_list <- results_list[!sapply(results_list, is.null)]
  
  if (length(results_list) == 0) {
    stop("No valid benchmark results found")
  }
  
  # Combine into single data frame
  results_df <- do.call(rbind, results_list)
  
  # Sort by input, then expression, then timestamp
  results_df <- results_df[order(results_df$input, 
                                   results_df$expression, 
                                   results_df$timestamp), ]
  
  # Reset row names
  rownames(results_df) <- NULL
  
  # Save to CSV
  write.csv(results_df, output_csv, row.names = FALSE)
  message("Aggregated results saved to: ", output_csv)
  
  return(results_df)
}


#' Print Benchmark Summary Statistics
#'
#' Prints summary statistics grouped by input and expression.
#'
#' @param results_df Data frame from aggregate_benchmarks()
#'
#' @export
print_benchmark_summary <- function(results_df) {
  cat("\n=== Benchmark Summary ===\n\n")
  
  # Summary by input and expression
  summary_stats <- aggregate(
    cbind(runtime_ms, max_memory_mb) ~ input + expression,
    data = results_df,
    FUN = function(x) c(
      mean = mean(x),
      min = min(x),
      max = max(x),
      sd = sd(x)
    )
  )
  
  cat("Runtime (ms) by Input and Expression:\n")
  print(summary_stats[, c("input", "expression", "runtime_ms")])
  
  cat("\n\nMemory (MB) by Input and Expression:\n")
  print(summary_stats[, c("input", "expression", "max_memory_mb")])
  
  cat("\n")
}
