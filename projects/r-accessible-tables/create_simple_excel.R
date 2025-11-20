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

#' Create Simple Excel-Compatible Accessible Table
#' 
#' @param data Data frame to export
#' @param filename Output filename
#' @param title Table title
#' @param description Brief description
#' @return Path to created file
create_simple_excel_table <- function(data, 
                                    filename = "simple_accessible_table.xlsx",
                                    title = "Accessible Data Table",
                                    description = "Excel-compatible accessible table") {
  
  cat(sprintf("Creating simple Excel-compatible table: %s\n", filename))
  
  # Create workbook
  wb <- createWorkbook()
  
  # Add main worksheet
  sheet_name <- "Data"
  addWorksheet(wb, sheet_name)
  
  # Analyze column structure
  col_names <- names(data)
  has_spanners <- any(grepl("_", col_names))
  
  # Create clean, readable column names
  clean_names <- create_clean_column_names(col_names)
  
  current_row <- 1
  
  # Add title (simple, no merge)
  writeData(wb, sheet_name, title, startRow = current_row, startCol = 1)
  current_row <- current_row + 2
  
  # Add headers with clean names
  data_with_clean_names <- data
  names(data_with_clean_names) <- clean_names
  
  writeData(wb, sheet_name, data_with_clean_names, startRow = current_row, startCol = 1)
  
  # Apply minimal, safe formatting
  apply_safe_formatting(wb, sheet_name, length(clean_names), current_row)
  
  # Add documentation sheet
  create_simple_docs_sheet(wb, data, title, description, col_names, clean_names)
  
  # Save with error handling
  tryCatch({
    saveWorkbook(wb, filename, overwrite = TRUE)
    cat(sprintf("✓ Simple Excel file created: %s\n", filename))
    
    # Quick validation
    test_sheets <- readxl::excel_sheets(filename)
    cat(sprintf("  Sheets: %s\n", paste(test_sheets, collapse = ", ")))
    
    return(invisible(filename))
    
  }, error = function(e) {
    cat(sprintf("✗ Error creating file: %s\n", e$message))
    stop(e)
  })
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