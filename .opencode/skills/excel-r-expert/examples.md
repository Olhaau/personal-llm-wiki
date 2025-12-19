# Excel-R Expert Examples

## Basic Excel Creation

### Simple Data Export
```r
# Create a basic Excel file with minimal formatting
create_basic_excel <- function(data, filename = "basic_example.xlsx") {
  wb <- wb_workbook()
  wb$add_worksheet("Data")
  
  wb$add_data_table(
    sheet = "Data",
    x = data,
    start_col = 1,
    start_row = 1,
    table_style = "TableStyleMedium2"
  )
  
  # Auto-size columns for readability
  wb$set_col_widths(sheet = "Data", cols = 1:ncol(data), widths = "auto")
  wb$save(filename)
  return(filename)
}

# Example usage
create_basic_excel(mtcars, "output/cars_basic.xlsx")
```

## Corporate Design

### Destatis-Style Report
```r
# Create professional German statistical report
create_destatis_report <- function(data, filename, title) {
  wb <- wb_workbook()
  wb$add_worksheet("Report")
  
  # Destatis blue color scheme
  destatis_blue <- "004B76"
  light_grey <- "D9D9D9"
  
  # Corporate title style
  title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 16,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = destatis_blue),
    horizontal = "center"
  )
  
  # Add and format title
  wb$add_data(sheet = "Report", x = title, start_col = 1, start_row = 1)
  wb$merge_cells(sheet = "Report", dims = paste0("A1:", LETTERS[ncol(data)], "1"))
  wb$add_cell_style(sheet = "Report", dims = paste0("A1:", LETTERS[ncol(data)], "1"), 
                    style = title_style)
  
  # Add data with German formatting
  wb$add_data(sheet = "Report", x = data, start_col = 1, start_row = 3)
  
  # Apply German number format to numeric columns
  for (col in 1:ncol(data)) {
    if (is.numeric(data[[col]])) {
      range <- paste0(LETTERS[col], "4:", LETTERS[col], nrow(data) + 3)
      wb$add_numfmt(sheet = "Report", dims = range, numfmt = "# ### ##0,00")
    }
  }
  
  wb$save(filename)
  return(filename)
}
```

## Multi-Sheet Workbooks

### Complete Report with Navigation
```r
create_multi_sheet_report <- function(data_list, filename, main_title) {
  wb <- wb_workbook()
  
  # Create index sheet first
  wb$add_worksheet("Index")
  
  # Add title and links
  wb$add_data(sheet = "Index", x = main_title, start_col = 1, start_row = 1)
  
  # Create each data sheet
  for (i in seq_along(data_list)) {
    sheet_name <- names(data_list)[i]
    data <- data_list[[i]]
    
    # Create data sheet
    wb$add_worksheet(sheet_name)
    
    # Add back link
    back_link <- sprintf('HYPERLINK("#Index!A1", "← Zurück zum Index")')
    wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
    
    # Add data
    wb$add_data_table(sheet = sheet_name, x = data, start_col = 1, start_row = 3,
                      table_style = "TableStyleMedium2")
    
    # Add forward link in index
    row_in_index <- i + 2
    link_formula <- sprintf('HYPERLINK("#%s!A1", "%s")', sheet_name, sheet_name)
    wb$add_formula(sheet = "Index", x = link_formula, start_col = 1, start_row = row_in_index)
  }
  
  wb$save(filename)
  return(filename)
}

# Example usage
datasets <- list("Cars" = mtcars, "Flowers" = iris)
create_multi_sheet_report(datasets, "output/complete_report.xlsx", "Analysis Report")
```

## Accessibility Features

### WCAG-Compliant Excel
```r
create_accessible_excel <- function(data, filename, title, description) {
  wb <- wb_workbook()
  
  # Set accessibility metadata
  wb$set_properties(
    title = title,
    subject = "Accessible Data Export",
    creator = "R Accessible Tables",
    category = "Data Analysis"
  )
  
  # Main accessible sheet
  wb$add_worksheet("Accessible_Data")
  
  # High contrast styles
  header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 12,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = "000000"),  # High contrast
    border = "TopBottomLeftRight"
  )
  
  # Add descriptive title and description
  wb$add_data(sheet = "Accessible_Data", x = title, start_col = 1, start_row = 1)
  wb$add_data(sheet = "Accessible_Data", x = description, start_col = 1, start_row = 2)
  
  # Add data with accessibility formatting
  wb$add_data(sheet = "Accessible_Data", x = data, start_col = 1, start_row = 4)
  
  # Style headers for screen readers
  for (col in 1:ncol(data)) {
    cell <- paste0(LETTERS[col], "4")
    wb$add_cell_style(sheet = "Accessible_Data", dims = cell, style = header_style)
  }
  
  # Create simplified version sheet
  wb$add_worksheet("Simple_Data")
  wb$add_data_table(sheet = "Simple_Data", x = data, start_col = 1, start_row = 1,
                    table_style = "none")  # No styling for maximum compatibility
  
  wb$save(filename)
  return(filename)
}
```

