# Code Library

This folder contains the core R functions and utilities for Excel manipulation using openxlsx2.

## Core Files

- **`extract_excel_to_json.R`** - Main Excel to JSON extraction functions
- **`analyze_statistischer_bericht.R`** - Analysis functions for German statistical reports
- **`clinical_to_statistischer_bericht.R`** - Convert clinical data to German statistical format
- **`detailed_excel_analysis.R`** - Detailed Excel structure analysis utilities

## Usage

These files provide the underlying functions used by the main solution scripts in the project root. They can be sourced individually for specific functionality:

```r
# Load Excel analysis functions
source("code/analyze_statistischer_bericht.R")

# Load JSON extraction functions  
source("code/extract_excel_to_json.R")

# Load clinical data conversion
source("code/clinical_to_statistischer_bericht.R")
```

## Integration

These functions are integrated into the main solution scripts:
- `complete_formatting_fix.R` - Uses extraction and conversion functions
- `working_hyperlinks_demo.R` - Uses basic Excel manipulation functions

## Development

Development and experimental versions of these functions have been moved to the `archive/development/` folder.