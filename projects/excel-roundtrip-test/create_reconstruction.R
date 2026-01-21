# ---- Excel Reconstruction Engine ----
# Reconstructs Excel files from JSON specifications

library(openxlsx2)
library(jsonlite)

# Source excel-operations skill
source("../../.opencode/skills/excel-operations/code/excel_helpers.R")

#' Reconstruct Excel workbook from JSON specifications
#' 
#' @param json_file Path to JSON specifications file
#' @return Workbook object
reconstruct_excel_from_json <- function(json_file) {
  
  # Load specifications
  specs <- read_json(json_file)
  
  return(reconstruct_excel_from_json_specs(specs))
}

#' Reconstruct Excel workbook from loaded JSON specifications
#' 
#' @param specs List with Excel specifications
#' @return Workbook object
reconstruct_excel_from_json_specs <- function(specs) {
  
  cat("Reconstructing Excel workbook from specifications...\n")
  
  # Create base workbook
  wb <- wb_workbook()
  
  # Set workbook properties if available
  if (!is.null(specs$workbook$properties)) {
    props <- specs$workbook$properties
    
    if (!is.null(props$title) && props$title != "") {
      wb$set_properties(title = props$title)
    }
    if (!is.null(props$creator) && props$creator != "") {
      wb$set_properties(creator = props$creator)
    }
    if (!is.null(props$subject) && props$subject != "") {
      wb$set_properties(subject = props$subject)
    }
  }
  
  # Reconstruct each worksheet
  if (!is.null(specs$worksheets)) {
    for (sheet_name in names(specs$worksheets)) {
      sheet_specs <- specs$worksheets[[sheet_name]]
      reconstruct_worksheet(wb, sheet_name, sheet_specs)
    }
  }
  
  return(wb)
}

#' Reconstruct individual worksheet from specifications
#' 
#' @param wb Workbook object
#' @param sheet_name Name of sheet to create
#' @param sheet_specs Sheet specifications
reconstruct_worksheet <- function(wb, sheet_name, sheet_specs) {
  
  cat(sprintf("  Reconstructing sheet: %s\n", sheet_name))
  
  # Add worksheet
  wb$add_worksheet(sheet_name)
  
  # Set sheet properties if available
  if (!is.null(sheet_specs$properties)) {
    props <- sheet_specs$properties
    
    # Set tab color if specified
    if (!is.null(props$tab_color) && props$tab_color != "") {
      # wb$set_sheet_tab_color(sheet_name, props$tab_color)  # If available
    }
    
    # Set zoom if specified
    if (!is.null(props$zoom) && is.numeric(props$zoom)) {
      # wb$set_sheet_zoom(sheet_name, props$zoom)  # If available
    }
  }
  
  # Reconstruct content layers
  if (!is.null(sheet_specs$content_layers)) {
    reconstruct_content_layers(wb, sheet_name, sheet_specs$content_layers)
  } else if (!is.null(sheet_specs$cells)) {
    # Fallback to old cell structure
    reconstruct_cells_legacy(wb, sheet_name, sheet_specs$cells)
  }
  
  # Reconstruct formatting layers
  if (!is.null(sheet_specs$formatting_layers)) {
    reconstruct_formatting_layers(wb, sheet_name, sheet_specs$formatting_layers)
  } else if (!is.null(sheet_specs$formatting)) {
    # Fallback to old formatting structure
    reconstruct_formatting_legacy(wb, sheet_name, sheet_specs$formatting)
  }
  
  # Reconstruct advanced features
  if (!is.null(sheet_specs$advanced_features)) {
    reconstruct_advanced_features(wb, sheet_name, sheet_specs$advanced_features)
  }
  
  # Set column widths based on coordinate grid
  if (!is.null(sheet_specs$coordinate_grid$column_definitions)) {
    reconstruct_column_widths(wb, sheet_name, sheet_specs$coordinate_grid$column_definitions)
  }
  
  # Set row heights based on coordinate grid
  if (!is.null(sheet_specs$coordinate_grid$row_definitions)) {
    reconstruct_row_heights(wb, sheet_name, sheet_specs$coordinate_grid$row_definitions)
  }
}

