# Advanced Features in openxlsx2

## Data Tables and Filtering

### Excel Data Tables
```r
wb <- wb_workbook()$add_worksheet("Tables")

# Create data table with default styling
wb$add_data_table(x = mtcars, dims = "A1")

# Custom table styling
wb$add_data_table(
  x = iris,
  dims = "A10", 
  table_style = "TableStyleMedium15",
  table_name = "IrisData",
  with_filter = TRUE,
  first_column = TRUE,  # Bold first column
  last_column = TRUE    # Bold last column
)

# Available table styles: TableStyleLight1-21, TableStyleMedium1-28, TableStyleDark1-11

# Update existing table
wb$update_table(
  sheet = 1, 
  table = "IrisData",
  dims = "A10:E160"  # Expand table range
)

# Remove table (keep data)
wb$remove_tables(sheet = 1, table = "IrisData")
```

### Filters and Sorting
```r
wb <- wb_workbook()$add_worksheet("Filters")$add_data(x = mtcars)

# Add filter to data range
wb$add_filter(dims = "A1:K33")

# Remove filter
wb$remove_filter(sheet = 1)

# Note: Actual filtering is done in Excel, not in R
# Data must be manually sorted/filtered in the Excel application
```

## Charts and Visualizations

### Adding Charts (XML-based)
```r
wb <- wb_workbook()$add_worksheet("Charts")

# Sample data for charts
chart_data <- data.frame(
  Month = month.name[1:6],
  Sales = c(100, 150, 180, 120, 200, 160),
  Costs = c(80, 120, 140, 100, 150, 130)
)

wb$add_data(x = chart_data, dims = "A1")

# Basic column chart (requires chart XML - advanced)
chart_xml <- '<c:chart xmlns:c="http://schemas.openxmlformats.org/drawingml/2006/chart">
  <!-- Complex chart XML structure -->
</c:chart>'

wb$add_chart_xml(xml = chart_xml, dims = "E5:M20")

# For practical charting, use mschart package with wb_add_mschart()
```

### Charts with mschart Package
```r
# Requires: install.packages("mschart")
library(mschart)

wb <- wb_workbook()$add_worksheet("Charts")$add_data(x = chart_data)

# Create chart with mschart
chart <- ms_barchart(
  data = chart_data,
  x = "Month", 
  y = "Sales",
  title = "Monthly Sales"
)

# Add to workbook
wb$add_mschart(sheet = 1, dims = "E5:M20", graph = chart)
```

### Sparklines
```r
wb <- wb_workbook()$add_worksheet("Sparklines")

# Sample time series data
ts_data <- matrix(rnorm(60), nrow = 5, ncol = 12)
colnames(ts_data) <- month.abb
rownames(ts_data) <- paste("Series", 1:5)

wb$add_data(x = ts_data, dims = "A1", row_names = TRUE)

# Create sparklines
sparklines <- create_sparklines(
  sheet = 1,
  dims = "B2:M6",      # Data range (5 rows x 12 months)
  sqref = "N2:N6",     # Where to place sparklines
  type = "line",       # line, column, or stacked
  markers = TRUE,      # Show data points
  high = TRUE,         # Highlight highest point
  low = TRUE,          # Highlight lowest point
  first = TRUE,        # Highlight first point
  last = TRUE,         # Highlight last point
  color_series = wb_color("blue"),
  color_high = wb_color("green"),
  color_low = wb_color("red")
)

wb$add_sparklines(sparklines = sparklines)

# Multiple sparkline types
column_sparklines <- create_sparklines(
  sheet = 1,
  dims = "B2:M6",
  sqref = "O2:O6", 
  type = "column",
  negative = TRUE,  # Highlight negative values
  color_negative = wb_color("red")
)

wb$add_sparklines(sparklines = column_sparklines)
```

## Pivot Tables

