---
name: "excel-extractor"
description: "Comprehensive Excel file extraction skill - Extracts all specifications from .xlsx files to JSON format for AI agent consumption and reconstruction"
---

# Excel Extractor - Comprehensive Specification Extraction Skill

**🔍 COMPREHENSIVE EXCEL EXTRACTION**: This skill provides complete extraction of Excel file specifications to JSON format. It captures all structural, formatting, content, and complex features needed for AI agents to understand and recreate Excel files exactly.

## When to Use This Skill

**Use this skill when you need to:**
- Extract complete Excel file specifications to JSON for AI agent analysis
- Create machine-readable documentation of Excel file structure
- Backup Excel formatting and structure information  
- Prepare Excel files for programmatic reconstruction
- Analyze Excel file complexity and features
- Generate input for the excel-operations skill to recreate files

## Core Extraction Capabilities

**Why This Skill is Essential:**
- **Complete Coverage**: Extracts ALL Excel features including hidden elements
- **AI-Optimized**: JSON output designed for AI agent consumption
- **Reconstruction-Ready**: Contains sufficient detail to recreate identical files
- **Human-Readable**: Structured JSON that humans can understand and modify
- **Lossless**: Preserves all formatting, formulas, and complex features

### **Structural Extraction**
- Workbook properties and metadata
- Worksheet structure and properties
- Cell ranges and dimensions
- Named ranges and defined names
- Sheet relationships and dependencies

### **Content Extraction**
- Raw cell values with proper typing
- Formulas with full syntax
- Comments and notes
- Hyperlinks and external references
- Data validation rules

### **Formatting Extraction**
- Font properties (family, size, color, style)
- Cell backgrounds and patterns
- Borders (styles, colors, all sides)
- Number formats (built-in and custom)
- Alignment and text properties
- Conditional formatting rules

### **Advanced Features**
- Charts and sparklines with full specifications
- Pivot tables with layout and data sources
- Data tables and Excel Tables
- Form controls and ActiveX objects  
- Macros and VBA code (if present)
- Print settings and page setup
- Protection and security settings

## Quick Start

For basic extraction, see [`basic-extraction.md`](basic-extraction.md).
For advanced features, see [`advanced-extraction.md`](advanced-extraction.md).
For JSON schema reference, see [`json-schema.md`](json-schema.md).

## Basic Usage Pattern

```r
library(openxlsx2)
source("excel-extractor/code/extraction_engine.R")

# Load Excel file
wb <- wb_load("complex_file.xlsx")

# Extract complete specifications
excel_specs <- extract_excel_specifications(wb)

# Save to JSON
write_json(excel_specs, "excel_specifications.json", pretty = TRUE)

# Verify extraction completeness
validation_report <- validate_extraction(excel_specs, wb)
print(validation_report)
```

## JSON Output Structure

The extraction creates a hierarchical JSON structure:

```json
{
  "meta": {
    "extracted_at": "2024-01-20T10:30:00Z",
    "extraction_version": "1.0.0",
    "source_file": "example.xlsx",
    "extractor": "excel-extractor-skill"
  },
  "workbook": {
    "properties": {...},
    "theme": {...},
    "worksheets": [...],
    "defined_names": [...],
    "protection": {...}
  },
  "extraction_summary": {
    "total_sheets": 3,
    "total_cells": 1524,
    "has_formulas": true,
    "has_charts": true,
    "complexity_score": 85
  }
}
```

## Extraction Functions by Category

### **Core Extraction Functions**
- `extract_excel_specifications()` - Main extraction function
- `extract_workbook_properties()` - Workbook-level metadata
- `extract_worksheet_specifications()` - Complete sheet analysis
- `extract_cell_specifications()` - Individual cell details

### **Content Extraction**
- `extract_cell_values()` - Raw values with proper typing
- `extract_formulas()` - Formula expressions and dependencies
- `extract_comments()` - Cell comments and threading
- `extract_hyperlinks()` - Links and external references

### **Formatting Extraction**
- `extract_font_specifications()` - Font properties
- `extract_fill_specifications()` - Backgrounds and patterns
- `extract_border_specifications()` - Border styles and colors
- `extract_number_formats()` - All number formatting rules

### **Advanced Feature Extraction**
- `extract_charts()` - Chart specifications and data
- `extract_pivot_tables()` - Pivot table structure and settings
- `extract_data_validation()` - Validation rules and lists
- `extract_conditional_formatting()` - CF rules and styles

## Skill Organization

- `SKILL.md` - Core extraction overview and function reference
- `basic-extraction.md` - Simple extraction patterns
- `advanced-extraction.md` - Complex feature extraction
- `json-schema.md` - Complete JSON output schema
- `code/` - Extraction engine and helper functions
- `examples/` - Sample extractions and use cases
- `templates/` - JSON templates for reconstruction

## Integration with excel-operations

This skill generates JSON that the excel-operations skill can consume:

```r
# Extract specifications
specs <- extract_excel_specifications(original_wb)
write_json(specs, "file_specs.json")

# Later: Reconstruct from specifications  
specs <- read_json("file_specs.json")
reconstructed_wb <- create_workbook_from_specifications(specs)
wb_save(reconstructed_wb, "reconstructed.xlsx")
```

## Extraction Quality Assurance

### **Completeness Validation**
- Verify all sheets are extracted
- Check cell count matches
- Validate formula references
- Confirm formatting preservation

### **Accuracy Testing**
- Compare extracted values with original
- Validate formula calculations  
- Test conditional formatting rules
- Verify chart data accuracy

### **Reconstruction Testing**
- Create new file from JSON specifications
- Compare with original file
- Test functionality preservation
- Validate visual appearance

## Use Cases

### **AI Agent Consumption**
- Provide complete Excel context to AI agents
- Enable intelligent Excel file analysis
- Support automated Excel processing workflows
- Create training data for Excel AI models

### **Documentation & Backup**
- Create human-readable Excel file documentation
- Backup complex formatting and structure
- Track changes in Excel file evolution
- Generate Excel file inventories

### **Analysis & Migration**
- Analyze Excel file complexity and features
- Prepare for Excel version migrations
- Audit Excel file contents and structure
- Support Excel to other format conversions

## Extension Guidelines

When extending this skill:
- Maintain JSON schema compatibility
- Add extraction for new Excel features
- Include validation for new extractions
- Update reconstruction capabilities
- Follow semantic versioning for JSON schema changes

---

**Foundation Integration**: This skill works alongside the excel-operations skill to provide complete Excel manipulation capabilities - extraction for analysis and reconstruction for creation.