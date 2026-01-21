# Complete Styling Guide for openxlsx2

## Font Styling

### Basic Font Operations
```r
wb <- wb_workbook()$add_worksheet("Fonts")$add_data(x = mtcars)

# Make headers bold
wb$add_font(dims = "A1:K1", bold = TRUE)

# Change font family and size
wb$add_font(dims = "A1:K1", name = "Arial", size = 14)

# Font color
wb$add_font(dims = "A1:K1", color = wb_color("red"))

# Multiple font properties
wb$add_font(dims = "A1:K1", 
  bold = TRUE,
  italic = TRUE, 
  underline = TRUE,
  name = "Calibri",
  size = 12,
  color = wb_color("blue")
)
```

### Advanced Font Styling
```r
# Create custom font
font <- create_font(
  b = TRUE,                    # bold
  i = TRUE,                    # italic
  color = wb_color("red"),     # color
  name = "Arial",              # font family
  sz = "14",                   # size
  u = "single",                # underline style
  vert_align = "superscript"   # vertical alignment
)

# Apply custom font
wb$styles_mgr$add(font, "header_font")
wb$add_cell_style(dims = "A1:K1", 
  font_id = wb$styles_mgr$get_font_id("header_font")
)
```

## Colors and Fills

### Color Creation
```r
# Predefined colors
red_color <- wb_color("red")
blue_color <- wb_color("blue") 

# Hex colors
custom_color <- wb_color(hex = "FF5733")

# RGB colors
rgb_color <- wb_color(rgb = c(255, 87, 51))

# Theme colors (Excel theme-based)
theme_color <- wb_color(theme = "accent1")

# Transparent color
transparent <- wb_color(hex = "00FFFFFF")  # First two digits = alpha
```

### Fill Patterns
```r
wb <- wb_workbook()$add_worksheet("Fills")$add_data(x = iris)

# Solid fill
wb$add_fill(dims = "A1:E1", color = wb_color("lightblue"))

# Pattern fills
wb$add_fill(dims = "A2:E2", 
  pattern_type = "lightHorizontal",
  fg_color = wb_color("blue"),
  bg_color = wb_color("white")
)

# Gradient fill
gradient_xml <- '<gradientFill>
  <stop position="0"><color rgb="FFFFFFFF"/></stop>
  <stop position="1"><color rgb="FF0000FF"/></stop>
</gradientFill>'

gradient_fill <- create_fill(gradient_fill = gradient_xml)
```

### Advanced Fill Creation
```r
# Create custom fill patterns
fill_diagonal <- create_fill(
  pattern_type = "darkUp",
  fg_color = wb_color("navy"),
  bg_color = wb_color("lightgray")
)

fill_dots <- create_fill(
  pattern_type = "gray125", 
  fg_color = wb_color("black")
)

# Apply to workbook
wb$styles_mgr$add(fill_diagonal, "diagonal")
wb$add_fill(dims = "A1:C1", 
  fill_id = wb$styles_mgr$get_fill_id("diagonal")
)
```

## Borders

### Basic Borders
```r
wb <- wb_workbook()$add_worksheet("Borders")$add_data(x = mtcars[1:5,1:5])

# All borders
wb$add_border(dims = "A1:E6", 
  top_style = "thin",
  bottom_style = "thin", 
  left_style = "thin",
  right_style = "thin"
)

# Specific sides
wb$add_border(dims = "A1:E1",
  bottom_style = "thick",
  bottom_color = wb_color("red")
)

# Border styles: "thin", "medium", "thick", "double", "dashed", "dotted"
wb$add_border(dims = "A2:E2", 
  top_style = "double",
  bottom_style = "dashed",
  left_style = "dotted", 
  right_style = "medium"
)
```

### Advanced Border Creation
```r
# Create custom border
border <- create_border(
  top = "thick",
  top_color = wb_color("blue"),
  bottom = "double", 
  bottom_color = wb_color("red"),
  left = "thin",
  right = "thin",
  diagonal = "medium",
  diagonal_color = wb_color("green"),
  diagonal_up = TRUE
)

# Apply border
wb$styles_mgr$add(border, "custom_border")
wb$add_border(dims = "A1:C3", 
  border_id = wb$styles_mgr$get_border_id("custom_border")
)
```

## Number Formatting

