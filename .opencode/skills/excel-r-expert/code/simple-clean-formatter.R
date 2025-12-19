# Simple Clean Excel Formatter - Professional Destatis Style
# ===========================================================
#
# Clean, minimal Excel formatting with:
# - White background 
# - Border only around entire table (no inner borders)
# - Space as thousands separator
# - 14pt Arial heading in Destatis blue

suppressPackageStartupMessages({
  library(openxlsx2)
  library(dplyr)
})

#' Create Clean Excel Table with Outer Border Only
#' 
#' @param data Data frame to export
#' @param filename Output Excel filename
#' @param title Table title (14pt, Destatis blue)
#' @param subtitle Optional subtitle text
#' @return Path to created Excel file
create_simple_clean_excel <- function(data, filename, title = "Data Table", subtitle = NULL) {
  
  # Destatis blue color
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
    horizontal = "left"
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
  
  # ---- Header Style (Destatis blue background, white text) ----
  header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),  # White text
    fill_color = wb_color(hex = destatis_blue),  # Blue background
    horizontal = "center",
    vertical = "center"
  )
  
  # ---- Data Cell Style (clean, no borders) ----
  data_style <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    num_fmt = "# ##0,00"  # Space as thousands separator
  )
  
  # Alternating row style
  data_style_alt <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),  # Light grey
    horizontal = "left",
    vertical = "center",
    num_fmt = "# ##0,00"
  )
  
  # Add table data
  table_start_row <- current_row
  wb$add_data(sheet = "Data", x = data, start_col = 1, start_row = table_start_row)
  
  # Apply header formatting
  n_cols <- ncol(data)
  n_rows <- nrow(data)
  
  for (col in 1:n_cols) {
    cell <- paste0(LETTERS[col], table_start_row)
    wb$add_cell_style(sheet = "Data", dims = cell, style = header_style)
  }
  
  # Apply data cell formatting with alternating rows
  for (row in 1:n_rows) {
    actual_row <- table_start_row + row
    
    for (col in 1:n_cols) {
      cell <- paste0(LETTERS[col], actual_row)
      
      # Use alternating style for even data rows
      if (row %% 2 == 0) {
        wb$add_cell_style(sheet = "Data", dims = cell, style = data_style_alt)
      } else {
        wb$add_cell_style(sheet = "Data", dims = cell, style = data_style)
      }
    }
  }
  
  # Add outer border around entire table
  table_end_row <- table_start_row + n_rows
  table_end_col <- LETTERS[n_cols]
  table_range <- paste0("A", table_start_row, ":", table_end_col, table_end_row)
  
  # Apply border to the entire table range
  wb$add_border(
    sheet = "Data",
    dims = table_range,
    top_border = "medium",
    bottom_border = "medium", 
    left_border = "medium",
    right_border = "medium",
    top_color = wb_color(hex = destatis_blue),
    bottom_color = wb_color(hex = destatis_blue),
    left_color = wb_color(hex = destatis_blue),
    right_color = wb_color(hex = destatis_blue)
  )
  
  # Auto-size columns for optimal display
  for (col in 1:n_cols) {
    wb$set_col_widths(sheet = "Data", cols = col, widths = "auto")
  }
  
  # Set minimum column width for readability
  for (col in 1:n_cols) {
    current_width <- 15  # Default minimum
    wb$set_col_widths(sheet = "Data", cols = col, widths = max(current_width, 15))
  }
  
  # Save the workbook
  wb$save(filename)
  
  cat("✓ Clean Excel table created:", filename, "\n")
  cat("  Style: Clean with outer border only\n") 
  cat("  Title: 14pt Arial, Destatis blue\n")
  cat("  Numbers: Space thousands separator\n")
  cat("  Background: White with light alternating rows\n")
  
  return(filename)
}

#' Create Sample Clean Report
#' 
#' @param filename Output filename
#' @return Path to created file
create_sample_clean_report <- function(filename = "sample_clean_destatis.xlsx") {
  
  # Create sample data with German formatting
  sample_data <- data.frame(
    Region = c("Bayern", "Nordrhein-Westfalen", "Baden-Württemberg", "Niedersachsen"),
    Einwohner = c(13124737, 17932651, 11100394, 7993608),
    BIP_Mrd_Euro = c(632.9, 704.2, 524.3, 310.5),
    Arbeitslosenquote = c(3.1, 6.8, 3.2, 5.1),
    Unternehmen = c(725630, 838492, 627459, 394821),
    stringsAsFactors = FALSE
  )
  
  # Create clean Excel report
  create_simple_clean_excel(
    data = sample_data,
    filename = filename,
    title = "Wirtschaftsdaten der Bundesländer",
    subtitle = "Einwohner, BIP und Arbeitsmarktdaten"
  )
  
  return(filename)
}

cat("Simple Clean Excel Formatter loaded!\n")
cat("Functions available:\n")
cat("  - create_simple_clean_excel(data, filename, title, subtitle)\n")
cat("  - create_sample_clean_report(filename)\n")
cat("\nFeatures:\n")
cat("  ✓ Clean white background\n")
cat("  ✓ Border only around entire table\n") 
cat("  ✓ No inner borders\n")
cat("  ✓ Space as thousands separator (# ##0,00)\n")
cat("  ✓ 14pt Arial heading in Destatis blue\n")
cat("  ✓ Light alternating row colors\n")