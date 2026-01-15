---
name: "modify-excel-with-r"
description: "Excel file operations using R with openxlsx2 package"
---

# modify-excel-with-r

Excel file operations using R and the openxlsx2 package.

## Core Operations

### Reading Excel Files
```r
# Load Excel file
wb <- wb_load("file.xlsx")

# Read specific worksheet to data frame
data <- wb_to_df(wb, sheet = "Sheet1")

# Read cell range
data <- wb_to_df(wb, sheet = "Sheet1", dims = "A1:C10")
```

### Writing Excel Files
```r
# Create new workbook
wb <- wb_workbook()

# Add worksheet
wb$add_worksheet("Data")

# Add data
wb$add_data(sheet = "Data", x = data, dims = wb_dims(1, 1))

# Save file
wb_save(wb, "output.xlsx", overwrite = TRUE)
```

### Modifying Excel Files
```r
# Load existing file
wb <- wb_load("existing.xlsx")

# Add new worksheet
wb$add_worksheet("NewSheet")

# Add data to new sheet
wb$add_data(sheet = "NewSheet", x = new_data, dims = wb_dims(1, 1))

# Modify existing sheet
wb$add_data(sheet = "Sheet1", x = updated_data, dims = wb_dims(5, 1))

# Save changes
wb_save(wb, "existing.xlsx", overwrite = TRUE)
```

## Basic Formatting

### Column Operations
```r
# Auto-size columns
wb$set_col_widths(sheet = "Data", cols = 1:5, widths = "auto")

# Set specific widths
wb$set_col_widths(sheet = "Data", cols = 1:3, widths = c(15, 20, 25))
```

### Cell Styling
```r
# Bold headers
wb$add_style(
  sheet = "Data",
  style = wb_style(font_bold = TRUE),
  rows = 1, cols = 1:ncol(data)
)

# Background color
wb$add_style(
  sheet = "Data",
  style = wb_style(bg_fill = wb_color("lightblue")),
  rows = 1, cols = 1:ncol(data)
)
```

## Worksheet Operations

### Add/Remove Worksheets
```r
# Add worksheet
wb$add_worksheet("NewSheet")

# Remove worksheet
wb$remove_worksheet("OldSheet")

# Clone worksheet
wb$clone_worksheet("Sheet1", "Sheet1_Copy")
```

### Navigation & Hyperlinks
```r
# CRITICAL: Proper hyperlink syntax for sheet navigation
# Format: "#'SheetName'!A1" (with single quotes around sheet name)

# Link to another sheet
wb$add_hyperlink(
  dims = "A1",  # Cell with the hyperlink
  target = "#'Data'!A1"  # Target sheet and cell
)

# Alternative syntax
wb$add_hyperlink(
  sheet = "Index",
  dims = wb_dims(1, 1),
  target = "#'Sheet1'!A1"
)

# Link with display text
wb$add_data(x = "Go to Data Sheet", dims = "A1")
wb$add_hyperlink(dims = "A1", target = "#'Data'!A1")
wb$add_font(dims = "A1", color = wb_color("blue"))

# External URL
wb$add_hyperlink(
  dims = "B1",
  target = "https://www.example.com"
)

# Email link
wb$add_hyperlink(
  dims = "C1", 
  target = "mailto:contact@example.com"
)

# Set active sheet
wb$set_active_sheet("Data")
```

## Quick Start

### Load the Skill
```r
library(openxlsx2)
source(".opencode/skills/modify-excel-with-r/code/excel-operations.R")
```

### Create Professional Excel with Navigation
```r
# Prepare your datasets
datasets <- list(
  "Iris" = iris,
  "Cars" = mtcars
)

# Create formatted Excel with navigation
create_formatted_excel_with_navigation(datasets, "professional_report.xlsx")
```

This creates an Excel file with:
- **Inhaltsübersicht** sheet with navigation links
- Individual data sheets with titles and back-links
- Professional formatting (headers, alternating rows, borders)
- Auto-sized columns

## Professional Navigation Systems

