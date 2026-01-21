---
name: "excel-operations"
description: "CORE Excel operations skill - Default foundation for all Excel manipulation using R openxlsx2 package"
---

# Excel Operations - Core Foundation Skill

**🔧 CORE EXCEL OPERATIONS**: This skill provides the foundational capabilities for ALL Excel manipulation in this environment. It serves as the base layer that other Excel-related skills build upon. R with openxlsx2 ensures reproducible, script-based Excel operations that humans can understand, review, and modify.

## When to Use This Skill

**Use this skill as the foundation for ALL Excel operations** - this provides core capabilities that other skills extend:
- Reading Excel files (.xlsx, .xlsm, .xlsb) into R data frames
- Writing R data to Excel workbooks with custom formatting
- Creating and modifying Excel workbooks programmatically  
- Advanced styling: fonts, colors, borders, fills, conditional formatting
- Managing worksheets: add, remove, copy, modify properties
- Data tables, pivot tables, charts, and sparklines
- Cell formatting: number formats, alignment, protection
- Workbook-level operations: properties, themes, protection

## Core Foundation Capabilities

**Why This Serves as the Core Foundation:**
- **Transparency**: All operations are scripted and reviewable by humans
- **Reproducibility**: Excel manipulations can be automated and repeated exactly
- **Version Control**: R scripts can be tracked and versioned unlike manual Excel work
- **Documentation**: Code serves as documentation of what was done to Excel files
- **Integration**: Seamlessly works with existing R data analysis workflows
- **Flexibility**: Programmatic approach allows complex conditional operations
- **Extensibility**: Other skills can build upon these core operations for specialized use cases

This foundational skill enables comprehensive Excel manipulation through openxlsx2's full feature set:

### **Reading Operations**
- Load existing Excel files into R workbooks
- Convert workbook data to data frames with type conversion
- Read specific ranges, sheets, or cells
- Handle dates, times, and formatted numbers

### **Writing Operations**  
- Create new workbooks from scratch
- Write data frames and matrices to worksheets
- Save workbooks to files with compression options
- Export with formulas and dynamic content

### **Styling System**
- Font styling (family, size, color, bold, italic, underline)
- Cell backgrounds and patterns (solid colors, gradients, patterns)  
- Borders (styles, colors, individual sides)
- Number formatting (currency, dates, percentages, custom formats)
- Cell alignment and text wrapping
- Conditional formatting with rules and styles

### **Worksheet Management**
- Add, remove, copy, and reorder worksheets
- Set visibility, protection, and properties
- Freeze panes and split views
- Page setup for printing (margins, orientation, scaling)
- Headers and footers with dynamic content

### **Advanced Features**
- Data tables with sorting and filtering
- Pivot tables with custom layouts
- Charts and sparklines for visualization
- Named ranges for easier formula references
- Comments and threaded discussions
- Hyperlinks to cells, files, or URLs
- Data validation rules
- Form controls (checkboxes, dropdowns)

## Quick Start

For basic operations, see [`basic-operations.md`](basic-operations.md).
For styling examples, see [`styling-guide.md`](styling-guide.md).
For advanced features, see [`advanced-features.md`](advanced-features.md).

## Basic Usage Pattern

```r
library(openxlsx2)

# Create workbook and add data
wb <- wb_workbook() %>%
  wb_add_worksheet("Sheet1") %>%
  wb_add_data(x = mtcars, dims = "A1")

# Apply styling
wb %>%
  wb_add_font(dims = "A1:K1", bold = TRUE) %>%
  wb_add_fill(dims = "A1:K1", color = wb_color("blue")) %>%
  wb_set_col_widths(cols = 1:11, widths = "auto")

# Save to file
wb_save(wb, "styled_data.xlsx")
```

## Package Functions by Category

The openxlsx2 package provides 166+ exported functions organized by functionality:

### **Core Workbook Functions**
- `wb_workbook()` - Create new workbook
- `wb_load()` - Load existing Excel file
- `wb_save()` - Save workbook to file
- `wb_open()` - Open workbook in spreadsheet software

### **Data Operations**
- `wb_add_data()` - Write data to worksheet
- `wb_read()`, `wb_to_df()` - Read data from workbook
- `read_xlsx()` - Quick read Excel to data frame
- `write_xlsx()` - Quick write data frame to Excel

### **Worksheet Management**
- `wb_add_worksheet()` - Add new worksheet
- `wb_remove_worksheet()` - Remove worksheet
- `wb_clone_worksheet()` - Copy worksheet
- `wb_set_sheet_names()` - Rename worksheets

### **Styling Functions**
- Font: `wb_add_font()`, `create_font()`
- Fill: `wb_add_fill()`, `create_fill()`  
- Border: `wb_add_border()`, `create_border()`
- Number Format: `wb_add_numfmt()`, `create_numfmt()`
- Cell Style: `wb_add_cell_style()`, `create_cell_style()`

### **Layout & Formatting**
- `wb_set_col_widths()` - Set column widths
- `wb_set_row_heights()` - Set row heights
- `wb_merge_cells()` - Merge cell ranges
- `wb_freeze_pane()` - Freeze panes for scrolling

## Skill Organization

- `SKILL.md` - Core foundation overview and function reference
- `basic-operations.md` - Reading, writing, and simple formatting
- `styling-guide.md` - Complete styling system with examples
- `advanced-features.md` - Complex features like charts and pivot tables
- `code/` - Helper functions and reusable templates
- `examples/` - Working code examples for common use cases
- `config/` - Integration policies and system requirements

## Extension Pattern for Other Skills

Other Excel-related skills should build upon this foundation:
- Import this skill's helper functions: `source("excel-operations/code/excel_helpers.R")`
- Reference core capabilities: Use basic operations as building blocks
- Extend functionality: Add domain-specific Excel operations
- Maintain consistency: Follow same R+openxlsx2 approach and human-readable patterns