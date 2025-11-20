#' Fix Excel Compatibility Issues
#' 
#' This script creates a more Excel-compatible version of the accessible tables
#' by simplifying formatting and avoiding problematic features.

suppressPackageStartupMessages({
  library(openxlsx)
  library(dplyr)
})

# Source dependencies
source("fix_gt_headers.R")

#' Create Excel-Compatible Accessible Table
#' 
#' Simplified version that prioritizes Excel compatibility while maintaining accessibility
create_excel_compatible_table <- function(data,
                                        filename = "excel_compatible_table.xlsx",
                                        title = "Accessible Data Table",
                                        subtitle = NULL,
                                        description = "Excel-compatible accessible table",
                                        spanner_delimiter = "_") {
  
  cat(sprintf("Creating Excel-compatible accessible table: %s\n", filename))
  
  # Analyze structure
  structure_info <- analyze_simple_structure(data, spanner_delimiter)
  
  # Create workbook with minimal formatting
  wb <- createWorkbook()
  
  # Create main worksheet with simple formatting
  create_compatible_main_worksheet(wb, data, structure_info, title, subtitle)
  
  # Create accessible data worksheet
  create_simple_accessible_worksheet(wb, data, structure_info)
  
  # Create documentation
  create_simple_documentation_worksheet(wb, data, title, description)
  
  # Save with error handling
  tryCatch({
    saveWorkbook(wb, filename, overwrite = TRUE)
    cat(sprintf("✓ Excel-compatible file created: %s\n", filename))
    
    # Validate the file
    validate_excel_file(filename)
    
  }, error = function(e) {
    cat(sprintf("✗ Error creating file: %s\n", e$message))
    stop(e)
  })
  
  return(invisible(filename))
}

#' Analyze Structure (Simplified)
analyze_simple_structure <- function(data, delimiter = "_") {
  col_names <- names(data)
  structure <- list()
  
  for (i in seq_along(col_names)) {
    name <- col_names[i]
    
    if (grepl(delimiter, name, fixed = TRUE)) {
      parts <- strsplit(name, delimiter, fixed = TRUE)[[1]]
      group <- parts[1]
      sub_col <- paste(parts[-1], collapse = " ")
      
      structure[[i]] <- list(
        original = name,
        group = group,
        sub_column = sub_col,
        has_spanner = TRUE,
        display_name = paste(group, "-", sub_col)
      )
    } else {
      structure[[i]] <- list(
        original = name,
        group = NULL,
        sub_column = name,
        has_spanner = FALSE,
        display_name = name
      )
    }
  }
  
  return(list(
    columns = structure,
    has_spanners = any(sapply(structure, function(x) x$has_spanner)),
    num_cols = length(col_names),
    num_rows = nrow(data)
  ))
}

#' Create Compatible Main Worksheet with Proper Merged Cells
create_compatible_main_worksheet <- function(wb, data, structure, title, subtitle = NULL) {
  
  sheet_name <- "Main_Table"
  addWorksheet(wb, sheet_name)
  
  # Safe styles for Excel compatibility
  title_style <- createStyle(
    fontSize = 14, fontName = "Calibri", textDecoration = "bold",
    halign = "center", fgFill = "#366092", fontColour = "#FFFFFF",
    border = c("top", "bottom", "left", "right"), borderStyle = "medium"
  )
  
  spanner_style <- createStyle(
    fontSize = 12, fontName = "Calibri", textDecoration = "bold",
    halign = "center", fgFill = "#4F81BD", fontColour = "#FFFFFF",
    border = c("top", "bottom", "left", "right"), borderStyle = "medium"
  )
  
  header_style <- createStyle(
    fontSize = 11, fontName = "Calibri", textDecoration = "bold",
    halign = "center", fgFill = "#B7D4F0", fontColour = "#000000",
    border = c("top", "bottom", "left", "right"), borderStyle = "thin"
  )
  
  data_style <- createStyle(
    fontSize = 10, fontName = "Calibri",
    halign = "center", border = c("top", "bottom", "left", "right"), borderStyle = "thin"
  )
  
  current_row <- 1
  
  # Add title with merge
  writeData(wb, sheet_name, title, startRow = current_row, startCol = 1)
  mergeCells(wb, sheet_name, cols = 1:structure$num_cols, rows = current_row)
  addStyle(wb, sheet_name, title_style, rows = current_row, cols = 1:structure$num_cols)
  
  current_row <- current_row + 2
  
  # Add subtitle if provided
  if (!is.null(subtitle)) {
    writeData(wb, sheet_name, subtitle, startRow = current_row, startCol = 1)
    mergeCells(wb, sheet_name, cols = 1:structure$num_cols, rows = current_row)
    current_row <- current_row + 2
  }
  
  # Create headers with proper spanners and merging
  if (structure$has_spanners) {
    # Create spanner row with proper merging
    spanner_row <- create_spanner_row_safe(structure, structure$num_cols)
    writeData(wb, sheet_name, t(spanner_row), startRow = current_row, startCol = 1, colNames = FALSE)
    addStyle(wb, sheet_name, spanner_style, rows = current_row, cols = 1:structure$num_cols)
    
    # Apply safe spanner merges
    apply_safe_spanner_merges(wb, sheet_name, structure, current_row)
    current_row <- current_row + 1
    
    # Sub-headers
    sub_headers <- sapply(structure$columns, function(x) x$sub_column)
    writeData(wb, sheet_name, t(sub_headers), startRow = current_row, startCol = 1, colNames = FALSE)
    addStyle(wb, sheet_name, header_style, rows = current_row, cols = 1:structure$num_cols)
    current_row <- current_row + 1
  } else {
    # Simple headers
    headers <- sapply(structure$columns, function(x) x$display_name)
    writeData(wb, sheet_name, t(headers), startRow = current_row, startCol = 1, colNames = FALSE)
    addStyle(wb, sheet_name, header_style, rows = current_row, cols = 1:structure$num_cols)
    current_row <- current_row + 1
  }
  
  # Add spacer row
  current_row <- current_row + 1
  
  # Add data with formatting
  writeData(wb, sheet_name, data, startRow = current_row, startCol = 1, colNames = FALSE)
  
  # Apply data formatting
  if (nrow(data) > 0) {
    addStyle(wb, sheet_name, data_style, 
             rows = current_row:(current_row + nrow(data) - 1), 
             cols = 1:structure$num_cols, gridExpand = TRUE)
  }
  
  # Set column widths
  setColWidths(wb, sheet_name, cols = 1:structure$num_cols, widths = "auto")
  
  # Freeze header row
  freezePane(wb, sheet_name, firstActiveRow = current_row, firstActiveCol = 1)
}

