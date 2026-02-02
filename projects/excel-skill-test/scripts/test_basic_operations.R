# ---- Test Basic Operations - excel-operations Skill ----
# Purpose: Test fundamental Excel operations using openxlsx2 package
# Output: 01_basic_operations.xlsx
# Features: Workbook creation, data writing, sheet management, basic reading

# Load required libraries
suppressPackageStartupMessages(library(openxlsx2))

# Source sample data
source(here::here("projects/excel-skill-test/data/sample_datasets.R"))

# Set output path
output_path <- here::here("projects/excel-skill-test/output/01_basic_operations.xlsx")

cat("🔧 Testing Basic Operations - excel-operations skill\n")
cat("====================================================\n\n")

# ---- 1. Create New Workbook ----
cat("1. Creating new workbook...\n")
wb <- wb_workbook()

cat("   ✓ New workbook created\n")

# ---- 2. Add Documentation Sheet ----
cat("2. Adding documentation sheet...\n")

wb$add_worksheet("📖 Documentation")

# Add title and description
documentation_text <- data.frame(
  Section = c(
    "BASIC OPERATIONS TEST",
    "",
    "This Excel file demonstrates fundamental openxlsx2 operations:",
    "",
    "Sheet Overview:",
    "• 📖 Documentation - This explanatory sheet",
    "• 📊 Sample Data - Various data types and formats",  
    "• 🔢 Calculations - Formulas and computed values",
    "• 📋 Lists - Different data structures",
    "• ⚙️ Properties - Workbook and sheet properties",
    "",
    "Key Features Tested:",
    "✓ Workbook creation and management", 
    "✓ Worksheet addition and naming",
    "✓ Data writing (data.frames, vectors, individual values)",
    "✓ Multiple data types (numeric, character, date, logical)",
    "✓ Formula creation and calculation",
    "✓ Sheet properties and metadata",
    "✓ File saving and verification",
    "",
    "Generated on:", as.character(Sys.time()),
    "R Version:", R.version.string,
    "openxlsx2 Package: Latest version",
    "",
    "This file serves as:",
    "• Test verification for basic Excel operations",
    "• Template for standard data export workflows", 
    "• Reference for openxlsx2 basic functionality",
    "• Training material for R-Excel integration"
  )
)

wb$add_data(x = documentation_text, dims = "A1", col_names = FALSE)

# Style the documentation  
wb$add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("#2E75B6"))
wb$add_font(dims = "A5", bold = TRUE, size = 12, color = wb_color("#2E75B6"))
wb$add_font(dims = "A13", bold = TRUE, size = 12, color = wb_color("#2E75B6"))
wb$add_font(dims = "A24", bold = TRUE, size = 12, color = wb_color("#2E75B6"))

wb$set_col_widths(sheet = "📖 Documentation", cols = 1, widths = 80)

cat("   ✓ Documentation sheet added with descriptions\n")

# ---- 3. Add Sample Data Sheet ----
cat("3. Adding sample data sheet...\n")

wb$add_worksheet("📊 Sample Data")

# Get sample financial data
financial_data <- get_sample_data("financial")

# Add data with headers
wb$add_data(sheet = "📊 Sample Data", x = financial_data, dims = "A1", with_filter = TRUE)

# Add data type examples
wb$add_data(sheet = "📊 Sample Data", x = "Data Type Examples:", dims = "A10")
wb$add_font(sheet = "📊 Sample Data", dims = "A10", bold = TRUE)

type_examples <- data.frame(
  Type = c("Character", "Numeric", "Date", "Logical", "Currency"),
  Example = c("Sample Text", 12345.67, Sys.Date(), TRUE, 1999.99),
  Description = c("Text string", "Decimal number", "Date value", "Boolean", "Money amount"),
  stringsAsFactors = FALSE
)

wb$add_data(sheet = "📊 Sample Data", x = type_examples, dims = "A11")

# Set column widths
wb$set_col_widths(sheet = "📊 Sample Data", cols = 1:6, widths = "auto")

cat("   ✓ Sample data sheet added with financial data and type examples\n")

# ---- 4. Add Calculations Sheet ----
cat("4. Adding calculations sheet with formulas...\n")

wb$add_worksheet("🔢 Calculations")