### Basic Pivot Tables
```r
wb <- wb_workbook()

# Prepare data for pivot table
sales_data <- data.frame(
  Region = rep(c("North", "South", "East", "West"), each = 12),
  Month = rep(month.abb, 4),
  Product = rep(c("A", "B"), 24),
  Sales = round(runif(48, 50, 200)),
  Profit = round(runif(48, 10, 50))
)

wb$add_worksheet("Data")$add_data(x = sales_data)
wb$add_worksheet("Pivot")

# Create pivot table
wb$add_pivot_table(
  data_sheet = "Data",
  dims = "A1:E49",  # Data range including headers
  pivot_sheet = "Pivot",
  pivot_dims = "A3:D20",  # Where to place pivot table
  rows = c("Region", "Month"),     # Row fields
  cols = "Product",                # Column fields  
  values = list("Sales" = "sum", "Profit" = "average"),  # Value fields
  filters = NULL                   # Filter fields
)
```

### Advanced Pivot Table Features
```r
# Pivot table with custom formatting
wb$add_pivot_table(
  data_sheet = "Data",
  dims = "A1:E49",
  pivot_sheet = "Pivot", 
  pivot_dims = "A25:F40",
  rows = "Region",
  cols = c("Product", "Month"),
  values = list("Sales" = "sum"),
  show_row_totals = TRUE,
  show_col_totals = TRUE,
  compact = FALSE,  # Use tabular layout
  outline = TRUE,   # Show outline structure
  pivot_table_style_name = "PivotStyleMedium9"
)

# Add slicer for interactive filtering
wb$add_slicer(
  sheet = "Pivot",
  slicer_range = "H3:K8", 
  pivot_table_name = "PivotTable1",
  column_name = "Region"
)
```

## Data Validation

### Dropdown Lists
```r
wb <- wb_workbook()$add_worksheet("Validation")

# Simple dropdown list
wb$add_data_validation(
  dims = "A1:A10",
  type = "list",
  value = '"Option1,Option2,Option3"'
)

# Dropdown from range
wb$add_data(x = data.frame(Options = c("Low", "Medium", "High")), dims = "D1")
wb$add_data_validation(
  dims = "B1:B10", 
  type = "list",
  value = "$D$1:$D$3"
)

# Named range dropdown
wb$add_named_region(name = "ValidOptions", dims = "D1:D3")
wb$add_data_validation(
  dims = "C1:C10",
  type = "list", 
  value = "ValidOptions"
)
```

### Numeric Validation
```r
# Whole numbers between 1 and 100
wb$add_data_validation(
  dims = "E1:E10",
  type = "whole",
  operator = "between", 
  value = c(1, 100),
  error_title = "Invalid Number",
  error_msg = "Please enter a number between 1 and 100"
)

# Decimal numbers greater than 0
wb$add_data_validation(
  dims = "F1:F10",
  type = "decimal",
  operator = "greaterThan",
  value = 0
)

# Date validation
wb$add_data_validation(
  dims = "G1:G10", 
  type = "date",
  operator = "between",
  value = c(Sys.Date(), Sys.Date() + 365),
  input_title = "Date Entry",
  input_msg = "Enter a date within the next year"
)
```

### Custom Validation Rules
```r
# Custom formula validation
wb$add_data_validation(
  dims = "H1:H10",
  type = "custom",
  value = "=AND(H1>0,H1<1000)",
  show_error_msg = TRUE,
  error_title = "Invalid Value", 
  error_msg = "Value must be between 0 and 1000"
)

# Text length validation
wb$add_data_validation(
  dims = "I1:I10",
  type = "textLength",
  operator = "lessThan",
  value = 50,
  input_msg = "Enter text shorter than 50 characters"
)
```

## Comments and Annotations

### Cell Comments
```r
wb <- wb_workbook()$add_worksheet("Comments")$add_data(x = mtcars[1:5, 1:5])

# Add simple comment
wb$add_comment(dims = "A1", comment = "This is the car names column", author = "R User")

# Styled comment
comment_obj <- wb_comment(
  text = "Important data point!\nThis value is above average.",
  author = "Data Analyst", 
  width = 300,
  height = 100,
  visible = TRUE
)

wb$add_comment(dims = "B3", comment = comment_obj)

# Remove comment
wb$remove_comment(dims = "A1")

# Get existing comment
existing_comment <- wb_get_comment(wb, sheet = 1, dims = "B3")
```

