# ---- Excel Helper Functions for openxlsx2 ----

#' Create a styled workbook with standard formatting
#' 
#' @param theme Character, workbook theme name
#' @param base_font Character, default font family
#' @param base_size Numeric, default font size
#' @return wb object with standard styles applied
create_styled_workbook <- function(theme = NULL, 
                                   base_font = "Arial", 
                                   base_size = 11) {
  
  wb <- wb_workbook(theme = theme)
  
  # Set base font
  wb$set_base_font(
    font_name = base_font,
    font_size = base_size,
    font_color = wb_color("black")
  )
  
  # Add standard named styles
  
  # Header style
  wb$add_named_style(
    style_name = "header",
    font_color = wb_color("white"),
    font_size = base_size + 2,
    bg_fill = wb_color("#4472C4"),
    text_bold = TRUE,
    horizontal = "center",
    vertical = "middle"
  )
  
  # Subheader style  
  wb$add_named_style(
    style_name = "subheader",
    font_size = base_size + 1,
    bg_fill = wb_color("#D9E1F2"),
    text_bold = TRUE,
    horizontal = "center"
  )
  
  # Data style
  wb$add_named_style(
    style_name = "data",
    font_size = base_size,
    horizontal = "left",
    border = TRUE,
    border_style = "thin",
    border_color = wb_color("gray")
  )
  
  # Number style
  wb$add_named_style(
    style_name = "number",
    num_fmt = "#,##0.00",
    horizontal = "right"
  )
  
  # Currency style
  wb$add_named_style(
    style_name = "currency", 
    num_fmt = "$#,##0.00",
    horizontal = "right"
  )
  
  # Percentage style
  wb$add_named_style(
    style_name = "percentage",
    num_fmt = "0.00%",
    horizontal = "right" 
  )
  
  # Date style
  wb$add_named_style(
    style_name = "date",
    num_fmt = "yyyy-mm-dd",
    horizontal = "center"
  )
  
  return(wb)
}

#' Apply standard table formatting to a data range
#' 
#' @param wb Workbook object
#' @param sheet Sheet name or index
#' @param data Data frame to format
#' @param start_row Starting row (default 1)
#' @param start_col Starting column (default 1)
#' @param auto_width Logical, auto-size columns
#' @return wb object with formatted table
format_data_table <- function(wb, sheet, data, 
                             start_row = 1, start_col = 1,
                             auto_width = TRUE) {
  
  end_row <- start_row + nrow(data)
  end_col <- start_col + ncol(data) - 1
  
  # Header range
  header_range <- wb_dims(
    from_row = start_row, 
    to_row = start_row,
    from_col = start_col,
    to_col = end_col
  )
  
  # Data range (excluding headers)
  data_range <- wb_dims(
    from_row = start_row + 1,
    to_row = end_row, 
    from_col = start_col,
    to_col = end_col
  )
  
  # Apply header formatting
  wb$add_cell_style(dims = header_range, apply_style = "header")
  
  # Apply data formatting
  wb$add_cell_style(dims = data_range, apply_style = "data")
  
  # Format specific column types
  for (i in seq_len(ncol(data))) {
    col_idx <- start_col + i - 1
    col_range <- wb_dims(
      from_row = start_row + 1,
      to_row = end_row,
      from_col = col_idx, 
      to_col = col_idx
    )
    
    # Apply formatting based on column type
    if (is.numeric(data[[i]])) {
      wb$add_cell_style(dims = col_range, apply_style = "number")
    } else if (inherits(data[[i]], "Date")) {
      wb$add_cell_style(dims = col_range, apply_style = "date")
    }
  }
  
  # Auto-size columns if requested
  if (auto_width) {
    wb$set_col_widths(
      sheet = sheet,
      cols = start_col:end_col, 
      widths = "auto"
    )
  }
  
  # Add borders around entire table
  table_range <- wb_dims(
    from_row = start_row,
    to_row = end_row,
    from_col = start_col, 
    to_col = end_col
  )
  
  wb$add_border(
    dims = table_range,
    top_style = "medium",
    bottom_style = "medium", 
    left_style = "medium",
    right_style = "medium"
  )
  
  return(wb)
}

#' Create summary statistics table with formatting
#' 
#' @param data Data frame with numeric columns
#' @param stats Character vector of statistics to calculate
#' @return Formatted data frame ready for Excel
create_summary_table <- function(data, stats = c("mean", "median", "sd", "min", "max")) {
  
  numeric_cols <- sapply(data, is.numeric)
  numeric_data <- data[, numeric_cols, drop = FALSE]
  
  if (ncol(numeric_data) == 0) {
    stop("No numeric columns found in data")
  }
  
  summary_list <- list()
  
  for (stat in stats) {
    summary_list[[stat]] <- switch(stat,
      "mean" = sapply(numeric_data, mean, na.rm = TRUE),
      "median" = sapply(numeric_data, median, na.rm = TRUE), 
      "sd" = sapply(numeric_data, sd, na.rm = TRUE),
      "min" = sapply(numeric_data, min, na.rm = TRUE),
      "max" = sapply(numeric_data, max, na.rm = TRUE),
      "sum" = sapply(numeric_data, sum, na.rm = TRUE),
      "count" = sapply(numeric_data, function(x) sum(!is.na(x)))
    )
  }
  
  summary_df <- as.data.frame(summary_list)
  summary_df$Variable <- rownames(summary_df)
  summary_df <- summary_df[, c("Variable", stats)]
  
  return(summary_df)
}

