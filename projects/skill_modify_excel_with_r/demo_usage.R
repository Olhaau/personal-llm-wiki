# ============================================================================
# Demo: Using modify-excel-with-r Skill
# ============================================================================
# Practical demonstration of creating formatted Excel files with navigation

# Load required packages
library(openxlsx2)

# Load the skill
source(".opencode/skills/modify-excel-with-r/code/excel-operations.R")

# Prepare sample datasets ----
datasets <- list(
  "Iris" = iris,
  "Cars" = mtcars,
  "Pressure" = pressure  # Add a third dataset for demonstration
)

# Method 1: Using the convenience function ----
cat("Creating formatted Excel with navigation...\n")
create_formatted_excel_with_navigation(
  data_list = datasets, 
  filename = "professional_datasets.xlsx"
)

# Method 2: Create additional customized version ----
cat("Creating customized version...\n")

wb <- wb_workbook()

# Custom index sheet
wb$add_worksheet("Inhaltsübersicht")

# Enhanced title
wb$add_data(sheet = "Inhaltsübersicht", x = "Datensammlung 2024", dims = wb_dims(1, 1))
wb$add_style(
  sheet = "Inhaltsübersicht",
  style = wb_style(
    font_bold = TRUE, 
    font_size = 18,
    font_color = wb_color("white"),
    bg_fill = wb_color("#2E4057")  # Dark blue-gray
  ),
  rows = 1, cols = 1:3
)
wb$merge_cells(sheet = "Inhaltsübersicht", dims = wb_dims(1, 1:3))
wb$set_row_heights(sheet = "Inhaltsübersicht", rows = 1, heights = 30)

# Subtitle
wb$add_data(sheet = "Inhaltsübersicht", 
            x = paste("Erstellt am:", format(Sys.Date(), "%d.%m.%Y")), 
            dims = wb_dims(2, 1))
wb$add_style(
  sheet = "Inhaltsübersicht",
  style = wb_style(font_italic = TRUE, font_color = wb_color("gray")),
  rows = 2, cols = 1
)

# Table headers
headers <- c("Dataset", "Beschreibung", "Zeilen")
wb$add_data(sheet = "Inhaltsübersicht", x = headers, dims = wb_dims(4, 1:3))
wb$add_style(
  sheet = "Inhaltsübersicht",
  style = wb_style(font_bold = TRUE, bg_fill = wb_color("#E8F4FD")),
  rows = 4, cols = 1:3
)

# Add dataset links and info
current_row <- 5
for (name in names(datasets)) {
  data <- datasets[[name]]
  
  # Dataset name with hyperlink
  wb$add_data(sheet = "Inhaltsübersicht", x = name, dims = wb_dims(current_row, 1))
  wb$add_hyperlink(
    sheet = "Inhaltsübersicht",
    target = paste0("#'", name, "'!A1"),
    dims = wb_dims(current_row, 1)
  )
  wb$add_style(
    sheet = "Inhaltsübersicht",
    style = wb_style(font_color = wb_color("blue"), text_underline = TRUE),
    rows = current_row, cols = 1
  )
  
  # Description based on dataset
  description <- switch(name,
    "Iris" = "Blumendaten mit Arten und Maßen",
    "Cars" = "Autodaten mit Verbrauch und Leistung", 
    "Pressure" = "Temperatur- und Druckmessungen",
    paste("Datensatz:", name)
  )
  wb$add_data(sheet = "Inhaltsübersicht", x = description, dims = wb_dims(current_row, 2))
  
  # Row count
  wb$add_data(sheet = "Inhaltsübersicht", x = nrow(data), dims = wb_dims(current_row, 3))
  
  current_row <- current_row + 1
}

# Set column widths
wb$set_col_widths(sheet = "Inhaltsübersicht", cols = 1:3, widths = c(15, 35, 10))

