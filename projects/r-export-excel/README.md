# Excel Export with Destatis Corporate Design

R project for exporting data to nicely formatted Excel files following Destatis corporate design guidelines.

## Features

- Export `gt` tables to formatted Excel files
- CSS-based styling configuration
- Destatis corporate design (blue colors, Arial 10pt)
- Automatic heading rows
- Frozen panes (rows and columns)
- Index sheet with navigation links
- Configurable through `config/destatis_style.yaml`

## Installation

Required packages:
```r
install.packages(c("openxlsx2", "gt", "yaml"))
```

## Usage

```r
source("R/excelize.R")

# Create a gt table
library(gt)
my_table <- gt(head(mtcars))

# Export to Excel with Destatis styling
excelize(
  gt_object = my_table,
  filename = "output/my_report.xlsx",
  sheet_name = "Data",
  heading = "Motor Trend Car Road Tests",
  freeze_rows = 2,
  freeze_cols = 1,
  add_index_link = TRUE
)
```

## Configuration

Edit `config/destatis_style.yaml` to customize:
- Colors (primary, secondary, background)
- Font settings (family, size)
- Header styles
- Cell formatting

## Project Structure

```
r-export-excel/
├── R/
│   └── excelize.R          # Main export function
├── config/
│   └── destatis_style.yaml # Style configuration
├── examples/
│   └── example_usage.R     # Example scripts
├── output/                 # Generated Excel files
├── DESCRIPTION             # Project metadata
└── README.md              # This file
```
