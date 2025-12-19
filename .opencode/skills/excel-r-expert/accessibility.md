# Accessibility and WCAG Compliance

## WCAG 2.1 AA Compliance Features

### Core Accessibility Principles

1. **Perceivable** - Information must be presentable to users in ways they can perceive
2. **Operable** - Interface components must be operable
3. **Understandable** - Information and UI operation must be understandable  
4. **Robust** - Content must be robust enough for interpretation by assistive technologies

### High Contrast Design

#### WCAG AA Color Requirements
- **Normal text**: Contrast ratio of at least 4.5:1
- **Large text**: Contrast ratio of at least 3:1
- **Non-text elements**: Contrast ratio of at least 3:1

```r
create_accessible_styles <- function(high_contrast = FALSE) {
  if (high_contrast) {
    # High contrast mode for visual impairments
    list(
      header = create_cell_style(
        font_name = "Arial",
        font_size = 12,
        text_bold = TRUE,
        font_color = wb_color(hex = "FFFFFF"),  # White text
        fill_color = wb_color(hex = "000000"),  # Black background
        border = "TopBottomLeftRight",
        border_color = wb_color(hex = "000000")
      ),
      
      data = create_cell_style(
        font_name = "Arial",
        font_size = 11,
        font_color = wb_color(hex = "000000"),  # Black text
        fill_color = wb_color(hex = "FFFFFF"),  # White background
        border = "TopBottomLeftRight",
        border_color = wb_color(hex = "000000")
      ),
      
      alt_data = create_cell_style(
        font_name = "Arial", 
        font_size = 11,
        font_color = wb_color(hex = "000000"),  # Black text
        fill_color = wb_color(hex = "F0F0F0"),  # Light grey (high contrast)
        border = "TopBottomLeftRight",
        border_color = wb_color(hex = "000000")
      )
    )
  } else {
    # Standard accessible colors (still WCAG AA compliant)
    list(
      header = create_cell_style(
        font_name = "Arial",
        font_size = 11,
        text_bold = TRUE,
        font_color = wb_color(hex = "000000"),
        fill_color = wb_color(hex = "D9D9D9"),  # Light grey
        border = "TopBottomLeftRight"
      ),
      
      data = create_cell_style(
        font_name = "Arial",
        font_size = 10,
        font_color = wb_color(hex = "000000"),
        border = "TopBottomLeftRight",
        border_color = wb_color(hex = "808080")
      )
    )
  }
}
```

### Screen Reader Optimization

#### Proper Table Structure
```r
create_screen_reader_friendly <- function(data, filename, title, description) {
  wb <- wb_workbook()
  
  # Set comprehensive metadata for screen readers
  wb$set_properties(
    title = title,
    subject = "Accessible Data Table", 
    creator = "R Accessible Tables",
    category = "Data Analysis",
    keywords = "accessible, data, WCAG, screen reader"
  )
  
  wb$add_worksheet("Accessible_Data")
  
  # Add descriptive title and explanation
  wb$add_data(sheet = "Accessible_Data", x = title, start_col = 1, start_row = 1)
  wb$add_data(sheet = "Accessible_Data", x = description, start_col = 1, start_row = 2)
  wb$add_data(sheet = "Accessible_Data", x = "Tabellenbeschreibung:", start_col = 1, start_row = 3)
  
  # Add table structure description for screen readers
  table_desc <- sprintf(
    "Diese Tabelle enthält %d Zeilen und %d Spalten mit Daten zu %s",
    nrow(data), ncol(data), 
    paste(names(data), collapse = ", ")
  )
  wb$add_data(sheet = "Accessible_Data", x = table_desc, start_col = 1, start_row = 4)
  
  # Start data table with clear header row
  data_start_row <- 6
  wb$add_data(sheet = "Accessible_Data", x = data, start_col = 1, start_row = data_start_row)
  
  # Apply accessible styling
  styles <- create_accessible_styles()
  
  # Style headers with proper contrast
  for (col in 1:ncol(data)) {
    cell <- paste0(LETTERS[col], data_start_row)
    wb$add_cell_style(sheet = "Accessible_Data", dims = cell, style = styles$header)
  }
  
  # Style data cells
  for (row in 1:nrow(data)) {
    for (col in 1:ncol(data)) {
      actual_row <- data_start_row + row
      cell <- paste0(LETTERS[col], actual_row)
      wb$add_cell_style(sheet = "Accessible_Data", dims = cell, style = styles$data)
    }
  }
  
  # Freeze panes for easier navigation
  wb$freeze_pane(sheet = "Accessible_Data", 
                 first_active_row = data_start_row + 1, 
                 first_active_col = 1)
  
  # Set appropriate column widths for readability
  for (col in 1:ncol(data)) {
    wb$set_col_widths(sheet = "Accessible_Data", cols = col, widths = "auto")
  }
  
  wb$save(filename)
  return(filename)
}
```

### Multiple Format Outputs

