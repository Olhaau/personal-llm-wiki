# Agent Instructions: Statistischer Bericht Creation

**Quick Reference for AI Agents**

## When to Use
Create "Statistischer Bericht" when user requests:
- Official German statistical reports
- Destatis-style formatting
- Government publication format
- Statistical office standards

## Quick Setup
```r
# Load the function
source("corporate-design/statistischer-bericht-generator.R")

# Create report
create_statistischer_bericht(
  data_list = your_data_list,
  filename = "report.xlsx", 
  title = "Report Title",
  period = "December 2025"
)
```

## Required Data Structure
```r
# Organize data as named list
data_list <- list(
  "61241-01" = summary_table,
  "61241-02" = time_series_data,
  "61241-03" = detailed_breakdown
)
```

## Key Features Applied
- ✅ **Arial font, size 10** (accessibility standard)
- ✅ **Official Destatis colors** (#004B76 blue)
- ✅ **German number formatting** (comma decimals, space thousands)
- ✅ **Complete navigation system** with hyperlinks
- ✅ **Barrier-free versions** (-b suffix)
- ✅ **CSV data tables** for machine reading
- ✅ **Official sheet structure** (Titel, Inhaltsübersicht, etc.)

## Automatic Sheet Creation
1. **Titel** - Title page with report info
2. **Informationen_Barrierefreiheit** - Accessibility information  
3. **Inhaltsübersicht** - Main navigation hub
4. **Info sheets** - GENESIS-Online, Impressum, etc.
5. **Data tables** - Your data in official format
6. **Barrier-free tables** - Accessible versions (-b suffix)
7. **CSV tables** - Machine-readable versions

## Standard Formatting
- **Numbers**: Automatic German format detection
- **Headers**: Bold, gray background (#E6E6E6)
- **Navigation**: Blue hyperlinks throughout
- **Titles**: Official Destatis blue (#004B76)
- **Layout**: Professional spacing and alignment

## Quality Assurance
The function automatically ensures:
- Consistent navigation on all sheets
- Proper German statistical formatting
- Accessibility compliance
- Official color scheme
- Required metadata and properties

## Common Use Cases

### Financial Statistics
```r
price_data <- list(
  "prices-summary" = quarterly_summary,
  "prices-detailed" = monthly_breakdown
)

create_statistischer_bericht(
  data_list = price_data,
  filename = "price_statistics.xlsx",
  title = "Preisstatistiken",
  evas_number = "61241"
)
```

### Economic Indicators
```r
economic_data <- list(
  "indicators" = economic_indicators,
  "regional" = regional_breakdown  
)

create_statistischer_bericht(
  data_list = economic_data,
  filename = "economic_report.xlsx",
  title = "Wirtschaftsindikatoren"
)
```

This creates a complete, professional German statistical report that matches official Destatis standards exactly.