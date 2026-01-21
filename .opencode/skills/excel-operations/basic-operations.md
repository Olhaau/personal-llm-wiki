# Basic Operations with openxlsx2

## Creating and Managing Workbooks

### Create New Workbook
```r
library(openxlsx2)

# Basic workbook
wb <- wb_workbook()

# With custom theme
wb <- wb_workbook(theme = "Office 2013 - 2022 Theme")

# Set workbook properties
wb <- wb_workbook() %>%
  wb_set_properties(
    title = "My Workbook",
    subject = "Data Analysis", 
    creator = "R User"
  )
```

### Load Existing Excel Files
```r
# Load Excel file into workbook object
wb <- wb_load("data.xlsx")

# Quick read to data frame
df <- read_xlsx("data.xlsx")

# Read specific sheet and range
df <- read_xlsx("data.xlsx", sheet = "Sheet2", dims = "A1:E100")

# Read with column types
df <- read_xlsx("data.xlsx", col_types = c("text", "numeric", "date"))
```

## Worksheet Management

### Add and Configure Worksheets
```r
wb <- wb_workbook()

# Add worksheet with default name
wb$add_worksheet()

# Add with custom name
wb$add_worksheet("Data")

# Add multiple sheets
wb$add_worksheet("Sales")$add_worksheet("Inventory")

# Set sheet properties
wb$add_worksheet("Report", 
  grid_lines = FALSE,
  tab_color = wb_color("red"),
  zoom = 120
)
```

### Worksheet Operations
```r
# Get sheet names
wb_get_sheet_names(wb)

# Rename sheets
wb$set_sheet_names(c("Q1_Data", "Q2_Data", "Summary"))

# Remove worksheet
wb$remove_worksheet("Sheet1")

# Set active sheet
wb$set_active_sheet("Summary")

# Hide/show sheets
wb$set_sheet_visibility("Data", visible = FALSE)
```

## Writing Data to Worksheets

### Basic Data Writing
```r
wb <- wb_workbook()$add_worksheet("Data")

# Write data frame
wb$add_data(x = mtcars)

# Write to specific location
wb$add_data(x = iris, dims = "C5")

# Write with headers
wb$add_data(x = mtcars, with_filter = TRUE)

# Write without row names
wb$add_data(x = mtcars, row_names = FALSE)
```

### Advanced Data Writing
```r
# Write as data table (Excel Table)
wb$add_data_table(x = mtcars, table_style = "TableStyleMedium2")

# Write formulas
wb$add_formula(x = "=SUM(A:A)", dims = "B1")

# Write dates properly
dates <- Sys.Date() + 1:10
wb$add_data(x = data.frame(dates = dates), dims = "A1")

# Write large numbers with formatting
wb$add_data(x = data.frame(values = c(1234567.89, 9876543.21)))
wb$add_numfmt(dims = "A:A", numfmt = "#,##0.00")
```

## Reading Data from Workbooks

### Convert Workbook to Data Frame
```r
# Read entire active sheet
df <- wb_to_df(wb)

# Read specific sheet
df <- wb_to_df(wb, sheet = "Data")

# Read specific range
df <- wb_to_df(wb, dims = "A1:E50")

# Read with options
df <- wb_to_df(wb, 
  col_names = TRUE,
  row_names = FALSE,
  skip_empty_rows = TRUE,
  skip_empty_cols = TRUE
)
```

### Handle Data Types
```r
# Auto-detect types (default)
df <- wb_to_df(wb, detect_dates = TRUE)

# Specify column types
df <- wb_to_df(wb, col_types = c("text", "numeric", "date", "logical"))

# Convert Excel dates
df <- wb_to_df(wb, convert = TRUE)

# Handle NA values
df <- wb_to_df(wb, na.strings = c("", "N/A", "NULL"))
```

## Saving Workbooks

### Basic Saving
```r
# Save to file
wb_save(wb, "output.xlsx")

# Save with overwrite
wb_save(wb, "output.xlsx", overwrite = TRUE)

# Save to temporary file
temp_file <- temp_xlsx()
wb_save(wb, temp_file)
```

### Save Options
```r
# Save without calculation chain (faster for large files)
wb_save(wb, "output.xlsx", calc_chain = FALSE)

# Save with custom creator
wb$set_last_modified_by("R Script")
wb_save(wb, "output.xlsx")
```

## Cell References and Dimensions

### Working with Cell References
```r
# Use wb_dims helper for easy referencing
dims <- wb_dims(from_row = 1, from_col = 1, to_row = 10, to_col = 5)
wb$add_data(x = mtcars[1:10, 1:5], dims = dims)

# Convert between formats
col2int("AZ")  # Convert column letter to number
int2col(52)   # Convert number to column letter

# Validate dimensions
validate_dims("A1:Z100")

# Create ranges
dims <- wb_dims(rows = 1:10, cols = 1:5)  # A1:E10
```

### Range Utilities
```r
# Get dimensions from data frame
dims <- dataframe_to_dims(mtcars)  # "A1:K33" (32 rows + header, 11 cols)

# Convert dims to row/column numbers  
rowcol_to_dims(1, 1, 10, 5)  # "A1:E10"
dims_to_rowcol("A1:E10")     # returns list with rows and cols

# Work with current sheet reference
wb$add_data(x = iris, sheet = current_sheet())
```

## Quick Operations

### One-Line Operations
```r
# Quick write data frame to Excel
write_xlsx(mtcars, "cars.xlsx")

# Quick read Excel to data frame  
cars <- read_xlsx("cars.xlsx")

# Write multiple data frames to sheets
write_xlsx(list(cars = mtcars, flowers = iris), "data.xlsx")
```

### Chaining Operations
```r
# Fluent interface for building workbooks
wb <- wb_workbook() %>%
  wb_add_worksheet("Data") %>%
  wb_add_data(x = mtcars) %>%
  wb_set_col_widths(cols = 1:11, widths = "auto") %>%
  wb_save("formatted_cars.xlsx")
```

## Common Patterns

### Template Workbook Creation
```r
create_report_template <- function(data, title = "Report") {
  wb <- wb_workbook() %>%
    wb_add_worksheet("Report") %>%
    wb_add_data(x = title, dims = "A1") %>%
    wb_add_data(x = data, dims = "A3", with_filter = TRUE) %>%
    wb_set_col_widths(cols = 1:ncol(data), widths = "auto")
  return(wb)
}

# Use template
wb <- create_report_template(mtcars, "Car Data Analysis")
```

### Multi-Sheet Workbook
```r
create_multi_sheet_workbook <- function(data_list) {
  wb <- wb_workbook()
  
  for(sheet_name in names(data_list)) {
    wb$add_worksheet(sheet_name)$
      add_data(x = data_list[[sheet_name]], with_filter = TRUE)
  }
  
  return(wb)
}

# Create workbook with multiple datasets
data_list <- list(cars = mtcars, flowers = iris, trees = trees)
wb <- create_multi_sheet_workbook(data_list)
```