### Standard Number Formats
```r
wb <- wb_workbook()$add_worksheet("Numbers")

# Sample data
data <- data.frame(
  currency = c(1234.56, 9876.54),
  percent = c(0.1234, 0.8765),
  date = Sys.Date() + 0:1,
  time = Sys.time() + 0:1 * 3600,
  scientific = c(1234567, 0.000123)
)

wb$add_data(x = data)

# Currency format
wb$add_numfmt(dims = "A:A", numfmt = "$#,##0.00")

# Percentage 
wb$add_numfmt(dims = "B:B", numfmt = "0.00%")

# Date formats
wb$add_numfmt(dims = "C:C", numfmt = "yyyy-mm-dd")

# Time format
wb$add_numfmt(dims = "D:D", numfmt = "h:mm:ss AM/PM")

# Scientific notation
wb$add_numfmt(dims = "E:E", numfmt = "0.00E+00")
```

### Custom Number Formats
```r
# Create custom number format
numfmt <- create_numfmt(
  numFmtId = 165,  # Use 165+ for custom formats
  formatCode = '"Value: "$#,##0.00" USD"'
)

# Built-in format IDs (some examples):
# 1: "0"
# 2: "0.00" 
# 3: "#,##0"
# 4: "#,##0.00"
# 9: "0%"
# 10: "0.00%"
# 14: "mm-dd-yy"
# 20: "h:mm"
# 22: "m/d/yy h:mm"

# Apply formatting
wb$add_numfmt(dims = "A:A", numfmt = "#,##0.00_);[Red](#,##0.00)")
```

### Conditional Number Formatting
```r
# Format based on value (positive;negative;zero;text)
wb$add_numfmt(dims = "A:A", 
  numfmt = '"↗"#,##0.00;"↘"[Red]#,##0.00;"–"General;@'
)

# Date with conditions
wb$add_numfmt(dims = "B:B",
  numfmt = '[>=TODAY()]"Future";[<TODAY()]"Past";General'
)
```

## Cell Styles and Alignment

### Cell Alignment
```r
wb <- wb_workbook()$add_worksheet("Alignment")$add_data(x = mtcars[1:5,1:3])

# Horizontal alignment
wb$add_cell_style(dims = "A:A", horizontal = "left")
wb$add_cell_style(dims = "B:B", horizontal = "center") 
wb$add_cell_style(dims = "C:C", horizontal = "right")

# Vertical alignment  
wb$add_cell_style(dims = "A1:C1", vertical = "top")

# Text wrapping
wb$add_cell_style(dims = "A:C", wrap_text = TRUE)

# Text rotation
wb$add_cell_style(dims = "A1:C1", text_rotation = 45)

# Shrink to fit
wb$add_cell_style(dims = "A:C", shrink_to_fit = TRUE)

# Indent
wb$add_cell_style(dims = "A:A", indent = 2)
```

### Complete Cell Styling
```r
# Create comprehensive cell style
cell_style <- create_cell_style(
  horizontal = "center",
  vertical = "middle", 
  wrap_text = TRUE,
  shrink_to_fit = FALSE,
  text_rotation = 0,
  indent = 0,
  locked = FALSE,
  hidden = FALSE
)

# Apply with multiple style elements
wb$add_cell_style(dims = "A1:E1",
  horizontal = "center",
  vertical = "middle",
  wrap_text = TRUE
)

# Set specific font and fill for a style
font_id <- wb$styles_mgr$get_font_id("custom_font")
fill_id <- wb$styles_mgr$get_fill_id("custom_fill")

wb$add_cell_style(dims = "A1:E1",
  font_id = font_id,
  fill_id = fill_id,
  horizontal = "center"
)
```

## Layout and Dimensions

### Column and Row Sizing
```r
wb <- wb_workbook()$add_worksheet("Layout")$add_data(x = mtcars)

# Auto-size columns
wb$set_col_widths(cols = 1:11, widths = "auto")

# Specific widths
wb$set_col_widths(cols = c(1, 3, 5), widths = c(15, 20, 12))

# Hide columns
wb$set_col_widths(cols = 2, widths = 10, hidden = TRUE)

# Row heights
wb$set_row_heights(rows = 1, heights = 25)
wb$set_row_heights(rows = 2:10, heights = 18)

# Auto-size with limits
options(openxlsx2.minWidth = 5)
options(openxlsx2.maxWidth = 50)
wb$set_col_widths(cols = 1:11, widths = "auto")
```

### Cell Merging and Layout
```r
# Merge cells
wb$merge_cells(dims = "A1:E1")  # Merge header row
wb$merge_cells(dims = "A2:B2")  # Merge specific range

# Unmerge
wb$unmerge_cells(dims = "A1:E1")

# Freeze panes
wb$freeze_pane(first_active_row = 2, first_active_col = 2)  # Freeze first row and column
wb$freeze_pane(first_active_row = 2)  # Freeze first row only
wb$freeze_pane(first_active_col = 2)  # Freeze first column only
```

## Conditional Formatting

