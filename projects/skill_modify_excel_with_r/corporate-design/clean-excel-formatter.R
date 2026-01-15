# Clean Excel Formatter - Professional Destatis Style
# ====================================================
#
# This script creates clean, professional Excel files with Destatis styling:
# - White background with borders only around table
# - Space as thousands separator
# - 14pt Arial heading in Destatis blue
# - Clean, minimal design

suppressPackageStartupMessages({
  library(openxlsx2)
  library(dplyr)
})

#' Create Clean Professional Excel Table
#' 
#' Creates Excel file with clean Destatis styling - borders only around table,
#' white background, space as thousands separator, 14pt blue heading.
#'
#' @param data Data frame to export
#' @param filename Output Excel filename
#' @param title Table title (14pt, Destatis blue)
#' @param subtitle Optional subtitle text
#' @return Path to created Excel file
create_clean_excel <- function(data, filename, title = "Data Table", subtitle = NULL) {
  
  # Destatis colors
  destatis_blue <- "004B76"
  
  wb <- wb_workbook()
  wb$add_worksheet("Data")
  
  # Set document properties
  wb$set_properties(
    title = title,
    creator = "Statistisches Bundesamt",
    subject = "Professional Data Table"
  )
  
  current_row <- 1
  
  # ---- Title Style (14pt, Destatis Blue, Arial) ----
  title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 14,
    text_bold = TRUE,
    font_color = wb_color(hex = destatis_blue),
    horizontal = "left",
    vertical = "center"
  )
  
  # Add title
  wb$add_data(sheet = "Data", x = title, start_col = 1, start_row = current_row)
  wb$add_cell_style(sheet = "Data", dims = paste0("A", current_row), style = title_style)
  current_row <- current_row + 1
  
  # Add subtitle if provided
  if (!is.null(subtitle)) {
    subtitle_style <- create_cell_style(
      font_name = "Arial",
      font_size = 11,
      font_color = wb_color(hex = "666666"),
      horizontal = "left"
    )
    
    wb$add_data(sheet = "Data", x = subtitle, start_col = 1, start_row = current_row)
    wb$add_cell_style(sheet = "Data", dims = paste0("A", current_row), style = subtitle_style)
    current_row <- current_row + 1
  }
  
  # Add blank row before table
  current_row <- current_row + 1
  
  # ---- Table Header Style ----
  header_style_left <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),  # White text on blue background
    fill_color = wb_color(hex = destatis_blue),
    horizontal = "center",
    vertical = "center",
    border = "TopLeft",
    border_color = wb_color(hex = destatis_blue)
  )
  
  header_style_middle <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = destatis_blue),
    horizontal = "center",
    vertical = "center",
    border = "Top",
    border_color = wb_color(hex = destatis_blue)
  )
  
  header_style_right <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = destatis_blue),
    horizontal = "center",
    vertical = "center",
    border = "TopRight",
    border_color = wb_color(hex = destatis_blue)
  )
  
  # ---- Data Cell Styles (no inner borders) ----
  data_style_left <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    border = "Left",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"  # Space as thousands separator, comma as decimal
  )
  
  data_style_middle <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    num_fmt = "# ##0,00"
  )
  
  data_style_right <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    border = "Right",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  # Last row styles (with bottom border)
  data_style_left_last <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    border = "BottomLeft",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  data_style_middle_last <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    border = "Bottom",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  data_style_right_last <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    border = "BottomRight",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  # Alternating row styles
  data_style_left_alt <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    border = "Left",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  data_style_middle_alt <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    num_fmt = "# ##0,00"
  )
  
  data_style_right_alt <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    border = "Right",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  # Last row alternating styles
  data_style_left_alt_last <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    border = "BottomLeft",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  data_style_middle_alt_last <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    border = "Bottom",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  data_style_right_alt_last <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    border = "BottomRight",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  # Add table data
  table_start_row <- current_row
  wb$add_data(sheet = "Data", x = data, start_col = 1, start_row = table_start_row)
  
  # Apply header formatting (only outer borders)
  n_cols <- ncol(data)
  for (col in 1:n_cols) {
    cell <- paste0(LETTERS[col], table_start_row)
    
    if (col == 1) {
      wb$add_cell_style(sheet = "Data", dims = cell, style = header_style_left)
    } else if (col == n_cols) {
      wb$add_cell_style(sheet = "Data", dims = cell, style = header_style_right)
    } else {
      wb$add_cell_style(sheet = "Data", dims = cell, style = header_style_middle)
    }
  }
  
  # Apply data cell formatting with alternating rows (only outer borders)
  n_rows <- nrow(data)
  for (row in 1:n_rows) {
    actual_row <- table_start_row + row
    is_last_row <- (row == n_rows)
    is_alt_row <- (row %% 2 == 0)
    
    for (col in 1:n_cols) {
      cell <- paste0(LETTERS[col], actual_row)
      
      # Determine which style to use based on position and alternating
      if (col == 1) {
        # Left column
        if (is_last_row) {
          style <- if (is_alt_row) data_style_left_alt_last else data_style_left_last
        } else {
          style <- if (is_alt_row) data_style_left_alt else data_style_left
        }
      } else if (col == n_cols) {
        # Right column
        if (is_last_row) {
          style <- if (is_alt_row) data_style_right_alt_last else data_style_right_last
        } else {
          style <- if (is_alt_row) data_style_right_alt else data_style_right
        }
      } else {
        # Middle columns
        if (is_last_row) {
          style <- if (is_alt_row) data_style_middle_alt_last else data_style_middle_last
        } else {
          style <- if (is_alt_row) data_style_middle_alt else data_style_middle
        }
      }
      
      wb$add_cell_style(sheet = "Data", dims = cell, style = style)
    }
  }
  
  # Auto-size columns for optimal display
  for (col in 1:n_cols) {
    wb$set_col_widths(sheet = "Data", cols = col, widths = "auto")
  }
  
  # Set minimum column width for readability
  for (col in 1:n_cols) {
    wb$set_col_widths(sheet = "Data", cols = col, widths = max(15, wb$get_col_widths(sheet = "Data", cols = col)))
  }
  
  # Save the workbook
  wb$save(filename)
  
  cat("✓ Clean Excel table created:", filename, "\n")
  cat("  Style: Professional Destatis formatting\n")
  cat("  Title: 14pt Arial, Destatis blue\n")
  cat("  Table: Bordered, space thousands separator\n")
  cat("  Background: Clean white\n")
  
  return(filename)
}

