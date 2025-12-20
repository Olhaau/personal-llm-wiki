# Test Clean Excel Formatting
# Test the new clean, professional Excel formatting with Destatis style

# Load the clean formatter
source(".opencode/skills/excel-r-expert/code/clean-excel-formatter.R")

cat("Testing Clean Excel Formatting...\n")

# Create test data with numbers to test formatting
test_data <- data.frame(
  Region = c("Nord", "Süd", "Ost", "West"),
  Bevölkerung = c(1234567, 2345678, 987654, 1876543),
  BIP_Millionen_Euro = c(45678.90, 67890.12, 34567.89, 56789.01),
  Arbeitslosenquote_Prozent = c(7.5, 5.2, 9.1, 6.8),
  Unternehmen = c(12345, 23456, 8765, 18765),
  stringsAsFactors = FALSE
)

cat("Test data created with", nrow(test_data), "rows and", ncol(test_data), "columns\n")

# Test 1: Clean single table
cat("\nTest 1: Creating clean Excel table...\n")
clean_file <- create_clean_excel(
  data = test_data,
  filename = "output/clean_destatis_table.xlsx",
  title = "Regionale Wirtschaftsdaten",
  subtitle = "Bevölkerung, BIP und Arbeitsmarktdaten nach Regionen"
)

# Test 2: Sample Destatis report
cat("\nTest 2: Creating sample Destatis report...\n")
sample_file <- create_sample_destatis_report("output/sample_destatis_clean.xlsx")

# Test 3: Multi-table report
cat("\nTest 3: Creating multi-table report...\n")
data_list <- list(
  "Wirtschaftsdaten" = test_data,
  "Fahrzeugdaten" = data.frame(
    Typ = c("PKW", "LKW", "Bus"),
    Anzahl = c(45000000, 3500000, 750000),
    Durchschnittsalter = c(9.8, 12.3, 11.5),
    stringsAsFactors = FALSE
  )
)

multi_file <- create_clean_multi_table(
  data_list = data_list,
  filename = "output/multi_table_clean.xlsx",
  main_title = "Statistischer Bericht - Deutschland"
)

cat("\n=== Clean Excel Formatting Test Complete ===\n")
cat("Files created with clean Destatis formatting:\n")
cat("  ✓", clean_file, "\n")
cat("  ✓", sample_file, "\n") 
cat("  ✓", multi_file, "\n")
cat("\nFormatting features applied:\n")
cat("  • White background with borders only around tables\n")
cat("  • Space as thousands separator (# ##0,00)\n")
cat("  • 14pt Arial headings in Destatis blue (#004B76)\n")
cat("  • Clean professional appearance\n")
cat("  • Alternating row colors for readability\n")