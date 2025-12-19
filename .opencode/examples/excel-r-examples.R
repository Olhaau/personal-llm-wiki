# Excel-R Expert: Comprehensive Code Examples
# ============================================
#
# This file demonstrates comprehensive Excel manipulation using R
# covering all major Excel features with practical examples.

# ---- Package Dependencies ----
suppressPackageStartupMessages({
  library(openxlsx2)
  library(openxlsx)  # For legacy compatibility
  library(readxl)    # For reading Excel files
  library(gt)        # For table formatting
  library(dplyr)     # For data manipulation
  library(yaml)      # For configuration management
})

# ---- 1. Basic Excel Creation ----

#' Create a Simple Excel File with Basic Formatting
create_basic_excel <- function(data, filename = "basic_example.xlsx") {
  wb <- wb_workbook()
  wb$add_worksheet("Data")
  
  # Add data with table formatting
  wb$add_data_table(
    sheet = "Data",
    x = data,
    start_col = 1,
    start_row = 1,
    table_style = "TableStyleMedium2"
  )
  
  # Auto-size columns
  wb$set_col_widths(
    sheet = "Data",
    cols = 1:ncol(data),
    widths = "auto"
  )
  
  wb$save(filename)
  return(filename)
}

# Example usage:
# create_basic_excel(mtcars, "output/basic_cars.xlsx")

# ---- 2. Advanced Styling with Corporate Design ----

#' Create Excel with Corporate Styling
create_corporate_excel <- function(data, filename = "corporate_example.xlsx",
                                 title = "Corporate Report",
                                 color_scheme = "destatis") {
  
  # Define color schemes
  colors <- list(
    destatis = list(
      primary = "004B76",
      secondary = "0080C8", 
      background = "E6F2F8",
      header = "D9D9D9",
      alt_row = "F8F8F8"
    ),
    bmf = list(
      primary = "1f3a93",
      secondary = "2e5bba",
      background = "f0f3ff",
      header = "e6ebff",
      alt_row = "f8faff"
    )
  )
  
  scheme <- colors[[color_scheme]]
  wb <- wb_workbook()
  wb$add_worksheet("Report")
  
  # Create styles
  title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 16,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = scheme$primary),
    horizontal = "center",
    vertical = "center"
  )
  
  header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 11,
    text_bold = TRUE,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = scheme$header),
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = "808080")
  )
  
  data_style <- create_cell_style(
    font_name = "Arial", 
    font_size = 10,
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = "D9D9D9"),
    num_fmt = "# ### ##0,00"  # German number format
  )
  
  # Add title
  wb$add_data(sheet = "Report", x = title, start_col = 1, start_row = 1)
  wb$merge_cells(sheet = "Report", dims = paste0("A1:", LETTERS[ncol(data)], "1"))
  wb$add_cell_style(sheet = "Report", dims = paste0("A1:", LETTERS[ncol(data)], "1"), style = title_style)
  
  # Add data starting from row 3
  wb$add_data(sheet = "Report", x = data, start_col = 1, start_row = 3)
  
  # Style headers
  for (col in 1:ncol(data)) {
    cell <- paste0(LETTERS[col], "3")
    wb$add_cell_style(sheet = "Report", dims = cell, style = header_style)
  }
  
  # Style data with alternating rows
  for (row in 1:nrow(data)) {
    for (col in 1:ncol(data)) {
      actual_row <- row + 3
      cell <- paste0(LETTERS[col], actual_row)
      
      # Use different background for even rows
      if (row %% 2 == 0) {
        alt_style <- create_cell_style(
          font_name = "Arial",
          font_size = 10,
          fill_color = wb_color(hex = scheme$alt_row),
          border = "TopBottomLeftRight",
          border_color = wb_color(hex = "D9D9D9"),
          num_fmt = "# ### ##0,00"
        )
        wb$add_cell_style(sheet = "Report", dims = cell, style = alt_style)
      } else {
        wb$add_cell_style(sheet = "Report", dims = cell, style = data_style)
      }
    }
  }
  
  # Freeze panes (title + header)
  wb$freeze_pane(sheet = "Report", first_active_row = 4, first_active_col = 2)
  
  # Auto-size columns
  for (col in 1:ncol(data)) {
    wb$set_col_widths(sheet = "Report", cols = col, widths = "auto")
  }
  
  wb$save(filename)
  return(filename)
}

