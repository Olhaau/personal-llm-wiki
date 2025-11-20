#' Create Simple, Excel-Compatible Accessible Tables
#'
#' This creates the most Excel-compatible version while maintaining accessibility
#' by avoiding problematic features that trigger Excel's recovery mode.

suppressPackageStartupMessages({
  library(openxlsx)
  library(dplyr)
})

# Source the fix function if available
if (file.exists("fix_gt_headers.R")) {
  source("fix_gt_headers.R")
}

#' Create Simple Excel-Compatible Accessible Table with Merged Cells
#' 
#' @param data Data frame to export
#' @param filename Output filename
#' @param title Table title
#' @param description Brief description
#' @param include_spanners Whether to create merged spanner cells
#' @return Path to created file
create_simple_excel_table <- function(data, 
                                    filename = "simple_accessible_table.xlsx",
                                    title = "Accessible Data Table",
                                    description = "Excel-compatible accessible table",
                                    include_spanners = TRUE) {
  
  cat(sprintf("Creating simple Excel-compatible table with GT formatting: %s\n", filename))
  
  # Create workbook
  wb <- createWorkbook()
  
  # Add main worksheet
  sheet_name <- "GT_Table"
  addWorksheet(wb, sheet_name)
  
  # Analyze column structure
  structure_info <- analyze_column_structure(data)
  
  current_row <- 1
  
  # Create GT-style layout with merged cells
  current_row <- create_gt_style_layout(wb, sheet_name, data, structure_info, title, current_row, include_spanners)
  
  # Add documentation sheet
  create_simple_docs_sheet(wb, data, title, description, names(data), structure_info$display_names)
  
  # Save with error handling
  tryCatch({
    saveWorkbook(wb, filename, overwrite = TRUE)
    cat(sprintf("✓ Simple Excel file with GT formatting created: %s\n", filename))
    
    # Quick validation
    test_sheets <- readxl::excel_sheets(filename)
    cat(sprintf("  Sheets: %s\n", paste(test_sheets, collapse = ", ")))
    
    return(invisible(filename))
    
  }, error = function(e) {
    cat(sprintf("✗ Error creating file: %s\n", e$message))
    stop(e)
  })
}

#' Analyze Column Structure for GT Layout
analyze_column_structure <- function(data) {
  col_names <- names(data)
  structure <- list()
  
  for (i in seq_along(col_names)) {
    name <- col_names[i]
    
    if (grepl("_", name)) {
      parts <- strsplit(name, "_", fixed = TRUE)[[1]]
      group <- tools::toTitleCase(parts[1])
      sub_col <- tools::toTitleCase(paste(parts[-1], collapse = " "))
      
      structure[[i]] <- list(
        original = name,
        group = group,
        sub_column = sub_col,
        has_spanner = TRUE,
        display_name = paste(group, "-", sub_col)
      )
    } else {
      display_name <- tools::toTitleCase(name)
      structure[[i]] <- list(
        original = name,
        group = NULL,
        sub_column = display_name,
        has_spanner = FALSE,
        display_name = display_name
      )
    }
  }
  
  return(list(
    columns = structure,
    has_spanners = any(sapply(structure, function(x) x$has_spanner)),
    num_cols = length(col_names),
    display_names = sapply(structure, function(x) x$display_name)
  ))
}