### Threaded Comments (Modern Comments)
```r
# Add person for threaded comments
wb$add_person(name = "John Doe", userid = "johndoe@company.com", provider_id = "AD")

# Add threaded comment  
wb$add_thread(
  dims = "C3",
  comment = "This needs review for Q4 reporting",
  author = "johndoe@company.com"
)

# Get threaded comment
thread <- wb_get_thread(wb, sheet = 1, dims = "C3")
```

## Hyperlinks and Navigation

### Internal Hyperlinks
```r
wb <- wb_workbook()
wb$add_worksheet("Sheet1")$add_worksheet("Sheet2")$add_worksheet("Summary")

# Link to another sheet
hyperlink1 <- create_hyperlink(sheet = "Sheet2", row = 5, col = 3, text = "Go to Sheet2 C5")
wb$add_formula(sheet = "Sheet1", x = hyperlink1, dims = "A1")

# Link to specific cell range
hyperlink2 <- create_hyperlink(sheet = "Summary", row = 1, col = 1, text = "Summary Report")
wb$add_formula(sheet = "Sheet1", x = hyperlink2, dims = "A2")

# Direct hyperlink addition
wb$add_hyperlink(
  sheet = "Sheet1",
  dims = "A3", 
  target = "#Summary!A1",
  tooltip = "Click to go to Summary",
  is_external = FALSE
)
```

### External Hyperlinks
```r
# Web URL
web_link <- create_hyperlink(
  text = "OpenXLSX2 Documentation", 
  file = "https://janmarvin.github.io/openxlsx2/"
)
wb$add_formula(x = web_link, dims = "A4")

# File link  
file_link <- create_hyperlink(
  text = "Open Related File",
  file = "C:/Users/Documents/report.xlsx"
)
wb$add_formula(x = file_link, dims = "A5")

# Email link
wb$add_hyperlink(
  dims = "A6",
  target = "mailto:user@example.com?subject=Report Question",
  tooltip = "Send email about this report"
)
```

## Form Controls

### Checkboxes and Buttons
```r
wb <- wb_workbook()$add_worksheet("Controls")

# Add checkbox
wb$add_form_control(
  dims = "B2",
  type = "Checkbox",
  text = "Include in Analysis",
  linked_cell = "C2"  # Cell to store TRUE/FALSE value
)

# Add radio button group
wb$add_form_control(dims = "B4", type = "Radio", text = "Option A", linked_cell = "C4")
wb$add_form_control(dims = "B5", type = "Radio", text = "Option B", linked_cell = "C4") 
wb$add_form_control(dims = "B6", type = "Radio", text = "Option C", linked_cell = "C4")

# Add dropdown (combo box)
wb$add_form_control(
  dims = "B8",
  type = "Drop",
  text = "Select Item",
  linked_cell = "C8",
  input_range = "E1:E5"  # Range containing dropdown options
)
```

## Worksheet Protection

### Sheet Protection
```r
wb <- wb_workbook()$add_worksheet("Protected")$add_data(x = mtcars[1:10, 1:5])

# Protect worksheet
wb$protect_worksheet(
  sheet = 1,
  protect = TRUE,
  password = "mypassword",
  lock_structure = TRUE,
  lock_windows = TRUE
)

# Protect with specific permissions
wb$protect_worksheet(
  sheet = 1,
  protect = TRUE,
  password = "secret",
  allow_select_locked_cells = TRUE,
  allow_select_unlocked_cells = TRUE,
  allow_formatting_cells = FALSE,
  allow_formatting_columns = FALSE,
  allow_formatting_rows = FALSE,
  allow_insert_columns = FALSE,
  allow_insert_rows = FALSE,
  allow_insert_hyperlinks = TRUE,
  allow_delete_columns = FALSE,
  allow_delete_rows = FALSE,
  allow_sort = FALSE,
  allow_auto_filter = FALSE,
  allow_pivot_tables = FALSE
)

# Unlock specific cells before protection
wb$add_cell_style(dims = "A1:C10", locked = FALSE)  # Allow editing in this range
```

