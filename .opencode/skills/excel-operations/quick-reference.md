# openxlsx2 Quick Reference

## Essential Functions Cheat Sheet

### **Workbook Operations**
```r
# Create & manage
wb <- wb_workbook()                    # New workbook
wb <- wb_load("file.xlsx")             # Load existing
wb_save(wb, "output.xlsx")             # Save workbook
wb$open()                              # Preview in Excel

# Quick operations
write_xlsx(data, "file.xlsx")          # Quick write
df <- read_xlsx("file.xlsx")           # Quick read
```

### **Worksheet Management** 
```r
wb$add_worksheet("SheetName")          # Add sheet
wb$remove_worksheet("SheetName")       # Remove sheet  
wb$clone_worksheet("Old", "New")       # Copy sheet
wb_get_sheet_names(wb)                 # List sheets
```

### **Data Operations**
```r
wb$add_data(x = data, dims = "A1")     # Write data
wb$add_data_table(x = data)            # Excel table
wb$add_formula(x = "=SUM(A:A)")        # Add formula
df <- wb_to_df(wb)                     # Read to data frame
```

### **Basic Styling**
```r
# Fonts
wb$add_font(dims = "A1:C1", bold = TRUE, size = 12)

# Colors & fills  
wb$add_fill(dims = "A1:C1", color = wb_color("blue"))

# Borders
wb$add_border(dims = "A1:C1", top_style = "thin")

# Number formatting
wb$add_numfmt(dims = "A:A", numfmt = "$#,##0.00")

# Cell alignment
wb$add_cell_style(dims = "A1:C1", horizontal = "center")
```

### **Layout**
```r
wb$set_col_widths(cols = 1:5, widths = "auto")    # Auto-size columns
wb$set_row_heights(rows = 1, heights = 25)        # Set row height
wb$merge_cells(dims = "A1:C1")                    # Merge cells
wb$freeze_pane(first_active_row = 2)              # Freeze panes
```

## Common Patterns

### **Styled Data Export**
```r
wb <- wb_workbook() %>%
  wb_add_worksheet("Data") %>%
  wb_add_data(x = mtcars) %>%
  wb_add_font(dims = "A1:K1", bold = TRUE) %>%
  wb_add_fill(dims = "A1:K1", color = wb_color("lightblue")) %>%
  wb_set_col_widths(cols = 1:11, widths = "auto") %>%
  wb_save("styled_export.xlsx")
```

### **Multi-Sheet Workbook**
```r
datasets <- list(Cars = mtcars, Flowers = iris)
wb <- wb_workbook()

for(name in names(datasets)) {
  wb$add_worksheet(name)$
    add_data(x = datasets[[name]], with_filter = TRUE)$
    set_col_widths(sheet = name, cols = 1:ncol(datasets[[name]]), widths = "auto")
}

wb_save(wb, "multi_sheet.xlsx")
```

### **Financial Report Format**
```r
wb$add_data(x = financial_data) %>%
  wb_add_numfmt(dims = "B:D", numfmt = "$#,##0") %>%        # Currency
  wb_add_numfmt(dims = "E:E", numfmt = "0.00%") %>%         # Percentage  
  wb_add_conditional_formatting(dims = "B:D", rule = "dataBar")  # Data bars
```

## Function Categories Reference

### **Core Functions (Most Used)**
- `wb_workbook()` - Create workbook
- `wb_add_worksheet()` - Add sheet  
- `wb_add_data()` - Write data
- `wb_save()` - Save file
- `wb_load()` - Load file
- `read_xlsx()` / `write_xlsx()` - Quick I/O

### **Styling Functions**
- `wb_add_font()` - Font styling
- `wb_add_fill()` - Background colors
- `wb_add_border()` - Cell borders
- `wb_add_numfmt()` - Number formats
- `wb_add_cell_style()` - Combined styling

### **Layout Functions**  
- `wb_set_col_widths()` - Column widths
- `wb_set_row_heights()` - Row heights
- `wb_merge_cells()` - Merge cells
- `wb_freeze_pane()` - Freeze panes

### **Advanced Features**
- `wb_add_data_table()` - Excel tables
- `wb_add_conditional_formatting()` - Conditional formats
- `wb_add_chart_xml()` - Charts
- `wb_add_sparklines()` - Sparklines
- `wb_add_pivot_table()` - Pivot tables

### **Helpers & Utilities**
- `wb_dims()` - Create cell ranges
- `wb_color()` - Create colors
- `col2int()` / `int2col()` - Convert column refs
- `create_*()` functions - Style objects

## Color Reference

### **Color Creation**
```r
wb_color("red")                    # Named colors
wb_color(hex = "FF5733")          # Hex colors  
wb_color(rgb = c(255, 87, 51))    # RGB values
wb_color(theme = "accent1")       # Theme colors
```

### **Common Colors**
- `wb_color("red")`, `wb_color("blue")`, `wb_color("green")`
- `wb_color("lightblue")`, `wb_color("lightgreen")`, `wb_color("yellow")`
- `wb_color("navy")`, `wb_color("orange")`, `wb_color("purple")`

## Border Styles
- `"thin"`, `"medium"`, `"thick"`, `"double"`
- `"dashed"`, `"dotted"`, `"hair"`
- `"mediumDashed"`, `"dashDot"`

## Number Format Codes

### **Common Formats**
```r
"#,##0"           # Thousands separator
"#,##0.00"        # Two decimal places  
"$#,##0.00"       # Currency
"0.00%"           # Percentage
"yyyy-mm-dd"      # Date format
"h:mm AM/PM"      # Time format
"0.00E+00"        # Scientific notation
```

### **Custom Formats**
```r
'"Value: "$#,##0.00" USD"'                    # Custom text
'[>=1000]#,##0;[<1000]0.00'                  # Conditional formatting
'"↗"#,##0.00;"↘"[Red]#,##0.00;"–"General'    # Symbols for pos/neg/zero
```

## Conditional Formatting Types

### **Rules**
```r
rule = ">50"                    # Greater than value
rule = "between"                # Between two values  
rule = "top10"                  # Top 10 values
rule = "duplicateValues"        # Duplicate values
rule = "dataBar"                # Data bars
rule = "colorScale"             # Color scales  
rule = "iconSet"                # Icon sets
```

### **Icon Sets**
- `"3Arrows"`, `"4Arrows"`, `"5Arrows"`  
- `"3TrafficLights"`, `"4TrafficLights"`
- `"3Stars"`, `"5Quarters"`, `"5Boxes"`

## Cell Reference Helpers

### **Range Creation**
```r
wb_dims(from_row = 1, to_row = 10, from_col = 1, to_col = 5)  # "A1:E10"
wb_dims(rows = 1:10, cols = 1:5)                              # "A1:E10"  
wb_dims(from_col = "A", to_col = "E", from_row = 1, to_row = 10) # "A1:E10"
```

### **Conversions**  
```r
col2int("AZ")        # 52
int2col(52)          # "AZ"
rowcol_to_dims(1, 1, 10, 5)    # "A1:E10"
```

This quick reference covers the most commonly used openxlsx2 functions and patterns for Excel manipulation in R.