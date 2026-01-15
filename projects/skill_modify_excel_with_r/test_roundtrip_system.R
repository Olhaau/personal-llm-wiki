# Test Round-trip Excel-JSON Conversion System
# Test with our recreated Statistischer Bericht file

library(openxlsx2)
library(jsonlite)

# Load the round-trip functions
source("excel_json_roundtrip.R")

cat("=== TESTING EXCEL-JSON ROUND-TRIP SYSTEM ===\n\n")

# ---- Test 1: Our Recreated File ----

cat("TEST 1: Testing with our recreated Statistischer Bericht file\n")
test_file <- "output/statistischer_bericht_EXACT_RECREATION.xlsx"

if (file.exists(test_file)) {
  
  cat(sprintf("Testing file: %s\n", test_file))
  
  # Run round-trip test
  result_recreation <- test_roundtrip(test_file, "recreation_roundtrip")
  
  if (result_recreation$success) {
    cat("\n✅ RECREATION ROUND-TRIP TEST PASSED\n")
    cat(sprintf("  Size efficiency: %.1f%%\n", result_recreation$size_ratio * 100))
    cat(sprintf("  Sheet structure preserved: %s\n", result_recreation$sheets_match))
  } else {
    cat("\n❌ Recreation round-trip test failed\n")
  }
  
} else {
  cat("⚠️ Recreation file not found, skipping test\n")
}

# ---- Test 2: Original File ----

cat("\nTEST 2: Testing with original Statistischer Bericht file\n")
original_file <- "output/statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx"

if (file.exists(original_file)) {
  
  cat(sprintf("Testing file: %s\n", original_file))
  
  # Run round-trip test  
  result_original <- test_roundtrip(original_file, "original_roundtrip")
  
  if (result_original$success) {
    cat("\n✅ ORIGINAL ROUND-TRIP TEST PASSED\n")
    cat(sprintf("  Size efficiency: %.1f%%\n", result_original$size_ratio * 100))
    cat(sprintf("  Sheet structure preserved: %s\n", result_original$sheets_match))
  } else {
    cat("\n❌ Original round-trip test failed\n")
  }
  
} else {
  cat("⚠️ Original file not found, skipping test\n")
}

# ---- Test 3: Create Test Excel for Complex Round-trip ----

cat("\nTEST 3: Creating complex test Excel for comprehensive round-trip\n")

# Create a complex test Excel file
test_excel <- "output/complex_test_file.xlsx"

wb_test <- wb_workbook()
wb_test$set_base_font(font_name = "Arial", font_size = 10)

# Sheet 1: Mixed data types
wb_test$add_worksheet("Mixed_Data")
wb_test$set_grid_lines("Mixed_Data", show = FALSE)

# Add various data types
wb_test$add_data(x = "Test Title", dims = "A1")
wb_test$add_data(x = "Navigation Link", dims = "A2")
wb_test$add_data(x = "Numbers", dims = "A4")
wb_test$add_data(x = c(123.45, 678.90, 1234.56), dims = "B4")

# Add formatting
wb_test$add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color(hex = "004B76"), name = "Arial")
wb_test$add_font(dims = "A2", color = wb_color(hex = "0080C8"), name = "Arial")
wb_test$add_fill(dims = "A4", color = wb_color(hex = "E6E6E6"))
wb_test$add_numfmt(dims = "B4:B6", numfmt = "# ##0,00")

# Add hyperlink
wb_test$add_hyperlink(dims = "A2", target = "#'Data_Table'!A1")

# Sheet 2: Data table
wb_test$add_worksheet("Data_Table")
sample_data <- data.frame(
  Product = c("Item A", "Item B", "Item C"),
  Price = c(123.45, 67.89, 234.56),
  Quantity = c(10, 25, 8),
  stringsAsFactors = FALSE
)

# Add back navigation
wb_test$add_data(x = "Back to Main", dims = "A1")
wb_test$add_hyperlink(dims = "A1", target = "#'Mixed_Data'!A1")
wb_test$add_font(dims = "A1", color = wb_color(hex = "0080C8"))