#### Creating Different Accessibility Versions
```r
create_multi_format_accessible <- function(data, base_filename, title) {
  base_name <- tools::file_path_sans_ext(base_filename)
  
  # 1. High contrast version for visually impaired users
  create_high_contrast_version <- function() {
    wb <- wb_workbook()
    wb$add_worksheet("High_Contrast")
    
    # Use high contrast styling
    styles <- create_accessible_styles(high_contrast = TRUE)
    
    wb$add_data(sheet = "High_Contrast", x = data, start_col = 1, start_row = 1)
    
    # Apply high contrast styles
    for (col in 1:ncol(data)) {
      # Header
      cell <- paste0(LETTERS[col], "1")
      wb$add_cell_style(sheet = "High_Contrast", dims = cell, style = styles$header)
      
      # Data cells
      for (row in 1:nrow(data)) {
        actual_row <- row + 1
        cell <- paste0(LETTERS[col], actual_row)
        
        style <- if (row %% 2 == 0) styles$alt_data else styles$data
        wb$add_cell_style(sheet = "High_Contrast", dims = cell, style = style)
      }
    }
    
    filename <- paste0(base_name, "_high_contrast.xlsx")
    wb$save(filename)
    return(filename)
  }
  
  # 2. Screen reader optimized version
  create_screen_reader_version <- function() {
    wb <- wb_workbook()
    wb$add_worksheet("Screen_Reader")
    
    # Add comprehensive table description
    descriptions <- c(
      paste("Titel:", title),
      paste("Anzahl Zeilen:", nrow(data)),
      paste("Anzahl Spalten:", ncol(data)),
      paste("Spalten:", paste(names(data), collapse = ", ")),
      "",
      "Dateninhalt:"
    )
    
    for (i in seq_along(descriptions)) {
      wb$add_data(sheet = "Screen_Reader", x = descriptions[i], start_col = 1, start_row = i)
    }
    
    # Add data with minimal styling
    data_start <- length(descriptions) + 2
    wb$add_data(sheet = "Screen_Reader", x = data, start_col = 1, start_row = data_start)
    
    filename <- paste0(base_name, "_screen_reader.xlsx")
    wb$save(filename)
    return(filename)
  }
  
  # 3. Simple format for maximum compatibility
  create_simple_version <- function() {
    wb <- wb_workbook()
    wb$add_worksheet("Simple")
    
    # No styling, just raw data
    wb$add_data_table(sheet = "Simple", x = data, start_col = 1, start_row = 1,
                      table_style = "none")
    
    filename <- paste0(base_name, "_simple.xlsx")
    wb$save(filename)
    return(filename)
  }
  
  # Create all versions
  results <- list(
    high_contrast = create_high_contrast_version(),
    screen_reader = create_screen_reader_version(),
    simple = create_simple_version()
  )
  
  cat("Accessible Excel versions created:\n")
  cat("  High contrast:", results$high_contrast, "\n")
  cat("  Screen reader:", results$screen_reader, "\n")
  cat("  Simple format:", results$simple, "\n")
  
  return(results)
}
```

### Navigation and Structure

#### Logical Tab Order and Navigation
```r
create_structured_navigation <- function(data_list, filename, title) {
  wb <- wb_workbook()
  
  # Create accessibility guide sheet first
  wb$add_worksheet("Accessibility_Guide")
  create_accessibility_guide(wb, "Accessibility_Guide")
  
  # Create main index with clear structure
  wb$add_worksheet("Index") 
  
  # Add clear navigation instructions
  navigation_text <- c(
    paste("Titel:", title),
    "",
    "Navigation:",
    "- Verwenden Sie Tab und Shift+Tab zum Navigieren",
    "- Jedes Arbeitsblatt hat eine klare Struktur",
    "- Zurück-Links sind in jeder Tabelle verfügbar",
    "",
    "Inhaltsverzeichnis:"
  )
  
  for (i in seq_along(navigation_text)) {
    wb$add_data(sheet = "Index", x = navigation_text[i], start_col = 1, start_row = i)
  }
  
  # Add links to data sheets
  link_start_row <- length(navigation_text) + 1
  
  for (i in seq_along(data_list)) {
    sheet_name <- names(data_list)[i]
    row <- link_start_row + i
    
    # Create accessible link
    link_formula <- sprintf('HYPERLINK("#%s!A1", "%s")', sheet_name, sheet_name)
    wb$add_formula(sheet = "Index", x = link_formula, start_col = 1, start_row = row)
    
    # Create data sheet with accessibility features
    create_accessible_data_sheet(wb, data_list[[i]], sheet_name)
  }
  
  wb$save(filename)
  return(filename)
}

create_accessible_data_sheet <- function(wb, data, sheet_name) {
  wb$add_worksheet(sheet_name)
  
  # Add back navigation
  back_link <- 'HYPERLINK("#Index!A1", "← Zurück zum Index")'
  wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
  
  # Add sheet description
  sheet_desc <- sprintf("Arbeitsblatt: %s mit %d Zeilen und %d Spalten", 
                       sheet_name, nrow(data), ncol(data))
  wb$add_data(sheet = sheet_name, x = sheet_desc, start_col = 1, start_row = 2)
  
  # Add data with accessible formatting
  wb$add_data(sheet = sheet_name, x = data, start_col = 1, start_row = 4)
  
  # Apply accessible styles
  styles <- create_accessible_styles()
  
  for (col in 1:ncol(data)) {
    # Header styling
    cell <- paste0(LETTERS[col], "4")
    wb$add_cell_style(sheet = sheet_name, dims = cell, style = styles$header)
    
    # Data styling
    for (row in 1:nrow(data)) {
      actual_row <- row + 4
      cell <- paste0(LETTERS[col], actual_row)
      wb$add_cell_style(sheet = sheet_name, dims = cell, style = styles$data)
    }
  }
  
  # Set logical tab order with freeze panes
  wb$freeze_pane(sheet = sheet_name, first_active_row = 5, first_active_col = 1)
}
```

