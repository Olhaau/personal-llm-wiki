#!/usr/bin/env Rscript
# Benchmark multiple R methods for data processing ----
# Task: Create a contingency table of years x statistics with counts

# Load required packages ----
suppressPackageStartupMessages({
  library(data.table)
  library(jsonlite)
})

# Helper function to detect data files in path ----
detect_data_files <- function(data_path) {
  if (dir.exists(data_path)) {
    # Scan directory for data files
    csv_files <- list.files(data_path, pattern = "\\.csv$", full.names = TRUE)
    parquet_files <- list.files(data_path, pattern = "\\.parquet$", full.names = TRUE)
    
    list(
      type = "directory",
      path = data_path,
      csv_files = csv_files,
      parquet_files = parquet_files,
      n_csv = length(csv_files),
      n_parquet = length(parquet_files)
    )
  } else if (file.exists(data_path)) {
    # Single file
    list(
      type = "file",
      path = data_path,
      format = if (grepl("\\.csv$", data_path)) "csv" else "parquet"
    )
  } else {
    stop("Data path not found: ", data_path)
  }
}

# Helper function to measure memory ----
get_memory_usage <- function() {
  gc_info <- gc(reset = TRUE, full = TRUE)
  # gc_info has columns: used, gc trigger, max used, and rows for Ncells and Vcells
  # Calculate memory in MB: (used Ncells * 8 bytes + used Vcells * 8 bytes) / 1024^2
  mem_used <- sum(gc_info[, "used"] * c(8, 8)) / 1024^2
  return(mem_used)
}

# Helper function to get disk space ----
get_disk_space <- function(data_info) {
  if (data_info$type == "directory") {
    all_files <- c(data_info$csv_files, data_info$parquet_files)
    total_size <- sum(file.size(all_files))
  } else {
    total_size <- file.size(data_info$path)
  }
  return(total_size / 1024^2)  # Return in MB
}

# Set resource limits ----
set_resource_limits <- function(max_cores = NULL, max_memory_gb = NULL) {
  # Set number of threads/cores
  if (!is.null(max_cores)) {
    # Set environment variables for various parallel backends
    Sys.setenv(OMP_NUM_THREADS = max_cores)
    Sys.setenv(MKL_NUM_THREADS = max_cores)
    Sys.setenv(OPENBLAS_NUM_THREADS = max_cores)
    
    # Set data.table threads
    if (requireNamespace("data.table", quietly = TRUE)) {
      data.table::setDTthreads(max_cores)
    }
    
    cat(sprintf("Resource limit: Max cores = %d\n", max_cores))
  }
  
  # Note: R doesn't have built-in memory limits that work reliably across platforms
  # Memory monitoring is done per-operation instead
  if (!is.null(max_memory_gb)) {
    cat(sprintf("Resource limit: Max memory = %.1f GB (monitoring only)\n", max_memory_gb))
  }
  
  invisible(list(max_cores = max_cores, max_memory_gb = max_memory_gb))
}

# Benchmark Method 1: Arrow ----
benchmark_arrow <- function(data_info, output_dir) {
  cat("\n=== Method 1: Arrow ===\n")
  
  if (!requireNamespace("arrow", quietly = TRUE)) {
    cat("Arrow not installed. Skipping.\n")
    return(NULL)
  }
  
  suppressPackageStartupMessages({
    library(arrow)
    library(dplyr)
  })
  
  gc(full = TRUE)
  mem_start <- get_memory_usage()
  time_start <- Sys.time()
  
  # Read data with arrow (handles both single files and directories)
  if (data_info$type == "directory" && data_info$n_parquet > 0) {
    # Use parquet files from directory
    ds <- open_dataset(data_info$parquet_files)
  } else if (data_info$type == "file" && data_info$format == "parquet") {
    ds <- open_dataset(data_info$path)
  } else {
    cat("Arrow requires Parquet format. Skipping.\n")
    return(NULL)
  }
  
  # Create contingency table
  result <- ds |>
    mutate(stat = substr(verk, 1, 1)) |>
    filter(stat %in% c("g", "k", "u", "p", "v", "e")) |>
    group_by(jahr, stat) |>
    summarise(n = n(), .groups = "drop") |>
    collect() |>
    as.data.frame()
  
  # Convert to wide format
  if (requireNamespace("tidyr", quietly = TRUE)) {
    result_wide <- tidyr::pivot_wider(result, 
                                       names_from = stat, 
                                       values_from = n, 
                                       values_fill = 0)
  } else {
    # Fallback to data.table dcast
    result_wide <- data.table::dcast(data.table::as.data.table(result), 
                                      jahr ~ stat, value.var = "n", fill = 0)
  }
  
  time_end <- Sys.time()
  runtime <- as.numeric(difftime(time_end, time_start, units = "secs"))
  
  gc_info <- gc(full = TRUE)
  mem_end <- get_memory_usage()
  mem_used <- mem_end - mem_start
  
  code_complexity <- 8
  
  result_path <- file.path(output_dir, "result_arrow.csv")
  write.csv(result_wide, result_path, row.names = FALSE)
  
  cat(sprintf("Runtime: %.3f seconds\n", runtime))
  cat(sprintf("Memory used: %.2f MB\n", mem_used))
  cat(sprintf("Result saved: %s\n", result_path))
  
  return(list(
    method = "arrow",
    runtime_sec = runtime,
    memory_mb = mem_used,
    code_complexity = code_complexity,
    result_path = result_path
  ))
}

