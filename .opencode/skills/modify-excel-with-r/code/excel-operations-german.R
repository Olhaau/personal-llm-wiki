# ============================================================================
# Excel Operations with German Formatting
# ============================================================================
# Enhanced version with Arial font, German number formatting

library(openxlsx2)

#' Create Formatted Excel with German Standards
#' 
#' Creates Excel file with German formatting: Arial font size 10, 
#' comma as decimal separator, space as thousands separator
#' 
#' @param data_list Named list of data frames
#' @param filename Output file path
#' @param main_title Main title (default: "Inhaltsübersicht")
#' @return wb object
#' @export
create_german_excel <- function(data_list, filename, main_title = "Inhaltsübersicht") {
  wb <- wb_workbook()
  
  # Set Arial font, size 10 as base
  wb$set_base_font(font_name = "Arial", font_size = 10)
  
  # Create index sheet
  wb$add_worksheet("Inhaltsübersicht")
  
  # Add title
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")
  
  # Add table headers
  wb$add_data(x = "Blatt", dims = "A3")
  wb$add_data(x = "Beschreibung", dims = "B3")
  
  # Add navigation links
  row <- 4
  for (sheet_name in names(data_list)) {
    wb$add_data(x = sheet_name, dims = paste0("A", row))
    wb$add_hyperlink(dims = paste0("A", row), target = paste0("#", sheet_name, "!A1"))
    
    n_rows <- nrow(data_list[[sheet_name]])
    n_cols <- ncol(data_list[[sheet_name]])
    description <- paste0("Tabelle mit ", n_rows, " Zeilen und ", n_cols, " Spalten")
    wb$add_data(x = description, dims = paste0("B", row))
    row <- row + 1
  }
  
  # Set column widths for index
  wb$set_col_widths(cols = 1, widths = 20)
  wb$set_col_widths(cols = 2, widths = 40)
  
  # Create data sheets
  for (sheet_name in names(data_list)) {
    wb$add_worksheet(sheet_name)
    data <- data_list[[sheet_name]]
    
    # Add title
    title <- paste("Daten:", sheet_name)
    wb$add_data(x = title, dims = "A1")
    
    # Add back link
    wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")
    wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
    
    # Add data starting from A4
    wb$add_data(x = data, dims = "A4")
    
    # Apply German number formatting to numeric columns
    for (col in 1:ncol(data)) {
      if (is.numeric(data[[col]])) {
        range_start <- paste0(int2col(col), "5")  # Data starts at row 4, so values start at row 5
        range_end <- paste0(int2col(col), nrow(data) + 4)
        range <- paste0(range_start, ":", range_end)
        
        # Determine decimal places based on data
        max_val <- max(abs(data[[col]]), na.rm = TRUE)
        has_decimals <- any(data[[col]] != floor(data[[col]]), na.rm = TRUE)
        
        if (has_decimals && max_val < 1000) {
          # Small decimal numbers - use 2 decimal places
          wb$add_numfmt(dims = range, numfmt = "# ##0,00")
        } else if (has_decimals) {
          # Large decimal numbers - use 2 decimal places with space separator
          wb$add_numfmt(dims = range, numfmt = "# ##0,00")
        } else {
          # Integer-like values - no decimals
          wb$add_numfmt(dims = range, numfmt = "# ##0")
        }
      }
    }
    
    # Auto-size columns
    wb$set_col_widths(cols = 1:ncol(data), widths = "auto")
  }
  
  # Set active sheet to index
  wb$set_active_sheet("Inhaltsübersicht")
  
  # Save
  wb_save(wb, filename, overwrite = TRUE)
  cat("✓ Created German-formatted Excel file:", filename, "\n")
  
  return(wb)
}

#' Apply German Number Formatting to Range
#' 
#' @param wb Workbook object
#' @param range Cell range (e.g., "A5:A100")
#' @param decimal_places Number of decimal places (default: 2)
#' @return wb object
#' @export
apply_german_format <- function(wb, range, decimal_places = 2) {
  if (decimal_places > 0) {
    format_string <- paste0("# ##0,", paste(rep("0", decimal_places), collapse = ""))
  } else {
    format_string <- "# ##0"
  }
  
  wb$add_numfmt(dims = range, numfmt = format_string)
  return(wb)
}

#' Quick German Export
#' 
#' @param data Data frame
#' @param filename Output file
#' @export
quick_german_export <- function(data, filename) {
  wb <- wb_workbook()
  wb$set_base_font(font_name = "Arial", font_size = 10)
  
  wb$add_worksheet("Data")
  wb$add_data(x = data, dims = "A1")
  
  # Apply German formatting to numeric columns
  for (col in 1:ncol(data)) {
    if (is.numeric(data[[col]])) {
      range_start <- paste0(int2col(col), "2")  # Data starts at row 1, so values start at row 2
      range_end <- paste0(int2col(col), nrow(data) + 1)
      range <- paste0(range_start, ":", range_end)
      
      # Auto-detect decimal places needed
      has_decimals <- any(data[[col]] != floor(data[[col]]), na.rm = TRUE)
      decimal_places <- if (has_decimals) 2 else 0
      
      apply_german_format(wb, range, decimal_places)
    }
  }
  
  wb$set_col_widths(cols = 1:ncol(data), widths = "auto")
  wb_save(wb, filename, overwrite = TRUE)
  cat("✓ Quick German export:", filename, "\n")
}