#' Reconstruct content layers using coordinate system
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param content_layers Content layer specifications
reconstruct_content_layers <- function(wb, sheet_name, content_layers) {
  
  # Reconstruct cell values
  if (!is.null(content_layers$cell_values)) {
    for (cell_ref in names(content_layers$cell_values)) {
      cell_data <- content_layers$cell_values[[cell_ref]]
      
      # Add cell value
      wb$add_data(
        sheet = sheet_name,
        x = cell_data$value,
        dims = cell_ref
      )
    }
  }
  
  # Reconstruct formulas
  if (!is.null(content_layers$formulas)) {
    for (cell_ref in names(content_layers$formulas)) {
      formula_data <- content_layers$formulas[[cell_ref]]
      
      # Add formula
      wb$add_formula(
        sheet = sheet_name,
        x = formula_data$formula,
        dims = cell_ref
      )
    }
  }
  
  # Reconstruct comments
  if (!is.null(content_layers$comments)) {
    for (cell_ref in names(content_layers$comments)) {
      comment_data <- content_layers$comments[[cell_ref]]
      
      # Add comment
      wb$add_comment(
        sheet = sheet_name,
        dims = cell_ref,
        comment = comment_data$text,
        author = comment_data$author %||% "Unknown"
      )
    }
  }
  
  # Reconstruct hyperlinks
  if (!is.null(content_layers$hyperlinks)) {
    for (cell_ref in names(content_layers$hyperlinks)) {
      hyperlink_data <- content_layers$hyperlinks[[cell_ref]]
      
      # Add hyperlink
      wb$add_hyperlink(
        sheet = sheet_name,
        dims = cell_ref,
        target = hyperlink_data$target,
        display = hyperlink_data$display_text %||% hyperlink_data$target
      )
    }
  }
}

#' Reconstruct formatting layers with blocks and overlays
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name  
#' @param formatting_layers Formatting layer specifications
reconstruct_formatting_layers <- function(wb, sheet_name, formatting_layers) {
  
  # Apply base formatting
  if (!is.null(formatting_layers$base_formatting)) {
    # This would set sheet-level defaults
    # Implementation depends on openxlsx2 capabilities
  }
  
  # Apply formatting blocks (in priority order)
  if (!is.null(formatting_layers$block_formatting)) {
    # Sort blocks by priority
    blocks <- formatting_layers$block_formatting
    if (length(blocks) > 0) {
      # Sort by priority if available
      for (block in blocks) {
        apply_formatting_block(wb, sheet_name, block)
      }
    }
  }
  
  # Apply overlay formatting (in priority order)
  if (!is.null(formatting_layers$overlay_formatting)) {
    overlays <- formatting_layers$overlay_formatting
    if (length(overlays) > 0) {
      for (overlay in overlays) {
        apply_formatting_overlay(wb, sheet_name, overlay)
      }
    }
  }
  
  # Apply conditional formatting
  if (!is.null(formatting_layers$conditional_formatting)) {
    cf_rules <- formatting_layers$conditional_formatting
    if (length(cf_rules) > 0) {
      for (rule in cf_rules) {
        apply_conditional_formatting_rule(wb, sheet_name, rule)
      }
    }
  }
}

#' Apply formatting block to worksheet
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param block Formatting block specification
apply_formatting_block <- function(wb, sheet_name, block) {
  
  # Get range for this block
  if (!is.null(block$coordinates$range_address)) {
    range <- block$coordinates$range_address
  } else if (!is.null(block$coordinates$start) && !is.null(block$coordinates$end)) {
    range <- paste0(block$coordinates$start$address, ":", block$coordinates$end$address)
  } else {
    return()  # Cannot determine range
  }
  
  formatting <- block$formatting
  
  # Apply font formatting
  if (!is.null(formatting$font)) {
    font_props <- formatting$font
    wb$add_font(
      sheet = sheet_name,
      dims = range,
      bold = font_props$bold %||% FALSE,
      italic = font_props$italic %||% FALSE,
      size = font_props$size %||% 11,
      color = wb_color(font_props$color %||% "#000000"),
      name = font_props$name %||% "Calibri"
    )
  }
  
  # Apply fill formatting
  if (!is.null(formatting$fill)) {
    fill_props <- formatting$fill
    if (fill_props$type == "solid" && !is.null(fill_props$color)) {
      wb$add_fill(
        sheet = sheet_name,
        dims = range,
        color = wb_color(fill_props$color)
      )
    }
  }
  
  # Apply border formatting
  if (!is.null(formatting$borders)) {
    border_props <- formatting$borders
    if (!is.null(border_props$all)) {
      wb$add_border(
        sheet = sheet_name,
        dims = range,
        top_style = border_props$all$style %||% "thin",
        bottom_style = border_props$all$style %||% "thin",
        left_style = border_props$all$style %||% "thin",
        right_style = border_props$all$style %||% "thin",
        top_color = wb_color(border_props$all$color %||% "#000000"),
        bottom_color = wb_color(border_props$all$color %||% "#000000"),
        left_color = wb_color(border_props$all$color %||% "#000000"),
        right_color = wb_color(border_props$all$color %||% "#000000")
      )
    }
  }
  
  # Apply alignment
  if (!is.null(formatting$alignment)) {
    align_props <- formatting$alignment
    wb$add_cell_style(
      sheet = sheet_name,
      dims = range,
      horizontal = align_props$horizontal %||% "general",
      vertical = align_props$vertical %||% "bottom",
      wrap_text = align_props$wrap_text %||% FALSE
    )
  }
  
  # Apply number formatting
  if (!is.null(formatting$number_format)) {
    wb$add_numfmt(
      sheet = sheet_name,
      dims = range,
      numfmt = formatting$number_format
    )
  }
}