#' Create GT-Style Layout with Merged Cells
create_gt_style_layout <- function(wb, sheet_name, data, structure, title, start_row, include_spanners) {
  
  # Define GT-compatible styles
  title_style <- createStyle(
    fontSize = 14, fontName = "Calibri", textDecoration = "bold",
    halign = "center", valign = "center",
    fgFill = "#366092", fontColour = "#FFFFFF",
    border = c("top", "bottom", "left", "right"), borderStyle = "medium"
  )
  
  spanner_style <- createStyle(
    fontSize = 12, fontName = "Calibri", textDecoration = "bold", 
    halign = "center", valign = "center",
    fgFill = "#4F81BD", fontColour = "#FFFFFF",
    border = c("top", "bottom", "left", "right"), borderStyle = "medium"
  )
  
  header_style <- createStyle(
    fontSize = 11, fontName = "Calibri", textDecoration = "bold",
    halign = "center", valign = "center", 
    fgFill = "#B7D4F0", fontColour = "#000000",
    border = c("top", "bottom", "left", "right"), borderStyle = "thin"
  )
  
  data_style <- createStyle(
    fontSize = 10, fontName = "Calibri",
    halign = "center", valign = "center",
    border = c("top", "bottom", "left", "right"), borderStyle = "thin"
  )
  
  current_row <- start_row
  
  # Add title with merge
  writeData(wb, sheet_name, title, startRow = current_row, startCol = 1)
  mergeCells(wb, sheet_name, cols = 1:structure$num_cols, rows = current_row)
  addStyle(wb, sheet_name, title_style, rows = current_row, cols = 1:structure$num_cols)
  current_row <- current_row + 2
  
  # Create spanner headers if requested and present
  if (include_spanners && structure$has_spanners) {
    # Create spanner row
    spanner_row <- create_simple_spanner_row(structure)
    writeData(wb, sheet_name, t(spanner_row), startRow = current_row, startCol = 1, colNames = FALSE)
    addStyle(wb, sheet_name, spanner_style, rows = current_row, cols = 1:structure$num_cols)
    
    # Apply spanner merges
    apply_simple_spanner_merges(wb, sheet_name, structure, current_row)
    current_row <- current_row + 1
    
    # Sub-headers
    sub_headers <- sapply(structure$columns, function(x) x$sub_column)
    writeData(wb, sheet_name, t(sub_headers), startRow = current_row, startCol = 1, colNames = FALSE)
    addStyle(wb, sheet_name, header_style, rows = current_row, cols = 1:structure$num_cols)
    current_row <- current_row + 2
  } else {
    # Simple headers (no spanners)
    headers <- structure$display_names
    writeData(wb, sheet_name, t(headers), startRow = current_row, startCol = 1, colNames = FALSE)
    addStyle(wb, sheet_name, header_style, rows = current_row, cols = 1:structure$num_cols)
    current_row <- current_row + 2
  }
  
  # Add data
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
  
  return(current_row + nrow(data))
}

