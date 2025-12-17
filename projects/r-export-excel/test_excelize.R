# test_excelize.R ----
# Test script for excelize() function

cat("\n" ,"=".rep(60), "\n", sep = "")
cat("Testing excelize() function\n")
cat("=".rep(60), "\n\n", sep = "")

# Test 1: Check required packages ----
cat("Test 1: Checking required packages... ")
required_packages <- c("openxlsx2", "gt", "yaml")
missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if (length(missing_packages) > 0) {
  cat("FAILED\n")
  cat("Missing packages:", paste(missing_packages, collapse = ", "), "\n")
  cat("Install with: install.packages(c('", paste(missing_packages, collapse = "', '"), "'))\n", sep = "")
  stop("Required packages not installed")
} else {
  cat("PASSED\n")
}

# Test 2: Load excelize function ----
cat("Test 2: Loading excelize function... ")
tryCatch({
  source("R/excelize.R")
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to load excelize function")
})

# Test 3: Check config file exists ----
cat("Test 3: Checking configuration file... ")
if (file.exists("config/destatis_style.yaml")) {
  cat("PASSED\n")
} else {
  cat("FAILED\n")
  stop("Configuration file not found: config/destatis_style.yaml")
}

# Test 4: Load style configuration ----
cat("Test 4: Loading style configuration... ")
tryCatch({
  config <- load_style_config("config/destatis_style.yaml")
  if (is.null(config$font) || is.null(config$colors)) {
    stop("Invalid configuration structure")
  }
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to load style configuration")
})

# Test 5: Create output directory ----
cat("Test 5: Creating output directory... ")
if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}
cat("PASSED\n")

# Test 6: Create simple gt table ----
cat("Test 6: Creating test gt table... ")
tryCatch({
  suppressPackageStartupMessages(library(gt))
  test_data <- data.frame(
    Name = c("Alice", "Bob", "Charlie"),
    Age = c(25, 30, 35),
    Score = c(85.5, 92.3, 78.9)
  )
  test_gt <- gt(test_data)
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to create gt table")
})

# Test 7: Export to Excel with minimal options ----
cat("Test 7: Exporting with minimal options... ")
tryCatch({
  excelize(
    gt_object = test_gt,
    filename = "output/test_minimal.xlsx",
    sheet_name = "Test",
    create_index = FALSE
  )
  if (!file.exists("output/test_minimal.xlsx")) {
    stop("Output file not created")
  }
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to export with minimal options")
})

# Test 8: Export with heading ----
cat("Test 8: Exporting with heading... ")
tryCatch({
  excelize(
    gt_object = test_gt,
    filename = "output/test_heading.xlsx",
    sheet_name = "Test",
    heading = "Test Report",
    create_index = FALSE
  )
  if (!file.exists("output/test_heading.xlsx")) {
    stop("Output file not created")
  }
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to export with heading")
})

# Test 9: Export with frozen panes ----
cat("Test 9: Exporting with frozen panes... ")
tryCatch({
  excelize(
    gt_object = test_gt,
    filename = "output/test_freeze.xlsx",
    sheet_name = "Test",
    heading = "Test with Frozen Panes",
    freeze_rows = 2,
    freeze_cols = 1,
    create_index = FALSE
  )
  if (!file.exists("output/test_freeze.xlsx")) {
    stop("Output file not created")
  }
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to export with frozen panes")
})

# Test 10: Export multiple sheets with index ----
cat("Test 10: Exporting multiple sheets with index... ")
tryCatch({
  # First sheet
  excelize(
    gt_object = test_gt,
    filename = "output/test_multi.xlsx",
    sheet_name = "Sheet1",
    heading = "First Sheet",
    add_index_link = TRUE,
    create_index = TRUE,
    append = FALSE
  )
  
  # Second sheet
  test_gt2 <- gt(data.frame(X = 1:3, Y = 4:6))
  excelize(
    gt_object = test_gt2,
    filename = "output/test_multi.xlsx",
    sheet_name = "Sheet2",
    heading = "Second Sheet",
    add_index_link = TRUE,
    create_index = TRUE,
    append = TRUE
  )
  
  if (!file.exists("output/test_multi.xlsx")) {
    stop("Output file not created")
  }
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to export multiple sheets")
})

# Test 11: Verify Excel file can be read ----
cat("Test 11: Verifying Excel file integrity... ")
tryCatch({
  suppressPackageStartupMessages(library(openxlsx2))
  wb <- wb_load("output/test_minimal.xlsx")
  sheets <- wb$get_sheet_names()
  if (length(sheets) == 0) {
    stop("No sheets found in workbook")
  }
  cat("PASSED\n")
}, error = function(e) {
  cat("FAILED\n")
  cat("Error:", e$message, "\n")
  stop("Failed to verify Excel file")
})

# Summary ----
cat("\n", "=".rep(60), "\n", sep = "")
cat("All tests PASSED successfully!\n")
cat("=".rep(60), "\n\n", sep = "")

cat("Generated test files in output/:\n")
test_files <- list.files("output", pattern = "^test_.*\\.xlsx$", full.names = FALSE)
for (f in test_files) {
  size <- file.info(file.path("output", f))$size
  cat(sprintf("  - %s (%.1f KB)\n", f, size / 1024))
}

cat("\nYou can now run the full examples with:\n")
cat("  Rscript examples/example_usage.R\n\n")
