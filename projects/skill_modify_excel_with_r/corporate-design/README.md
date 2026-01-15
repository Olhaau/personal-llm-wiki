# Corporate Design for Excel Reports

This directory contains corporate design templates and styling for Excel reports, extracted from the modify-excel-with-r skill for use in future projects.

## Files

### Code Files
- `destatis-report.R` - German statistical office (Destatis) report generator with official styling
- `clean-excel-formatter.R` - Clean, professional Excel formatting functions

### Configuration
- `destatis-style.yaml` - Destatis corporate design configuration with colors, fonts, and styling rules

## Usage

### Destatis Reports
```r
source("corporate-design/destatis-report.R")

# Create official Destatis-style report
create_destatis_report(data, "report.xlsx", "Statistischer Bericht")
```

### Clean Corporate Styling
```r
source("corporate-design/clean-excel-formatter.R")

# Apply clean professional formatting
create_clean_report(data, "clean_report.xlsx")
```

### Using Configuration
```r
library(yaml)
config <- read_yaml("corporate-design/destatis-style.yaml")

# Access colors
primary_color <- config$colors$primary  # "#004B76" (Destatis blue)
```

## Features

### Destatis Styling
- Official color palette (#004B76 blue, #0080C8 light blue)
- Arial font family for accessibility
- German number formatting (space separators, comma decimals)
- Professional headers and footers
- Alternating row colors
- Proper margins and page setup

### Clean Formatting
- Modern, minimal design
- Consistent spacing and typography
- Professional color schemes
- Auto-sizing and responsive layouts

## Integration

These corporate design files can be integrated into any R project requiring professional Excel output. Simply source the appropriate R files and apply the styling functions to your data exports.

The configuration files allow for consistent branding across multiple reports and can be customized for different organizations while maintaining professional standards.