#' Create Simple Spanner Row
create_simple_spanner_row <- function(structure) {
  spanner_row <- character(structure$num_cols)
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

#' Apply Simple Spanner Merges
apply_simple_spanner_merges <- function(wb, sheet_name, structure, row) {
  # Track spanner groups
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
  
  # Apply merges safely
  for (group_name in names(groups)) {
    range <- groups[[group_name]]
    if (range[2] > range[1]) {
      tryCatch({
        mergeCells(wb, sheet_name, cols = range[1]:range[2], rows = row)
      }, error = function(e) {
        cat(sprintf("Note: Spanner merge skipped for '%s'\n", group_name))
      })
    }
  }
}

#' Create Clean Column Names
create_clean_column_names <- function(col_names) {
  clean_names <- character(length(col_names))
  
  for (i in seq_along(col_names)) {
    name <- col_names[i]
    
    # Check if it has spanner structure
    if (grepl("_", name)) {
      parts <- strsplit(name, "_", fixed = TRUE)[[1]]
      group <- parts[1]
      sub_col <- paste(parts[-1], collapse = " ")
      
      # Create readable name
      clean_names[i] <- paste(tools::toTitleCase(group), "-", tools::toTitleCase(sub_col))
    } else {
      clean_names[i] <- tools::toTitleCase(name)
    }
  }
  
  return(clean_names)
}

#' Apply Safe Formatting
apply_safe_formatting <- function(wb, sheet_name, num_cols, header_row) {
  
  # Safe title style
  title_style <- createStyle(
    fontSize = 14, 
    textDecoration = "bold",
    fgFill = "#4472C4", 
    fontColour = "#FFFFFF"
  )
  
  # Safe header style  
  header_style <- createStyle(
    fontSize = 11,
    textDecoration = "bold", 
    fgFill = "#D9E2F3"
  )
  
  # Apply title formatting (single cell only)
  addStyle(wb, sheet_name, title_style, rows = 1, cols = 1)
  
  # Apply header formatting
  addStyle(wb, sheet_name, header_style, rows = header_row, cols = 1:num_cols)
  
  # Set reasonable column widths
  setColWidths(wb, sheet_name, cols = 1:num_cols, widths = "auto")
  
  # Freeze header row
  freezePane(wb, sheet_name, firstActiveRow = header_row + 1, firstActiveCol = 1)
}

#' Create Simple Documentation Sheet
create_simple_docs_sheet <- function(wb, data, title, description, original_names, clean_names) {
  
  sheet_name <- "Info"
  addWorksheet(wb, sheet_name)
  
  # Table info
  info_data <- data.frame(
    Property = c("Title", "Description", "Rows", "Columns", "Created"),
    Value = c(
      title,
      description,
      nrow(data),
      ncol(data),
      format(Sys.Date(), "%Y-%m-%d")
    ),
    stringsAsFactors = FALSE
  )
  
  writeData(wb, sheet_name, info_data, startRow = 1, startCol = 1)
  
  # Column mapping
  if (length(original_names) <= 50) {  # Only for reasonable number of columns
    writeData(wb, sheet_name, "Column Name Mapping:", startRow = nrow(info_data) + 3, startCol = 1)
    
    mapping_data <- data.frame(
      Original = original_names,
      Display = clean_names,
      stringsAsFactors = FALSE
    )
    
    writeData(wb, sheet_name, mapping_data, startRow = nrow(info_data) + 4, startCol = 1)
  }
  
  # Set column widths
  setColWidths(wb, sheet_name, cols = 1:2, widths = c(15, 50))
}

#' Quick Fix for Existing German Data
fix_mikrozensus_simple <- function() {
  cat("Creating simple, Excel-compatible version of German Mikrozensus data...\n")
  
  # Load the German data if available
  if (file.exists("gt-issue.R")) {
    source("gt-issue.R")
    
    if (exists("df")) {
      create_simple_excel_table(
        data = df,
        filename = "mikrozensus_simple_excel.xlsx",
        title = "German Mikrozensus 2023 - Simple Format",
        description = "German census data in simple Excel-compatible format for maximum compatibility"
      )
      
      cat("✓ Simple version created: mikrozensus_simple_excel.xlsx\n")
    } else {
      cat("✗ German data not found\n")
    }
  } else {
    cat("✗ gt-issue.R not found\n")
  }
}

#' Create Multiple Compatibility Versions
create_compatibility_versions <- function() {
  cat("Creating multiple versions for different Excel compatibility levels...\n")
  
  if (file.exists("gt-issue.R")) {
    source("gt-issue.R")
    
    if (exists("df")) {
      # Version 1: Ultra-simple (maximum compatibility)
      cat("\n1. Creating ultra-simple version...\n")
      create_simple_excel_table(
        data = df,
        filename = "mikrozensus_ultra_simple.xlsx",
        title = "German Mikrozensus - Ultra Simple",
        description = "Maximum Excel compatibility version"
      )
      
      # Version 2: Formatted but safe
      cat("\n2. Creating formatted but safe version...\n")
      wb_safe <- createWorkbook()
      addWorksheet(wb_safe, "Data")
      
      # Just write data with minimal formatting
      writeData(wb_safe, "Data", df, startRow = 3, startCol = 1)
      writeData(wb_safe, "Data", "German Mikrozensus 2023", startRow = 1, startCol = 1)
      
      # Only basic header formatting
      header_style <- createStyle(textDecoration = "bold", fgFill = "#E7E6E6")
      addStyle(wb_safe, "Data", header_style, rows = 3, cols = 1:ncol(df))
      
      saveWorkbook(wb_safe, "mikrozensus_safe_format.xlsx", overwrite = TRUE)
      cat("✓ Safe formatted version created: mikrozensus_safe_format.xlsx\n")
      
      # Version 3: CSV fallback
      cat("\n3. Creating CSV fallback...\n")
      write.csv(df, "mikrozensus_data.csv", row.names = FALSE, fileEncoding = "UTF-8")
      cat("✓ CSV fallback created: mikrozensus_data.csv\n")
      
      cat("\n=== Summary ===\n")
      cat("Created 3 versions:\n")
      cat("• mikrozensus_ultra_simple.xlsx - Maximum compatibility\n")
      cat("• mikrozensus_safe_format.xlsx - Minimal formatting\n") 
      cat("• mikrozensus_data.csv - Universal CSV format\n")
      
    }
  }
}