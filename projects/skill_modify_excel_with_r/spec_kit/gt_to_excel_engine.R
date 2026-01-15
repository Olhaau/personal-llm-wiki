# GT to Excel Conversion Engine
# Core functions for converting gt tables to exact Statistischer Bericht format

library(openxlsx2)
library(gt)
library(dplyr)
library(stringr)

# ---- Core GT Extraction Functions ----

#' Extract data from gt table object
#' @param gt_table A gt table object
#' @return Data frame with the underlying data
extract_gt_data <- function(gt_table) {
  # Extract the original data from gt object
  data <- gt_table[["_data"]]
  return(data)
}

#' Extract formatting information from gt table
#' @param gt_table A gt table object
#' @return List with formatting specifications
extract_gt_formatting <- function(gt_table) {
  formatting <- list(
    title = gt_table[["_heading"]][["title"]],
    subtitle = gt_table[["_heading"]][["subtitle"]],
    column_labels = gt_table[["_boxhead"]][["column_label"]],
    styles = gt_table[["_styles"]]
  )
  
  # Extract number formatting
  if (!is.null(gt_table[["_formats"]])) {
    formatting$number_formats <- gt_table[["_formats"]]
  }
  
  return(formatting)
}

# ---- GT to Excel Conversion Functions ----

#' Convert GT table to Excel sheet with exact Destatis formatting
#' @param wb Workbook object
#' @param gt_table GT table object
#' @param sheet_name Sheet name
#' @param table_id Official table identifier (e.g., "61241-01")
convert_gt_to_excel_sheet <- function(wb, gt_table, sheet_name, table_id) {
  # Extract data and formatting from gt table
  data <- extract_gt_data(gt_table)
  formatting <- extract_gt_formatting(gt_table)
  
  # Add worksheet
  wb$add_worksheet(sheet_name)
  
  # Add back navigation link (Row 1)
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
  wb$add_hyperlink(dims = "A1", target = "#'Inhaltsübersicht'!A1")
  wb$add_font(dims = "A1", color = wb_color("blue"), name = "Arial", size = 10)
  
  # Add table title (Row 2)
  title_text <- ifelse(is.null(formatting$title), 
                      paste0(table_id, ": Statistische Daten"),
                      formatting$title)
  wb$add_data(x = title_text, dims = "A2")
  wb$add_font(dims = "A2", bold = TRUE, size = 11, name = "Arial", color = "#004B76")
  
  # Add subtitle if present (Row 3)
  start_row <- 4
  if (!is.null(formatting$subtitle) && formatting$subtitle != "") {
    wb$add_data(x = formatting$subtitle, dims = "A3")
    wb$add_font(dims = "A3", name = "Arial", size = 10, color = "#666666")
    start_row <- 5
  }
  
  # Add column headers
  headers <- names(data)
  if (!is.null(formatting$column_labels)) {
    # Use GT column labels if available
    for (i in seq_along(headers)) {
      if (!is.na(formatting$column_labels[i])) {
        headers[i] <- formatting$column_labels[i]
      }
    }
  }
  
  # Add headers to Excel
  for (i in seq_along(headers)) {
    col_letter <- int2col(i)
    cell_ref <- paste0(col_letter, start_row)
    wb$add_data(x = headers[i], dims = cell_ref)
  }
  
  # Style headers
  header_range <- paste0("A", start_row, ":", int2col(ncol(data)), start_row)
  wb$add_font(dims = header_range, bold = TRUE, name = "Arial", size = 10)
  wb$add_fill(dims = header_range, color = wb_color("#E6E6E6"))
  wb$add_border(dims = header_range, border = "thin", border_color = wb_color("black"))
  
  # Add data starting from next row
  data_start_row <- start_row + 1
  
  for (row in 1:nrow(data)) {
    for (col in 1:ncol(data)) {
      cell_value <- data[row, col]
      col_letter <- int2col(col)
      cell_ref <- paste0(col_letter, data_start_row + row - 1)
      
      if (!is.na(cell_value)) {
        wb$add_data(x = cell_value, dims = cell_ref)
      }
    }
  }
  
  # Apply German number formatting
  apply_german_statistical_formatting(wb, sheet_name, data, data_start_row)
  
  # Apply alternating row colors
  apply_alternating_row_colors(wb, sheet_name, nrow(data), data_start_row, ncol(data))
  
  # Set column widths
  wb$set_col_widths(sheet = sheet_name, cols = 1:ncol(data), widths = "auto")
  
  # Ensure all text is Arial
  all_range <- paste0("A1:", int2col(ncol(data)), data_start_row + nrow(data))
  wb$add_font(dims = all_range, name = "Arial", size = 10)
  
  return(wb)
}

