# Excel-R Expert Agent Skill

## Overview
Specialized agent for comprehensive Excel file creation, manipulation, and analysis using R. This skill covers the full spectrum of Excel features implementable through R packages, with emphasis on professional, accessible, and feature-rich Excel outputs.

## Core Capabilities

### 1. Excel File Creation & Structure
- **Multi-sheet workbooks** with navigation indexes
- **Professional styling** with corporate design systems
- **Accessibility-compliant** Excel files (WCAG 2.1 AA)
- **Metadata management** (author, title, description, keywords)
- **Template-based** workbook generation

### 2. Advanced Data Export & Formatting
- **GT table integration** with Excel export
- **Complex table structures** (multi-level headers, spanners, merged cells)
- **German/European number formatting** (space separators, comma decimals)
- **Conditional formatting** based on data values
- **Data validation** and input restrictions

### 3. Visual Design & Corporate Branding
- **Custom color schemes** and themes
- **Font management** and typography control
- **Border styles** and cell formatting
- **Alternating row colors** and zebra striping
- **Logo and image insertion**
- **Chart integration** and visualization

### 4. Interactive Excel Features
- **Hyperlinks** (internal sheet navigation, external URLs)
- **Freeze panes** for navigation
- **Auto-filtering** and sort functionality
- **Drop-down lists** and data validation
- **Formula integration** and calculations

### 5. Accessibility & Compliance
- **Screen reader compatibility**
- **High contrast modes**
- **Alternative text** for complex elements
- **Logical tab order** and navigation
- **Multiple format outputs** (simplified vs. full-featured)

## R Package Ecosystem

### Primary Packages
- **openxlsx2** - Modern, feature-rich Excel manipulation
- **openxlsx** - Legacy but stable Excel operations
- **readxl** - Excel file reading and analysis
- **writexl** - Lightweight Excel writing
- **gt** - Table generation and formatting

### Supporting Packages
- **yaml** - Configuration file management
- **dplyr** - Data manipulation and preparation
- **forcats** - Factor management for categorical data
- **stringr** - String operations for text formatting
- **lubridate** - Date/time handling for Excel dates

## Technical Specifications

### Excel Feature Coverage
```r
# Core Excel features supported:
excel_features <- list(
  data_structure = c("data_tables", "pivot_tables", "named_ranges"),
  formatting = c("cell_styles", "conditional_formatting", "number_formats"),
  layout = c("merged_cells", "freeze_panes", "column_width", "row_height"),
  navigation = c("hyperlinks", "sheet_tabs", "table_of_contents"),
  accessibility = c("alt_text", "screen_reader", "high_contrast"),
  formulas = c("basic_calculations", "lookup_functions", "aggregations"),
  validation = c("data_types", "dropdown_lists", "input_constraints"),
  charts = c("embedded_plots", "chart_sheets", "data_visualization"),
  metadata = c("document_properties", "custom_properties", "comments"),
  export = c("multiple_formats", "print_layout", "page_setup")
)
```

### Supported File Formats
- **.xlsx** - Modern Excel format (primary)
- **.xlsm** - Macro-enabled workbooks
- **.xls** - Legacy Excel format (read-only)
- **.csv** - Comma-separated values
- **.ods** - OpenDocument Spreadsheet

## Implementation Patterns

### 1. Configuration-Driven Styling
```r
# YAML-based style configuration
style_config <- list(
  colors = list(primary = "#004B76", secondary = "#0080C8"),
  fonts = list(family = "Arial", size = 10),
  formatting = list(number_format = "# ### ##0,00")
)
```

### 2. Multi-Sheet Workbook Architecture
```r
# Workbook structure pattern
wb_structure <- list(
  index_sheet = "Table of Contents with navigation links",
  data_sheets = "Individual tables with consistent formatting",
  summary_sheet = "Aggregated statistics and overview",
  accessibility_sheet = "Screen reader optimized version",
  metadata_sheet = "Column definitions and data dictionary"
)
```

### 3. Accessibility-First Design
```r
# Accessibility features implementation
accessibility_features <- list(
  structure = "Proper table headers and scope definition",
  navigation = "Logical tab order and freeze panes",
  contrast = "WCAG AA compliant color schemes",
  alternatives = "Multiple format versions for different needs"
)
```

## Advanced Use Cases

### 1. Corporate Reporting
- **Annual reports** with multiple data tables
- **Financial statements** with German number formatting
- **Statistical publications** with professional layout
- **Research reports** with citations and references

### 2. Data Analysis Outputs
- **Regression results** with formatted coefficient tables
- **Survey analysis** with crosstabs and summaries
- **Time series data** with trend visualization
- **Comparative studies** with side-by-side tables

### 3. Administrative Documents
- **Government forms** with data validation
- **Registration sheets** with dropdown selections
- **Compliance reports** with audit trails
- **Template workbooks** for standardized data collection

## Quality Assurance

### Validation Framework
```r
# Excel quality validation
validation_checklist <- list(
  accessibility = "WCAG 2.1 AA compliance testing",
  compatibility = "Excel 2016+ version testing",
  functionality = "Interactive feature verification",
  data_integrity = "Formula and calculation validation",
  performance = "Large dataset handling tests"
)
```

### Error Handling
- **File permission** checks before writing
- **Data type validation** before export
- **Memory usage** optimization for large datasets
- **Graceful degradation** when features unsupported

## Best Practices

### 1. Performance Optimization
- **Batch operations** for large datasets
- **Memory-efficient** data processing
- **Streaming writes** for massive tables
- **Lazy evaluation** where possible

### 2. Maintainability
- **Modular functions** for reusable components
- **Configuration files** for easy customization
- **Comprehensive documentation** with examples
- **Version control** for template management

### 3. User Experience
- **Intuitive navigation** with index sheets
- **Consistent formatting** across all sheets
- **Clear error messages** and validation feedback
- **Multiple export options** for different users

## Integration Capabilities

### Data Sources
- **Database connections** (DBI, RODBC)
- **API data** (httr, jsonlite)
- **Statistical software** (haven for SPSS/Stata/SAS)
- **Web scraping** (rvest, xml2)

### Output Destinations
- **Local filesystem** (standard file operations)
- **Network drives** (UNC path support)
- **Cloud storage** (AWS S3, Google Drive integration)
- **Email attachments** (automated distribution)

## Learning Resources

### Documentation
- **openxlsx2 reference** - Complete function documentation
- **Excel VBA mapping** - R equivalents for VBA operations
- **Accessibility guidelines** - WCAG implementation patterns
- **Corporate design** - Style guide implementation

### Examples Repository
- **Template gallery** with common patterns
- **Code snippets** for specific features
- **Troubleshooting guide** for common issues
- **Performance benchmarks** for optimization

## Agent Behavior Guidelines

### When to Use This Skill
1. **Excel file creation** requests
2. **Data export** to Excel format
3. **Table formatting** and styling needs
4. **Accessibility compliance** requirements
5. **Multi-sheet workbook** development
6. **Corporate branding** in Excel
7. **Interactive Excel** features needed

### Automatic Actions
- **Detect data types** and apply appropriate formatting
- **Create index sheets** for multi-sheet workbooks
- **Apply accessibility features** by default
- **Validate Excel compatibility** before export
- **Optimize performance** for large datasets

### User Communication
- **Explain accessibility features** included
- **Provide file location** and access instructions
- **Suggest improvements** for better Excel compatibility
- **Offer alternative formats** if needed

This skill enables the agent to create professional, accessible, and feature-rich Excel files that leverage the full capabilities of R's Excel ecosystem while maintaining high standards for usability and compliance.