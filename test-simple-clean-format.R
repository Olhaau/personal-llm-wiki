# Test Simple Clean Excel Formatting
# Test the simplified clean formatting with outer border only

# Load the simple clean formatter
source(".opencode/skills/excel-r-expert/code/simple-clean-formatter.R")

cat("Testing Simple Clean Excel Formatting...\n")

# Create test data with numbers to test space separator
test_data <- data.frame(
  Region = c("Bayern", "Hessen", "Sachsen", "Hamburg"),
  Einwohner = c(13124737, 6265809, 4071971, 1892122),
  BIP_Mrd_Euro = c(632.9, 294.4, 132.3, 123.3),
  Arbeitslosenquote = c(3.1, 4.2, 7.5, 6.1),
  Unternehmen = c(725630, 341289, 198765, 125430),
  stringsAsFactors = FALSE
)

cat("Test data created with", nrow(test_data), "rows and", ncol(test_data), "columns\n")

# Test 1: Simple clean table
cat("\nTest 1: Creating simple clean Excel table...\n")
simple_file <- create_simple_clean_excel(
  data = test_data,
  filename = "output/simple_clean_table.xlsx",
  title = "Wirtschaftsdaten Bundesländer",
  subtitle = "Stand: 2023"
)

# Test 2: Sample report
cat("\nTest 2: Creating sample clean report...\n") 
sample_file <- create_sample_clean_report("output/sample_clean_report.xlsx")

cat("\n=== Simple Clean Excel Formatting Complete ===\n")
cat("Files created:\n")
cat("  ✓", simple_file, "\n") 
cat("  ✓", sample_file, "\n")
cat("\nFormatting applied:\n")
cat("  • White background\n")
cat("  • Outer border only (no inner borders)\n")
cat("  • Space as thousands separator\n") 
cat("  • 14pt Arial title in Destatis blue\n")
cat("  • Clean professional appearance\n")