#' Create Multi-Table Clean Excel Report
#' 
#' Creates professional report with multiple tables, each cleanly formatted.
#'
#' @param data_list Named list of data frames
#' @param filename Output Excel filename  
#' @param main_title Main report title
#' @return Path to created Excel file
create_clean_multi_table <- function(data_list, filename, main_title = "Statistical Report") {
  
  destatis_blue <- "004B76"
  
  wb <- wb_workbook()
  
  # Set document properties
  wb$set_properties(
    title = main_title,
    creator = "Statistisches Bundesamt",
    subject = "Professional Multi-Table Report"
  )
  
  # ---- Create Index Sheet ----
  wb$add_worksheet("Index")
  
  # Index title style
  index_title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 16,
    text_bold = TRUE,
    font_color = wb_color(hex = destatis_blue),
    horizontal = "left"
  )
  
  # Index link style
  link_style <- create_cell_style(
    font_name = "Arial", 
    font_size = 11,
    font_color = wb_color(hex = "0563C1"),
    text_decoration = "underline",
    horizontal = "left"
  )
  
  # Add index title
  wb$add_data(sheet = "Index", x = main_title, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = "Index", dims = "A1", style = index_title_style)
  
  wb$add_data(sheet = "Index", x = "Inhaltsverzeichnis", start_col = 1, start_row = 3)
  
  # Create each data sheet and add links
  for (i in seq_along(data_list)) {
    sheet_name <- names(data_list)[i]
    data <- data_list[[i]]
    
    # Create worksheet
    wb$add_worksheet(sheet_name)
    
    # Add back to index link
    back_link <- 'HYPERLINK("#Index!A1", "← Zurück zum Index")'
    wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
    wb$add_cell_style(sheet = sheet_name, dims = "A1", style = link_style)
    
    # Add clean table starting from row 3
    current_row <- 3
    
    # Table title
    table_title_style <- create_cell_style(
      font_name = "Arial",
      font_size = 14,
      text_bold = TRUE,
      font_color = wb_color(hex = destatis_blue)
    )
    
    wb$add_data(sheet = sheet_name, x = sheet_name, start_col = 1, start_row = current_row)
    wb$add_cell_style(sheet = sheet_name, dims = paste0("A", current_row), style = table_title_style)
    current_row <- current_row + 2
    
    # Add table with clean formatting
    add_clean_table_to_sheet(wb, sheet_name, data, current_row)
    
    # Add link in index
    index_row <- i + 3
    link_formula <- sprintf('HYPERLINK("#%s!A1", "%s")', sheet_name, sheet_name)
    wb$add_formula(sheet = "Index", x = link_formula, start_col = 1, start_row = index_row)
    wb$add_cell_style(sheet = "Index", dims = paste0("A", index_row), style = link_style)
  }
  
  # Set index column width
  wb$set_col_widths(sheet = "Index", cols = 1, widths = 40)
  
  wb$save(filename)
  
  cat("✓ Clean multi-table report created:", filename, "\n")
  cat("  Sheets:", length(data_list), "\n")
  cat("  Style: Professional with navigation\n")
  
  return(filename)
}

