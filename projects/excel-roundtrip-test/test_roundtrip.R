# ---- Excel Round-Trip Test Suite ----
# Tests complete cycle: Excel → JSON → Excel

library(openxlsx2)
library(jsonlite)
library(testthat)

# Source required skills
source("../../.opencode/skills/excel-operations/code/excel_helpers.R")
source("../../.opencode/skills/excel-extractor/code/extraction_engine.R")
source("create_reconstruction.R")
source("validate_roundtrip.R")

# ---- Main Test Functions ----

#' Run complete round-trip test suite
#' 
#' @param test_files Vector of Excel files to test (optional)
#' @param output_detailed Logical, create detailed reports
#' @return List with test results and summary
run_complete_roundtrip_test <- function(test_files = NULL, output_detailed = TRUE) {
  
  cat("=== EXCEL ROUND-TRIP TEST SUITE ===\n")
  start_time <- Sys.time()
  
  # Create output directories
  create_output_directories()
  
  # Use default test files if none specified
  if (is.null(test_files)) {
    test_files <- create_test_files()
  }
  
  # Initialize results
  test_results <- list(
    timestamp = Sys.time(),
    test_files = test_files,
    individual_results = list(),
    summary = list()
  )
  
  # Run tests for each file
  for (test_file in test_files) {
    cat(sprintf("\n--- Testing: %s ---\n", basename(test_file)))
    
    tryCatch({
      file_result <- run_single_roundtrip_test(
        test_file, 
        output_detailed = output_detailed
      )
      test_results$individual_results[[basename(test_file)]] <- file_result
      
    }, error = function(e) {
      cat("ERROR:", e$message, "\n")
      test_results$individual_results[[basename(test_file)]] <- list(
        status = "ERROR",
        error_message = e$message,
        extraction_success = FALSE,
        reconstruction_success = FALSE,
        validation_score = 0
      )
    })
  }
  
  # Generate summary
  test_results$summary <- generate_test_summary(test_results$individual_results)
  
  # Save results
  end_time <- Sys.time()
  test_results$duration <- as.numeric(difftime(end_time, start_time, units = "secs"))
  
  save_test_results(test_results)
  print_test_summary(test_results$summary)
  
  return(test_results)
}

#' Run round-trip test for a single Excel file
#' 
#' @param excel_file Path to Excel file
#' @param output_detailed Create detailed validation report
#' @return List with test results
run_single_roundtrip_test <- function(excel_file, output_detailed = TRUE) {
  
  file_base <- tools::file_path_sans_ext(basename(excel_file))
  
  # Step 1: Extract Excel to JSON
  cat("  Step 1: Extracting to JSON...\n")
  extract_start <- Sys.time()
  
  wb_original <- wb_load(excel_file)
  json_file <- file.path("output/extracted_specs", paste0(file_base, "_specs.json"))
  
  specs <- extract_excel_specifications(
    wb_original,
    output_file = json_file,
    include_raw_data = TRUE,
    include_formatting = TRUE,
    include_advanced = TRUE
  )
  
  extract_time <- as.numeric(difftime(Sys.time(), extract_start, units = "secs"))
  extraction_success <- file.exists(json_file)
  
  if (!extraction_success) {
    return(list(
      status = "EXTRACT_FAILED",
      extraction_success = FALSE,
      reconstruction_success = FALSE,
      validation_score = 0
    ))
  }
  
  # Step 2: Reconstruct Excel from JSON
  cat("  Step 2: Reconstructing Excel...\n")
  reconstruct_start <- Sys.time()
  
  reconstructed_file <- file.path("output/reconstructed", paste0(file_base, "_reconstructed.xlsx"))
  
  wb_reconstructed <- reconstruct_excel_from_json(json_file)
  wb_save(wb_reconstructed, reconstructed_file, overwrite = TRUE)
  
  reconstruct_time <- as.numeric(difftime(Sys.time(), reconstruct_start, units = "secs"))
  reconstruction_success <- file.exists(reconstructed_file)
  
  if (!reconstruction_success) {
    return(list(
      status = "RECONSTRUCT_FAILED", 
      extraction_success = TRUE,
      reconstruction_success = FALSE,
      validation_score = 0,
      extract_time = extract_time
    ))
  }
  
  # Step 3: Validate round-trip accuracy
  cat("  Step 3: Validating accuracy...\n")
  validate_start <- Sys.time()
  
  validation_result <- validate_roundtrip(
    original_file = excel_file,
    reconstructed_file = reconstructed_file,
    specifications = specs,
    output_detailed = output_detailed
  )
  
  validate_time <- as.numeric(difftime(Sys.time(), validate_start, units = "secs"))
  
  # Compile results
  result <- list(
    status = "COMPLETED",
    extraction_success = extraction_success,
    reconstruction_success = reconstruction_success,
    validation_score = validation_result$overall_score,
    grade = assign_grade(validation_result$overall_score),
    timings = list(
      extract_seconds = extract_time,
      reconstruct_seconds = reconstruct_time,
      validate_seconds = validate_time,
      total_seconds = extract_time + reconstruct_time + validate_time
    ),
    file_sizes = list(
      original_mb = file.size(excel_file) / (1024^2),
      json_mb = file.size(json_file) / (1024^2),
      reconstructed_mb = file.size(reconstructed_file) / (1024^2)
    ),
    validation_details = validation_result,
    files_created = list(
      json_specs = json_file,
      reconstructed_excel = reconstructed_file
    )
  )
  
  cat(sprintf("  Result: %s (Score: %.1f%%, Grade: %s)\n", 
              result$status, result$validation_score, result$grade))
  
  return(result)
}

