# Excel Operations Examples

Basic examples for working with Excel files in R using openxlsx2.

## Reading Excel Files

### Load and Read Data
```r
library(openxlsx2)

# Read Excel file
data <- wb_to_df(wb_load("file.xlsx"), sheet = "Sheet1")

# Read specific range
data <- wb_to_df(wb_load("file.xlsx"), sheet = "Sheet1", dims = "A1:C10")

# Read all sheets
wb <- wb_load("file.xlsx")
sheet_names <- wb_get_sheet_names(wb)
all_data <- lapply(sheet_names, function(s) wb_to_df(wb, sheet = s))
names(all_data) <- sheet_names
```

## Writing Excel Files

### Basic Export
```r
# Simple export
wb <- wb_workbook()
wb$add_worksheet("Data")
wb$add_data(sheet = "Data", x = mtcars, dims = wb_dims(1, 1))
wb_save(wb, "output.xlsx", overwrite = TRUE)

# Multiple sheets
wb <- wb_workbook()
datasets <- list("Cars" = mtcars, "Iris" = iris)
for(name in names(datasets)) {
  wb$add_worksheet(name)
  wb$add_data(sheet = name, x = datasets[[name]], dims = wb_dims(1, 1))
}
wb_save(wb, "datasets.xlsx", overwrite = TRUE)
```

## Modifying Existing Files

### Add Data to Existing File
```r
# Load existing file
wb <- wb_load("existing.xlsx")

# Add new worksheet
wb$add_worksheet("NewSheet")
wb$add_data(sheet = "NewSheet", x = new_data, dims = wb_dims(1, 1))

# Update existing sheet
wb$add_data(sheet = "Sheet1", x = updated_data, dims = wb_dims(5, 1))

# Save changes
wb_save(wb, "existing.xlsx", overwrite = TRUE)
```

### Append Data
```r
# Add data to end of existing sheet
wb <- wb_load("data.xlsx")
existing_data <- wb_to_df(wb, sheet = "Data")
next_row <- nrow(existing_data) + 2  # +1 for header, +1 for new data

wb$add_data(sheet = "Data", x = new_data, dims = wb_dims(next_row, 1))
wb_save(wb, "data.xlsx", overwrite = TRUE)
```

## Formatting

### Column Formatting
```r
wb <- wb_workbook()
wb$add_worksheet("Data")
wb$add_data(sheet = "Data", x = mtcars, dims = wb_dims(1, 1))

# Auto-size columns
wb$set_col_widths(sheet = "Data", cols = 1:ncol(mtcars), widths = "auto")

# Set specific widths
wb$set_col_widths(sheet = "Data", cols = 1:3, widths = c(15, 20, 25))

wb_save(wb, "formatted.xlsx", overwrite = TRUE)
```

### Cell Styling
```r
# Header formatting
wb$add_style(
  sheet = "Data",
  style = wb_style(font_bold = TRUE, bg_fill = wb_color("lightblue")),
  rows = 1, 
  cols = 1:ncol(mtcars)
)

# Cell background
wb$add_style(
  sheet = "Data",
  style = wb_style(bg_fill = wb_color("yellow")),
  rows = 2:5, 
  cols = 2
)
```

## Worksheet Management

### Add/Remove Sheets
```r
wb <- wb_load("file.xlsx")

# Add new worksheet
wb$add_worksheet("NewSheet")

# Remove worksheet
wb$remove_worksheet("OldSheet")

# Get sheet names
sheet_names <- wb_get_sheet_names(wb)

# Clone worksheet
wb$clone_worksheet("Sheet1", "Sheet1_Copy")

wb_save(wb, "file.xlsx", overwrite = TRUE)
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

## Cell Operations

### Writing to Specific Cells
```r
# Write single value
wb$add_data(sheet = "Data", x = "Title", dims = wb_dims(1, 1))

# Write range
wb$add_data(sheet = "Data", x = matrix(1:6, nrow=2), dims = wb_dims(3, 2))

# Write formula
wb$add_formula(sheet = "Data", x = "=SUM(A1:A10)", dims = wb_dims(11, 1))
```

### Reading Specific Cells
```r
# Read single cell
value <- wb_to_df(wb, sheet = "Data", dims = "A1")