#' Add conditional formatting for numeric ranges
#' 
#' @param wb Workbook object
#' @param sheet Sheet name or index  
#' @param dims Cell range to format
#' @param type Type of conditional formatting
#' @return wb object with conditional formatting applied
add_conditional_formatting_helper <- function(wb, sheet, dims, 
                                            type = c("data_bars", "color_scale", "icon_set")) {
  
  type <- match.arg(type)
  
  switch(type,
    "data_bars" = {
      wb$add_conditional_formatting(
        sheet = sheet,
        dims = dims,
        rule = "dataBar",
        style = create_dxfs_style(bg_fill = wb_color("#4472C4"))
      )
    },
    
    "color_scale" = {
      wb$add_conditional_formatting(
        sheet = sheet,
        dims = dims, 
        rule = "colorScale",
        style = c("#F8696B", "#FFEB84", "#63BE7B")  # Red-Yellow-Green
      )
    },
    
    "icon_set" = {
      wb$add_conditional_formatting(
        sheet = sheet,
        dims = dims,
        rule = "iconSet", 
        style = "3TrafficLights"
      )
    }
  )
  
  return(wb)
}

#' Create dashboard-style summary sheet
#' 
#' @param data_list Named list of data frames
#' @param title Character, dashboard title
#' @return Workbook object with dashboard layout
create_dashboard <- function(data_list, title = "Data Dashboard") {
  
  wb <- create_styled_workbook()
  wb$add_worksheet("Dashboard")
  
  # Add title
  wb$add_data(x = title, dims = "B2")
  wb$add_cell_style(
    dims = "B2",
    font_size = 18,
    text_bold = TRUE, 
    horizontal = "center"
  )
  wb$merge_cells(dims = "B2:F2")
  
  current_row <- 5
  
  # Add summary for each dataset
  for (name in names(data_list)) {
    data <- data_list[[name]]
    
    # Dataset title
    wb$add_data(x = paste("Dataset:", name), dims = paste0("B", current_row))
    wb$add_cell_style(
      dims = paste0("B", current_row),
      apply_style = "subheader"
    )
    
    current_row <- current_row + 2
    
    # Basic statistics
    stats_text <- sprintf(
      "Rows: %d | Columns: %d | Numeric Columns: %d",
      nrow(data),
      ncol(data), 
      sum(sapply(data, is.numeric))
    )
    
    wb$add_data(x = stats_text, dims = paste0("C", current_row))
    
    current_row <- current_row + 3
  }
  
  # Auto-size columns
  wb$set_col_widths(sheet = "Dashboard", cols = 1:6, widths = "auto")
  
  return(wb)
}

#' Export multiple data frames to separate sheets with consistent formatting
#' 
#' @param data_list Named list of data frames  
#' @param filename Output Excel filename
#' @param include_dashboard Logical, add dashboard summary sheet
#' @return NULL (saves file)
export_multi_sheet_workbook <- function(data_list, filename, include_dashboard = TRUE) {
  
  wb <- create_styled_workbook()
  
  # Add dashboard if requested
  if (include_dashboard) {
    dashboard_wb <- create_dashboard(data_list)
    # Copy dashboard sheet (simplified - in practice would merge workbooks)
  }
  
  # Add data sheets
  for (sheet_name in names(data_list)) {
    data <- data_list[[sheet_name]]
    
    wb$add_worksheet(sheet_name)
    wb$add_data(x = data, dims = "A1", with_filter = TRUE)
    
    # Apply formatting
    wb <- format_data_table(wb, sheet_name, data)
    
    # Add conditional formatting for numeric columns
    numeric_cols <- which(sapply(data, is.numeric))
    
    for (col_idx in numeric_cols) {
      col_range <- wb_dims(
        from_row = 2,
        to_row = nrow(data) + 1,
        from_col = col_idx,
        to_col = col_idx
      )
      
      wb <- add_conditional_formatting_helper(
        wb, sheet_name, col_range, "data_bars"
      )
    }
  }
  
  # Save workbook
  wb_save(wb, filename, overwrite = TRUE)
  
  message("Exported workbook to: ", filename)
  message("Sheets created: ", paste(names(data_list), collapse = ", "))
}