### Workbook Protection
```r
# Protect workbook structure
wb$protect(password = "workbook_password", structure = TRUE, windows = TRUE)

# Remove protection
wb$protect(protect = FALSE)
```

## Page Setup and Printing

### Page Layout
```r
wb <- wb_workbook()$add_worksheet("Report")$add_data(x = mtcars)

# Set page margins and orientation
wb$page_setup(
  orientation = "landscape",
  scale = 80,
  left = 0.7,
  right = 0.7, 
  top = 0.75,
  bottom = 0.75,
  header = 0.3,
  footer = 0.3,
  fit_to_width = 1,
  fit_to_height = 0  # 0 = automatic
)

# Headers and footers
wb$set_header_footer(
  header = c("&L&G", "&CMonthly Report", "&R&D"),  # Left: Logo, Center: Title, Right: Date
  footer = c("&LConfidential", "&C&P", "&R&A"),    # Left: Text, Center: Page, Right: Sheet name
  even_header = c("", "&CMonthly Report - Even", ""),
  even_footer = c("", "&C&P", "")
)

# Page breaks
wb$add_page_break(sheet = 1, row = 20)  # Horizontal break after row 20
wb$add_page_break(sheet = 1, col = 8)   # Vertical break after column H
```

### Print Areas and Titles
```r
# Set print area
wb$set_print_area(dims = "A1:H50")

# Repeat rows/columns on each page
wb$set_print_title_rows(rows = 1)     # Repeat row 1 (headers) on each page
wb$set_print_title_cols(cols = "A")   # Repeat column A on each page

# Grid lines and headings for printing
wb$set_grid_lines(show = TRUE, print = TRUE)
wb$set_row_col_headers(show = TRUE, print = TRUE)
```

## Advanced Workbook Management

### Named Ranges
```r
wb <- wb_workbook()$add_worksheet("Data")$add_data(x = mtcars)

# Create named ranges
wb$add_named_region(name = "CarData", dims = "A1:K33")
wb$add_named_region(name = "CarNames", dims = "A2:A33") 
wb$add_named_region(name = "MPGColumn", dims = "B2:B33")

# Use named ranges in formulas
wb$add_worksheet("Analysis")
wb$add_formula(x = "=AVERAGE(MPGColumn)", dims = "A1")
wb$add_formula(x = "=MAX(MPGColumn)", dims = "A2") 
wb$add_formula(x = "=MIN(MPGColumn)", dims = "A3")

# Get all named ranges
named_ranges <- wb_get_named_regions(wb)

# Remove named range
wb$remove_named_region(name = "MPGColumn")
```

### Workbook Properties and Metadata
```r
# Set comprehensive workbook properties
wb$set_properties(
  title = "Sales Analysis Report",
  subject = "Q4 Sales Performance", 
  creator = "Data Analytics Team",
  category = "Business Reports",
  keywords = "sales, quarterly, performance, analysis",
  comments = "Generated automatically from R analysis",
  manager = "John Manager",
  company = "Company Name",
  language = "en-US",
  revision = "1.0"
)

# Get properties
props <- wb_get_properties(wb)

# Set last modified info
wb$set_last_modified_by("R Automated Process")

# Add creators and contributors
wb$add_creators(c("Alice Analyst", "Bob Reporter"))
wb$set_creators(c("Updated by: Charlie Checker"))
```

### Worksheet Organization
```r
# Reorder worksheets
wb$set_order(c("Summary", "Data", "Charts", "Appendix"))

# Group worksheets
wb$group_cols(sheet = "Data", cols = 2:5)  # Group columns B-E
wb$group_rows(sheet = "Data", rows = 10:20)  # Group rows 10-20

# Copy worksheets
wb$clone_worksheet(old = "Data", new = "Data_Backup")

# Clean up worksheet (remove all data but keep structure)
wb$clean_sheet(sheet = "Data_Backup")

# Set worksheet tab color
wb$set_sheet_visibility("Data_Backup", visible = FALSE)  # Hide sheet
```