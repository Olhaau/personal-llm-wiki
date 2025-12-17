# excelize.R ----
# Export gt tables to formatted Excel files with Destatis corporate design

suppressPackageStartupMessages({
  library(openxlsx2)
  library(gt)
  library(yaml)
})

#' Load Destatis Style Configuration
#' 
#' @param config_path Path to YAML configuration file
#' @return List with style settings
#' @keywords internal
load_style_config <- function(config_path = "config/destatis_style.yaml") {
  if (!file.exists(config_path)) {
    stop("Style configuration file not found: ", config_path)
  }
  yaml::read_yaml(config_path)
}

#' Create Excel Styles from Configuration
#' 
#' @param style_config Style configuration list from YAML
#' @return List of openxlsx2 styles
#' @keywords internal
create_styles <- function(style_config) {
  styles <- list()
  
  # Heading style
  styles$heading <- openxlsx2::create_cell_style(
    font_name = style_config$heading$font_family,
    font_size = style_config$heading$font_size,
    text_bold = style_config$heading$font_bold,
    font_color = wb_color(hex = style_config$heading$font_color),
    fill_color = wb_color(hex = style_config$heading$fill_color),
    horizontal = style_config$heading$horizontal_align,
    vertical = style_config$heading$vertical_align,
    wrap_text = style_config$heading$wrap_text
  )
  
  # Column header style
  styles$col_header <- openxlsx2::create_cell_style(
    font_name = style_config$column_header$font_family,
    font_size = style_config$column_header$font_size,
    text_bold = style_config$column_header$font_bold,
    font_color = wb_color(hex = style_config$column_header$font_color),
    fill_color = wb_color(hex = style_config$column_header$fill_color),
    horizontal = style_config$column_header$horizontal_align,
    vertical = style_config$column_header$vertical_align,
    wrap_text = style_config$column_header$wrap_text,
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = style_config$column_header$border_color)
  )
  
  # Data cell style
  styles$data_cell <- openxlsx2::create_cell_style(
    font_name = style_config$data_cell$font_family,
    font_size = style_config$data_cell$font_size,
    font_color = wb_color(hex = style_config$data_cell$font_color),
    fill_color = wb_color(hex = style_config$data_cell$fill_color),
    horizontal = style_config$data_cell$horizontal_align,
    vertical = style_config$data_cell$vertical_align,
    wrap_text = style_config$data_cell$wrap_text,
    border = "TopBottomLeftRight",
    border_color = wb_color(hex = style_config$data_cell$border_color)
  )
  
  # Alternating row style (even rows)
  if (style_config$alternating_rows$enabled) {
    styles$data_cell_alt <- openxlsx2::create_cell_style(
      font_name = style_config$data_cell$font_family,
      font_size = style_config$data_cell$font_size,
      font_color = wb_color(hex = style_config$data_cell$font_color),
      fill_color = wb_color(hex = style_config$alternating_rows$even_color),
      horizontal = style_config$data_cell$horizontal_align,
      vertical = style_config$data_cell$vertical_align,
      wrap_text = style_config$data_cell$wrap_text,
      border = "TopBottomLeftRight",
      border_color = wb_color(hex = style_config$data_cell$border_color)
    )
  }
  
  # Index sheet title style
  styles$index_title <- openxlsx2::create_cell_style(
    font_name = style_config$font$family,
    font_size = style_config$index_sheet$font_size,
    text_bold = style_config$index_sheet$font_bold,
    font_color = wb_color(hex = style_config$colors$primary)
  )
  
  styles
}