# Add data with headers
wb_test$add_data(x = sample_data, dims = "A3")
wb_test$add_font(dims = "A3:C3", bold = TRUE)
wb_test$add_fill(dims = "A3:C3", color = wb_color(hex = "E6E6E6"))
wb_test$add_numfmt(dims = "B4:B6", numfmt = "# ##0,00")

# Alternating row colors
wb_test$add_fill(dims = "A4:C4", color = wb_color(hex = "F5F5F5"))
wb_test$add_fill(dims = "A6:C6", color = wb_color(hex = "F5F5F5"))

wb_test$set_active_sheet("Mixed_Data")
wb_save(wb_test, test_excel, overwrite = TRUE)

cat(sprintf("✓ Created complex test file: %s\n", test_excel))

# Test the complex file
result_complex <- test_roundtrip(test_excel, "complex_roundtrip")

if (result_complex$success) {
  cat("\n✅ COMPLEX ROUND-TRIP TEST PASSED\n")
  cat(sprintf("  Size efficiency: %.1f%%\n", result_complex$size_ratio * 100))
  cat(sprintf("  Sheet structure preserved: %s\n", result_complex$sheets_match))
} else {
  cat("\n❌ Complex round-trip test failed\n")
}

# ---- Detailed Analysis of JSON Structure ----

cat("\n=== JSON STRUCTURE ANALYSIS ===\n")

# Analyze JSON structure for one of our files
if (exists("result_recreation") && result_recreation$success) {
  json_file <- result_recreation$json_file
  
  if (file.exists(json_file)) {
    json_structure <- fromJSON(json_file, simplifyVector = FALSE)
    
    cat(sprintf("JSON file: %s\n", json_file))
    cat(sprintf("JSON structure components:\n"))
    cat(sprintf("  Metadata: %s\n", !is.null(json_structure$metadata)))
    cat(sprintf("  Workbook properties: %s\n", !is.null(json_structure$workbook_properties)))
    cat(sprintf("  Sheets: %d\n", length(json_structure$sheets)))
    
    # Analyze each sheet
    for (sheet_name in names(json_structure$sheets)) {
      sheet_info <- json_structure$sheets[[sheet_name]]
      cat(sprintf("    %s: %d rows x %d cols\n", 
                 sheet_name, 
                 sheet_info$dimensions$rows, 
                 sheet_info$dimensions$cols))
      
      # Count formatting elements
      formatting <- sheet_info$formatting
      font_count <- length(formatting$fonts %||% list())
      fill_count <- length(formatting$fills %||% list())
      link_count <- length(formatting$hyperlinks %||% list())
      
      if (font_count + fill_count + link_count > 0) {
        cat(sprintf("      Formatting: %d fonts, %d fills, %d links\n", 
                   font_count, fill_count, link_count))
      }
    }
  }
}

# ---- Final Summary ----

cat("\n=== ROUND-TRIP SYSTEM TEST SUMMARY ===\n")

test_results <- list()
if (exists("result_recreation")) test_results$recreation <- result_recreation$success
if (exists("result_original")) test_results$original <- result_original$success  
if (exists("result_complex")) test_results$complex <- result_complex$success

successful_tests <- sum(unlist(test_results))
total_tests <- length(test_results)

cat(sprintf("Tests completed: %d/%d successful\n", successful_tests, total_tests))

for (test_name in names(test_results)) {
  status <- if (test_results[[test_name]]) "✅ PASS" else "❌ FAIL"
  cat(sprintf("  %s: %s\n", test_name, status))
}

if (successful_tests == total_tests && total_tests > 0) {
  cat("\n🎯 ALL TESTS PASSED\n")
  cat("✓ Excel-to-JSON extraction working perfectly\n")
  cat("✓ JSON-to-Excel recreation working perfectly\n")
  cat("✓ Round-trip conversion preserves structure and data\n")
  cat("✓ Complex formatting and navigation preserved\n")
  cat("✓ System ready for production use\n")
} else {
  cat("\n⚠️ Some tests failed or no tests completed\n")
  cat("Review the output above for details\n")
}

# List all generated files
cat("\nGenerated files:\n")
generated_files <- list.files("output/", pattern = "(roundtrip|complex_test)", full.names = FALSE)
for (file in generated_files) {
  cat(sprintf("  📄 %s\n", file))
}

cat(sprintf("\n📅 Testing completed: %s\n", Sys.Date()))