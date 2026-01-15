# ============================================================================
# Core Excel Operations with openxlsx2
# ============================================================================
# Essential functions for Excel file operations in R

# Required packages ----
suppressPackageStartupMessages({
  if (!require("openxlsx2", quietly = TRUE)) stop("openxlsx2 package required")
})

# Reading Excel Files ----

#' Load Excel File
#' 
#' @param file_path Path to Excel file
#' @return wb object
#' @export
load_excel <- function(file_path) {
  wb_load(file_path)
}

#' Read Excel Sheet to Data Frame
#' 
#' @param file_path Path to Excel file or wb object
#' @param sheet Sheet name or number (default: 1)
#' @param range Cell range (optional)
#' @return data.frame
#' @export
read_excel_sheet <- function(file_path, sheet = 1, range = NULL) {
  if (is.character(file_path)) {
    wb <- wb_load(file_path)
  } else {
    wb <- file_path
  }
  
  if (is.null(range)) {
    wb_to_df(wb, sheet = sheet)
  } else {
    wb_to_df(wb, sheet = sheet, dims = range)
  }
}

# Writing Excel Files ----

#' Write Data to Excel
#' 
#' @param data Data frame to write
#' @param file_path Output file path
#' @param sheet_name Sheet name (default: "Sheet1")
#' @return wb object
#' @export
write_excel <- function(data, file_path, sheet_name = "Sheet1") {
  wb <- wb_workbook()
  wb$add_worksheet(sheet_name)
  wb$add_data(sheet = sheet_name, x = data, dims = wb_dims(1, 1))
  wb$set_col_widths(sheet = sheet_name, cols = 1:ncol(data), widths = "auto")
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

#' Write Multiple Sheets
#' 
#' @param data_list Named list of data frames
#' @param file_path Output file path
#' @return wb object
#' @export
write_excel_sheets <- function(data_list, file_path) {
  wb <- wb_workbook()
  
  for (sheet_name in names(data_list)) {
    wb$add_worksheet(sheet_name)
    wb$add_data(sheet = sheet_name, x = data_list[[sheet_name]], dims = wb_dims(1, 1))
    wb$set_col_widths(sheet = sheet_name, cols = 1:ncol(data_list[[sheet_name]]), widths = "auto")
  }
  
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

# Modifying Excel Files ----

#' Add Data to Existing Excel
#' 
#' @param file_path Path to existing Excel file
#' @param data Data frame to add
#' @param sheet_name Sheet name (new or existing)
#' @param start_row Starting row (default: 1)
#' @param start_col Starting column (default: 1)
#' @return wb object
#' @export
add_to_excel <- function(file_path, data, sheet_name, start_row = 1, start_col = 1) {
  wb <- wb_load(file_path)
  
  # Add worksheet if it doesn't exist
  if (!sheet_name %in% wb_get_sheet_names(wb)) {
    wb$add_worksheet(sheet_name)
  }
  
  wb$add_data(sheet = sheet_name, x = data, dims = wb_dims(start_row, start_col))
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

#' Update Cell Range
#' 
#' @param file_path Path to Excel file
#' @param sheet_name Sheet name
#' @param data Data to write
#' @param range Cell range (e.g., "A1:C3")
#' @return wb object
#' @export
update_range <- function(file_path, sheet_name, data, range) {
  wb <- wb_load(file_path)
  wb$add_data(sheet = sheet_name, x = data, dims = range)
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

# Worksheet Operations ----

#' Add Worksheet
#' 
#' @param file_path Path to Excel file
#' @param sheet_name New sheet name
#' @return wb object
#' @export
add_worksheet <- function(file_path, sheet_name) {
  wb <- wb_load(file_path)
  wb$add_worksheet(sheet_name)
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

#' Remove Worksheet
#' 
#' @param file_path Path to Excel file
#' @param sheet_name Sheet name to remove
#' @return wb object
#' @export
remove_worksheet <- function(file_path, sheet_name) {
  wb <- wb_load(file_path)
  wb$remove_worksheet(sheet_name)
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

#' Get Sheet Names
#' 
#' @param file_path Path to Excel file
#' @return character vector of sheet names
#' @export
get_sheet_names <- function(file_path) {
  wb <- wb_load(file_path)
  wb_get_sheet_names(wb)
}

# Formatting Operations ----

#' Set Column Widths
#' 
#' @param file_path Path to Excel file
#' @param sheet_name Sheet name
#' @param cols Column numbers
#' @param widths Width values or "auto"
#' @return wb object
#' @export
set_column_widths <- function(file_path, sheet_name, cols, widths = "auto") {
  wb <- wb_load(file_path)
  wb$set_col_widths(sheet = sheet_name, cols = cols, widths = widths)
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

#' Format Header Row
#' 
#' @param file_path Path to Excel file
#' @param sheet_name Sheet name
#' @param header_row Row number (default: 1)
#' @param bold Make text bold (default: TRUE)
#' @param bg_color Background color (default: "lightblue")
#' @return wb object
#' @export
format_headers <- function(file_path, sheet_name, header_row = 1, bold = TRUE, bg_color = "lightblue") {
  wb <- wb_load(file_path)
  
  # Get number of columns
  data <- wb_to_df(wb, sheet = sheet_name)
  n_cols <- ncol(data)
  
  wb$add_style(
    sheet = sheet_name,
    style = wb_style(font_bold = bold, bg_fill = wb_color(bg_color)),
    rows = header_row,
    cols = 1:n_cols
  )
  
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

#' Add Cell Border
#' 
#' @param file_path Path to Excel file
#' @param sheet_name Sheet name
#' @param range Cell range
#' @param border_style Border style (default: "thin")
#' @return wb object
#' @export
add_borders <- function(file_path, sheet_name, range, border_style = "thin") {
  wb <- wb_load(file_path)
  wb$add_border(
    sheet = sheet_name,
    dims = range,
    bottom_border = border_style,
    top_border = border_style,
    left_border = border_style,
    right_border = border_style
  )
  wb_save(wb, file_path, overwrite = TRUE)
  return(wb)
}

# Convenience Functions ----

#' Quick Excel Export
#' 
#' @param data Data frame
#' @param file_path Output path
#' @export
quick_export <- function(data, file_path) {
  write_excel(data, file_path, "Data")
  cat("Exported to:", file_path, "\n")
}

#' Append to Excel
#' 
#' @param data Data frame
#' @param file_path Excel file path
#' @param sheet_name Sheet name (default: "Data")
#' @export
append_to_excel <- function(data, file_path, sheet_name = "Data") {
  if (!file.exists(file_path)) {
    write_excel(data, file_path, sheet_name)
  } else {
    # Find next empty row
    existing_data <- read_excel_sheet(file_path, sheet_name)
    next_row <- nrow(existing_data) + 2  # +1 for header, +1 for new row
    add_to_excel(file_path, data, sheet_name, next_row, 1)
  }
  cat("Data appended to:", file_path, "\n")
}

#' Create Formatted Excel with Navigation
#' 
#' Creates an Excel file with nicely formatted sheets, navigation index, and hyperlinks
#' 
#' @param data_list Named list of data frames
#' @param filename Output file path
#' @param main_title Main title for the index (default: "Inhaltsübersicht")
#' @return wb object
#' @export
create_formatted_excel_with_navigation <- function(data_list, filename, main_title = "Datenübersicht") {
  wb <- wb_workbook()
  
  # Create index sheet (Inhaltsübersicht) ----
  wb$add_worksheet("Inhaltsübersicht")
  
  # Title in A1
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")
  wb$add_style(
    dims = "A1:B1",
    style = wb_style(
      font_bold = TRUE, 
      font_size = 16,
      font_color = wb_color("white"),
      bg_fill = wb_color("#4472C4")
    )
  )
  wb$merge_cells(sheet = "Inhaltsübersicht", dims = wb_dims(1, 1:2))
  wb$set_row_heights(sheet = "Inhaltsübersicht", rows = 1, heights = 25)
  
  # Table headers
  wb$add_data(sheet = "Inhaltsübersicht", x = "Blatt", dims = wb_dims(3, 1))
  wb$add_data(sheet = "Inhaltsübersicht", x = "Beschreibung", dims = wb_dims(3, 2))
  wb$add_style(
    sheet = "Inhaltsübersicht",
    style = wb_style(font_bold = TRUE, bg_fill = wb_color("lightgray")),
    rows = 3, cols = 1:2
  )
  
  # Add navigation links for each dataset
  current_row <- 4
  for (sheet_name in names(data_list)) {
    # Sheet name with hyperlink
    wb$add_data(sheet = "Inhaltsübersicht", x = sheet_name, dims = wb_dims(current_row, 1))
    wb$add_hyperlink(
      sheet = "Inhaltsübersicht",
      target = paste0("#'", sheet_name, "'!A1"),
      dims = wb_dims(current_row, 1)
    )
    wb$add_style(
      sheet = "Inhaltsübersicht",
      style = wb_style(font_color = wb_color("blue"), text_underline = TRUE),
      rows = current_row, cols = 1
    )
    
    # Description
    n_rows <- nrow(data_list[[sheet_name]])
    n_cols <- ncol(data_list[[sheet_name]])
    description <- paste0("Tabelle mit ", n_rows, " Zeilen und ", n_cols, " Spalten")
    wb$add_data(sheet = "Inhaltsübersicht", x = description, dims = wb_dims(current_row, 2))
    
    current_row <- current_row + 1
  }
  
  # Set column widths for index
  wb$set_col_widths(sheet = "Inhaltsübersicht", cols = 1, widths = 20)
  wb$set_col_widths(sheet = "Inhaltsübersicht", cols = 2, widths = 40)
  
  # Create data sheets ----
  for (sheet_name in names(data_list)) {
    wb$add_worksheet(sheet_name)
    
    # Title in A1 with dataset name
    wb$add_data(sheet = sheet_name, x = paste("Daten:", sheet_name), dims = wb_dims(1, 1))
    wb$add_style(
      sheet = sheet_name,
      style = wb_style(
        font_bold = TRUE, 
        font_size = 14,
        bg_fill = wb_color("#4472C4"),
        font_color = wb_color("white")
      ),
      rows = 1, cols = 1:ncol(data_list[[sheet_name]])
    )
    wb$merge_cells(sheet = sheet_name, dims = wb_dims(1, 1:ncol(data_list[[sheet_name]])))
    
    # Back to index link in A2
    wb$add_data(sheet = sheet_name, x = "← Zur Inhaltsübersicht", dims = wb_dims(2, 1))
    wb$add_hyperlink(
      sheet = sheet_name,
      target = "#Inhaltsübersicht!A1",
      dims = wb_dims(2, 1)
    )
    wb$add_style(
      sheet = sheet_name,
      style = wb_style(font_color = wb_color("blue"), text_underline = TRUE),
      rows = 2, cols = 1
    )
    
    # Add the actual data starting from row 4
    wb$add_data(sheet = sheet_name, x = data_list[[sheet_name]], dims = wb_dims(4, 1))
    
    # Format headers nicely
    wb$add_style(
      sheet = sheet_name,
      style = wb_style(
        font_bold = TRUE, 
        bg_fill = wb_color("lightblue"),
        font_color = wb_color("black")
      ),
      rows = 4, cols = 1:ncol(data_list[[sheet_name]])
    )
    
    # Alternating row colors for better readability
    for (i in seq(2, nrow(data_list[[sheet_name]]), 2)) {
      wb$add_style(
        sheet = sheet_name,
        style = wb_style(bg_fill = wb_color("#F8F8F8")),
        rows = 4 + i, cols = 1:ncol(data_list[[sheet_name]])
      )
    }
    
    # Auto-size columns
    wb$set_col_widths(sheet = sheet_name, cols = 1:ncol(data_list[[sheet_name]]), widths = "auto")
    
    # Add borders around the data
    data_range <- wb_dims(
      from_row = 4, from_col = 1,
      to_row = 4 + nrow(data_list[[sheet_name]]), to_col = ncol(data_list[[sheet_name]])
    )
    wb$add_border(
      sheet = sheet_name, dims = data_range,
      bottom_border = "thin", top_border = "thin",
      left_border = "thin", right_border = "thin"
    )
  }
  
  # Set active sheet to index
  wb$set_active_sheet("Inhaltsübersicht")
  
  # Save the workbook
  wb_save(wb, filename, overwrite = TRUE)
  cat("✓ Created formatted Excel file:", filename, "\n")
  cat("  - Index sheet: Inhaltsübersicht\n")
  cat("  - Data sheets:", paste(names(data_list), collapse = ", "), "\n")
  
  return(wb)
}

# Example Usage ----
if (FALSE) {
  # Basic operations
  quick_export(mtcars, "cars.xlsx")
  
  # Multiple sheets
  data_list <- list("Cars" = mtcars, "Iris" = iris)
  write_excel_sheets(data_list, "datasets.xlsx")
  
  # Read data
  car_data <- read_excel_sheet("cars.xlsx", "Data")
  
  # Modify existing file
  add_to_excel("cars.xlsx", iris, "Iris")
  format_headers("cars.xlsx", "Data")
  
  # Create formatted Excel with navigation - Example for iris and mtcars
  datasets <- list(
    "Iris" = iris,
    "Cars" = mtcars
  )
  create_formatted_excel_with_navigation(datasets, "formatted_datasets.xlsx")
}