# ---- Test File Creation ----

#' Create test Excel files for round-trip testing
#' 
#' @return Vector of created test file paths
create_test_files <- function() {
  
  cat("Creating test Excel files...\n")
  
  test_files <- c()
  
  # Simple test file
  simple_file <- create_simple_test_file()
  test_files <- c(test_files, simple_file)
  
  # Complex formatting test file  
  complex_file <- create_complex_formatting_test_file()
  test_files <- c(test_files, complex_file)
  
  # Advanced features test file
  advanced_file <- create_advanced_features_test_file()
  test_files <- c(test_files, advanced_file)
  
  return(test_files)
}

#' Create simple test Excel file
create_simple_test_file <- function() {
  
  file_path <- "input/simple_test.xlsx"
  
  # Create basic workbook
  wb <- wb_workbook() %>%
    wb_add_worksheet("Test_Data")
  
  # Add simple data
  test_data <- data.frame(
    Name = c("Alice", "Bob", "Charlie", "Diana"),
    Age = c(25, 30, 35, 28),
    Salary = c(50000, 60000, 70000, 55000),
    Department = c("Sales", "IT", "Finance", "HR"),
    stringsAsFactors = FALSE
  )
  
  wb <- wb %>%
    wb_add_data(x = test_data, dims = "A1", with_filter = TRUE) %>%
    wb_add_font(dims = "A1:D1", bold = TRUE, size = 12) %>%
    wb_add_fill(dims = "A1:D1", color = wb_color("#4472C4")) %>%
    wb_add_font(dims = "A1:D1", color = wb_color("white")) %>%
    wb_set_col_widths(cols = 1:4, widths = "auto") %>%
    wb_add_numfmt(dims = "C:C", numfmt = "$#,##0")
  
  wb_save(wb, file_path, overwrite = TRUE)
  cat("  Created:", file_path, "\n")
  
  return(file_path)
}

#' Create complex formatting test Excel file  
create_complex_formatting_test_file <- function() {
  
  file_path <- "input/complex_formatting.xlsx"
  
  # Create workbook with complex formatting
  wb <- create_styled_workbook() %>%
    wb_add_worksheet("Complex_Data")
  
  # Create sample data
  complex_data <- data.frame(
    Region = rep(c("North", "South", "East", "West"), each = 3),
    Product = rep(c("Widget A", "Widget B", "Widget C"), 4),
    Sales = runif(12, 10000, 50000),
    Target = runif(12, 15000, 45000),
    Performance = runif(12, 0.7, 1.3),
    stringsAsFactors = FALSE
  )
  
  complex_data$Difference <- complex_data$Sales - complex_data$Target
  
  wb <- wb %>%
    wb_add_data(x = complex_data, dims = "A1", with_filter = TRUE)
  
  # Apply complex formatting blocks
  wb <- format_data_table(wb, "Complex_Data", complex_data)
  
  # Add conditional formatting overlays
  wb <- wb %>%
    wb_add_conditional_formatting(
      dims = "F2:F13",
      rule = "cellIs",
      style = c(">=0"),
      dxf = create_dxfs_style(bg_fill = wb_color("#90EE90"))
    ) %>%
    wb_add_conditional_formatting(
      dims = "F2:F13", 
      rule = "cellIs",
      style = c("<0"),
      dxf = create_dxfs_style(bg_fill = wb_color("#FFB6C1"))
    )
  
  # Merge cells for title
  wb <- wb %>%
    wb_merge_cells(dims = "A14:F14") %>%
    wb_add_data(x = "Sales Performance Analysis", dims = "A14") %>%
    wb_add_font(dims = "A14", bold = TRUE, size = 14) %>%
    wb_add_cell_style(dims = "A14", horizontal = "center")
  
  wb_save(wb, file_path, overwrite = TRUE)
  cat("  Created:", file_path, "\n")
  
  return(file_path)
}