# Add some base data for calculations
calc_data <- data.frame(
  Item = c("Base Value", "Multiplier", "Addition", "Subtraction"),
  Value_A = c(100, 2.5, 50, 25),
  Value_B = c(200, 1.8, 75, 15)
)

wb$add_data(sheet = "🔢 Calculations", x = calc_data, dims = "A1")

# Add formula examples
wb$add_data(sheet = "🔢 Calculations", x = "Formula Examples:", dims = "A6")
wb$add_font(sheet = "🔢 Calculations", dims = "A6", bold = TRUE)

# Add formulas
wb$add_formula(sheet = "🔢 Calculations", x = "=SUM(B2:C2)", dims = "D2")
wb$add_formula(sheet = "🔢 Calculations", x = "=B3*C3", dims = "D3")
wb$add_formula(sheet = "🔢 Calculations", x = "=B4+C4", dims = "D4")
wb$add_formula(sheet = "🔢 Calculations", x = "=B5-C5", dims = "D5")

# Add headers for formulas
wb$add_data(sheet = "🔢 Calculations", x = "Result", dims = "D1")
wb$add_font(sheet = "🔢 Calculations", dims = "A1:D1", bold = TRUE)

# Add summary calculations
wb$add_data(sheet = "🔢 Calculations", x = "Summary Statistics:", dims = "A8")
wb$add_font(sheet = "🔢 Calculations", dims = "A8", bold = TRUE)

summary_labels <- data.frame(
  Statistic = c("Total Sum", "Average", "Maximum", "Minimum", "Count"),
  Formula = c("=SUM(B2:C5)", "=AVERAGE(B2:C5)", "=MAX(B2:C5)", "=MIN(B2:C5)", "=COUNT(B2:C5)")
)

wb$add_data(sheet = "🔢 Calculations", x = summary_labels, dims = "A9")

# Add the actual formulas
wb$add_formula(sheet = "🔢 Calculations", x = "=SUM(B2:C5)", dims = "C10")
wb$add_formula(sheet = "🔢 Calculations", x = "=AVERAGE(B2:C5)", dims = "C11")
wb$add_formula(sheet = "🔢 Calculations", x = "=MAX(B2:C5)", dims = "C12")
wb$add_formula(sheet = "🔢 Calculations", x = "=MIN(B2:C5)", dims = "C13")
wb$add_formula(sheet = "🔢 Calculations", x = "=COUNT(B2:C5)", dims = "C14")

wb$set_col_widths(sheet = "🔢 Calculations", cols = 1:4, widths = "auto")

cat("   ✓ Calculations sheet added with formulas and statistics\n")

# ---- 5. Add Lists and Structures Sheet ----
cat("5. Adding lists and data structures sheet...\n")

wb$add_worksheet("📋 Lists")

# Different data structures
wb$add_data(sheet = "📋 Lists", x = "Data Structure Examples:", dims = "A1")
wb$add_font(sheet = "📋 Lists", dims = "A1", bold = TRUE, size = 14)

# Simple vector
wb$add_data(sheet = "📋 Lists", x = "Simple Vector:", dims = "A3")
wb$add_font(sheet = "📋 Lists", dims = "A3", bold = TRUE)
simple_vector <- data.frame(Numbers = 1:10)
wb$add_data(sheet = "📋 Lists", x = simple_vector, dims = "A4")

# Named list
wb$add_data(sheet = "📋 Lists", x = "Named Categories:", dims = "C3")
wb$add_font(sheet = "📋 Lists", dims = "C3", bold = TRUE)
categories <- data.frame(
  Category = c("Electronics", "Books", "Clothing", "Sports", "Home"),
  Code = c("ELEC", "BOOK", "CLTH", "SPRT", "HOME"),
  Active = c(TRUE, TRUE, FALSE, TRUE, TRUE)
)
wb$add_data(sheet = "📋 Lists", x = categories, dims = "C4")

# Date sequence
wb$add_data(sheet = "📋 Lists", x = "Date Sequence:", dims = "A15")
wb$add_font(sheet = "📋 Lists", dims = "A15", bold = TRUE)
date_seq <- data.frame(
  Date = seq(Sys.Date(), by = "week", length.out = 8),
  Week_Number = 1:8
)
wb$add_data(sheet = "📋 Lists", x = date_seq, dims = "A16")

wb$set_col_widths(sheet = "📋 Lists", cols = 1:6, widths = "auto")