## Advanced Features

### Conditional Formatting and Validation
```r
create_advanced_excel <- function(data, filename) {
  wb <- wb_workbook()
  wb$add_worksheet("Advanced")
  
  # Add data
  wb$add_data(sheet = "Advanced", x = data, start_col = 1, start_row = 2)
  
  # Add conditional formatting for numeric columns
  numeric_cols <- which(sapply(data, is.numeric))
  
  for (col in numeric_cols[1:min(length(numeric_cols), 26)]) {  # Limit to A-Z
    col_letter <- LETTERS[col]
    range <- paste0(col_letter, "3:", col_letter, nrow(data) + 2)
    
    # Color scale: red (low) to green (high)
    wb$add_conditional_formatting(
      sheet = "Advanced",
      dims = range,
      type = "colorScale",
      rule = list(colors = c("FF0000", "FFFF00", "00FF00"))
    )
  }
  
  # Add data validation for categorical columns
  if (any(sapply(data, function(x) is.factor(x) || is.character(x)))) {
    first_cat_col <- which(sapply(data, function(x) is.factor(x) || is.character(x)))[1]
    unique_vals <- unique(data[[first_cat_col]])
    
    wb$add_data_validation(
      sheet = "Advanced",
      dims = paste0("A3:A", nrow(data) + 2),
      type = "list",
      value = paste(unique_vals, collapse = ",")
    )
  }
  
  wb$save(filename)
  return(filename)
}
```

## Configuration-Driven Styling

### Using YAML Configuration
```r
create_styled_excel <- function(data, config_file, filename) {
  # Load configuration
  config <- yaml::read_yaml(config_file)
  
  wb <- wb_workbook()
  wb$add_worksheet("Styled_Report")
  
  # Apply configuration-based styling
  title_style <- create_cell_style(
    font_name = config$font$family,
    font_size = config$heading$font_size,
    text_bold = config$heading$font_bold,
    font_color = wb_color(hex = config$colors$primary),
    fill_color = wb_color(hex = config$colors$background)
  )
  
  # Add styled content
  wb$add_data(sheet = "Styled_Report", x = config$report$title, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = "Styled_Report", dims = "A1", style = title_style)
  
  # Add data with configured formatting
  wb$add_data(sheet = "Styled_Report", x = data, start_col = 1, start_row = 3)
  
  wb$save(filename)
  return(filename)
}

# Example usage with Destatis configuration
create_styled_excel(mtcars, ".opencode/skills/excel-r-expert/config/destatis-style.yaml", 
                   "output/styled_report.xlsx")
```

## Batch Processing

### Multiple Datasets to Excel
```r
batch_excel_export <- function(data_list, output_dir = "output") {
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
  
  results <- list()
  
  for (name in names(data_list)) {
    data <- data_list[[name]]
    filename <- file.path(output_dir, paste0(name, "_export.xlsx"))
    
    tryCatch({
      create_destatis_report(data, filename, paste("Report:", name))
      results[[name]] <- list(success = TRUE, file = filename)
      cat("✓ Created:", filename, "\n")
    }, error = function(e) {
      results[[name]] <- list(success = FALSE, error = e$message)
      cat("✗ Failed:", name, "-", e$message, "\n")
    })
  }
  
  return(results)
}

# Example usage
datasets <- list("cars" = mtcars, "flowers" = iris, "economics" = economics)
batch_results <- batch_excel_export(datasets, "output/batch")
```

## Integration Examples

### From Data Analysis to Excel Report
```r
# Complete workflow: analysis to professional Excel
analyze_and_export <- function(raw_data, filename) {
  # 1. Data processing
  processed_data <- raw_data %>%
    mutate(across(where(is.numeric), ~ round(.x, 2))) %>%
    arrange(desc(if (ncol(.) > 0) .[[1]] else 1))
  
  # 2. Create summary statistics
  summary_stats <- processed_data %>%
    summarise(across(where(is.numeric), list(mean = mean, median = median, sd = sd), 
                    na.rm = TRUE, .names = "{.col}_{.fn}"))
  
  # 3. Create multi-sheet Excel report
  data_list <- list(
    "Raw_Data" = raw_data,
    "Processed_Data" = processed_data,
    "Summary_Statistics" = summary_stats
  )
  
  create_multi_sheet_report(data_list, filename, "Data Analysis Report")
}

# Usage
analyze_and_export(mtcars, "output/analysis_report.xlsx")
```

These examples demonstrate the progressive complexity of Excel creation using this skill, from basic data export to sophisticated multi-sheet reports with corporate branding and accessibility features.