# ---- 3. Multi-Sheet Workbook with Navigation ----

#' Create Multi-Sheet Workbook with Index
create_multi_sheet_workbook <- function(data_list, filename = "multi_sheet_example.xlsx",
                                       main_title = "Multi-Sheet Report") {
  wb <- wb_workbook()
  
  # Create index sheet first
  wb$add_worksheet("Index")
  
  # Style for index
  index_title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 18,
    text_bold = TRUE,
    font_color = wb_color(hex = "004B76")
  )
  
  link_style <- create_cell_style(
    font_name = "Arial",
    font_size = 12,
    font_color = wb_color(hex = "0563C1"),
    text_decoration = "underline"
  )
  
  # Add index title
  wb$add_data(sheet = "Index", x = main_title, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = "Index", dims = "A1", style = index_title_style)
  
  # Add each data sheet
  sheet_names <- names(data_list)
  for (i in seq_along(data_list)) {
    sheet_name <- sheet_names[i]
    data <- data_list[[i]]
    
    # Create data sheet
    wb$add_worksheet(sheet_name)
    
    # Add "Back to Index" link
    back_link <- sprintf('HYPERLINK("#Index!A1", "← Back to Index")')
    wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
    wb$add_cell_style(sheet = sheet_name, dims = "A1", style = link_style)
    
    # Add data starting from row 3
    wb$add_data_table(
      sheet = sheet_name,
      x = data,
      start_col = 1,
      start_row = 3,
      table_style = "TableStyleMedium2"
    )
    
    # Auto-size columns
    wb$set_col_widths(sheet = sheet_name, cols = 1:ncol(data), widths = "auto")
    
    # Add link in index
    row_in_index <- i + 2
    link_formula <- sprintf('HYPERLINK("#%s!A1", "%s")', sheet_name, sheet_name)
    wb$add_formula(sheet = "Index", x = link_formula, start_col = 1, start_row = row_in_index)
    wb$add_cell_style(sheet = "Index", dims = paste0("A", row_in_index), style = link_style)
  }
  
  # Adjust index column width
  wb$set_col_widths(sheet = "Index", cols = 1, widths = 30)
  
  wb$save(filename)
  return(filename)
}

# Example usage:
# data_list <- list("Cars" = mtcars, "Flowers" = iris, "Pressure" = pressure)
# create_multi_sheet_workbook(data_list, "output/multi_example.xlsx")

# ---- 4. Accessibility-Compliant Excel ----