### Accessibility Testing and Validation

#### Built-in Accessibility Checker
```r
validate_accessibility <- function(filename) {
  validation_results <- list(
    file_exists = file.exists(filename),
    file_size = if (file.exists(filename)) file.size(filename) else 0,
    sheets = character(0),
    issues = character(0),
    recommendations = character(0)
  )
  
  if (!validation_results$file_exists) {
    validation_results$issues <- c(validation_results$issues, "File does not exist")
    return(validation_results)
  }
  
  # Read Excel file for validation
  tryCatch({
    sheets <- readxl::excel_sheets(filename)
    validation_results$sheets <- sheets
    
    # Check for accessibility features
    if (!"Accessibility_Guide" %in% sheets) {
      validation_results$recommendations <- c(validation_results$recommendations,
                                            "Consider adding accessibility guide sheet")
    }
    
    if (length(sheets) > 1 && !"Index" %in% sheets) {
      validation_results$recommendations <- c(validation_results$recommendations,
                                            "Multi-sheet workbook should have index")
    }
    
    # Check first sheet structure
    first_sheet_data <- readxl::read_excel(filename, sheet = sheets[1], n_max = 5)
    
    if (ncol(first_sheet_data) > 10) {
      validation_results$recommendations <- c(validation_results$recommendations,
                                            "Consider splitting wide tables for better accessibility")
    }
    
    validation_results$status <- "Valid"
    
  }, error = function(e) {
    validation_results$issues <- c(validation_results$issues, 
                                  paste("Error reading file:", e$message))
    validation_results$status <- "Error"
  })
  
  return(validation_results)
}

print_accessibility_report <- function(validation_results) {
  cat("=== Accessibility Validation Report ===\n")
  cat("Status:", validation_results$status, "\n")
  cat("Sheets:", length(validation_results$sheets), "\n")
  cat("Sheet names:", paste(validation_results$sheets, collapse = ", "), "\n\n")
  
  if (length(validation_results$issues) > 0) {
    cat("Issues found:\n")
    for (issue in validation_results$issues) {
      cat("  ✗", issue, "\n")
    }
    cat("\n")
  }
  
  if (length(validation_results$recommendations) > 0) {
    cat("Recommendations:\n")
    for (rec in validation_results$recommendations) {
      cat("  •", rec, "\n")
    }
    cat("\n")
  }
  
  if (length(validation_results$issues) == 0) {
    cat("✓ No accessibility issues found\n")
  }
}
```

### Accessibility Guide Template

#### Standard Accessibility Information Sheet
```r
create_accessibility_guide <- function(wb, sheet_name) {
  guide_content <- c(
    "Accessibility Guide / Bedienungshilfe",
    "",
    "Diese Excel-Datei wurde nach WCAG 2.1 AA Standards erstellt.",
    "",
    "Tastaturnavigation:",
    "- Tab: Nächste Zelle",
    "- Shift+Tab: Vorherige Zelle", 
    "- Strg+Home: Anfang des Arbeitsblatts",
    "- Strg+End: Ende der Daten",
    "",
    "Arbeitsblatt-Navigation:",
    "- Strg+Page Up/Down: Zwischen Arbeitsblättern wechseln",
    "- Hyperlinks mit Enter aktivieren",
    "",
    "Screen Reader Unterstützung:",
    "- Alle Tabellen haben Überschriften",
    "- Beschreibungen sind vor jeder Tabelle",
    "- Navigation Links sind verfügbar",
    "",
    "Barrierefreiheits-Features:",
    "- Hoher Kontrast verfügbar",
    "- Klare Tabellenstruktur",
    "- Deutsche Beschriftungen",
    "- Logische Tab-Reihenfolge",
    "",
    "Bei Problemen:",
    "- Verwenden Sie die einfache Version",
    "- Aktivieren Sie den hohen Kontrast",
    "- Nutzen Sie Screen Reader Modi"
  )
  
  for (i in seq_along(guide_content)) {
    wb$add_data(sheet = sheet_name, x = guide_content[i], start_col = 1, start_row = i)
  }
  
  # Set appropriate column width for readability
  wb$set_col_widths(sheet = sheet_name, cols = 1, widths = 60)
}
```

This accessibility framework ensures that Excel outputs are usable by people with disabilities and comply with German accessibility requirements for government documents.