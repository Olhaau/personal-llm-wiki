# benchmark.R
# Benchmark function execution with performance metrics
# ----

#' Benchmark Expression Execution with Performance Metrics
#'
#' Executes an expression on input data and collects performance metrics
#' including runtime, memory usage, file size, and results.
#'
#' @param input_path Character string. Path to the input data file.
#' @param expr Expression or function to apply to the input data.
#' @param expr_name Character string. Optional name for the expression. If NULL, will attempt to extract from expr.
#' @param output_json Character string. Optional path to save JSON results.
#'   If NULL (default), generates filename as: <runtime_ms>_bm_<function>_<input>_<timestamp>.json
#'
#' @return A list containing:
#'   \item{function_name}{Name of the function or expression being benchmarked}
#'   \item{input_name}{Name of the input file (without path and extension)}
#'   \item{input_path}{Full path to the input file}
#'   \item{result}{The result of executing expr(input)}
#'   \item{filesize_bytes}{Size of the input file in bytes}
#'   \item{filesize_mb}{Size of the input file in megabytes}
#'   \item{max_memory_mb}{Maximum memory allocated during execution in MB (from bench)}
#'   \item{runtime_seconds}{Median execution time in seconds (from bench)}
#'   \item{timestamp}{ISO 8601 timestamp when benchmark was run}
#'
#' @examples
#' \dontrun{
#' # Benchmark reading a CSV file
#' benchmark(
#'   input_path = "data/mydata.csv",
#'   expr = read.csv
#' )
#'
#' # Benchmark custom function
#' benchmark(
#'   input_path = "data/mydata.csv",
#'   expr = function(x) {
#'     df <- read.csv(x)
#'     nrow(df)
#'   },
#'   output_json = "results.json"
#' )
#' }
#'
#' @export
benchmark <- function(input_path, expr, expr_name = NULL, output_json = NULL) {
  # Validate input path exists
  if (!file.exists(input_path)) {
    stop("Input file does not exist: ", input_path)
  }
  
  # Load required packages
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required. Install with: install.packages('jsonlite')")
  }
  if (!requireNamespace("bench", quietly = TRUE)) {
    stop("Package 'bench' is required. Install with: install.packages('bench')")
  }
  
  # Extract function name
  function_name <- if (!is.null(expr_name)) {
    # Use provided expr_name if available
    expr_name
  } else {
    # Otherwise try to extract from expr
    tryCatch(
      {
        if (is.function(expr)) {
          # Try to get the function name from the call
          func_name <- deparse(substitute(expr))
          if (length(func_name) == 1 && func_name != "expr") {
            func_name
          } else {
            "anonymous_function"
          }
        } else {
          deparse(substitute(expr))
        }
      },
      error = function(e) {
        "unknown_function"
      }
    )
  }
  
  # Extract input name (parent directory name + filename without extension)
  # e.g., "data/btp_obs10/data.csv" -> "btp_obs10_data"
  parent_dir <- basename(dirname(input_path))
  file_base <- tools::file_path_sans_ext(basename(input_path))
  input_name <- paste(parent_dir, file_base, sep = "_")
  
  # Get file size
  file_info <- file.info(input_path)
  filesize_bytes <- file_info$size
  filesize_mb <- filesize_bytes / (1024^2)
  
  # Use bench::mark() for accurate timing and memory measurement
  bench_result <- bench::mark(
    {
      if (is.function(expr)) {
        result <- expr(input_path)
      } else {
        result <- eval(substitute(expr(input_path)))
      }
      result
    },
    iterations = 1,
    check = FALSE,
    filter_gc = FALSE
  )
  
  # Extract result from the benchmark
  result <- tryCatch(
    {
      if (is.function(expr)) {
        expr(input_path)
      } else {
        eval(substitute(expr(input_path)))
      }
    },
    error = function(e) {
      stop("Error executing expression: ", e$message)
    }
  )
  
  # Extract timing and memory metrics from bench results
  runtime_seconds <- as.numeric(bench_result$median)
  max_memory_bytes <- as.numeric(bench_result$mem_alloc)
  max_memory_mb <- max_memory_bytes / (1024^2)
  
  # Calculate runtime in milliseconds for filename (4 digits with leading zeros)
  runtime_ms <- round(runtime_seconds * 1000, 2)
  runtime_ms_formatted <- sprintf("%04.0f", round(runtime_ms))
  
  # Generate timestamp for filename
  timestamp_str <- format(Sys.time(), "%Y%m%d_%H%M%S")
  
  # Prepare output
  benchmark_results <- list(
    function_name = function_name,
    input_name = input_name,
    input_path = input_path,
    result = result,
    filesize_bytes = filesize_bytes,
    filesize_mb = round(filesize_mb, 4),
    max_memory_mb = round(max_memory_mb, 4),
    runtime_seconds = round(runtime_seconds, 6),
    timestamp = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z")
  )
  
  # Create results directory if it doesn't exist
  results_dir <- "results"
  if (!dir.exists(results_dir)) {
    dir.create(results_dir, recursive = TRUE)
  }
  
  # Generate filename: bm_<input>_<runtime_ms>_<expression>_<timestamp>.json
  if (is.null(output_json)) {
    output_json <- file.path(
      results_dir,
      sprintf(
        "bm_%s_%s_%s_%s.json",
        input_name,
        runtime_ms_formatted,
        function_name,
        timestamp_str
      )
    )
  }
  
  ## Save to JSON
  #jsonlite::write_json(
  #  benchmark_results,
  #  output_json,
  #  pretty = TRUE,
  #  auto_unbox = TRUE
  #)
  #message("Benchmark results saved to: ", output_json)
  
  # Also save as CSV (one-line with header)
  output_csv <- sub("\\.json$", ".csv", output_json)
  
  # Prepare CSV-friendly version of results
  csv_results <- benchmark_results
  
  # Handle the result field - convert to string representation
  if (!is.null(csv_results$result)) {
    if (is.data.frame(csv_results$result)) {
      # For data frames, show dimensions
      csv_results$result <- sprintf("data.frame[%d x %d]", 
                                     nrow(csv_results$result), 
                                     ncol(csv_results$result))
    } else if (is.list(csv_results$result) && !is.data.frame(csv_results$result)) {
      # For lists, show length
      csv_results$result <- sprintf("list[%d]", length(csv_results$result))
    } else if (is.vector(csv_results$result) && length(csv_results$result) > 1) {
      # For vectors, show type and length
      csv_results$result <- sprintf("%s[%d]", typeof(csv_results$result), 
                                     length(csv_results$result))
    } else if (is.atomic(csv_results$result) && length(csv_results$result) == 1) {
      # For single atomic values, keep as is
      csv_results$result <- as.character(csv_results$result)
    } else {
      # For other complex objects, show class
      csv_results$result <- sprintf("%s", paste(class(csv_results$result), collapse = ", "))
    }
  } else {
    csv_results$result <- NA_character_
  }
  
  # Convert to data frame for CSV output
  csv_df <- as.data.frame(csv_results, stringsAsFactors = FALSE)
  
  # Write CSV
  write.csv(csv_df, output_csv, row.names = FALSE)
  message("Benchmark results also saved to: ", output_csv)
  
  return(benchmark_results)
}


# Helper function to format benchmark results for display
#' @export
print_benchmark_summary <- function(benchmark_results) {
  cat("\n=== Benchmark Summary ===\n")
  cat("Function:", benchmark_results$function_name, "\n")
  cat("Input:", benchmark_results$input_name, "\n")
  cat("Input path:", benchmark_results$input_path, "\n")
  cat("File size:", benchmark_results$filesize_mb, "MB\n")
  cat("Runtime:", benchmark_results$runtime_seconds, "seconds\n")
  cat("Max memory:", benchmark_results$max_memory_mb, "MB\n")
  cat("Timestamp:", benchmark_results$timestamp, "\n")
  cat("========================\n\n")
}