#' Helper function to add clean table to existing sheet
#' @keywords internal
add_clean_table_to_sheet <- function(wb, sheet_name, data, start_row) {
  destatis_blue <- "004B76"
  
  # Header style
  header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = destatis_blue),
    horizontal = "center",
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = destatis_blue)
  )
  
  # Data styles
  data_style <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  data_style_alt <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    border = "TopBottomLeftRight", 
    border_color = wb_color(hex = destatis_blue),
    num_fmt = "# ##0,00"
  )
  
  # Add data
  wb$add_data(sheet = sheet_name, x = data, start_col = 1, start_row = start_row)
  
  # Apply formatting
  n_cols <- ncol(data)
  n_rows <- nrow(data)
  
  # Headers
  for (col in 1:n_cols) {
    cell <- paste0(LETTERS[col], start_row)
    wb$add_cell_style(sheet = sheet_name, dims = cell, style = header_style)
  }
  
  # Data cells
  for (row in 1:n_rows) {
    actual_row <- start_row + row
    for (col in 1:n_cols) {
      cell <- paste0(LETTERS[col], actual_row)
      
      if (row %% 2 == 0) {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = data_style_alt)
      } else {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = data_style)
      }
    }
  }
  
  # Auto-size columns
  for (col in 1:n_cols) {
    wb$set_col_widths(sheet = sheet_name, cols = col, widths = "auto")
  }
}

#' Create Sample Destatis Report
#' 
#' Creates a sample report using the cars dataset with proper formatting.
#' 
#' @param filename Output filename
#' @return Path to created file
create_sample_destatis_report <- function(filename = "destatis_sample_clean.xlsx") {
  
  # Prepare sample data
  sample_data <- data.frame(
    Fahrzeugtyp = c("PKW", "LKW", "Motorrad", "Bus"),
    Geschwindigkeit_kmh = c(50.5, 45.2, 75.8, 40.0),
    Bremsweg_m = c(25.3, 35.7, 18.9, 42.1),
    Sicherheitsbewertung = c(4.2, 3.8, 3.5, 4.5),
    Anzahl_Tests = c(1250, 850, 420, 180),
    stringsAsFactors = FALSE
  )
  
  # Create clean Excel report
  create_clean_excel(
    data = sample_data,
    filename = filename,
    title = "Kraftfahrzeug-Testbericht",
    subtitle = "Geschwindigkeit, Bremsweg und Sicherheitsbewertung"
  )
  
  return(filename)
}

cat("Clean Excel Formatter loaded successfully!\n")
cat("Functions available:\n")
cat("  - create_clean_excel(data, filename, title)\n") 
cat("  - create_clean_multi_table(data_list, filename, title)\n")
cat("  - create_sample_destatis_report(filename)\n")
cat("\nFormatting features:\n")
cat("  ✓ Clean white background\n")
cat("  ✓ Borders only around table\n")
cat("  ✓ Space as thousands separator\n")
cat("  ✓ 14pt Arial heading in Destatis blue\n")
cat("  ✓ Professional alternating row colors\n")