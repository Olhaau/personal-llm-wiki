# Enhanced Demo Excel File with German Formatting
library(openxlsx2)

# Create workbook with Arial font
wb <- wb_workbook()

# Set base font to Arial, size 10
wb$set_base_font(font_name = "Arial", font_size = 10)

# Create index sheet
wb$add_worksheet("Inhaltsübersicht")

# Add title and content to index
wb$add_data(x = "Inhaltsübersicht", dims = "A1")
wb$add_data(x = "Blatt", dims = "A3") 
wb$add_data(x = "Beschreibung", dims = "B3")

# Add navigation links
wb$add_data(x = "Iris", dims = "A4")
wb$add_hyperlink(dims = "A4", target = "#Iris!A1")
wb$add_data(x = "Iris Blumendaten mit 150 Zeilen und 5 Spalten", dims = "B4")

wb$add_data(x = "Cars", dims = "A5")
wb$add_hyperlink(dims = "A5", target = "#Cars!A1") 
wb$add_data(x = "Autodaten mit 32 Zeilen und 11 Spalten", dims = "B5")

# Set column widths for index
wb$set_col_widths(cols = 1, widths = 15)
wb$set_col_widths(cols = 2, widths = 40)

# Create Iris sheet
wb$add_worksheet("Iris")
wb$add_data(x = "Daten: Iris", dims = "A1")
wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")
wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
wb$add_data(x = iris, dims = "A4")

# Apply German number formatting to numeric columns in Iris
# Iris has 4 numeric columns (Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)
numeric_cols_iris <- c(1, 2, 3, 4)  # First 4 columns are numeric
for (col in numeric_cols_iris) {
  # German format: space as thousands separator, comma as decimal
  range_start <- paste0(int2col(col), "5")  # Start from row 5 (data starts at A4, so headers are row 4)
  range_end <- paste0(int2col(col), nrow(iris) + 4)
  range <- paste0(range_start, ":", range_end)
  
  wb$add_numfmt(dims = range, numfmt = "# ##0,00")
}

# Auto-size columns for Iris
wb$set_col_widths(cols = 1:ncol(iris), widths = "auto")

# Create Cars sheet  
wb$add_worksheet("Cars")
wb$add_data(x = "Daten: Cars", dims = "A1")
wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2") 
wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
wb$add_data(x = mtcars, dims = "A4")

# Apply German number formatting to all numeric columns in Cars (all are numeric)
for (col in 1:ncol(mtcars)) {
  range_start <- paste0(int2col(col), "5")  # Start from row 5 (data starts at A4)
  range_end <- paste0(int2col(col), nrow(mtcars) + 4)
  range <- paste0(range_start, ":", range_end)
  
  # Use different formats based on typical values
  if (col %in% c(1, 3, 4, 5, 6, 7)) {  # mpg, disp, hp, drat, wt, qsec - use 2 decimals
    wb$add_numfmt(dims = range, numfmt = "# ##0,00")
  } else {  # cyl, vs, am, gear, carb - use 0 decimals for integer-like values
    wb$add_numfmt(dims = range, numfmt = "# ##0")
  }
}

# Auto-size columns for Cars
wb$set_col_widths(cols = 1:ncol(mtcars), widths = "auto")

# Set active sheet to index
wb$set_active_sheet("Inhaltsübersicht")

# Save file
wb_save(wb, "demo_excel_german_formatting.xlsx", overwrite = TRUE)

cat("✓ Enhanced demo Excel file created: demo_excel_german_formatting.xlsx\n")
cat("  Features:\n")
cat("  - Arial font, size 10 throughout\n")
cat("  - German number formatting (comma as decimal, space as thousands)\n")
cat("  - Inhaltsübersicht (navigation sheet)\n")  
cat("  - Iris sheet (150 rows of flower data) with 2 decimal places\n")
cat("  - Cars sheet (32 rows of car data) with appropriate decimal places\n")
cat("  - Hyperlinks for navigation between sheets\n")
cat("  - Auto-sized columns\n")