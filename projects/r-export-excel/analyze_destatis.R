# Analyze Destatis Excel files to understand their formatting
suppressPackageStartupMessages({
  library(openxlsx2)
})

# Analyze a Destatis Excel file
analyze_file <- function(filepath, filename) {
  cat("\n========================================\n")
  cat("File:", filename, "\n")
  cat("========================================\n")
  
  # Load workbook
  wb <- wb_load(filepath)
  
  # Get sheet names
  sheets <- wb$get_sheet_names()
  cat("\nSheets (", length(sheets), "):\n")
  for (i in seq_along(sheets)) {
    cat("  ", i, ":", sheets[i], "\n")
  }
  
  # Analyze first 3 sheets in detail
  for (i in 1:min(3, length(sheets))) {
    sheet_name <- sheets[i]
    cat("\n--- Sheet:", sheet_name, "---\n")
    
    # Read data to understand structure
    tryCatch({
      data <- wb$to_df(sheet = i, start_row = 1, col_names = FALSE)
      cat("  Dimensions:", nrow(data), "rows x", ncol(data), "cols\n")
      
      # Show first few rows
      cat("  First 5 rows:\n")
      print(head(data, 5))
    }, error = function(e) {
      cat("  Error reading sheet:", e$message, "\n")
    })
  }
}

# Analyze each file
analyze_file("examples/destatis_original/mineraloelerzeugnisse.xlsx", 
             "Mineralölerzeugnisse")

analyze_file("examples/destatis_original/energiepreisentwicklung.xlsx", 
             "Energiepreisentwicklung")

# Don't analyze the huge file fully, just get basic info
cat("\n========================================\n")
cat("File: Erzeugerpreise (large file - basic info only)\n")
cat("========================================\n")
wb <- wb_load("examples/destatis_original/erzeugerpreise.xlsx")
sheets <- wb$get_sheet_names()
cat("Sheets:", length(sheets), "\n")
cat("First 10 sheet names:\n")
for (i in 1:min(10, length(sheets))) {
  cat("  ", i, ":", sheets[i], "\n")
}