# Create enhanced data sheets
for (sheet_name in names(datasets)) {
  data <- datasets[[sheet_name]]
  wb$add_worksheet(sheet_name)
  
  # Enhanced title
  wb$add_data(sheet = sheet_name, x = paste("Dataset:", sheet_name), dims = wb_dims(1, 1))
  wb$add_style(
    sheet = sheet_name,
    style = wb_style(
      font_bold = TRUE, 
      font_size = 16,
      bg_fill = wb_color("#2E4057"),
      font_color = wb_color("white")
    ),
    rows = 1, cols = 1:ncol(data)
  )
  wb$merge_cells(sheet = sheet_name, dims = wb_dims(1, 1:ncol(data)))
  
  # Navigation and info row
  wb$add_data(sheet = sheet_name, x = "← Zur Inhaltsübersicht", dims = wb_dims(2, 1))
  wb$add_hyperlink(
    sheet = sheet_name,
    target = "#Inhaltsübersicht!A1",
    dims = wb_dims(2, 1)
  )
  wb$add_style(
    sheet = sheet_name,
    style = wb_style(font_color = wb_color("blue"), text_underline = TRUE),
    rows = 2, cols = 1
  )
  
  # Dataset info
  info_text <- paste0("Zeilen: ", nrow(data), " | Spalten: ", ncol(data))
  wb$add_data(sheet = sheet_name, x = info_text, dims = wb_dims(2, ncol(data)))
  wb$add_style(
    sheet = sheet_name,
    style = wb_style(font_italic = TRUE, font_color = wb_color("gray")),
    rows = 2, cols = ncol(data)
  )
  
  # Data
  wb$add_data(sheet = sheet_name, x = data, dims = wb_dims(4, 1))
  
  # Enhanced header formatting
  wb$add_style(
    sheet = sheet_name,
    style = wb_style(
      font_bold = TRUE, 
      bg_fill = wb_color("#4A90A4"),
      font_color = wb_color("white")
    ),
    rows = 4, cols = 1:ncol(data)
  )
  
  # Alternating row colors
  for (i in seq(2, nrow(data), 2)) {
    wb$add_style(
      sheet = sheet_name,
      style = wb_style(bg_fill = wb_color("#F8F9FA")),
      rows = 4 + i, cols = 1:ncol(data)
    )
  }
  
  # Auto-size and borders
  wb$set_col_widths(sheet = sheet_name, cols = 1:ncol(data), widths = "auto")
  
  # Add borders to data area
  data_range <- wb_dims(
    from_row = 4, from_col = 1,
    to_row = 4 + nrow(data), to_col = ncol(data)
  )
  wb$add_border(
    sheet = sheet_name, dims = data_range,
    bottom_border = "thin", top_border = "thin",
    left_border = "thin", right_border = "thin"
  )
}

# Set active sheet to index
wb$set_active_sheet("Inhaltsübersicht")

# Save
wb_save(wb, "custom_datasets.xlsx", overwrite = TRUE)
cat("✓ Created custom Excel file: custom_datasets.xlsx\n")

# Method 3: Quick examples with individual datasets ----
cat("Creating individual dataset files...\n")

# Quick export for single datasets
quick_export(iris, "iris_simple.xlsx")
quick_export(mtcars, "cars_simple.xlsx")

# Enhanced single dataset
wb_single <- wb_workbook()
wb_single$add_worksheet("Iris Data")

# Title
wb_single$add_data(sheet = "Iris Data", x = "Iris Flower Dataset", dims = wb_dims(1, 1))
wb_single$add_style(
  sheet = "Iris Data",
  style = wb_style(font_bold = TRUE, font_size = 14),
  rows = 1, cols = 1:ncol(iris)
)
wb_single$merge_cells(sheet = "Iris Data", dims = wb_dims(1, 1:ncol(iris)))

# Data
wb_single$add_data(sheet = "Iris Data", x = iris, dims = wb_dims(3, 1))
wb_single$add_style(
  sheet = "Iris Data",
  style = wb_style(font_bold = TRUE, bg_fill = wb_color("lightgreen")),
  rows = 3, cols = 1:ncol(iris)
)
wb_single$set_col_widths(sheet = "Iris Data", cols = 1:ncol(iris), widths = "auto")

wb_save(wb_single, "iris_enhanced.xlsx", overwrite = TRUE)

cat("✓ All demo files created successfully!\n")
cat("Files created:\n")
cat("  - professional_datasets.xlsx (using convenience function)\n")
cat("  - custom_datasets.xlsx (manual customization)\n") 
cat("  - iris_simple.xlsx (quick export)\n")
cat("  - cars_simple.xlsx (quick export)\n")
cat("  - iris_enhanced.xlsx (single dataset, enhanced)\n")