#' Create advanced features test Excel file
create_advanced_features_test_file <- function() {
  
  file_path <- "input/advanced_features.xlsx"
  
  # Create workbook with advanced features
  wb <- wb_workbook() %>%
    wb_add_worksheet("Data") %>%
    wb_add_worksheet("Summary") %>%
    wb_add_worksheet("Charts")
  
  # Add data with formulas
  data_with_formulas <- data.frame(
    Month = month.name[1:12],
    Sales = round(runif(12, 10000, 30000)),
    Costs = round(runif(12, 5000, 15000)),
    stringsAsFactors = FALSE
  )
  
  wb <- wb %>%
    wb_add_data(sheet = "Data", x = data_with_formulas, dims = "A1")
  
  # Add formula column
  wb <- wb %>%
    wb_add_data(sheet = "Data", x = "Profit", dims = "D1") %>%
    wb_add_formula(sheet = "Data", x = "=B2-C2", dims = "D2") %>%
    wb_add_formula(sheet = "Data", x = "=B3-C3", dims = "D3") %>%
    wb_add_formula(sheet = "Data", x = "=B4-C4", dims = "D4")
  
  # Add data validation
  wb <- wb %>%
    wb_add_data_validation(
      sheet = "Data",
      dims = "E2:E13", 
      type = "list",
      value = '"Excellent,Good,Fair,Poor"'
    )
  
  # Add hyperlink
  wb <- wb %>%
    wb_add_hyperlink(
      sheet = "Summary",
      dims = "A1",
      target = "Data!A1",
      display = "View Data Sheet"
    )
  
  # Add comment
  wb <- wb %>%
    wb_add_comment(
      sheet = "Data",
      dims = "D2",
      comment = "This is a calculated profit field",
      author = "Test User"
    )
  
  wb_save(wb, file_path, overwrite = TRUE)
  cat("  Created:", file_path, "\n")
  
  return(file_path)
}

# ---- Utility Functions ----

#' Create output directories
create_output_directories <- function() {
  dirs <- c(
    "input",
    "output",
    "output/extracted_specs", 
    "output/reconstructed",
    "output/validation_reports",
    "test_results"
  )
  
  for (dir in dirs) {
    if (!dir.exists(dir)) {
      dir.create(dir, recursive = TRUE)
    }
  }
}

#' Assign letter grade based on validation score
#' 
#' @param score Numeric validation score (0-100)
#' @return Character grade (A, B, C, D, F)
assign_grade <- function(score) {
  if (score >= 90) return("A")
  if (score >= 80) return("B") 
  if (score >= 70) return("C")
  if (score >= 60) return("D")
  return("F")
}

#' Generate test summary from individual results
#' 
#' @param individual_results List of individual test results
#' @return List with summary statistics
generate_test_summary <- function(individual_results) {
  
  total_tests <- length(individual_results)
  successful_extractions <- sum(sapply(individual_results, function(r) r$extraction_success))
  successful_reconstructions <- sum(sapply(individual_results, function(r) r$reconstruction_success))
  
  scores <- sapply(individual_results, function(r) r$validation_score)
  average_score <- mean(scores)
  
  grades <- sapply(individual_results, function(r) assign_grade(r$validation_score))
  grade_distribution <- table(grades)
  
  summary <- list(
    total_tests = total_tests,
    successful_extractions = successful_extractions,
    successful_reconstructions = successful_reconstructions,
    extraction_rate = successful_extractions / total_tests * 100,
    reconstruction_rate = successful_reconstructions / total_tests * 100,
    average_validation_score = average_score,
    overall_grade = assign_grade(average_score),
    grade_distribution = as.list(grade_distribution),
    passing_tests = sum(scores >= 70),
    passing_rate = sum(scores >= 70) / total_tests * 100
  )
  
  return(summary)
}

#' Save test results to files
#' 
#' @param test_results Complete test results list
save_test_results <- function(test_results) {
  
  # Save detailed results as JSON
  results_file <- file.path("test_results", "roundtrip_test_results.json")
  write_json(test_results, results_file, pretty = TRUE, auto_unbox = TRUE)
  
  # Save summary as CSV for easy analysis
  summary_df <- data.frame(
    file = names(test_results$individual_results),
    extraction_success = sapply(test_results$individual_results, function(r) r$extraction_success),
    reconstruction_success = sapply(test_results$individual_results, function(r) r$reconstruction_success),
    validation_score = sapply(test_results$individual_results, function(r) r$validation_score),
    grade = sapply(test_results$individual_results, function(r) assign_grade(r$validation_score)),
    extract_time = sapply(test_results$individual_results, function(r) r$timings$extract_seconds %||% NA),
    reconstruct_time = sapply(test_results$individual_results, function(r) r$timings$reconstruct_seconds %||% NA),
    total_time = sapply(test_results$individual_results, function(r) r$timings$total_seconds %||% NA),
    stringsAsFactors = FALSE
  )
  
  summary_file <- file.path("test_results", "test_summary.csv")
  write.csv(summary_df, summary_file, row.names = FALSE)
  
  cat("\nTest results saved to:\n")
  cat("  Detailed:", results_file, "\n")
  cat("  Summary:", summary_file, "\n")
}

