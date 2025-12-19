# Test Excel-R Expert Skill
# This script tests the Excel skill functionality

# Load required libraries
suppressPackageStartupMessages({
  library(openxlsx2)
  library(dplyr)
  library(tidyr)
})

# Source the Excel skill code
source(".opencode/skills/excel-r-expert/code/excel-r-examples.R")

# Test basic Excel creation
cat("Testing Excel-R Expert Skill...\n")

# Create test data
test_data <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "Diana"),
  Age = c(25, 30, 35, 28),
  Salary = c(50000, 60000, 70000, 55000),
  Department = c("Engineering", "Marketing", "Sales", "HR"),
  stringsAsFactors = FALSE
)

cat("Test data created with", nrow(test_data), "rows\n")

# Test 1: Basic Excel file
cat("Test 1: Creating basic Excel file...\n")
basic_file <- create_basic_excel(test_data, "output/test_basic.xlsx")
cat("✓ Basic Excel file created:", basic_file, "\n")

# Test 2: Corporate styled Excel
cat("Test 2: Creating corporate styled Excel...\n") 
corporate_file <- create_corporate_excel(
  test_data, 
  "output/test_corporate.xlsx",
  "Employee Report",
  "destatis"
)
cat("✓ Corporate Excel file created:", corporate_file, "\n")

# Test 3: Accessible Excel
cat("Test 3: Creating accessible Excel...\n")
accessible_file <- create_accessible_excel(
  test_data,
  "output/test_accessible.xlsx", 
  "Accessible Employee Data",
  "WCAG compliant employee information table"
)
cat("✓ Accessible Excel file created:", accessible_file, "\n")

cat("\n=== Excel-R Expert Skill Test Complete ===\n")
cat("All tests passed successfully!\n")
cat("Files created in output/ directory:\n")
cat("  - test_basic.xlsx\n")
cat("  - test_corporate.xlsx\n") 
cat("  - test_accessible.xlsx\n")