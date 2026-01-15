# Final Demo Excel File with Enhanced Header Formatting
library(openxlsx2)

# Create workbook with Arial font
wb <- wb_workbook()

# Set base font to Arial, size 10
wb$set_base_font(font_name = "Arial", font_size = 10)

# Create index sheet
wb$add_worksheet("Inhaltsübersicht")

# Add title in A1
wb$add_data(x = "Inhaltsübersicht", dims = "A1")

# Merge cells A1:B1 for the title
wb$merge_cells(dims = "A1:B1")

# Format the merged title cell with colored background, white font, and center alignment
wb$add_style(
  dims = "A1", 
  style = wb_style(
    font_bold = TRUE,
    font_size = 14,
    font_color = wb_color("white"),
    bg_fill = wb_color("#4472C4"),  # Professional blue background
    horizontal = "center",
    vertical = "center"
  )
)

# Set row height for better appearance
wb$set_row_heights(rows = 1, heights = 25)

# Add table headers in row 3
wb$add_data(x = "Blatt", dims = "A3") 
wb$add_data(x = "Beschreibung", dims = "B3")

# Format table headers
wb$add_style(
  dims = "A3:B3",
  style = wb_style(
    font_bold = TRUE,
    bg_fill = wb_color("lightgray")
  )
)

# Add navigation links
wb$add_data(x = "Iris", dims = "A4")
wb$add_hyperlink(dims = "A4", target = "#Iris!A1")
wb$add_data(x = "Iris Blumendaten mit 150 Zeilen und 5 Spalten", dims = "B4")

wb$add_data(x = "Cars", dims = "A5")
wb$add_hyperlink(dims = "A5", target = "#Cars!A1") 
wb$add_data(x = "Autodaten mit 32 Zeilen und 11 Spalten", dims = "B5")

# Format hyperlinks
wb$add_style(
  dims = "A4:A5",
  style = wb_style(
    font_color = wb_color("blue"),
    text_underline = TRUE
  )
)

# Set column widths for index
wb$set_col_widths(cols = 1, widths = 15)
wb$set_col_widths(cols = 2, widths = 40)

# Create Iris sheet
wb$add_worksheet("Iris")
wb$add_data(x = "Daten: Iris", dims = "A1")

# Format Iris title
wb$add_style(
  dims = "A1",
  style = wb_style(
    font_bold = TRUE,
    font_size = 12,
    bg_fill = wb_color("#70AD47"),  # Green for Iris (nature theme)
    font_color = wb_color("white")
  )
)

wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")
wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
wb$add_style(
  dims = "A2",
  style = wb_style(
    font_color = wb_color("blue"),
    text_underline = TRUE
  )
)

wb$add_data(x = iris, dims = "A4")

# Format Iris headers
wb$add_style(
  dims = "A4:E4",
  style = wb_style(
    font_bold = TRUE,
    bg_fill = wb_color("#E2EFDA")  # Light green for headers
  )
)

# Apply German number formatting to numeric columns in Iris
numeric_cols_iris <- c(1, 2, 3, 4)  # First 4 columns are numeric
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
wb$add_data(x = "Daten: Cars", dims = "A1")

# Format Cars title
wb$add_style(
  dims = "A1",
  style = wb_style(
    font_bold = TRUE,
    font_size = 12,
    bg_fill = wb_color("#C55A11"),  # Orange for Cars (automotive theme)
    font_color = wb_color("white")
  )
)

wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2") 
wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
wb$add_style(
  dims = "A2",
  style = wb_style(
    font_color = wb_color("blue"),
    text_underline = TRUE
  )
)

wb$add_data(x = mtcars, dims = "A4")

# Format Cars headers
wb$add_style(
  dims = "A4:K4",  # mtcars has 11 columns
  style = wb_style(
    font_bold = TRUE,
    bg_fill = wb_color("#FCE4D6")  # Light orange for headers
  )
)

# Apply German number formatting to Cars
for (col in 1:ncol(mtcars)) {
  range_start <- paste0(int2col(col), "5")
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
wb_save(wb, "final_demo_excel.xlsx", overwrite = TRUE)

cat("✓ Final demo Excel file created: final_demo_excel.xlsx\n")
cat("  Enhanced features:\n")
cat("  - Merged and centered title in Inhaltsübersicht with blue background and white font\n")
cat("  - Professional color scheme for each sheet\n")
cat("  - Arial font, size 10 throughout\n")
cat("  - German number formatting (comma decimal, space thousands)\n")
cat("  - Enhanced header formatting with colors\n")
cat("  - Hyperlink styling\n")