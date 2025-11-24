#!/usr/bin/env Rscript
# Quick test setup - generates parameterized sample data for testing benchmarks

#' Generate Test Data
#'
#' @param obs Integer. Number of observations to generate (default: 10000)
#' @param n_files Integer. Number of split files to create (default: 1)
#' @param output_dir Character. Output directory path (default: "data")
#' @param formats Character vector. File formats to generate (default: c("csv", "parquet"))
#' @param seed Integer. Random seed for reproducibility (default: 42)
#'
#' @examples
#' # Generate 10k rows, single file
#' generate_test_data(obs = 10000, n_files = 1)
#'
#' # Generate 100k rows, split into 10 files
#' generate_test_data(obs = 100000, n_files = 10)
#'
#' # Generate 1M rows with only parquet format
#' generate_test_data(obs = 1e6, n_files = 5, formats = "parquet")
generate_test_data <- function(obs = 10000,
                               n_files = 1,
                               output_dir = "data",
                               formats = c("csv", "parquet"),
                               seed = 42) {
  
  suppressPackageStartupMessages({
    library(data.table)
    library(arrow)
  })
  
  cat("\n========================================\n")
  cat("Generating Test Data\n")
  cat("========================================\n")
  cat(sprintf("Observations: %s\n", format(obs, big.mark = ",")))
  cat(sprintf("Number of files: %d\n", n_files))
  cat(sprintf("Formats: %s\n", paste(formats, collapse = ", ")))
  cat(sprintf("Output directory: %s\n", output_dir))
  cat(sprintf("Seed: %d\n\n", seed))
  
  set.seed(seed)
  
  # Ensure output directory exists
  dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
  
  # Generate data
  cat("Creating synthetic dataset...\n")
  
  # Calculate observations per file
  obs_per_file <- ceiling(obs / n_files)
  
  # Generate all data at once for consistency
  total_obs <- obs_per_file * n_files
  
  # Create panel structure
  n_units <- ceiling(total_obs / 7)  # Average 7 years per unit
  years <- 2013:2019
  
  dt_full <- data.table(
    id = rep(1:n_units, each = 7)[1:total_obs],
    jahr = rep(years, times = ceiling(total_obs / length(years)))[1:total_obs],
    verk = sample(c("g______", "k______", "_u_____", "___p___", 
                    "____v__", "______e", "gku____", "___pv__",
                    "gkupvre", "_______"), 
                  total_obs, replace = TRUE,
                  prob = c(0.15, 0.05, 0.12, 0.05, 0.25, 0.18, 0.08, 0.07, 0.03, 0.02)),
    verk_qual = sample(1:3, total_obs, replace = TRUE, prob = c(0.7, 0.2, 0.1)),
    ags = sample(sprintf("%08d", 1000000:9999999), total_obs, replace = TRUE),
    urs_we_umsatz = pmax(0, rlnorm(total_obs, meanlog = 10, sdlog = 2)),
    urs_we_tp_stichtag = rpois(total_obs, lambda = 15),
    urs_we_svb_stichtag = rpois(total_obs, lambda = 10),
    g_value = rnorm(total_obs, mean = 50000, sd = 10000),
    k_value = rnorm(total_obs, mean = 60000, sd = 12000),
    u_value = pmax(0, rlnorm(total_obs, meanlog = 11, sdlog = 1.5)),
    p_value = rnorm(total_obs, mean = 40000, sd = 8000),
    v_value = pmax(0, rlnorm(total_obs, meanlog = 12, sdlog = 1.5)),
    e_value = pmax(0, rlnorm(total_obs, meanlog = 11, sdlog = 1.5))
  )
  
  # Trim to exact requested observations
  dt_full <- dt_full[1:obs]
  
  cat(sprintf("Generated %s rows × %d columns\n\n", 
              format(nrow(dt_full), big.mark = ","), ncol(dt_full)))
  
  # Save in different formats
  total_size_csv <- 0
  total_size_parquet <- 0
  
  if (n_files == 1) {
    # Single file output
    cat("Saving data...\n")
    
    if ("csv" %in% formats) {
      csv_path <- file.path(output_dir, "btp_synth.csv")
      fwrite(dt_full, csv_path)
      csv_size <- file.size(csv_path)
      total_size_csv <- csv_size
      cat(sprintf("  CSV: %s (%.2f MB)\n", csv_path, csv_size / 1024^2))
    }
    
    if ("parquet" %in% formats) {
      parquet_path <- file.path(output_dir, "btp_synth.parquet")
      write_parquet(dt_full, parquet_path)
      parquet_size <- file.size(parquet_path)
      total_size_parquet <- parquet_size
      cat(sprintf("  Parquet: %s (%.2f MB)\n", parquet_path, parquet_size / 1024^2))
    }
    
  } else {
    # Multiple files output
    cat(sprintf("Splitting data into %d files...\n", n_files))
    
    # Create partition column
    dt_full[, partition := (seq_len(.N) - 1) %% n_files]
    
    for (i in 0:(n_files - 1)) {
      dt_part <- dt_full[partition == i]
      dt_part[, partition := NULL]
      
      if ("csv" %in% formats) {
        csv_path <- file.path(output_dir, sprintf("btp_synth_%03d.csv", i + 1))
        fwrite(dt_part, csv_path)
        csv_size <- file.size(csv_path)
        total_size_csv <- total_size_csv + csv_size
        cat(sprintf("  CSV %d/%d: %s (%.2f MB)\n", 
                    i + 1, n_files, csv_path, csv_size / 1024^2))
      }
      
      if ("parquet" %in% formats) {
        parquet_path <- file.path(output_dir, sprintf("btp_synth_%03d.parquet", i + 1))
        write_parquet(dt_part, parquet_path)
        parquet_size <- file.size(parquet_path)
        total_size_parquet <- total_size_parquet + parquet_size
        cat(sprintf("  Parquet %d/%d: %s (%.2f MB)\n", 
                    i + 1, n_files, parquet_path, parquet_size / 1024^2))
      }
    }
  }
  
  cat("\n========================================\n")
  cat("Test Data Created Successfully!\n")
  cat("========================================\n")
  cat(sprintf("Total rows: %s\n", format(nrow(dt_full), big.mark = ",")))
  cat(sprintf("Total columns: %d\n", ncol(dt_full)))
  cat(sprintf("Files created: %d\n", n_files))
  
  if (total_size_csv > 0) {
    cat(sprintf("Total CSV size: %.2f MB\n", total_size_csv / 1024^2))
  }
  if (total_size_parquet > 0) {
    cat(sprintf("Total Parquet size: %.2f MB\n", total_size_parquet / 1024^2))
    if (total_size_csv > 0) {
      cat(sprintf("Compression ratio: %.1f%%\n", 
                  (1 - total_size_parquet / total_size_csv) * 100))
    }
  }
  
  cat(sprintf("\nOutput directory: %s\n", normalizePath(output_dir)))
  cat("\nNext step: Rscript 02_benchmark_methods.R\n")
  
  invisible(list(
    rows = nrow(dt_full),
    cols = ncol(dt_full),
    n_files = n_files,
    size_csv_mb = total_size_csv / 1024^2,
    size_parquet_mb = total_size_parquet / 1024^2
  ))
}

