# Analyze Statistischer Bericht Excel File
# Extract corporate design elements for style guide

library(openxlsx2)

# Load the statistischer bericht file
file_path <- "statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx"
wb <- wb_load(file_path)

cat("=== STATISTISCHER BERICHT ANALYSIS ===\n\n")

# 1. Get sheet names and structure
sheet_names <- wb_get_sheet_names(wb)
cat("1. SHEET STRUCTURE:\n")
cat("Number of sheets:", length(sheet_names), "\n")
for (i in seq_along(sheet_names)) {
  cat(sprintf("  %d. %s\n", i, sheet_names[i]))
}
cat("\n")

# 2. Analyze each sheet for content and layout
for (sheet_name in sheet_names) {
  cat(sprintf("=== SHEET: %s ===\n", sheet_name))
  
  tryCatch({
    # Try to read the sheet
    data <- wb_to_df(wb, sheet = sheet_name)
    
    if (nrow(data) > 0) {
      cat(sprintf("Dimensions: %d rows x %d columns\n", nrow(data), ncol(data)))
      cat("Column names:\n")
      for (col in names(data)) {
        cat(sprintf("  - %s\n", col))
      }
      
      # Show first few rows to understand structure
      cat("\nFirst 3 rows (sample data):\n")
      print(head(data, 3))
    } else {
      cat("Empty sheet or no readable data\n")
    }
    
    cat("\n")
    
  }, error = function(e) {
    cat(sprintf("Could not read sheet: %s\n", e$message))
    cat("\n")
  })
}

# 3. Try to extract specific cells that might contain titles or headers
cat("=== ANALYZING FIRST SHEET FOR LAYOUT ===\n")
first_sheet <- sheet_names[1]

# Read specific cells to understand layout
cat("Checking key cells for layout structure:\n")

# Check common title/header locations
key_cells <- c("A1", "A2", "A3", "B1", "B2", "C1", "D1", "A4", "A5", "B4", "B5")
for (cell in key_cells) {
  tryCatch({
    cell_data <- wb_to_df(wb, sheet = first_sheet, dims = cell)
    if (nrow(cell_data) > 0 && !is.na(cell_data[1,1])) {
      cat(sprintf("  %s: %s\n", cell, cell_data[1,1]))
    }
  }, error = function(e) {
    # Ignore errors for empty cells
  })
}

cat("\n=== RECOMMENDATIONS FOR STYLE GUIDE ===\n")
cat("Based on analysis of this Statistischer Bericht, create style guide for:\n")
cat("1. Sheet naming conventions\n")
cat("2. Title and header formatting\n") 
cat("3. Data table structure\n")
cat("4. Navigation between sheets\n")
cat("5. German formatting standards\n")
cat("6. Corporate color scheme\n")
cat("7. Font and typography standards\n")

# Save analysis to file
cat("\nAnalysis complete. Use this information to create the style guide.\n")