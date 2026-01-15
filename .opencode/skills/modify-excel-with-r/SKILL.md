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

### Navigation
```r
# Add hyperlinks between sheets
wb$add_hyperlink(
  sheet = "Index",
  target = "#Sheet1!A1",
  dims = wb_dims(1, 1)
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

## Package Requirements

```r
library(openxlsx2)
```