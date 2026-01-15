# Detailed Analysis of Original Destatis Excel File
# Focus on precise formatting, fonts, colors, and hyperlinks

library(openxlsx2)

# Load the original file
file_path <- "statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx"
wb <- wb_load(file_path)

cat("=== DETAILED DESTATIS EXCEL ANALYSIS ===\n\n")

# Get sheet names
sheet_names <- wb_get_sheet_names(wb)
cat("SHEETS:", paste(sheet_names, collapse = ", "), "\n\n")

# Focus on Inhaltsübersicht sheet (likely sheet 3 or 4)
if ("Inhaltsübersicht" %in% sheet_names) {
  toc_sheet <- "Inhaltsübersicht"
} else if (length(sheet_names) >= 3) {
  toc_sheet <- sheet_names[3]  # Usually the 3rd sheet
} else {
  toc_sheet <- sheet_names[2]  # Fallback
}

cat("=== ANALYZING SHEET:", toc_sheet, "===\n")

# Read the ToC sheet data
toc_data <- wb_to_df(wb, sheet = toc_sheet, col_names = FALSE, skip_empty_rows = FALSE)
cat("\nTOC Sheet dimensions:", nrow(toc_data), "rows x", ncol(toc_data), "columns\n")

# Show first 20 rows to understand structure
cat("\nFirst 20 rows of ToC:\n")
for (i in 1:min(20, nrow(toc_data))) {
  row_content <- paste(toc_data[i, ], collapse = " | ")
  cat(sprintf("Row %2d: %s\n", i, row_content))
}

# Analyze cell formatting for specific areas
cat("\n=== CELL FORMATTING ANALYSIS ===\n")

# Check workbook structure
cat("Workbook structure elements:\n")
wb_names <- names(wb)
cat("  ", paste(wb_names, collapse = ", "), "\n")

# Try to get worksheet names correctly
ws_names <- names(wb$worksheets)
if (length(ws_names) > 0) {
  cat("Worksheet names in workbook:\n")
  cat("  ", paste(ws_names, collapse = ", "), "\n")
  
  # Find the ToC sheet index
  toc_idx <- which(ws_names == toc_sheet)
  if (length(toc_idx) > 0) {
    cat("Found ToC sheet at index:", toc_idx, "\n")
  } else {
    cat("ToC sheet not found in worksheet names\n")
  }
} else {
  cat("No worksheet names found\n")
}

# Check for hyperlinks in workbook
cat("\n=== HYPERLINK ANALYSIS ===\n")
# Try alternative approach to find hyperlinks
for (sheet_idx in 1:min(3, length(sheet_names))) {
  sheet_name <- sheet_names[sheet_idx]
  cat("Checking sheet:", sheet_name, "\n")
  
  # Try to read with different approaches to find hyperlinks
  tryCatch({
    # Check if we can extract hyperlink information
    sheet_data <- wb_to_df(wb, sheet = sheet_name, col_names = FALSE)
    cat("  Sheet has", nrow(sheet_data), "rows\n")
  }, error = function(e) {
    cat("  Error reading sheet:", e$message, "\n")
  })
}

# Try to analyze a data table sheet for comparison
cat("\n=== DATA TABLE ANALYSIS ===\n")
data_sheets <- sheet_names[grepl("^[0-9]", sheet_names)]  # Sheets starting with numbers
if (length(data_sheets) > 0) {
  cat("Data table sheets:", paste(data_sheets, collapse = ", "), "\n")
  
  # Analyze first data sheet
  first_data_sheet <- data_sheets[1]
  cat("\nAnalyzing data sheet:", first_data_sheet, "\n")
  
  data_content <- wb_to_df(wb, sheet = first_data_sheet, col_names = FALSE, skip_empty_rows = FALSE)
  cat("Dimensions:", nrow(data_content), "rows x", ncol(data_content), "columns\n")
  
  # Show header area
  cat("\nFirst 10 rows of data sheet:\n")
  for (i in 1:min(10, nrow(data_content))) {
    row_content <- paste(data_content[i, ], collapse = " | ")
    cat(sprintf("Row %2d: %s\n", i, row_content))
  }
}

cat("\n=== ANALYSIS COMPLETE ===\n")