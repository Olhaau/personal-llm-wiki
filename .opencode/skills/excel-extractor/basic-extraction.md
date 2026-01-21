# Basic Excel Extraction Operations

## Quick Start Extraction

### Extract Complete File Specifications
```r
library(openxlsx2)
source("excel-extractor/code/extraction_engine.R")

# Load Excel file
wb <- wb_load("data.xlsx")

# Extract all specifications to JSON
specs <- extract_excel_specifications(wb, output_file = "data_specs.json")

# View extraction summary
print(specs$extraction_summary)
```

### Basic Extraction Patterns

#### Extract Specific Components Only
```r
# Extract only cell values (no formatting)
specs <- extract_excel_specifications(
  wb, 
  include_formatting = FALSE,
  include_advanced = FALSE
)

# Extract only formatting (no values)
specs <- extract_excel_specifications(
  wb,
  include_raw_data = FALSE,
  include_advanced = FALSE
)

# Extract everything except advanced features
specs <- extract_excel_specifications(
  wb,
  include_advanced = FALSE
)
```

#### Extract Single Worksheet
```r
# Extract specifications for one sheet only
sheet_specs <- extract_worksheet_specifications(wb, "Sheet1")

# Save single sheet specs
write_json(sheet_specs, "sheet1_specs.json", pretty = TRUE)
```

## Understanding the JSON Output Structure

### Top-Level Structure
```json
{
  "meta": {
    "extracted_at": "2024-01-20T10:30:00Z",
    "extraction_version": "1.0.0",
    "extractor": "excel-extractor-skill",
    "r_version": "R version 4.3.0",
    "openxlsx2_version": "1.0.0",
    "platform": "Linux"
  },
  "workbook": {
    "properties": {...},
    "theme": {...},
    "defined_names": [...],
    "protection": {...},
    "shared_strings": {...},
    "styles": {...}
  },
  "worksheets": {
    "Sheet1": {...},
    "Sheet2": {...}
  },
  "extraction_summary": {...}
}
```

### Workbook Properties
```json
"workbook": {
  "properties": {
    "title": "Sales Report Q4 2023",
    "subject": "Quarterly Sales Analysis", 
    "creator": "John Smith",
    "keywords": "sales, quarterly, analysis",
    "description": "Detailed sales analysis for Q4 2023",
    "last_modified_by": "Jane Doe",
    "created": "2023-10-01T00:00:00Z",
    "modified": "2023-12-31T15:30:00Z",
    "category": "Reports",
    "version": "1.0"
  }
}
```

### Worksheet Structure
```json
"worksheets": {
  "Sales_Data": {
    "name": "Sales_Data",
    "properties": {
      "visible": true,
      "tab_color": "#FF6B6B", 
      "zoom": 100,
      "grid_lines": true,
      "freeze_panes": {
        "has_freeze_panes": true,
        "freeze_row": 1,
        "freeze_col": 0,
        "top_left_cell": "A2"
      }
    },
    "dimensions": {
      "used_range": "A1:H100",
      "max_row": 100,
      "max_col": 8,
      "total_cells": 800
    },
    "cells": {...},
    "formatting": {...},
    "advanced_features": {...}
  }
}
```

### Cell Data Structure
```json
"cells": {
  "A1": {
    "address": "A1",
    "row": 1,
    "col": 1,
    "value": "Product Name",
    "type": "string",
    "formula": null,
    "comment": null
  },
  "B1": {
    "address": "B1", 
    "row": 1,
    "col": 2,
    "value": "Sales Amount",
    "type": "string",
    "formula": null,
    "comment": null
  },
  "C2": {
    "address": "C2",
    "row": 2,
    "col": 3, 
    "value": 1234.56,
    "type": "number",
    "formula": "=B2*D2",
    "comment": "Calculated field"
  }
}
```

## Working with Extracted Data

### Analyze Cell Contents
```r
# Count cells by type
cell_types <- sapply(specs$worksheets$Sheet1$cells, function(cell) cell$type)
table(cell_types)

# Find all formulas
formulas <- specs$worksheets$Sheet1$cells[
  sapply(specs$worksheets$Sheet1$cells, function(cell) !is.null(cell$formula))
]
length(formulas)

# Get cells with comments
commented_cells <- specs$worksheets$Sheet1$cells[
  sapply(specs$worksheets$Sheet1$cells, function(cell) !is.null(cell$comment))
]
```

### Extract Specific Data
```r
# Get all numeric values from a sheet
numeric_values <- sapply(specs$worksheets$Sheet1$cells, function(cell) {
  if (cell$type == "number") cell$value else NA
})
numeric_values <- numeric_values[!is.na(numeric_values)]

# Get all text values
text_values <- sapply(specs$worksheets$Sheet1$cells, function(cell) {
  if (cell$type == "string") cell$value else NA
})
text_values <- text_values[!is.na(text_values)]
```

### Reconstruction Preparation
```r
# Validate extraction is complete
validation <- validate_extraction(specs, wb)
print(validation)

# Check if ready for reconstruction
if (validation$reconstruction_readiness$reconstruction_confidence == "high") {
  cat("File is ready for accurate reconstruction\n")
} else {
  cat("Reconstruction may have issues:\n")
  print(validation$reconstruction_readiness$missing_elements)
}
```