#' Create WCAG-Compliant Excel File
create_accessible_excel <- function(data, filename = "accessible_example.xlsx",
                                  title = "Accessible Data Table",
                                  description = "Screen reader optimized data table") {
  wb <- wb_workbook()
  
  # Set document properties for accessibility
  wb$set_properties(
    title = title,
    subject = "Accessible Data Export",
    description = description,
    category = "Data Analysis"
  )
  
  # Main accessible sheet
  wb$add_worksheet("Accessible_Data")
  
  # High contrast styles
  accessible_header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 12,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = "000000"),  # High contrast: white on black
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = "000000")
  )
  
  accessible_data_style <- create_cell_style(
    font_name = "Arial",
    font_size = 11,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "FFFFFF"),
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = "000000")
  )
  
  # Add descriptive title
  wb$add_data(sheet = "Accessible_Data", x = title, start_col = 1, start_row = 1)
  wb$add_data(sheet = "Accessible_Data", x = description, start_col = 1, start_row = 2)
  
  # Add data starting from row 4
  wb$add_data(sheet = "Accessible_Data", x = data, start_col = 1, start_row = 4)
  
  # Style headers for accessibility
  for (col in 1:ncol(data)) {
    cell <- paste0(LETTERS[col], "4")
    wb$add_cell_style(sheet = "Accessible_Data", dims = cell, style = accessible_header_style)
  }
  
  # Style data cells
  for (row in 1:nrow(data)) {
    for (col in 1:ncol(data)) {
      actual_row <- row + 4
      cell <- paste0(LETTERS[col], actual_row)
      wb$add_cell_style(sheet = "Accessible_Data", dims = cell, style = accessible_data_style)
    }
  }
  
  # Freeze header row
  wb$freeze_pane(sheet = "Accessible_Data", first_active_row = 5, first_active_col = 1)
  
  # Auto-size for readability
  wb$set_col_widths(sheet = "Accessible_Data", cols = 1:ncol(data), widths = "auto")
  
  # Create simplified version sheet
  wb$add_worksheet("Simple_Data")
  wb$add_data_table(
    sheet = "Simple_Data", 
    x = data,
    start_col = 1,
    start_row = 1,
    table_style = "none"  # No styling for maximum compatibility
  )
  
  # Create metadata sheet
  wb$add_worksheet("Column_Info")
  
  # Generate column metadata
  col_info <- data.frame(
    Column_Name = names(data),
    Data_Type = sapply(data, class),
    Description = paste("Data for", names(data)),
    stringsAsFactors = FALSE
  )
  
  wb$add_data(sheet = "Column_Info", x = col_info, start_col = 1, start_row = 1)
  
  wb$save(filename)
  return(filename)
}

# ---- 5. Advanced Excel Features ----

#' Create Excel with Advanced Features
create_advanced_excel <- function(data, filename = "advanced_example.xlsx") {
  wb <- wb_workbook()
  wb$add_worksheet("Advanced_Features")
  
  # Add data
  wb$add_data(sheet = "Advanced_Features", x = data, start_col = 1, start_row = 2)
  
  # Create dropdown list for first column (if categorical)
  if (is.factor(data[[1]]) || is.character(data[[1]])) {
    unique_vals <- unique(data[[1]])
    wb$add_data_validation(
      sheet = "Advanced_Features",
      dims = paste0("A3:A", nrow(data) + 2),
      type = "list",
      value = paste(unique_vals, collapse = ",")
    )
  }
  
  # Add conditional formatting for numeric columns
  numeric_cols <- which(sapply(data, is.numeric))
  
  for (col in numeric_cols) {
    if (col <= 26) {  # Basic column letters only
      col_letter <- LETTERS[col]
      range <- paste0(col_letter, "3:", col_letter, nrow(data) + 2)
      
      # Color scale: red for low, yellow for medium, green for high
      wb$add_conditional_formatting(
        sheet = "Advanced_Features",
        dims = range,
        type = "colorScale",
        rule = list(
          colors = c("FF0000", "FFFF00", "00FF00"),
          values = c(min(data[[col]], na.rm = TRUE), 
                    median(data[[col]], na.rm = TRUE),
                    max(data[[col]], na.rm = TRUE))
        )
      )
    }
  }
  
  # Add formulas for summary statistics
  summary_start_row <- nrow(data) + 5
  wb$add_data(sheet = "Advanced_Features", x = "Summary Statistics", 
              start_col = 1, start_row = summary_start_row)
  
  for (col in numeric_cols) {
    if (col <= 26) {
      col_letter <- LETTERS[col]
      col_name <- names(data)[col]
      
      # Add labels and formulas
      wb$add_data(sheet = "Advanced_Features", x = paste("Average", col_name), 
                  start_col = 1, start_row = summary_start_row + col)
      
      avg_formula <- paste0("AVERAGE(", col_letter, "3:", col_letter, nrow(data) + 2, ")")
      wb$add_formula(sheet = "Advanced_Features", x = avg_formula, 
                     start_col = 2, start_row = summary_start_row + col)
    }
  }
  
  # Create chart (basic approach)
  if (length(numeric_cols) >= 2) {
    chart_data <- data[numeric_cols[1:2]]
    # Note: openxlsx2 has limited charting - consider external tools
  }
  
  wb$save(filename)
  return(filename)
}