# Benchmark Method 2: Polars ----
benchmark_polars <- function(data_info, output_dir) {
  cat("\n=== Method 2: Polars ===\n")
  
  if (!requireNamespace("polars", quietly = TRUE)) {
    cat("Polars not installed. Skipping.\n")
    return(NULL)
  }
  
  library(polars)
  
  gc(full = TRUE)
  mem_start <- get_memory_usage()
  time_start <- Sys.time()
  
  # Read data with polars
  if (data_info$type == "directory" && data_info$n_parquet > 0) {
    # Read multiple parquet files
    df <- pl$scan_parquet(data_info$parquet_files)
  } else if (data_info$type == "file" && data_info$format == "parquet") {
    df <- pl$scan_parquet(data_info$path)
  } else if (data_info$type == "directory" && data_info$n_csv > 0) {
    df <- pl$scan_csv(data_info$csv_files)
  } else if (data_info$type == "file" && data_info$format == "csv") {
    df <- pl$scan_csv(data_info$path)
  } else {
    cat("No suitable data files found. Skipping.\n")
    return(NULL)
  }
  
  # Create contingency table
  result <- df$
    with_columns(pl$col("verk")$str$slice(0, 1)$alias("stat"))$
    filter(pl$col("stat")$is_in(c("g", "k", "u", "p", "v", "e")))$
    group_by(c("jahr", "stat"))$
    agg(pl$len()$alias("n"))$
    collect()$
    to_data_frame()
  
  # Convert to wide format
  result_wide <- tidyr::pivot_wider(result,
                                     names_from = stat,
                                     values_from = n,
                                     values_fill = 0)
  
  time_end <- Sys.time()
  runtime <- as.numeric(difftime(time_end, time_start, units = "secs"))
  
  gc_info <- gc(full = TRUE)
  mem_end <- get_memory_usage()
  mem_used <- mem_end - mem_start
  
  code_complexity <- 7
  
  result_path <- file.path(output_dir, "result_polars.csv")
  write.csv(result_wide, result_path, row.names = FALSE)
  
  cat(sprintf("Runtime: %.3f seconds\n", runtime))
  cat(sprintf("Memory used: %.2f MB\n", mem_used))
  cat(sprintf("Result saved: %s\n", result_path))
  
  return(list(
    method = "polars",
    runtime_sec = runtime,
    memory_mb = mem_used,
    code_complexity = code_complexity,
    result_path = result_path
  ))
}