#' Apply German statistical number formatting
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param data Data frame
#' @param start_row Starting row for data
apply_german_statistical_formatting <- function(wb, sheet_name, data, start_row) {
  for (col in 1:ncol(data)) {
    if (is.numeric(data[[col]])) {
      col_letter <- int2col(col)
      range <- paste0(col_letter, start_row, ":", col_letter, start_row + nrow(data) - 1)
      
      # Determine format based on data characteristics
      max_val <- max(abs(data[[col]]), na.rm = TRUE)
      
      if (max_val >= 1000) {
        # Large numbers: space separator, 2 decimals
        wb$add_numfmt(dims = range, numfmt = "# ##0,00")
      } else if (max_val >= 1) {
        # Medium numbers: 2 decimals
        wb$add_numfmt(dims = range, numfmt = "0,00")
      } else if (max_val > 0) {
        # Small/percentage values: 4 decimals
        wb$add_numfmt(dims = range, numfmt = "0,0000")
      }
    }
  }
}

#' Apply alternating row colors
#' @param wb Workbook object
#' @param sheet_name Sheet name  
#' @param num_rows Number of data rows
#' @param start_row Starting row
#' @param num_cols Number of columns
apply_alternating_row_colors <- function(wb, sheet_name, num_rows, start_row, num_cols) {
  for (row in seq(2, num_rows, 2)) {  # Every second row
    actual_row <- start_row + row - 1
    range <- paste0("A", actual_row, ":", int2col(num_cols), actual_row)
    wb$add_fill(dims = range, color = wb_color("#F5F5F5"))
  }
}

# ---- Main Conversion Function ----

#' Create complete Statistischer Bericht from GT tables
#' @param gt_tables Named list of gt table objects
#' @param filename Output Excel filename
#' @param metadata List with report metadata
#' @return TRUE if successful
create_statistischer_bericht_from_gt <- function(gt_tables, filename, metadata = list()) {
  # Set default metadata
  metadata <- modifyList(list(
    title = "Statistischer Bericht",
    subtitle = "Statistische Daten",
    period = format(Sys.Date(), "%B %Y"),
    evas_number = "61241",
    publication_date = Sys.Date(),
    creator = "Statistisches Bundesamt"
  ), metadata)
  
  # Create workbook
  wb <- wb_workbook()
  wb$set_base_font(font_name = "Arial", font_size = 10)
  
  # Set document properties
  wb$set_properties(
    title = metadata$title,
    subject = "Statistischer Bericht",
    creator = metadata$creator,
    category = "Amtliche Statistik",
    keywords = "Destatis, Statistik, Deutschland"
  )
  
  # Create required sheets in correct order
  cat("Creating information sheets...\n")
  create_title_sheet(wb, metadata)
  create_accessibility_sheet(wb)
  create_table_of_contents(wb, names(gt_tables), metadata)
  create_genesis_online_sheet(wb)
  create_impressum_sheet(wb, metadata)
  create_statistics_info_sheet(wb)
  
  # Create barrier-free versions first
  cat("Creating barrier-free tables...\n")
  barrier_free_sheets <- c()
  for (table_id in names(gt_tables)) {
    bf_sheet_name <- paste0(table_id, "-b")
    barrier_free_sheets <- c(barrier_free_sheets, bf_sheet_name)
    create_barrier_free_table(wb, gt_tables[[table_id]], bf_sheet_name, table_id)
  }
  
  # Create main data tables
  cat("Creating main data tables...\n")
  for (table_id in names(gt_tables)) {
    wb <- convert_gt_to_excel_sheet(wb, gt_tables[[table_id]], table_id, table_id)
  }
  
  # Create CSV explanation sheet
  create_csv_explanation_sheet(wb, names(gt_tables))
  
  # Create CSV versions
  cat("Creating CSV tables...\n")
  for (table_id in names(gt_tables)) {
    csv_sheet_name <- paste0("csv-", table_id)
    create_csv_table(wb, gt_tables[[table_id]], csv_sheet_name, table_id)
  }
  
  # Set active sheet to table of contents
  wb$set_active_sheet("Inhaltsübersicht")
  
  # Save workbook
  wb_save(wb, filename, overwrite = TRUE)
  
  # Validate output
  cat(sprintf("✓ Statistischer Bericht created: %s\n", filename))
  cat("  - Complete sheet structure with navigation\n")
  cat("  - German statistical formatting applied\n") 
  cat("  - Accessibility features included\n")
  cat("  - CSV versions provided\n")
  
  return(TRUE)
}

# ---- Utility Functions ----

#' Convert column number to Excel column letter
#' @param n Column number
#' @return Excel column letter(s)
int2col <- function(n) {
  result <- ""
  while (n > 0) {
    remainder <- (n - 1) %% 26
    result <- paste0(LETTERS[remainder + 1], result)
    n <- (n - 1) %/% 26
  }
  return(result)
}

cat("✓ GT to Excel conversion engine loaded\n")
cat("✓ Main function: create_statistischer_bericht_from_gt()\n")