#' Create Index Sheet with Links
#' 
#' @param wb Workbook object
#' @param sheet_names Vector of sheet names to link to
#' @param style_config Style configuration
#' @keywords internal
create_index_sheet <- function(wb, sheet_names, style_config) {
  # Add index sheet as first sheet
  wb$add_worksheet(style_config$index_sheet$name, position = 1)
  
  # Add title
  wb$add_data(
    sheet = style_config$index_sheet$name,
    x = style_config$index_sheet$title,
    start_col = 1,
    start_row = 1
  )
  
  # Add title formatting
  title_style <- openxlsx2::create_cell_style(
    font_name = style_config$font$family,
    font_size = 14,
    text_bold = TRUE,
    font_color = wb_color(hex = style_config$colors$primary)
  )
  wb$add_cell_style(
    sheet = style_config$index_sheet$name,
    dims = "A1",
    style = title_style
  )
  
  # Add links to each sheet
  for (i in seq_along(sheet_names)) {
    sheet_name <- sheet_names[i]
    row <- i + 2  # Start after title and blank row
    
    # Create internal link
    formula <- sprintf('HYPERLINK("#%s!A1", "%s")', sheet_name, sheet_name)
    wb$add_formula(
      sheet = style_config$index_sheet$name,
      x = formula,
      start_col = 1,
      start_row = row
    )
    
    # Style as hyperlink
    link_style <- openxlsx2::create_cell_style(
      font_name = style_config$font$family,
      font_size = style_config$font$size,
      font_color = wb_color(hex = style_config$index_sheet$link_color),
      text_decoration = "underline"
    )
    wb$add_cell_style(
      sheet = style_config$index_sheet$name,
      dims = sprintf("A%d", row),
      style = link_style
    )
  }
  
  # Adjust column width
  wb$set_col_widths(
    sheet = style_config$index_sheet$name,
    cols = 1,
    widths = 30
  )
  
  wb
}