### Basic Conditional Formatting
```r
wb <- wb_workbook()$add_worksheet("Conditional")

# Sample data with values for formatting
data <- data.frame(
  values = c(10, 25, 50, 75, 100, 15, 30, 60, 80, 95),
  categories = c("A", "B", "A", "C", "B", "A", "C", "B", "A", "C")
)

wb$add_data(x = data)

# Highlight cells > 50
wb$add_conditional_formatting(
  dims = "A:A",
  rule = ">50",
  style = create_dxfs_style(bg_fill = wb_color("lightgreen"))
)

# Data bars
wb$add_conditional_formatting(
  dims = "A:A", 
  rule = "dataBar",
  style = create_dxfs_style(bg_fill = wb_color("blue"))
)

# Color scales (3-color)
wb$add_conditional_formatting(
  dims = "A:A",
  rule = "colorScale",
  style = c("red", "yellow", "green")
)
```

### Advanced Conditional Formatting
```r
# Icon sets
wb$add_conditional_formatting(
  dims = "A:A",
  rule = "iconSet",
  style = "3Arrows"  # Options: 3Arrows, 4Arrows, 5Arrows, 3TrafficLights, etc.
)

# Top/bottom rules
wb$add_conditional_formatting(
  dims = "A:A", 
  rule = "top10",
  style = create_dxfs_style(font_color = wb_color("red"), text_bold = TRUE)
)

# Formula-based rules
wb$add_conditional_formatting(
  dims = "B:B",
  rule = '=$A1="A"',  # Highlight category A
  style = create_dxfs_style(bg_fill = wb_color("yellow"))
)

# Duplicate values
wb$add_conditional_formatting(
  dims = "B:B",
  rule = "duplicateValues", 
  style = create_dxfs_style(bg_fill = wb_color("orange"))
)
```

## Themes and Workbook Styling

### Base Font and Colors
```r
wb <- wb_workbook()

# Set workbook base font
wb$set_base_font(
  font_size = 11,
  font_color = wb_color("black"),
  font_name = "Arial"
)

# Get current base font
base_font <- wb_get_base_font(wb)

# Set base color scheme
wb$set_base_colors(
  theme = create_colors_xml(
    name = "Custom Theme",
    dark = c("black", "white", "darkblue", "lightgray"),
    accent = c("red", "green", "blue", "orange", "purple", "yellow")
  )
)
```

### Named Styles
```r
# Create reusable named styles
wb$add_named_style(
  style_name = "header_style",
  font_color = wb_color("white"),
  font_size = 14,
  font_name = "Arial",
  bg_fill = wb_color("navy"),
  text_bold = TRUE,
  horizontal = "center"
)

# Apply named style
wb$add_cell_style(dims = "A1:E1", apply_style = "header_style")

# Create data style
wb$add_named_style(
  style_name = "data_style", 
  font_size = 10,
  border = TRUE,
  border_style = "thin",
  horizontal = "left"
)
```

## Style Management Best Practices

### Efficient Style Application
```r
# Pre-create styles for reuse
create_workbook_styles <- function(wb) {
  # Header style
  wb$add_named_style("header",
    font_color = wb_color("white"),
    bg_fill = wb_color("darkblue"),
    text_bold = TRUE,
    horizontal = "center"
  )
  
  # Data style
  wb$add_named_style("data", 
    font_size = 10,
    horizontal = "left"
  )
  
  # Number style
  wb$add_named_style("currency",
    num_fmt = "$#,##0.00"
  )
  
  return(wb)
}

# Apply consistent styling
format_data_sheet <- function(wb, sheet_name, data) {
  wb$add_worksheet(sheet_name)$
    add_data(x = data, with_filter = TRUE)
  
  # Apply header styling
  wb$add_cell_style(dims = paste0("A1:", int2col(ncol(data)), "1"), 
    apply_style = "header"
  )
  
  # Set column widths
  wb$set_col_widths(cols = 1:ncol(data), widths = "auto")
  
  return(wb)
}
```

### Style Templates
```r
# Create style library
style_library <- list(
  title = list(
    font_size = 16,
    text_bold = TRUE, 
    horizontal = "center",
    bg_fill = wb_color("lightgray")
  ),
  
  header = list(
    font_size = 12,
    text_bold = TRUE,
    bg_fill = wb_color("navy"),
    font_color = wb_color("white"),
    horizontal = "center"
  ),
  
  data = list(
    font_size = 10,
    border = TRUE,
    border_style = "thin"
  ),
  
  highlight = list(
    bg_fill = wb_color("yellow"),
    text_bold = TRUE
  )
)

# Function to apply style library
apply_style_from_library <- function(wb, dims, style_name) {
  style <- style_library[[style_name]]
  do.call(wb$add_cell_style, c(list(dims = dims), style))
}
```