# Benchmark Method 3: data.table ----
benchmark_datatable <- function(data_info, output_dir) {
  cat("\n=== Method 3: data.table ===\n")
  
  library(data.table)
  
  gc(full = TRUE)
  mem_start <- get_memory_usage()
  time_start <- Sys.time()
  
  # Read data
  if (data_info$type == "directory") {
    # Read multiple files and combine
    if (data_info$n_parquet > 0) {
      dt_list <- lapply(data_info$parquet_files, function(f) {
        as.data.table(arrow::read_parquet(f))
      })
      dt <- rbindlist(dt_list)
    } else if (data_info$n_csv > 0) {
      dt <- rbindlist(lapply(data_info$csv_files, fread))
    } else {
      cat("No data files found. Skipping.\n")
      return(NULL)
    }
  } else {
    # Single file
    if (data_info$format == "parquet") {
      dt <- as.data.table(arrow::read_parquet(data_info$path))
    } else {
      dt <- fread(data_info$path)
    }
  }
  
  # Create contingency table
  dt[, stat := substr(verk, 1, 1)]
  result <- dt[stat %in% c("g", "k", "u", "p", "v", "e"), 
               .N, 
               by = .(jahr, stat)]
  
  # Convert to wide format
  result_wide <- dcast(result, jahr ~ stat, value.var = "N", fill = 0)
  
  time_end <- Sys.time()
  runtime <- as.numeric(difftime(time_end, time_start, units = "secs"))
  
  gc_info <- gc(full = TRUE)
  mem_end <- get_memory_usage()
  mem_used <- mem_end - mem_start
  
  code_complexity <- 5
  
  result_path <- file.path(output_dir, "result_datatable.csv")
  fwrite(result_wide, result_path)
  
  cat(sprintf("Runtime: %.3f seconds\n", runtime))
  cat(sprintf("Memory used: %.2f MB\n", mem_used))
  cat(sprintf("Result saved: %s\n", result_path))
  
  return(list(
    method = "data.table",
    runtime_sec = runtime,
    memory_mb = mem_used,
    code_complexity = code_complexity,
    result_path = result_path
  ))
}

# Benchmark Method 4: tidyverse ----
benchmark_tidyverse <- function(data_info, output_dir) {
  cat("\n=== Method 4: tidyverse ===\n")
  
  if (!requireNamespace("dplyr", quietly = TRUE) || 
      !requireNamespace("tidyr", quietly = TRUE)) {
    cat("tidyverse packages not installed. Skipping.\n")
    return(NULL)
  }
  
  suppressPackageStartupMessages({
    library(dplyr)
    library(tidyr)
    library(readr)
  })
  
  gc(full = TRUE)
  mem_start <- get_memory_usage()
  time_start <- Sys.time()
  
  # Read data
  if (data_info$type == "directory") {
    if (data_info$n_parquet > 0) {
      df_list <- lapply(data_info$parquet_files, arrow::read_parquet)
      df <- bind_rows(df_list)
    } else if (data_info$n_csv > 0) {
      df <- bind_rows(lapply(data_info$csv_files, read_csv, show_col_types = FALSE))
    } else {
      cat("No data files found. Skipping.\n")
      return(NULL)
    }
  } else {
    if (data_info$format == "parquet") {
      df <- arrow::read_parquet(data_info$path)
    } else {
      df <- read_csv(data_info$path, show_col_types = FALSE)
    }
  }
  
  # Create contingency table
  result_wide <- df |>
    mutate(stat = substr(verk, 1, 1)) |>
    filter(stat %in% c("g", "k", "u", "p", "v", "e")) |>
    group_by(jahr, stat) |>
    summarise(n = n(), .groups = "drop") |>
    pivot_wider(names_from = stat, values_from = n, values_fill = 0)
  
  time_end <- Sys.time()
  runtime <- as.numeric(difftime(time_end, time_start, units = "secs"))
  
  gc_info <- gc(full = TRUE)
  mem_end <- get_memory_usage()
  mem_used <- mem_end - mem_start
  
  code_complexity <- 6
  
  result_path <- file.path(output_dir, "result_tidyverse.csv")
  write_csv(result_wide, result_path)
  
  cat(sprintf("Runtime: %.3f seconds\n", runtime))
  cat(sprintf("Memory used: %.2f MB\n", mem_used))
  cat(sprintf("Result saved: %s\n", result_path))
  
  return(list(
    method = "tidyverse",
    runtime_sec = runtime,
    memory_mb = mem_used,
    code_complexity = code_complexity,
    result_path = result_path
  ))
}