# ---- 6. Reading and Analyzing Excel Files ----

#' Comprehensive Excel File Analysis
analyze_excel_file <- function(filepath) {
  cat("Analyzing Excel file:", filepath, "\n\n")
  
  # Get basic file info
  if (!file.exists(filepath)) {
    stop("File not found: ", filepath)
  }
  
  # Get sheet names
  sheets <- excel_sheets(filepath)
  cat("Sheets found:", length(sheets), "\n")
  cat("Sheet names:", paste(sheets, collapse = ", "), "\n\n")
  
  analysis_results <- list()
  
  # Analyze each sheet
  for (sheet in sheets) {
    cat("Analyzing sheet:", sheet, "\n")
    
    # Try to read the sheet
    tryCatch({
      data <- read_excel(filepath, sheet = sheet)
      
      analysis_results[[sheet]] <- list(
        dimensions = dim(data),
        column_names = names(data),
        column_types = sapply(data, class),
        missing_values = sapply(data, function(x) sum(is.na(x))),
        sample_data = head(data, 3)
      )
      
      cat("  Dimensions:", paste(dim(data), collapse = " x "), "\n")
      cat("  Columns:", paste(names(data), collapse = ", "), "\n")
      
    }, error = function(e) {
      cat("  Error reading sheet:", e$message, "\n")
      analysis_results[[sheet]] <- list(error = e$message)
    })
    
    cat("\n")
  }
  
  return(analysis_results)
}

# ---- 7. Configuration-Driven Excel Creation ----

#' Create Excel from YAML Configuration
create_excel_from_config <- function(data, config_file, filename) {
  if (!file.exists(config_file)) {
    stop("Configuration file not found: ", config_file)
  }
  
  config <- yaml::read_yaml(config_file)
  
  wb <- wb_workbook()
  wb$add_worksheet(config$sheet_name %||% "Data")
  
  # Apply configuration-based styling
  # (This would use the loaded config to create styles)
  # Implementation depends on config structure
  
  wb$save(filename)
  return(filename)
}

# ---- 8. Batch Excel Processing ----

#' Process Multiple Data Sources to Single Excel
batch_excel_export <- function(data_sources, output_dir = "output") {
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  results <- list()
  
  for (name in names(data_sources)) {
    data <- data_sources[[name]]
    filename <- file.path(output_dir, paste0(name, "_export.xlsx"))
    
    tryCatch({
      create_corporate_excel(data, filename, title = paste("Report:", name))
      results[[name]] <- list(success = TRUE, file = filename)
      cat("✓ Created:", filename, "\n")
    }, error = function(e) {
      results[[name]] <- list(success = FALSE, error = e$message)
      cat("✗ Failed:", name, "-", e$message, "\n")
    })
  }
  
  return(results)
}

# ---- Usage Examples ----

# Example 1: Basic usage
# create_basic_excel(iris, "output/iris_basic.xlsx")

# Example 2: Corporate styling
# create_corporate_excel(mtcars, "output/mtcars_corporate.xlsx", 
#                       "Motor Trend Car Analysis", "destatis")

# Example 3: Multi-sheet workbook
# datasets <- list(
#   "Cars" = mtcars,
#   "Flowers" = iris, 
#   "Economics" = economics
# )
# create_multi_sheet_workbook(datasets, "output/complete_analysis.xlsx")

# Example 4: Accessible version
# create_accessible_excel(pressure, "output/pressure_accessible.xlsx",
#                        "Vapor Pressure Data", "Temperature vs Pressure measurements")

# Example 5: File analysis
# results <- analyze_excel_file("input/sample_data.xlsx")

# Example 6: Batch processing
# data_list <- list("cars" = mtcars, "flowers" = iris)
# batch_results <- batch_excel_export(data_list, "output/batch")

cat("Excel-R Expert examples loaded successfully!\n")
cat("All functions are ready for use.\n")