#' Print test summary to console
#' 
#' @param summary Test summary list
print_test_summary <- function(summary) {
  
  cat("\n=== TEST SUMMARY ===\n")
  cat(sprintf("Total Tests: %d\n", summary$total_tests))
  cat(sprintf("Extraction Success Rate: %.1f%%\n", summary$extraction_rate))
  cat(sprintf("Reconstruction Success Rate: %.1f%%\n", summary$reconstruction_rate))
  cat(sprintf("Average Validation Score: %.1f%%\n", summary$average_validation_score))
  cat(sprintf("Overall Grade: %s\n", summary$overall_grade))
  cat(sprintf("Passing Tests (≥70%%): %d/%d (%.1f%%)\n", 
              summary$passing_tests, summary$total_tests, summary$passing_rate))
  
  if (length(summary$grade_distribution) > 0) {
    cat("\nGrade Distribution:\n")
    for (grade in names(summary$grade_distribution)) {
      cat(sprintf("  %s: %d\n", grade, summary$grade_distribution[[grade]]))
    }
  }
}

# ---- Benchmark Functions ----

#' Run performance benchmarks for round-trip operations
#' 
#' @param iterations Number of iterations per benchmark
#' @return List with benchmark results
run_roundtrip_benchmarks <- function(iterations = 3) {
  
  cat("=== ROUND-TRIP PERFORMANCE BENCHMARKS ===\n")
  
  # Create test files if they don't exist
  if (!file.exists("input/simple_test.xlsx")) {
    create_test_files()
  }
  
  benchmark_results <- list()
  test_files <- list.files("input", pattern = "\\.xlsx$", full.names = TRUE)
  
  for (file_path in test_files) {
    file_name <- basename(file_path)
    cat(sprintf("\nBenchmarking: %s\n", file_name))
    
    file_size_mb <- file.size(file_path) / (1024^2)
    
    # Benchmark extraction
    extract_times <- numeric(iterations)
    for (i in 1:iterations) {
      start_time <- Sys.time()
      wb <- wb_load(file_path)
      specs <- extract_excel_specifications(wb)
      extract_times[i] <- as.numeric(difftime(Sys.time(), start_time, units = "secs"))
    }
    
    # Benchmark reconstruction (using cached specs)
    reconstruct_times <- numeric(iterations)
    for (i in 1:iterations) {
      start_time <- Sys.time()
      wb_new <- reconstruct_excel_from_json_specs(specs)
      reconstruct_times[i] <- as.numeric(difftime(Sys.time(), start_time, units = "secs"))
    }
    
    benchmark_results[[file_name]] <- list(
      file_size_mb = file_size_mb,
      extraction = list(
        mean_seconds = mean(extract_times),
        min_seconds = min(extract_times),
        max_seconds = max(extract_times),
        mb_per_second = file_size_mb / mean(extract_times)
      ),
      reconstruction = list(
        mean_seconds = mean(reconstruct_times),
        min_seconds = min(reconstruct_times),
        max_seconds = max(reconstruct_times)
      ),
      roundtrip = list(
        total_mean_seconds = mean(extract_times) + mean(reconstruct_times),
        efficiency_score = file_size_mb / (mean(extract_times) + mean(reconstruct_times))
      )
    )
    
    cat(sprintf("  Extraction: %.3f sec (%.2f MB/sec)\n", 
                mean(extract_times), file_size_mb / mean(extract_times)))
    cat(sprintf("  Reconstruction: %.3f sec\n", mean(reconstruct_times)))
    cat(sprintf("  Round-trip Total: %.3f sec\n", 
                mean(extract_times) + mean(reconstruct_times)))
  }
  
  # Save benchmark results
  benchmark_file <- file.path("test_results", "benchmark_results.json")
  write_json(benchmark_results, benchmark_file, pretty = TRUE, auto_unbox = TRUE)
  
  return(benchmark_results)
}

# ---- Main Execution ----

if (!interactive()) {
  # Run tests when script is executed directly
  cat("Starting Excel Round-Trip Test Suite...\n")
  results <- run_complete_roundtrip_test()
  
  # Run benchmarks
  cat("\nRunning performance benchmarks...\n") 
  benchmarks <- run_roundtrip_benchmarks()
  
  cat("\n=== COMPLETE ===\n")
  cat("Round-trip testing finished successfully!\n")
}