# Benchmark Method 5: vroom ----
benchmark_vroom <- function(data_info, output_dir) {
  cat("\n=== Method 5: vroom ===\n")
  
  if (!requireNamespace("vroom", quietly = TRUE)) {
    cat("vroom not installed. Skipping.\n")
    return(NULL)
  }
  
  suppressPackageStartupMessages({
    library(vroom)
    library(dplyr)
    library(tidyr)
  })
  
  # vroom only works with CSV files
  if (data_info$type == "directory" && data_info$n_csv == 0) {
    cat("vroom requires CSV files. Skipping.\n")
    return(NULL)
  } else if (data_info$type == "file" && data_info$format != "csv") {
    cat("vroom requires CSV files. Skipping.\n")
    return(NULL)
  }
  
  gc(full = TRUE)
  mem_start <- get_memory_usage()
  time_start <- Sys.time()
  
  # Read data with vroom
  if (data_info$type == "directory") {
    df <- vroom(data_info$csv_files, show_col_types = FALSE)
  } else {
    df <- vroom(data_info$path, show_col_types = FALSE)
  }
  
  # Create contingency table
  result_wide <- df |>
    mutate(stat = substr(verk, 1, 1)) |>
    filter(stat %in% c("g", "k", "u", "p", "v", "e")) |>
    group_by(jahr, stat) |>
    summarise(n = n(), .groups = "drop") |>
    pivot_wider(names_from = stat, values_from = n, values_fill = 0)
  
  time_end <- Sys.time()
  runtime <- as.numeric(difftime(time_end, time_start, units = "secs"))
  
  gc_info <- gc(full = TRUE)
  mem_end <- get_memory_usage()
  mem_used <- mem_end - mem_start
  
  code_complexity <- 6
  
  result_path <- file.path(output_dir, "result_vroom.csv")
  write.csv(result_wide, result_path, row.names = FALSE)
  
  cat(sprintf("Runtime: %.3f seconds\n", runtime))
  cat(sprintf("Memory used: %.2f MB\n", mem_used))
  cat(sprintf("Result saved: %s\n", result_path))
  
  return(list(
    method = "vroom",
    runtime_sec = runtime,
    memory_mb = mem_used,
    code_complexity = code_complexity,
    result_path = result_path
  ))
}