### Table of Contents with Working Links
```r
# Create a navigation sheet
create_table_of_contents <- function(wb, data_list) {
  wb$add_worksheet("Inhaltsübersicht")
  
  # Remove grid lines for clean look
  wb$set_grid_lines("Inhaltsübersicht", show = FALSE)
  
  # Main heading
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")
  wb$add_font(dims = "A1", bold = TRUE, size = 14)
  
  # Section header with professional styling
  wb$add_data(x = "Tabellen", dims = "A3")
  wb$add_font(dims = "A3", bold = TRUE, color = wb_color("white"), name = "Arial")
  wb$add_fill(dims = "A3", color = wb_color("#004B76"))
  
  # Add navigation links
  current_row <- 4
  for (sheet_name in names(data_list)) {
    wb$add_data(x = sheet_name, dims = paste0("A", current_row))
    wb$add_hyperlink(dims = paste0("A", current_row), 
                     target = paste0("#'", sheet_name, "'!A1"))
    wb$add_font(dims = paste0("A", current_row), color = wb_color("blue"))
    current_row <- current_row + 1
  }
}

# Add back-navigation to each sheet
add_back_navigation <- function(wb, sheet_name) {
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
  wb$add_hyperlink(dims = "A1", target = "#'Inhaltsübersicht'!A1")
  wb$add_font(dims = "A1", color = wb_color("blue"))
}
```

### German Statistical Report Format
```r
# Load German statistical formatting functions
source("corporate-design/statistischer-bericht-generator.R")

# Create professional German statistical report
clinical_data <- list(
  "61241-01" = demographic_summary,
  "61241-02" = age_analysis,
  "61241-03" = efficacy_data
)

create_statistischer_bericht(
  data_list = clinical_data,
  filename = "bericht.xlsx", 
  title = "Klinische Studie Ergebnisse",
  period = "Dezember 2025",
  evas_number = "61241"
)
```

## Usage Examples

### Simple Export
```r
# Quick export
quick_export(mtcars, "cars.xlsx")

# Basic export with headers
write_excel(iris, "iris.xlsx", "Flower Data")
```

### Multi-Sheet File
```r
# Create multiple sheets
datasets <- list("Cars" = mtcars, "Iris" = iris)
write_excel_sheets(datasets, "datasets.xlsx")
```

### Update Existing File
```r
# Add data to existing file
add_to_excel("existing.xlsx", new_data, "NewSheet")

# Update cell range
update_range("file.xlsx", "Sheet1", data, "A5:C10")
```

## Hyperlink Troubleshooting

### Common Issues & Solutions

**❌ Hyperlinks Don't Work**
```r
# WRONG - Missing quotes around sheet name
wb$add_hyperlink(dims = "A1", target = "#Sheet1!A1")

# WRONG - Missing # prefix  
wb$add_hyperlink(dims = "A1", target = "Sheet1!A1")

# ✅ CORRECT - Proper format
wb$add_hyperlink(dims = "A1", target = "#'Sheet1'!A1")
```

**❌ Navigation to Sheet with Spaces in Name**
```r
# WRONG - Spaces need to be handled properly
wb$add_hyperlink(dims = "A1", target = "#'Data Sheet'!A1")  # May not work

# ✅ CORRECT - Use underscores or avoid spaces
wb$add_hyperlink(dims = "A1", target = "#'Data_Sheet'!A1")
```

**❌ Links in German Statistical Reports**
```r
# WRONG - Old format that breaks navigation
wb$add_hyperlink(dims = "A1", target = "Inhaltsübersicht!A1")

# ✅ CORRECT - German sheet names need quotes
wb$add_hyperlink(dims = "A1", target = "#'Inhaltsübersicht'!A1")
```

### Professional Formatting Tips
```r
# Style hyperlinks to look professional
wb$add_font(dims = "A1", color = wb_color("blue"), name = "Arial")

# Remove grid lines for clean navigation sheets
wb$set_grid_lines("Inhaltsübersicht", show = FALSE)

# Use consistent back-navigation text
wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")  # German
wb$add_data(x = "Back to Contents", dims = "A1")      # English
```

## Package Requirements

```r
library(openxlsx2)
```