#' Create Spanner Row (Safe Version)
create_spanner_row_safe <- function(structure, num_cols) {
  spanner_row <- character(num_cols)
  current_group <- ""
  
  for (i in seq_along(structure$columns)) {
    col_info <- structure$columns[[i]]
    if (col_info$has_spanner) {
      if (col_info$group != current_group) {
        spanner_row[i] <- col_info$group
        current_group <- col_info$group
      } else {
        spanner_row[i] <- ""
      }
    } else {
      spanner_row[i] <- ""
      current_group <- ""
    }
  }
  
  return(spanner_row)
}

#' Apply Safe Spanner Merges
apply_safe_spanner_merges <- function(wb, sheet_name, structure, row) {
  # Track spanner groups for safe merging
  groups <- list()
  
  for (i in seq_along(structure$columns)) {
    col_info <- structure$columns[[i]]
    if (col_info$has_spanner) {
      group_name <- col_info$group
      if (!group_name %in% names(groups)) {
        groups[[group_name]] <- c(i, i)
      } else {
        groups[[group_name]][2] <- i
      }
    }
  }
  
  # Apply merges for each group (with error handling)
  for (group_name in names(groups)) {
    range <- groups[[group_name]]
    if (range[2] > range[1]) {  # Only merge if span > 1
      tryCatch({
        mergeCells(wb, sheet_name, cols = range[1]:range[2], rows = row)
      }, error = function(e) {
        cat(sprintf("Warning: Could not merge spanner '%s': %s\n", group_name, e$message))
      })
    }
  }
}

#' Create Simple Accessible Worksheet
create_simple_accessible_worksheet <- function(wb, data, structure) {
  
  sheet_name <- "Accessible_Data"
  addWorksheet(wb, sheet_name)
  
  # Create clear column names
  accessible_data <- data
  new_names <- sapply(structure$columns, function(x) x$display_name)
  names(accessible_data) <- new_names
  
  # Write data
  writeData(wb, sheet_name, accessible_data, startRow = 1, startCol = 1)
  
  # Simple header formatting
  header_style <- createStyle(
    fontSize = 11, fontName = "Calibri", textDecoration = "bold",
    fgFill = "#F2F2F2"
  )
  
  addStyle(wb, sheet_name, header_style, rows = 1, cols = 1:ncol(accessible_data))
  setColWidths(wb, sheet_name, cols = 1:ncol(accessible_data), widths = "auto")
}

#' Create Simple Documentation
create_simple_documentation_worksheet <- function(wb, data, title, description) {
  
  sheet_name <- "Documentation"
  addWorksheet(wb, sheet_name)
  
  doc_data <- data.frame(
    Item = c("Title", "Description", "Rows", "Columns", "Created", "Format"),
    Value = c(
      title,
      description,
      as.character(nrow(data)),
      as.character(ncol(data)),
      format(Sys.time(), "%Y-%m-%d %H:%M"),
      "Excel-compatible accessible format"
    ),
    stringsAsFactors = FALSE
  )
  
  writeData(wb, sheet_name, doc_data, startRow = 1, startCol = 1)
  setColWidths(wb, sheet_name, cols = 1:2, widths = c(15, 50))
}

#' Validate Excel File
validate_excel_file <- function(filename) {
  tryCatch({
    # Test if file can be opened
    sheets <- readxl::excel_sheets(filename)
    cat(sprintf("✓ File validation passed: %d worksheets found\n", length(sheets)))
    
    # Test reading main data
    test_data <- readxl::read_excel(filename, sheet = sheets[1], n_max = 5)
    cat(sprintf("✓ Data readable: %d rows sampled successfully\n", nrow(test_data)))
    
    return(TRUE)
    
  }, error = function(e) {
    cat(sprintf("✗ File validation failed: %s\n", e$message))
    return(FALSE)
  })
}

#' Fix Existing Problematic File
fix_demo_mikrozensus <- function() {
  cat("Creating fixed version of demo_mikrozensus_accessible.xlsx...\n")
  
  # Load the German data
  if (file.exists("gt-issue.R")) {
    source("gt-issue.R")
    
    if (exists("df")) {
      create_excel_compatible_table(
        data = df,
        filename = "demo_mikrozensus_accessible_fixed.xlsx",
        title = "German Mikrozensus 2023 - Excel Compatible",
        subtitle = "Fixed version for Excel compatibility",
        description = "German micro census data with Excel-compatible formatting and accessibility features"
      )
    }
  }
}