#' Export gt Table to Formatted Excel File
#' 
#' Export a gt table object to an Excel file with Destatis corporate design
#' styling. Supports custom headings, frozen panes, and optional index sheet.
#' 
#' @param gt_object A gt table object to export
#' @param filename Output Excel filename (will be created in output/ if relative)
#' @param sheet_name Name for the worksheet (default: "Data")
#' @param heading Optional heading text to display above the table
#' @param freeze_rows Number of rows to freeze (default: 2 for heading + header)
#' @param freeze_cols Number of columns to freeze (default: 1)
#' @param add_index_link Add "Back to Index" link at top (default: FALSE)
#' @param create_index Create index sheet if multiple sheets (default: TRUE)
#' @param config_path Path to style configuration YAML (default: "config/destatis_style.yaml")
#' @param append Append to existing workbook (default: FALSE)
#' 
#' @return Invisibly returns the workbook object
#' @export
#' 
#' @examples
#' library(gt)
#' my_table <- gt(head(mtcars))
#' excelize(my_table, "output/cars.xlsx", heading = "Motor Trend Cars")
excelize <- function(gt_object,
                     filename,
                     sheet_name = "Data",
                     heading = NULL,
                     freeze_rows = 2,
                     freeze_cols = 1,
                     add_index_link = FALSE,
                     create_index = TRUE,
                     config_path = "config/destatis_style.yaml",
                     append = FALSE) {
  
  # Validate inputs ----
  if (!inherits(gt_object, "gt_tbl")) {
    stop("gt_object must be a gt table object")
  }
  
  # Load style configuration ----
  style_config <- load_style_config(config_path)
  styles <- create_styles(style_config)
  
  # Extract data from gt object ----
  # Convert gt to data frame
  gt_data <- as.data.frame(gt_object[["_data"]])
  
  # Create or load workbook ----
  if (append && file.exists(filename)) {
    wb <- wb_load(filename)
  } else {
    wb <- wb_workbook()
  }
  
  # Add worksheet ----
  if (sheet_name %in% wb$get_sheet_names()) {
    wb$remove_worksheet(sheet_name)
  }
  wb$add_worksheet(sheet_name)
  
  # Set up row counter ----
  current_row <- 1
  
  # Add "Back to Index" link if requested ----
  if (add_index_link && create_index) {
    link_formula <- sprintf('HYPERLINK("#%s!A1", "← Back to Index")', 
                           style_config$index_sheet$name)
    wb$add_formula(
      sheet = sheet_name,
      x = link_formula,
      start_col = 1,
      start_row = current_row
    )
    
    # Style the link
    link_style <- openxlsx2::create_cell_style(
      font_name = style_config$font$family,
      font_size = style_config$font$size,
      font_color = wb_color(hex = style_config$index_sheet$link_color),
      text_decoration = "underline"
    )
    wb$add_cell_style(
      sheet = sheet_name,
      dims = sprintf("A%d", current_row),
      style = link_style
    )
    
    current_row <- current_row + 1
  }
  
  # Add heading if provided ----
  if (!is.null(heading)) {
    wb$add_data(
      sheet = sheet_name,
      x = heading,
      start_col = 1,
      start_row = current_row
    )
    
    # Merge cells for heading across all columns
    n_cols <- ncol(gt_data)
    end_col <- LETTERS[n_cols]
    merge_range <- sprintf("A%d:%s%d", current_row, end_col, current_row)
    wb$merge_cells(sheet = sheet_name, dims = merge_range)
    
    # Apply heading style
    wb$add_cell_style(
      sheet = sheet_name,
      dims = merge_range,
      style = styles$heading
    )
    
    # Set row height
    wb$set_row_heights(
      sheet = sheet_name,
      rows = current_row,
      heights = style_config$heading$row_height
    )
    
    current_row <- current_row + 1
  }
  
  # Add data with headers ----
  wb$add_data_table(
    sheet = sheet_name,
    x = gt_data,
    start_col = 1,
    start_row = current_row,
    table_style = "none",
    with_filter = FALSE
  )
  
  # Style column headers ----
  header_row <- current_row
  n_cols <- ncol(gt_data)
  for (col in 1:n_cols) {
    cell <- sprintf("%s%d", LETTERS[col], header_row)
    wb$add_cell_style(
      sheet = sheet_name,
      dims = cell,
      style = styles$col_header
    )
  }
  
  # Style data cells with alternating rows ----
  n_rows <- nrow(gt_data)
  data_start_row <- current_row + 1
  
  for (row in 1:n_rows) {
    actual_row <- data_start_row + row - 1
    
    # Choose style based on even/odd row
    if (style_config$alternating_rows$enabled && row %% 2 == 0) {
      cell_style <- styles$data_cell_alt
    } else {
      cell_style <- styles$data_cell
    }
    
    # Apply style to all cells in row
    for (col in 1:n_cols) {
      cell <- sprintf("%s%d", LETTERS[col], actual_row)
      wb$add_cell_style(
        sheet = sheet_name,
        dims = cell,
        style = cell_style
      )
    }
  }
  
  # Auto-size columns ----
  if (style_config$column_width$auto_size) {
    for (col in 1:n_cols) {
      wb$set_col_widths(
        sheet = sheet_name,
        cols = col,
        widths = "auto"
      )
    }
  }
  
  # Freeze panes ----
  if (freeze_rows > 0 || freeze_cols > 0) {
    freeze_row <- current_row + freeze_rows
    freeze_col <- freeze_cols + 1
    
    wb$freeze_pane(
      sheet = sheet_name,
      first_row = freeze_row,
      first_col = freeze_col
    )
  }
  
  # Create index sheet if this is the first data sheet ----
  sheet_names <- wb$get_sheet_names()
  data_sheets <- setdiff(sheet_names, style_config$index_sheet$name)
  
  if (create_index && length(data_sheets) > 0) {
    # Remove existing index if present
    if (style_config$index_sheet$name %in% sheet_names) {
      wb$remove_worksheet(style_config$index_sheet$name)
    }
    # Create new index with all data sheets
    wb <- create_index_sheet(wb, data_sheets, style_config)
  }
  
  # Save workbook ----
  wb$save(filename)
  
  message(sprintf("✓ Excel file saved: %s", filename))
  message(sprintf("  Sheet: %s", sheet_name))
  if (!is.null(heading)) {
    message(sprintf("  Heading: %s", heading))
  }
  message(sprintf("  Dimensions: %d rows × %d columns", n_rows, n_cols))
  
  invisible(wb)
}