# Read range
range_data <- wb_to_df(wb, sheet = "Data", dims = "A1:C5")
```

## Common Patterns

### Data Export with Headers
```r
export_with_headers <- function(data, filename, title = NULL) {
  wb <- wb_workbook()
  wb$add_worksheet("Data")
  
  start_row <- 1
  if (!is.null(title)) {
    wb$add_data(sheet = "Data", x = title, dims = wb_dims(1, 1))
    start_row <- 3
  }
  
  wb$add_data(sheet = "Data", x = data, dims = wb_dims(start_row, 1))
  wb$add_style(
    sheet = "Data",
    style = wb_style(font_bold = TRUE),
    rows = start_row, cols = 1:ncol(data)
  )
  wb$set_col_widths(sheet = "Data", cols = 1:ncol(data), widths = "auto")
  wb_save(wb, filename, overwrite = TRUE)
}
```

### Split Data by Groups
```r
split_by_group <- function(data, group_col, filename) {
  wb <- wb_workbook()
  groups <- unique(data[[group_col]])
  
  for(group in groups) {
    sheet_data <- data[data[[group_col]] == group, ]
    wb$add_worksheet(as.character(group))
    wb$add_data(sheet = as.character(group), x = sheet_data, dims = wb_dims(1, 1))
  }
  
  wb_save(wb, filename, overwrite = TRUE)
}
```

## Formatted Excel with Navigation

### Create Professional Multi-Sheet Excel
```r
# Load the skill
source(".opencode/skills/modify-excel-with-r/code/excel-operations.R")

# Prepare datasets
datasets <- list(
  "Iris" = iris,
  "Cars" = mtcars
)

# Create formatted Excel with navigation
create_formatted_excel_with_navigation(datasets, "professional_datasets.xlsx")
```

This creates an Excel file with:
- **Inhaltsübersicht** (index) sheet with navigation links
- **Iris** sheet with formatted iris data
- **Cars** sheet with formatted mtcars data
- Titles in A1 of each sheet
- Hyperlinks between sheets
- Professional formatting (headers, alternating rows, borders)
- Auto-sized columns

### Manual Step-by-Step Creation
```r
library(openxlsx2)

wb <- wb_workbook()

# Create index sheet
wb$add_worksheet("Inhaltsübersicht")
wb$add_data(sheet = "Inhaltsübersicht", x = "Inhaltsübersicht", dims = wb_dims(1, 1))

# Format title
wb$add_style(
  sheet = "Inhaltsübersicht",
  style = wb_style(font_bold = TRUE, font_size = 16, bg_fill = wb_color("navy"), font_color = wb_color("white")),
  rows = 1, cols = 1:2
)
wb$merge_cells(sheet = "Inhaltsübersicht", dims = wb_dims(1, 1:2))

# Add links to other sheets
wb$add_data(sheet = "Inhaltsübersicht", x = "Iris", dims = wb_dims(3, 1))
wb$add_hyperlink(sheet = "Inhaltsübersicht", target = "#Iris!A1", dims = wb_dims(3, 1))

wb$add_data(sheet = "Inhaltsübersicht", x = "Cars", dims = wb_dims(4, 1))
wb$add_hyperlink(sheet = "Inhaltsübersicht", target = "#Cars!A1", dims = wb_dims(4, 1))

# Create data sheets
for(dataset_name in c("Iris", "Cars")) {
  data <- if(dataset_name == "Iris") iris else mtcars
  
  wb$add_worksheet(dataset_name)
  
  # Title in A1
  wb$add_data(sheet = dataset_name, x = paste("Daten:", dataset_name), dims = wb_dims(1, 1))
  wb$add_style(
    sheet = dataset_name,
    style = wb_style(font_bold = TRUE, font_size = 14),
    rows = 1, cols = 1
  )
  
  # Back link in A2
  wb$add_data(sheet = dataset_name, x = "← Zur Inhaltsübersicht", dims = wb_dims(2, 1))
  wb$add_hyperlink(sheet = dataset_name, target = "#Inhaltsübersicht!A1", dims = wb_dims(2, 1))
  
  # Data starting from row 4
  wb$add_data(sheet = dataset_name, x = data, dims = wb_dims(4, 1))
  
  # Format headers
  wb$add_style(
    sheet = dataset_name,
    style = wb_style(font_bold = TRUE, bg_fill = wb_color("lightblue")),
    rows = 4, cols = 1:ncol(data)
  )
  
  # Auto-size columns
  wb$set_col_widths(sheet = dataset_name, cols = 1:ncol(data), widths = "auto")
}

wb_save(wb, "manual_datasets.xlsx", overwrite = TRUE)
```