#' Apply formatting overlay to worksheet
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param overlay Formatting overlay specification
apply_formatting_overlay <- function(wb, sheet_name, overlay) {
  
  # Get range for this overlay
  if (!is.null(overlay$coordinates$range_address)) {
    range <- overlay$coordinates$range_address
  } else {
    return()  # Cannot determine range
  }
  
  # Apply overlay formatting based on type
  if (overlay$overlay_type == "conditional") {
    # This would be handled by conditional formatting rules
    return()
  }
  
  # Apply overlay formatting (similar to block formatting)
  formatting <- overlay$formatting
  
  # Use blend mode to determine how to apply formatting
  blend_mode <- overlay$blend_mode %||% "override"
  
  # For now, treat as override (same as block formatting)
  apply_formatting_block(wb, sheet_name, list(
    coordinates = overlay$coordinates,
    formatting = formatting
  ))
}

#' Apply conditional formatting rule
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param rule Conditional formatting rule
apply_conditional_formatting_rule <- function(wb, sheet_name, rule) {
  
  # This would implement conditional formatting reconstruction
  # Based on the rule structure from the JSON
  
  # Placeholder implementation
  if (!is.null(rule$range) && !is.null(rule$condition)) {
    # wb$add_conditional_formatting(...)
  }
}

#' Reconstruct advanced features
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param advanced_features Advanced feature specifications
reconstruct_advanced_features <- function(wb, sheet_name, advanced_features) {
  
  # Reconstruct charts
  if (!is.null(advanced_features$charts) && length(advanced_features$charts) > 0) {
    for (chart in advanced_features$charts) {
      # Chart reconstruction would be complex
      # Placeholder for now
    }
  }
  
  # Reconstruct data validation
  if (!is.null(advanced_features$data_validation) && length(advanced_features$data_validation) > 0) {
    for (validation in advanced_features$data_validation) {
      # Add data validation
      # wb$add_data_validation(...)
    }
  }
  
  # Reconstruct merged cells
  if (!is.null(advanced_features$merged_cells) && length(advanced_features$merged_cells) > 0) {
    for (merge in advanced_features$merged_cells) {
      if (!is.null(merge$range)) {
        wb$merge_cells(
          sheet = sheet_name,
          dims = merge$range
        )
      }
    }
  }
}

#' Reconstruct column widths from coordinate grid
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param column_definitions Column definition specifications
reconstruct_column_widths <- function(wb, sheet_name, column_definitions) {
  
  for (col_letter in names(column_definitions)) {
    col_def <- column_definitions[[col_letter]]
    
    if (!is.null(col_def$width) && col_def$width != "auto") {
      wb$set_col_widths(
        sheet = sheet_name,
        cols = col_def$column_number,
        widths = as.numeric(col_def$width)
      )
    }
  }
}

#' Reconstruct row heights from coordinate grid
#' 
#' @param wb Workbook object  
#' @param sheet_name Sheet name
#' @param row_definitions Row definition specifications
reconstruct_row_heights <- function(wb, sheet_name, row_definitions) {
  
  for (row_num in names(row_definitions)) {
    row_def <- row_definitions[[row_num]]
    
    if (!is.null(row_def$height) && row_def$height != "auto") {
      wb$set_row_heights(
        sheet = sheet_name,
        rows = as.numeric(row_num),
        heights = as.numeric(row_def$height)
      )
    }
  }
}

# ---- Legacy Support Functions ----

#' Reconstruct cells from legacy cell structure
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param cells Legacy cells specifications
reconstruct_cells_legacy <- function(wb, sheet_name, cells) {
  
  # Convert legacy cell structure to data
  if (length(cells) > 0) {
    for (cell_ref in names(cells)) {
      cell_data <- cells[[cell_ref]]
      
      # Add cell value
      if (!is.null(cell_data$value)) {
        wb$add_data(
          sheet = sheet_name,
          x = cell_data$value,
          dims = cell_ref
        )
      }
      
      # Add formula if present
      if (!is.null(cell_data$formula)) {
        wb$add_formula(
          sheet = sheet_name,
          x = cell_data$formula,
          dims = cell_ref
        )
      }
    }
  }
}

#' Reconstruct formatting from legacy formatting structure
#' 
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param formatting Legacy formatting specifications
reconstruct_formatting_legacy <- function(wb, sheet_name, formatting) {
  
  # This would handle the old formatting structure
  # Implementation would depend on the legacy format
}

#' Null-default operator
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}