# Function to collect system information ----
collect_system_info <- function(output_dir, data_info, resource_limits) {
  cat("\n=== Collecting System Information ===\n")
  
  session_info <- sessionInfo()
  sys_info <- Sys.info()
  
  # CPU info
  cpu_info <- if (sys_info["sysname"] == "Linux") {
    tryCatch({
      cpu_data <- readLines("/proc/cpuinfo")
      model <- grep("model name", cpu_data, value = TRUE)[1]
      model <- sub(".*: ", "", model)
      cores <- grep("processor", cpu_data) |> length()
      list(model = model, cores = cores)
    }, error = function(e) {
      list(model = "Unknown", cores = parallel::detectCores())
    })
  } else {
    list(model = "Unknown", cores = parallel::detectCores())
  }
  
  # Memory info
  mem_info <- if (sys_info["sysname"] == "Linux") {
    tryCatch({
      mem_data <- readLines("/proc/meminfo")
      total_line <- grep("MemTotal", mem_data, value = TRUE)
      total_kb <- as.numeric(sub(".*?([0-9]+).*", "\\1", total_line))
      total_gb <- total_kb / 1024^2
      available_line <- grep("MemAvailable", mem_data, value = TRUE)
      available_kb <- as.numeric(sub(".*?([0-9]+).*", "\\1", available_line))
      available_gb <- available_kb / 1024^2
      list(total_gb = round(total_gb, 2), available_gb = round(available_gb, 2))
    }, error = function(e) {
      list(total_gb = "Unknown", available_gb = "Unknown")
    })
  } else {
    list(total_gb = "Unknown", available_gb = "Unknown")
  }
  
  # Disk space info
  disk_space_mb <- get_disk_space(data_info)
  
  # Data info
  data_details <- if (data_info$type == "directory") {
    sprintf("Directory with %d CSV files and %d Parquet files", 
            data_info$n_csv, data_info$n_parquet)
  } else {
    sprintf("Single %s file", toupper(data_info$format))
  }
  
  # Create markdown content
  md_content <- sprintf("# System and Session Information

## Generated
- **Timestamp**: %s
- **Working Directory**: %s

## Benchmark Configuration
- **Data Path**: %s
- **Data Type**: %s
- **Data Size**: %.2f MB
- **Max Cores**: %s
- **Max Memory**: %s GB

## R Environment
- **R Version**: %s
- **Platform**: %s
- **Running**: %s

## System Hardware
- **OS**: %s %s
- **Node**: %s
- **Machine**: %s
- **CPU Model**: %s
- **CPU Cores**: %d
- **Total Memory**: %s GB
- **Available Memory**: %s GB

## Resource Limits
- **Cores Limit**: %s
- **Memory Limit**: %s GB
- **OMP_NUM_THREADS**: %s
- **data.table threads**: %s

## Loaded Packages

| Package | Version |
|---------|---------|
%s

## Base Packages

%s

## Session Locale

```
%s
```

## Additional Information

- **Matrix Products**: %s
- **BLAS**: %s
- **LAPACK**: %s

---
*Generated by 02_benchmark_methods.R*
",
    format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"),
    getwd(),
    data_info$path,
    data_details,
    disk_space_mb,
    if (!is.null(resource_limits$max_cores)) resource_limits$max_cores else "None",
    if (!is.null(resource_limits$max_memory_gb)) resource_limits$max_memory_gb else "None",
    paste(session_info$R.version$version.string),
    session_info$platform,
    session_info$running,
    sys_info["sysname"],
    sys_info["release"],
    sys_info["nodename"],
    sys_info["machine"],
    cpu_info$model,
    cpu_info$cores,
    if (is.numeric(mem_info$total_gb)) sprintf("%.2f", mem_info$total_gb) else mem_info$total_gb,
    if (is.numeric(mem_info$available_gb)) sprintf("%.2f", mem_info$available_gb) else mem_info$available_gb,
    if (!is.null(resource_limits$max_cores)) resource_limits$max_cores else "Unlimited",
    if (!is.null(resource_limits$max_memory_gb)) resource_limits$max_memory_gb else "Unlimited",
    Sys.getenv("OMP_NUM_THREADS", "not set"),
    if (requireNamespace("data.table", quietly = TRUE)) data.table::getDTthreads() else "N/A",
    paste(sapply(session_info$otherPkgs, function(pkg) {
      sprintf("| %s | %s |", pkg$Package, pkg$Version)
    }), collapse = "\n"),
    paste("*", names(session_info$basePkgs), collapse = ", "),
    paste(capture.output(session_info$locale), collapse = "\n"),
    if (!is.null(session_info$matprod)) session_info$matprod else "default",
    if (!is.null(session_info$BLAS)) session_info$BLAS else "default",
    if (!is.null(session_info$LAPACK)) session_info$LAPACK else "default"
  )
  
  output_file <- file.path(output_dir, "sessioninfo.md")
  writeLines(md_content, output_file)
  
  cat(sprintf("System information saved: %s\n", output_file))
  
  return(output_file)
}

