# Enhanced Final Demo Excel File 
library(openxlsx2)

# Create workbook with Arial font
wb <- wb_workbook()

# Set base font to Arial, size 10
wb$set_base_font(font_name = "Arial", font_size = 10)

# Create index sheet
wb$add_worksheet("Inhaltsübersicht")

# Add title and format it using the chained approach
wb$add_data(x = "Inhaltsübersicht", dims = "A1")$
  add_font(dims = "A1", bold = TRUE, size = 14, color = wb_color("white"))$
  add_fill(dims = "A1", color = wb_color("#4472C4"))$
  add_cell_style(dims = "A1", horizontal = "center", vertical = "center")$
  merge_cells(dims = "A1:B1")$
  set_row_heights(rows = 1, heights = 25)

# Add table headers
wb$add_data(x = "Blatt", dims = "A3")$
  add_data(x = "Beschreibung", dims = "B3")$
  add_font(dims = "A3:B3", bold = TRUE)$
  add_fill(dims = "A3:B3", color = wb_color("lightgray"))

# Add navigation links
wb$add_data(x = "Iris", dims = "A4")$
  add_hyperlink(dims = "A4", target = "#Iris!A1")$
  add_font(dims = "A4", color = wb_color("blue"))

wb$add_data(x = "Iris Blumendaten mit 150 Zeilen und 5 Spalten", dims = "B4")

wb$add_data(x = "Cars", dims = "A5")$
  add_hyperlink(dims = "A5", target = "#Cars!A1")$
  add_font(dims = "A5", color = wb_color("blue"))

wb$add_data(x = "Autodaten mit 32 Zeilen und 11 Spalten", dims = "B5")

# Set column widths for index
wb$set_col_widths(cols = 1, widths = 15)$
  set_col_widths(cols = 2, widths = 40)

# Create Iris sheet
wb$add_worksheet("Iris")

wb$add_data(x = "Daten: Iris", dims = "A1")$
  add_font(dims = "A1", bold = TRUE, size = 12, color = wb_color("white"))$
  add_fill(dims = "A1", color = wb_color("#70AD47"))

wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")$
  add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")$
  add_font(dims = "A2", color = wb_color("blue"))

wb$add_data(x = iris, dims = "A4")$
  add_font(dims = "A4:E4", bold = TRUE)$
  add_fill(dims = "A4:E4", color = wb_color("#E2EFDA"))

# Apply German number formatting to numeric columns in Iris
numeric_cols_iris <- c(1, 2, 3, 4)
for (col in numeric_cols_iris) {
  range_start <- paste0(int2col(col), "5")
  range_end <- paste0(int2col(col), nrow(iris) + 4)
  range <- paste0(range_start, ":", range_end)
  
  wb$add_numfmt(dims = range, numfmt = "# ##0,00")
}

# Auto-size columns for Iris
wb$set_col_widths(cols = 1:ncol(iris), widths = "auto")

# Create Cars sheet  
wb$add_worksheet("Cars")

wb$add_data(x = "Daten: Cars", dims = "A1")$
  add_font(dims = "A1", bold = TRUE, size = 12, color = wb_color("white"))$
  add_fill(dims = "A1", color = wb_color("#C55A11"))

wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")$
  add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")$
  add_font(dims = "A2", color = wb_color("blue"))

wb$add_data(x = mtcars, dims = "A4")$
  add_font(dims = "A4:K4", bold = TRUE)$
  add_fill(dims = "A4:K4", color = wb_color("#FCE4D6"))

# Apply German number formatting to Cars
for (col in 1:ncol(mtcars)) {
  range_start <- paste0(int2col(col), "5")
  range_end <- paste0(int2col(col), nrow(mtcars) + 4)
  range <- paste0(range_start, ":", range_end)
  
  if (col %in% c(1, 3, 4, 5, 6, 7)) {  # Use 2 decimals
    wb$add_numfmt(dims = range, numfmt = "# ##0,00")
  } else {  # Use 0 decimals for integer-like values
    wb$add_numfmt(dims = range, numfmt = "# ##0")
  }
}

# Auto-size columns for Cars
wb$set_col_widths(cols = 1:ncol(mtcars), widths = "auto")

# Set active sheet to index
wb$set_active_sheet("Inhaltsübersicht")

# Save file
wb_save(wb, "final_formatted_demo.xlsx", overwrite = TRUE)

cat("✓ Final formatted demo Excel file created: final_formatted_demo.xlsx\n")
cat("  Professional features:\n")
cat("  - Merged and centered title 'Inhaltsübersicht' with blue background and white font\n")
cat("  - Professional color scheme: blue index, green Iris, orange Cars\n")
cat("  - Arial font, size 10 throughout\n")
cat("  - German number formatting (comma decimal, space thousands)\n")
cat("  - Enhanced header styling with theme colors\n")
cat("  - Proper hyperlink formatting\n")