# Command-line execution ----
if (!interactive()) {
  # Parse command line arguments
  args <- commandArgs(trailingOnly = TRUE)
  
  # Default values
  obs <- 10000
  n_files <- 1
  output_dir <- "data"
  formats <- c("csv", "parquet")
  seed <- 42
  
  # Parse arguments
  if (length(args) > 0) {
    for (arg in args) {
      if (grepl("^obs=", arg)) {
        obs <- as.numeric(sub("obs=", "", arg))
      } else if (grepl("^n_files=", arg)) {
        n_files <- as.integer(sub("n_files=", "", arg))
      } else if (grepl("^output_dir=", arg)) {
        output_dir <- sub("output_dir=", "", arg)
      } else if (grepl("^formats=", arg)) {
        formats <- strsplit(sub("formats=", "", arg), ",")[[1]]
      } else if (grepl("^seed=", arg)) {
        seed <- as.integer(sub("seed=", "", arg))
      } else if (arg == "--help" || arg == "-h") {
        cat("Usage: Rscript 00_test_setup.R [options]\n\n")
        cat("Options:\n")
        cat("  obs=N              Number of observations (default: 10000)\n")
        cat("  n_files=N          Number of split files (default: 1)\n")
        cat("  output_dir=PATH    Output directory (default: data)\n")
        cat("  formats=csv,parquet File formats (default: csv,parquet)\n")
        cat("  seed=N             Random seed (default: 42)\n\n")
        cat("Examples:\n")
        cat("  Rscript 00_test_setup.R obs=100000 n_files=10\n")
        cat("  Rscript 00_test_setup.R obs=1000000 n_files=5 formats=parquet\n")
        quit(status = 0)
      }
    }
  }
  
  # Generate data
  generate_test_data(obs = obs, n_files = n_files, output_dir = output_dir,
                     formats = formats, seed = seed)
}
