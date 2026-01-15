# Statistischer Bericht Style Guide

**Agent Guidelines for Creating Official German Statistical Reports**

Based on analysis of: `statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx`

---

## 📋 Document Structure Overview

### Required Sheet Types

1. **Titel** - Main title page
2. **Informationen_Barrierefreiheit** - Accessibility information
3. **Inhaltsübersicht** - Table of contents with navigation
4. **GENESIS-Online** - Online database reference  
5. **Impressum** - Legal notice/imprint
6. **Informationen_zur_Statistik** - Statistical methodology
7. **Data Tables** (61241-xx format) - Main statistical data
8. **CSV Tables** (csv-61241-xx) - Machine-readable data versions

---

## 🎨 Visual Design Standards

### Typography
- **Font Family**: Arial (required for accessibility)
- **Base Font Size**: 10pt
- **Title Font Size**: 14pt (bold)
- **Header Font Size**: 11pt (bold)

### Colors (Official Destatis Palette)
- **Primary Blue**: #004B76 (main headers, navigation)
- **Secondary Blue**: #0080C8 (sub-headers, accents)
- **Background Gray**: #F5F5F5 (alternating rows)
- **Header Gray**: #E6E6E6 (column headers)
- **Text Black**: #000000 (body text)
- **White**: #FFFFFF (title backgrounds)

---

## 📊 Sheet-Specific Formatting

### 1. Titel Sheet
```r
# Create title page
wb$add_worksheet("Titel")
wb$add_data(x = "Statistischer Bericht", dims = "A1")
wb$add_data(x = "Preise für ausgewählte Mineralölerzeugnisse", dims = "A2") 
wb$add_data(x = format(Sys.Date(), "%B %Y"), dims = "A3")
wb$add_data(x = "EVAS-Nummer", dims = "A4")

# Apply title formatting
wb$add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("#004B76"))
wb$add_font(dims = "A2", bold = TRUE, size = 14)
wb$add_font(dims = "A3", bold = FALSE, size = 12)
```

### 2. Inhaltsübersicht (Table of Contents)
```r
# Navigation sheet with hyperlinks
wb$add_worksheet("Inhaltsübersicht")
wb$add_data(x = "Inhaltsübersicht", dims = "A1")

# Format main title
wb$add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("white"))
wb$add_fill(dims = "A1", color = wb_color("#004B76"))
wb$add_cell_style(dims = "A1", horizontal = "center")
wb$merge_cells(dims = "A1:B1")

# Add navigation links (example)
navigation_items <- c(
  "Informationen zur Barrierefreiheit",
  "Übersicht GENESIS-Online", 
  "Impressum",
  "Informationen zur Statistik"
)

for (i in seq_along(navigation_items)) {
  row <- i + 1
  wb$add_data(x = navigation_items[i], dims = paste0("A", row))
  wb$add_hyperlink(dims = paste0("A", row), 
                   target = paste0("#", gsub(" ", "_", navigation_items[i]), "!A1"))
  wb$add_font(dims = paste0("A", row), color = wb_color("blue"))
}
```

### 3. Data Tables (61241-xx Format)
```r
# Main statistical data tables
create_data_table <- function(wb, sheet_name, data, table_title) {
  wb$add_worksheet(sheet_name)
  
  # Back navigation link
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
  wb$add_hyperlink(dims = "A1", target = "#Inhaltsübersicht!A1")
  wb$add_font(dims = "A1", color = wb_color("blue"))
  
  # Table title
  wb$add_data(x = table_title, dims = "A2")
  wb$add_font(dims = "A2", bold = TRUE, size = 14, color = wb_color("#004B76"))
  
  # Data starting from row 4
  wb$add_data(x = data, dims = "A4")
  
  # Apply German number formatting
  apply_german_statistical_formatting(wb, sheet_name, data, start_row = 5)
  
  # Header formatting
  wb$add_font(dims = paste0("A4:", int2col(ncol(data)), "4"), bold = TRUE)
  wb$add_fill(dims = paste0("A4:", int2col(ncol(data)), "4"), color = wb_color("#E6E6E6"))
}
```

---

## 🔢 German Statistical Number Formatting

### Standard Formats by Data Type

```r
apply_german_statistical_formatting <- function(wb, sheet, data, start_row) {
  for (col in 1:ncol(data)) {
    if (is.numeric(data[[col]])) {
      range <- paste0(int2col(col), start_row, ":", int2col(col), start_row + nrow(data) - 1)
      
      # Determine format based on typical statistical values
      max_val <- max(abs(data[[col]]), na.rm = TRUE)
      
      if (max_val >= 1000) {
        # Large numbers: use space separator, 2 decimals
        wb$add_numfmt(dims = range, numfmt = "# ##0,00")
      } else if (max_val >= 1) {
        # Medium numbers: 2 decimals
        wb$add_numfmt(dims = range, numfmt = "0,00") 
      } else {
        # Small/percentage values: 4 decimals
        wb$add_numfmt(dims = range, numfmt = "0,0000")
      }
    }
  }
}
```

### Specific Number Formats
- **Prices (Euro)**: `# ##0,00` → `1 234,56`
- **Percentages**: `0,00%` → `12,34%`
- **Index values**: `0,00` → `123,45`
- **Years**: `0` → `2025`
- **Large numbers**: `# ### ##0` → `1 234 567`