## Common Use Cases

### Documentation Generation
```r
# Generate human-readable summary
generate_excel_summary <- function(specs) {
  summary <- list(
    file_info = list(
      total_sheets = length(specs$worksheets),
      total_cells = specs$extraction_summary$total_cells,
      complexity = specs$extraction_summary$complexity_score
    ),
    sheets = lapply(specs$worksheets, function(sheet) {
      list(
        name = sheet$name,
        dimensions = sheet$dimensions$used_range,
        cell_count = length(sheet$cells),
        has_formulas = any(sapply(sheet$cells, function(c) !is.null(c$formula)))
      )
    })
  )
  return(summary)
}

summary <- generate_excel_summary(specs)
write_json(summary, "file_summary.json", pretty = TRUE)
```

### Data Migration Preparation  
```r
# Extract just data values for migration
extract_data_only <- function(specs) {
  data_only <- list()
  
  for (sheet_name in names(specs$worksheets)) {
    sheet <- specs$worksheets[[sheet_name]]
    
    # Convert cells to matrix format
    if (length(sheet$cells) > 0) {
      max_row <- max(sapply(sheet$cells, function(c) c$row))
      max_col <- max(sapply(sheet$cells, function(c) c$col))
      
      data_matrix <- matrix(NA, nrow = max_row, ncol = max_col)
      
      for (cell in sheet$cells) {
        data_matrix[cell$row, cell$col] <- cell$value
      }
      
      data_only[[sheet_name]] <- data_matrix
    }
  }
  
  return(data_only)
}

data_only <- extract_data_only(specs)
```

### Quality Assessment
```r
# Assess file complexity and features
assess_file_features <- function(specs) {
  features <- list(
    basic_data = specs$extraction_summary$total_cells > 0,
    multiple_sheets = length(specs$worksheets) > 1,
    has_formulas = specs$extraction_summary$has_formulas,
    has_formatting = any(sapply(specs$worksheets, function(sheet) {
      length(sheet$formatting) > 0
    })),
    has_charts = specs$extraction_summary$has_charts,
    has_pivot_tables = specs$extraction_summary$has_pivot_tables,
    complexity_level = if (specs$extraction_summary$complexity_score < 30) "Simple" else
                      if (specs$extraction_summary$complexity_score < 70) "Moderate" else "Complex"
  )
  
  return(features)
}

features <- assess_file_features(specs)
print(features)
```

## Error Handling

### Handle Large Files
```r
# For very large files, extract in chunks
extract_large_file <- function(file_path, max_cells_per_sheet = 10000) {
  wb <- wb_load(file_path)
  sheets <- wb_get_sheet_names(wb)
  
  all_specs <- list()
  
  for (sheet_name in sheets) {
    # Check sheet size first
    sheet_dims <- extract_sheet_dimensions(wb, sheet_name)
    
    if (sheet_dims$total_cells > max_cells_per_sheet) {
      warning("Sheet ", sheet_name, " has ", sheet_dims$total_cells, 
              " cells, extracting basic info only")
      
      # Extract without detailed formatting for large sheets
      sheet_specs <- extract_worksheet_specifications(
        wb, sheet_name,
        include_formatting = FALSE,
        include_advanced = FALSE
      )
    } else {
      sheet_specs <- extract_worksheet_specifications(wb, sheet_name)
    }
    
    all_specs[[sheet_name]] <- sheet_specs
  }
  
  return(all_specs)
}
```

### Validate Input Files
```r
# Check if file can be extracted
can_extract_file <- function(file_path) {
  tryCatch({
    wb <- wb_load(file_path)
    sheets <- wb_get_sheet_names(wb)
    
    if (length(sheets) == 0) {
      return(list(can_extract = FALSE, reason = "No worksheets found"))
    }
    
    # Test basic extraction
    test_sheet <- extract_sheet_dimensions(wb, sheets[1])
    
    return(list(can_extract = TRUE, sheets = sheets))
  }, error = function(e) {
    return(list(can_extract = FALSE, reason = paste("Error:", e$message)))
  })
}

check_result <- can_extract_file("test.xlsx")
if (check_result$can_extract) {
  specs <- extract_excel_specifications(wb_load("test.xlsx"))
} else {
  cat("Cannot extract:", check_result$reason)
}
```

## Performance Tips

### Optimize Extraction
```r
# Fast extraction for analysis only (no formatting)
fast_extract <- function(file_path) {
  wb <- wb_load(file_path)
  
  specs <- extract_excel_specifications(
    wb,
    include_formatting = FALSE,  # Skip formatting to save time
    include_advanced = FALSE     # Skip charts, etc. for speed
  )
  
  return(specs)
}

# Extract specific sheets only
extract_sheets <- function(file_path, sheet_names) {
  wb <- wb_load(file_path)
  
  specs <- list(worksheets = list())
  
  for (sheet_name in sheet_names) {
    if (sheet_name %in% wb_get_sheet_names(wb)) {
      specs$worksheets[[sheet_name]] <- extract_worksheet_specifications(wb, sheet_name)
    }
  }
  
  return(specs)
}
```