---
name: "Excel-R Expert"
description: "Comprehensive Excel file creation and manipulation using R, supporting professional German statistical reports, accessibility compliance, and corporate design standards"
---

# Excel-R Expert Skill

## When to Use This Skill

Use this skill for any task involving:
- Creating Excel files from R data
- Professional statistical reporting (especially German/European standards)
- Multi-sheet workbooks with navigation
- Corporate design and branding in Excel
- Accessibility-compliant Excel outputs (WCAG 2.1 AA)
- Advanced Excel features (conditional formatting, formulas, validation)

## Core Capabilities

This skill enables the agent to create sophisticated Excel files using R that include:

### Professional Formatting
- **Corporate design systems** (Destatis, BMF, custom themes)
- **German/European number formatting** (space separators, comma decimals)
- **Multi-level headers** and complex table structures
- **Accessibility features** for screen readers and compliance

### Advanced Excel Features
- **Multi-sheet workbooks** with navigation indexes
- **Hyperlink systems** for internal navigation
- **Conditional formatting** and data validation
- **Freeze panes** and auto-sizing
- **Formula integration** and calculations

### Statistical Reporting
- **Destatis-style reports** ("Statistischer Bericht" format)
- **Summary statistics** and cross-tabulations
- **Methodology documentation** and metadata
- **Multiple output formats** (full-featured vs. simplified)

## Quick Start

For immediate use, see the comprehensive examples in [`examples.md`](examples.md).

For advanced formatting and corporate design, see [`corporate-styling.md`](corporate-styling.md).

For accessibility compliance features, see [`accessibility.md`](accessibility.md).

For troubleshooting common issues, see [`troubleshooting.md`](troubleshooting.md).

## Package Dependencies

This skill requires the following R packages:
```r
# Primary packages
library(openxlsx2)  # Modern Excel manipulation
library(dplyr)      # Data processing
library(tidyr)      # Data reshaping

# Supporting packages  
library(gt)         # Table formatting
library(yaml)       # Configuration management
library(forcats)    # Factor handling
library(lubridate)  # Date/time processing
```

## Basic Usage Pattern

```r
# 1. Load the skill examples
source(".opencode/skills/excel-r-expert/code/excel-examples.R")

# 2. Create basic Excel file
create_basic_excel(data, "output.xlsx")

# 3. Create professional report
create_corporate_excel(data, "report.xlsx", 
                      title = "Statistical Report",
                      color_scheme = "destatis")

# 4. Create accessible version
create_accessible_excel(data, "accessible.xlsx",
                       title = "Accessible Data Table")
```

## File Structure

- `SKILL.md` - This overview file
- `examples.md` - Complete code examples and usage patterns
- `corporate-styling.md` - Corporate design and German formatting
- `accessibility.md` - WCAG compliance and accessibility features
- `troubleshooting.md` - Common issues and solutions
- `code/` - Executable R scripts and helper functions
  - `excel-examples.R` - Main example functions
  - `destatis-report.R` - Statistical report generator
  - `accessibility-helpers.R` - Accessibility utilities
- `config/` - Configuration files and templates
  - `destatis-style.yaml` - Destatis corporate design
  - `bmf-style.yaml` - BMF corporate design
- `templates/` - Reusable templates and patterns

## Integration with Existing Workflow

This skill integrates seamlessly with:
- **Research data analysis** - Export results to professional Excel
- **Government reporting** - Destatis/BMF compliant outputs
- **Academic publications** - Accessibility-compliant supplementary materials
- **Corporate reporting** - Branded multi-sheet workbooks
- **Data sharing** - Multiple format outputs for different audiences

The skill automatically detects data types and applies appropriate German formatting, creates navigation systems for multi-sheet workbooks, and ensures accessibility compliance by default.

## Progressive Disclosure

Start with basic examples, then explore advanced features:
1. **Basic usage** - Simple data export with formatting
2. **Corporate styling** - Professional reports with branding  
3. **Multi-sheet workbooks** - Complex reports with navigation
4. **Accessibility features** - WCAG-compliant outputs
5. **Advanced customization** - Configuration-driven styling

Use the `code/` directory for executable scripts and the configuration files for consistent styling across projects.