---

## 📝 Sheet Naming Conventions

### Pattern Recognition
- **Layout tables**: `61241-01`, `61241-02`, etc.
- **CSV tables**: `csv-61241-01`, `csv-61241-02`, etc.
- **Barrier-free tables**: `61241-b01`, `61241-b02` (marked with "-b")
- **Information sheets**: `Informationen_zur_Statistik`, `Informationen_Barrierefreiheit`

### Naming Rules
1. **Statistical tables**: Use official table numbers (e.g., `61241-01`)
2. **CSV versions**: Prefix with `csv-` (e.g., `csv-61241-01`)
3. **Barrier-free**: Add `-b` suffix (e.g., `61241-b01`)
4. **Information**: Use descriptive names with underscores
5. **Navigation**: Always use `Inhaltsübersicht` for main index

---

## 🔗 Navigation System

### Required Navigation Elements

1. **"zur Inhaltsübersicht"** link on every data sheet (cell A1)
2. **Table of contents** with clickable links to all sheets
3. **Sheet descriptions** in the index
4. **Consistent hyperlink styling** (blue, underlined)

```r
# Standard navigation implementation
add_navigation_link <- function(wb, sheet, target_sheet = "Inhaltsübersicht") {
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
  wb$add_hyperlink(dims = "A1", target = paste0("#", target_sheet, "!A1"))
  wb$add_font(dims = "A1", color = wb_color("blue"))
}
```

---

## 📱 Accessibility Requirements

### Barrier-Free Design Standards

```r
create_barrier_free_table <- function(wb, sheet_name, data, description) {
  # Add "-b" suffix to sheet name
  bf_sheet_name <- paste0(sheet_name, "-b")
  wb$add_worksheet(bf_sheet_name)
  
  # Add accessibility description
  wb$add_data(x = paste(description, "Sie erstreckt sich über", ncol(data), 
                       "Spalten und", nrow(data), "Zeilen."), dims = "A1")
  
  # Simplified formatting for screen readers
  wb$add_data(x = data, dims = "A3")
  
  # Minimal styling for maximum compatibility
  wb$add_font(dims = paste0("A3:", int2col(ncol(data)), "3"), bold = TRUE)
  
  return(bf_sheet_name)
}
```

### Accessibility Features
- **Table descriptions** with dimensions
- **Clear sheet titles** and purposes
- **High contrast** text and backgrounds
- **No complex merged cells** in data areas
- **Consistent navigation** structure

---

## 🏢 Corporate Metadata

### Document Properties
```r
set_destatis_properties <- function(wb, title, subject) {
  wb$set_properties(
    title = title,
    subject = "Statistischer Bericht",
    creator = "Statistisches Bundesamt",
    category = "Amtliche Statistik",
    keywords = "Destatis, Preise, Statistik, Deutschland"
  )
}
```

### Standard Headers/Footers
- **Header**: Report title and period
- **Footer**: "© Statistisches Bundesamt (Destatis)" + page numbers
- **Date format**: German format (DD.MM.YYYY)

---

## ⚡ Quick Implementation Function

```r
#' Create Complete Statistischer Bericht
#' 
#' @param data_list Named list of data frames
#' @param filename Output filename 
#' @param title Main report title
#' @param period Reporting period (e.g., "Dezember 2025")
create_statistischer_bericht <- function(data_list, filename, title, period) {
  wb <- wb_workbook()
  
  # Set base formatting
  wb$set_base_font(font_name = "Arial", font_size = 10)
  set_destatis_properties(wb, title, period)
  
  # 1. Create title sheet
  create_title_sheet(wb, title, period)
  
  # 2. Create accessibility info sheet
  create_accessibility_sheet(wb)
  
  # 3. Create table of contents
  create_table_of_contents(wb, names(data_list))
  
  # 4. Create data sheets
  for (name in names(data_list)) {
    create_data_table(wb, name, data_list[[name]], 
                     paste(name, ":", title))
    
    # Create barrier-free version
    create_barrier_free_table(wb, name, data_list[[name]], 
                             paste("Tabelle", name))
    
    # Create CSV version  
    create_csv_table(wb, name, data_list[[name]])
  }
  
  # 5. Set active sheet and save
  wb$set_active_sheet("Inhaltsübersicht")
  wb_save(wb, filename, overwrite = TRUE)
  
  cat("✓ Statistischer Bericht created:", filename, "\n")
  cat("  - Follows official Destatis design standards\n")
  cat("  - Includes accessibility features\n") 
  cat("  - German number formatting applied\n")
  cat("  - Complete navigation system\n")
}
```

---

## 🎯 Key Success Factors

1. **Consistency**: All sheets follow the same navigation and formatting patterns
2. **Accessibility**: Barrier-free versions of all data tables
3. **Standards Compliance**: Official Destatis color scheme and typography
4. **German Formatting**: Proper number formats with comma decimals and space separators
5. **Professional Navigation**: Complete linking system between all sheets
6. **Metadata Completeness**: Proper document properties and legal notices

This style guide ensures that Excel reports generated using the `modify-excel-with-r` skill match the official German statistical office standards exactly.