# Main benchmark runner ----
run_benchmark <- function(data_path = "data",
                          methods = c("arrow", "polars", "data.table", 
                                     "tidyverse", "vroom"),
                          max_cores = NULL,
                          max_memory_gb = NULL) {
  
  cat("\n========================================\n")
  cat("Starting Benchmark\n")
  cat("========================================\n")
  cat(sprintf("Timestamp: %s\n", Sys.time()))
  
  # Set resource limits
  resource_limits <- set_resource_limits(max_cores, max_memory_gb)
  
  # Detect data files
  data_info <- detect_data_files(data_path)
  
  cat(sprintf("Data path: %s\n", data_path))
  cat(sprintf("Data type: %s\n", data_info$type))
  
  if (data_info$type == "directory") {
    cat(sprintf("CSV files: %d\n", data_info$n_csv))
    cat(sprintf("Parquet files: %d\n", data_info$n_parquet))
  } else {
    cat(sprintf("Format: %s\n", data_info$format))
  }
  
  disk_space_mb <- get_disk_space(data_info)
  cat(sprintf("Total data size: %.2f MB\n", disk_space_mb))
  
  # Create results directory with timestamp
  timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
  results_dir <- file.path("results", sprintf("benchmark_%s", timestamp))
  dir.create(results_dir, recursive = TRUE, showWarnings = FALSE)
  
  cat(sprintf("Results directory: %s\n", results_dir))
  
  # Collect system information
  collect_system_info(results_dir, data_info, resource_limits)
  
  # Run benchmarks
  results <- list()
  
  if ("arrow" %in% methods) {
    results$arrow <- benchmark_arrow(data_info, results_dir)
  }
  
  if ("polars" %in% methods) {
    results$polars <- benchmark_polars(data_info, results_dir)
  }
  
  if ("data.table" %in% methods) {
    results$datatable <- benchmark_datatable(data_info, results_dir)
  }
  
  if ("tidyverse" %in% methods) {
    results$tidyverse <- benchmark_tidyverse(data_info, results_dir)
  }
  
  if ("vroom" %in% methods) {
    results$vroom <- benchmark_vroom(data_info, results_dir)
  }
  
  # Compile results
  compiled_results <- lapply(results, function(r) {
    if (is.null(r)) return(NULL)
    data.frame(
      method = r$method,
      runtime_sec = r$runtime_sec,
      max_memory_mb = r$memory_mb,
      disk_space_mb = disk_space_mb,
      code_complexity = r$code_complexity,
      n_files = if (data_info$type == "directory") {
        data_info$n_csv + data_info$n_parquet
      } else {
        1
      },
      max_cores = if (!is.null(resource_limits$max_cores)) {
        resource_limits$max_cores
      } else {
        NA
      },
      max_memory_gb = if (!is.null(resource_limits$max_memory_gb)) {
        resource_limits$max_memory_gb
      } else {
        NA
      },
      stringsAsFactors = FALSE
    )
  })
  
  # Remove NULL entries
  compiled_results <- compiled_results[!sapply(compiled_results, is.null)]
  
  if (length(compiled_results) > 0) {
    results_df <- do.call(rbind, compiled_results)
    results_df$timestamp <- timestamp
    
    # Save as JSON
    json_path <- file.path(results_dir, "benchmark_results.json")
    write_json(results_df, json_path, pretty = TRUE)
    
    # Also save as CSV
    csv_path <- file.path(results_dir, "benchmark_results.csv")
    write.csv(results_df, csv_path, row.names = FALSE)
    
    cat("\n========================================\n")
    cat("Benchmark Complete\n")
    cat("========================================\n\n")
    
    print(results_df)
    
    cat(sprintf("\nResults saved to:\n"))
    cat(sprintf("  - %s\n", json_path))
    cat(sprintf("  - %s\n", csv_path))
    cat(sprintf("  - %s/sessioninfo.md\n", results_dir))
    
    return(results_df)
  } else {
    cat("\nNo benchmark results collected.\n")
    return(NULL)
  }
}

# Command-line execution ----
if (!interactive()) {
  # Parse command line arguments
  args <- commandArgs(trailingOnly = TRUE)
  
  # Default values
  data_path <- "data"
  methods <- c("arrow", "polars", "data.table", "tidyverse", "vroom")
  max_cores <- NULL
  max_memory_gb <- NULL
  
  # Parse arguments
  if (length(args) > 0) {
    for (arg in args) {
      if (grepl("^data_path=", arg)) {
        data_path <- sub("data_path=", "", arg)
      } else if (grepl("^methods=", arg)) {
        methods <- strsplit(sub("methods=", "", arg), ",")[[1]]
      } else if (grepl("^max_cores=", arg)) {
        max_cores <- as.integer(sub("max_cores=", "", arg))
      } else if (grepl("^max_memory_gb=", arg)) {
        max_memory_gb <- as.numeric(sub("max_memory_gb=", "", arg))
      } else if (arg == "--help" || arg == "-h") {
        cat("Usage: Rscript 02_benchmark_methods.R [options]\n\n")
        cat("Options:\n")
        cat("  data_path=PATH       Path to data file or directory (default: data)\n")
        cat("  methods=m1,m2,...    Methods to benchmark (default: all)\n")
        cat("                       Available: arrow,polars,data.table,tidyverse,vroom\n")
        cat("  max_cores=N          Maximum number of cores to use (default: unlimited)\n")
        cat("  max_memory_gb=N      Maximum memory in GB (monitoring only)\n\n")
        cat("Examples:\n")
        cat("  Rscript 02_benchmark_methods.R\n")
        cat("  Rscript 02_benchmark_methods.R data_path=data max_cores=4\n")
        cat("  Rscript 02_benchmark_methods.R methods=data.table,arrow max_cores=8\n")
        quit(status = 0)
      }
    }
  }
  
  # Run benchmark
  run_benchmark(data_path = data_path, methods = methods, 
                max_cores = max_cores, max_memory_gb = max_memory_gb)
}