cat("   ✓ Lists sheet added with various data structures\n")

# ---- 6. Add Properties Sheet ----
cat("6. Adding properties and metadata sheet...\n")

wb$add_worksheet("⚙️ Properties")

# Workbook information
wb_info <- data.frame(
  Property = c(
    "Creation Date", "R Version", "Operating System", "Package Version",
    "Number of Sheets", "File Format", "Default Font", "Theme"
  ),
  Value = c(
    as.character(Sys.time()),
    R.version.string,
    Sys.info()["sysname"],
    "openxlsx2 (Latest)",
    length(wb_get_sheet_names(wb)),
    "Excel (.xlsx)",
    "Aptos Narrow",
    "Default"
  )
)

wb$add_data(sheet = "⚙️ Properties", x = "Workbook Properties:", dims = "A1")
wb$add_font(sheet = "⚙️ Properties", dims = "A1", bold = TRUE, size = 14)

wb$add_data(sheet = "⚙️ Properties", x = wb_info, dims = "A3")

# Sheet information
wb$add_data(sheet = "⚙️ Properties", x = "Sheet Information:", dims = "A12")
wb$add_font(sheet = "⚙️ Properties", dims = "A12", bold = TRUE, size = 14)

sheet_info <- data.frame(
  Sheet_Name = wb_get_sheet_names(wb),
  Purpose = c(
    "Documentation and overview",
    "Sample data with multiple types",
    "Formula examples and calculations", 
    "Data structures and lists",
    "Workbook metadata and properties"
  ),
  Rows_Used = c("~30", "~15", "~15", "~25", "~15"),
  Features_Demonstrated = c(
    "Text formatting, styling",
    "Data export, filtering",
    "Formulas, calculations",
    "Multiple data types",
    "Metadata, information"
  )
)

wb$add_data(sheet = "⚙️ Properties", x = sheet_info, dims = "A14")

wb$set_col_widths(sheet = "⚙️ Properties", cols = 1:4, widths = "auto")

cat("   ✓ Properties sheet added with workbook metadata\n")

# ---- 7. Set Workbook Properties ----
cat("7. Setting workbook properties...\n")

wb$set_properties(
  title = "Basic Operations Test - excel-operations",
  subject = "Demonstration of fundamental Excel operations using R",
  creator = "excel-operations Skill Test Suite",
  category = "Testing",
  keywords = "R, Excel, openxlsx2, basic operations, testing",
  comments = "Generated automatically to test and demonstrate basic openxlsx2 functionality"
)

cat("   ✓ Workbook properties set\n")

# ---- 8. Save Workbook ----
cat("8. Saving workbook to:", output_path, "\n")

# Create output directory if it doesn't exist
if (!dir.exists(dirname(output_path))) {
  dir.create(dirname(output_path), recursive = TRUE)
}

wb_save(wb, output_path, overwrite = TRUE)

cat("   ✓ Workbook saved successfully\n\n")

# ---- 9. Verification ----
cat("9. Verification:\n")

# Check file exists
if (file.exists(output_path)) {
  file_info <- file.info(output_path)
  cat("   ✓ File created:", output_path, "\n")
  cat("   ✓ File size:", round(file_info$size / 1024, 2), "KB\n")
  
  # Test reading back
  wb_test <- wb_load(output_path)
  sheets <- wb_get_sheet_names(wb_test)
  cat("   ✓ File readable, sheets found:", paste(sheets, collapse = ", "), "\n")
  
  # Test data reading
  sample_data_back <- wb_to_df(wb_test, sheet = "📊 Sample Data")
  cat("   ✓ Data readable, dimensions:", nrow(sample_data_back), "x", ncol(sample_data_back), "\n")
  
} else {
  cat("   ❌ File creation failed\n")
}

cat("\n✅ Basic Operations Test Completed!\n")
cat("==================================\n")
cat("Generated file: 01_basic_operations.xlsx\n")
cat("Features tested:\n")
cat("• Workbook creation and management\n")
cat("• Multiple worksheet addition\n") 
cat("• Data writing (data.frames, vectors, values)\n")
cat("• Formula creation and calculations\n")
cat("• Multiple data types handling\n")
cat("• Metadata and properties\n")
cat("• File saving and reading verification\n")
cat("\nOpen the Excel file to see the results!\n")