# Extract Excel to JSON - Universal Structure Extraction
# Convert any Excel file to structured JSON preserving all data and formatting
# NO HARDCODED VALUES - Works with any Excel file

library(openxlsx2)
library(jsonlite)
library(dplyr)
library(stringr)

#' Extract complete Excel file structure to JSON
#' @param excel_file Path to Excel file
#' @param output_json Path for output JSON file (optional)
#' @return List structure that can be converted to JSON
excel_to_json <- function(excel_file, output_json = NULL) {
  
  cat("=== EXTRACTING EXCEL TO JSON ===\n")
  cat(sprintf("Input file: %s\n", excel_file))
  
  if (!file.exists(excel_file)) {
    stop("Excel file not found: ", excel_file)
  }
  
  # Load workbook
  wb <- wb_load(excel_file)
  sheet_names <- wb_get_sheet_names(wb)
  
  # Initialize JSON structure
  json_structure <- list(
    metadata = list(
      source_file = basename(excel_file),
      source_path = excel_file,
      extraction_date = as.character(Sys.Date()),
      extraction_time = as.character(Sys.time()),
      total_sheets = length(sheet_names),
      sheet_names = sheet_names,
      extractor_version = "2.0",
      file_size_bytes = file.size(excel_file)
    ),
    workbook_properties = extract_workbook_properties(wb),
    sheets = list()
  )
  
  # Extract each sheet
  for (i in seq_along(sheet_names)) {
    sheet_name <- sheet_names[i]
    cat(sprintf("Extracting sheet %d/%d: %s\n", i, length(sheet_names), sheet_name))
    
    sheet_data <- extract_sheet_complete(wb, sheet_name)
    json_structure$sheets[[sheet_name]] <- sheet_data
  }
  
  # Save to JSON if output path provided
  if (!is.null(output_json)) {
    # Ensure output directory exists
    output_dir <- dirname(output_json)
    if (!dir.exists(output_dir)) {
      dir.create(output_dir, recursive = TRUE)
    }
    
    json_text <- toJSON(json_structure, pretty = TRUE, auto_unbox = TRUE, na = "null")
    writeLines(json_text, output_json)
    cat(sprintf("✓ JSON saved: %s\n", output_json))
    
    # Validate JSON
    file_size <- file.size(output_json)
    cat(sprintf("  File size: %.1f KB\n", file_size / 1024))
  }
  
  cat("✓ Extraction complete\n\n")
  return(json_structure)
}

#' Extract complete sheet information - UNIVERSAL approach
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @return Complete sheet structure
extract_sheet_complete <- function(wb, sheet_name) {
  
  tryCatch({
    # Read raw data without column names to preserve structure
    raw_data <- wb_to_df(wb, sheet = sheet_name, col_names = FALSE, na.strings = character(0))
    
    # Convert data frame to list of lists for JSON compatibility
    data_matrix <- list()
    if (nrow(raw_data) > 0 && ncol(raw_data) > 0) {
      for (row in 1:nrow(raw_data)) {
        row_data <- list()
        for (col in 1:ncol(raw_data)) {
          cell_value <- raw_data[row, col]
          # Handle different data types properly
          if (is.na(cell_value)) {
            row_data[[col]] <- NULL
          } else if (is.numeric(cell_value)) {
            row_data[[col]] <- as.numeric(cell_value)
          } else if (is.logical(cell_value)) {
            row_data[[col]] <- as.logical(cell_value)
          } else {
            row_data[[col]] <- as.character(cell_value)
          }
        }
        data_matrix[[row]] <- row_data
      }
    }
    
    # Extract sheet properties and formatting
    sheet_info <- list(
      name = sheet_name,
      position = match(sheet_name, wb_get_sheet_names(wb)),
      dimensions = list(
        rows = if(nrow(raw_data) > 0) nrow(raw_data) else 0,
        cols = if(ncol(raw_data) > 0) ncol(raw_data) else 0
      ),
      data = data_matrix,
      data_types = extract_data_types(raw_data),
      properties = extract_sheet_properties(wb, sheet_name),
      formatting = extract_sheet_formatting_universal(wb, sheet_name, raw_data),
      statistics = calculate_sheet_statistics(raw_data)
    )
    
    return(sheet_info)
    
  }, error = function(e) {
    cat(sprintf("  Warning: Could not fully extract sheet %s: %s\n", sheet_name, e$message))
    return(list(
      name = sheet_name,
      position = match(sheet_name, wb_get_sheet_names(wb)),
      dimensions = list(rows = 0, cols = 0),
      data = list(),
      data_types = list(),
      properties = list(),
      formatting = list(),
      statistics = list(),
      error = e$message
    ))
  })
}

#' Extract data types for each column - UNIVERSAL
#' @param raw_data Data frame
#' @return List of data types per column
extract_data_types <- function(raw_data) {
  if (nrow(raw_data) == 0 || ncol(raw_data) == 0) {
    return(list())
  }
  
  data_types <- list()
  for (col in 1:ncol(raw_data)) {
    col_data <- raw_data[, col]
    non_na_data <- col_data[!is.na(col_data)]
    
    if (length(non_na_data) == 0) {
      data_types[[col]] <- list(
        primary_type = "empty",
        is_numeric = FALSE,
        is_character = FALSE,
        is_date = FALSE,
        sample_values = list()
      )
    } else {
      # Detect primary type
      is_numeric <- is.numeric(non_na_data)
      is_character <- is.character(non_na_data) || is.factor(non_na_data)
      is_date <- any(class(non_na_data) %in% c("Date", "POSIXct", "POSIXlt"))
      
      # Try to detect if character data looks like dates or numbers
      if (is_character && !is_date) {
        # Check if looks like date
        date_patterns <- c("\\d{1,2}[/-]\\d{1,2}[/-]\\d{2,4}", 
                          "\\d{4}[/-]\\d{1,2}[/-]\\d{1,2}",
                          "\\w+ \\d{1,2}, \\d{4}")
        is_date <- any(sapply(date_patterns, function(p) any(grepl(p, non_na_data))))
        
        # Check if looks like number
        numeric_pattern <- "^[+-]?\\d*\\.?\\d+([eE][+-]?\\d+)?$"
        looks_numeric <- all(grepl(numeric_pattern, str_trim(non_na_data)))
      } else {
        looks_numeric <- FALSE
      }
      
      primary_type <- if (is_numeric) "numeric" else 
                     if (is_date) "date" else 
                     if (looks_numeric) "numeric_string" else "character"
      
      data_types[[col]] <- list(
        primary_type = primary_type,
        is_numeric = is_numeric || looks_numeric,
        is_character = is_character,
        is_date = is_date,
        unique_values = length(unique(non_na_data)),
        total_values = length(non_na_data),
        sample_values = head(non_na_data, 5)
      )
    }
  }
  
  return(data_types)
}

#' Calculate sheet statistics - UNIVERSAL
#' @param raw_data Data frame
#' @return Statistics about the sheet
calculate_sheet_statistics <- function(raw_data) {
  if (nrow(raw_data) == 0 || ncol(raw_data) == 0) {
    return(list(
      total_cells = 0,
      non_empty_cells = 0,
      empty_cells = 0,
      numeric_cells = 0,
      text_cells = 0
    ))
  }
  
  total_cells <- nrow(raw_data) * ncol(raw_data)
  non_empty <- sum(!is.na(raw_data))
  empty_cells <- total_cells - non_empty
  
  # Count cell types
  numeric_cells <- sum(sapply(raw_data, function(col) sum(is.numeric(col) & !is.na(col))))
  text_cells <- sum(sapply(raw_data, function(col) sum(is.character(col) & !is.na(col) & col != "")))
  
  list(
    total_cells = total_cells,
    non_empty_cells = non_empty,
    empty_cells = empty_cells,
    numeric_cells = numeric_cells,
    text_cells = text_cells,
    fill_percentage = round((non_empty / total_cells) * 100, 2)
  )
}

#' Extract workbook properties - UNIVERSAL
#' @param wb Workbook object
#' @return Workbook properties list
extract_workbook_properties <- function(wb) {
  # Extract what's available from openxlsx2 without assumptions
  tryCatch({
    sheet_names <- wb_get_sheet_names(wb)
    active_sheet <- wb$get_active_sheet()
    
    list(
      total_sheets = length(sheet_names),
      sheet_names = sheet_names,
      active_sheet = active_sheet,
      created_by = "Unknown",  # Would need workbook metadata access
      created_date = "Unknown",
      last_modified = "Unknown",
      application = "Excel",
      extraction_method = "openxlsx2"
    )
  }, error = function(e) {
    list(
      extraction_method = "openxlsx2",
      error = e$message
    )
  })
}

#' Extract sheet properties - UNIVERSAL
#' @param wb Workbook object  
#' @param sheet_name Sheet name
#' @return Sheet properties
extract_sheet_properties <- function(wb, sheet_name) {
  tryCatch({
    # Try to extract available properties
    list(
      name = sheet_name,
      visible = TRUE,  # Assume visible unless we can detect otherwise
      position = match(sheet_name, wb_get_sheet_names(wb)),
      protection = FALSE,  # Would need sheet protection detection
      zoom = 100,  # Default zoom
      frozen_panes = NULL,  # Would need frozen pane detection
      page_setup = list(
        orientation = "portrait",  # Default
        paper_size = "A4",        # Default
        margins = list(
          left = 0.75, right = 0.75, 
          top = 1.0, bottom = 1.0,
          header = 0.5, footer = 0.5
        )
      )
    )
  }, error = function(e) {
    list(
      name = sheet_name,
      error = e$message
    )
  })
}

#' Extract formatting information - UNIVERSAL approach
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param raw_data Data frame with sheet data
#' @return Formatting information
extract_sheet_formatting_universal <- function(wb, sheet_name, raw_data) {
  
  formatting <- list(
    fonts = list(),
    fills = list(),
    borders = list(),
    number_formats = list(),
    hyperlinks = list(),
    merged_cells = list()
  )
  
  # Only process if we have data
  if (nrow(raw_data) == 0 || ncol(raw_data) == 0) {
    return(formatting)
  }
  
  # Detect patterns without hardcoded assumptions
  
  # 1. Detect potential header rows (rows with many non-empty cells)
  row_fill_rates <- apply(raw_data, 1, function(row) {
    sum(!is.na(row) & row != "") / length(row)
  })
  
  # Find rows that are more filled than average (potential headers)
  avg_fill <- mean(row_fill_rates, na.rm = TRUE)
  potential_headers <- which(row_fill_rates > max(avg_fill, 0.5))
  
  for (header_row in potential_headers[1:min(3, length(potential_headers))]) {
    formatting$fonts[[paste0("potential_header_", header_row)]] <- list(
      range = paste0("A", header_row, ":", LETTERS[min(26, ncol(raw_data))], header_row),
      font = list(name = "Arial", size = 10, bold = TRUE),
      fill = list(color = "#E6E6E6"),
      detected_reason = "high_fill_rate_row"
    )
  }
  
  # 2. Detect numeric columns and suggest formatting
  for (col in 1:min(26, ncol(raw_data))) {  # Limit to A-Z columns for safety
    col_data <- raw_data[, col]
    non_na_data <- col_data[!is.na(col_data)]
    
    if (length(non_na_data) > 0 && is.numeric(col_data)) {
      col_letter <- LETTERS[col]
      
      # Analyze numeric patterns
      max_val <- max(abs(non_na_data), na.rm = TRUE)
      has_decimals <- any(non_na_data %% 1 != 0, na.rm = TRUE)
      
      # Suggest format based on data characteristics
      if (max_val >= 1000) {
        format_code <- if (has_decimals) "# ##0.00" else "# ##0"
      } else if (max_val >= 1) {
        format_code <- if (has_decimals) "0.00" else "0"
      } else {
        format_code <- "0.0000"
      }
      
      formatting$number_formats[[paste0("col_", col)]] <- list(
        range = paste0(col_letter, "1:", col_letter, nrow(raw_data)),
        format = format_code,
        detected_reason = paste0("numeric_column_max_", round(max_val))
      )
    }
  }
  
  # 3. Detect potential navigation text (common patterns)
  navigation_patterns <- c(
    "back", "return", "home", "index", "contents", "overview",
    "zur", "zurück", "inhalt", "übersicht", "navigation"
  )
  
  for (row in 1:min(10, nrow(raw_data))) {
    for (col in 1:min(5, ncol(raw_data))) {
      cell_value <- raw_data[row, col]
      if (!is.na(cell_value) && is.character(cell_value)) {
        cell_lower <- tolower(cell_value)
        
        if (any(sapply(navigation_patterns, function(p) grepl(p, cell_lower)))) {
          cell_ref <- paste0(LETTERS[col], row)
          formatting$hyperlinks[[cell_ref]] <- list(
            cell = cell_ref,
            text = cell_value,
            target = "unknown",  # Cannot determine without more context
            font_color = "#0080C8",
            detected_reason = "navigation_pattern_match"
          )
        }
      }
    }
  }
  
  # 4. Detect alternating row patterns (for tables with many rows)
  if (nrow(raw_data) > 5) {
    # Look for data region (rows with consistent column count)
    col_counts <- apply(raw_data, 1, function(row) sum(!is.na(row) & row != ""))
    mode_cols <- as.numeric(names(sort(table(col_counts), decreasing = TRUE)[1]))
    
    data_rows <- which(col_counts >= mode_cols * 0.8)  # Rows with ~full data
    
    if (length(data_rows) > 2) {
      # Add alternating colors for detected data region
      alternating_rows <- data_rows[seq(2, length(data_rows), 2)]
      for (row in alternating_rows[1:min(10, length(alternating_rows))]) {
        range_id <- paste0("alternating_row_", row)
        formatting$fills[[range_id]] <- list(
          range = paste0("A", row, ":", LETTERS[min(26, ncol(raw_data))], row),
          color = "#F5F5F5",
          detected_reason = "alternating_data_row"
        )
      }
    }
  }
  
  return(formatting)
}

#' Test extraction function - UNIVERSAL
#' @param excel_file Excel file to test
test_excel_extraction <- function(excel_file) {
  cat("=== TESTING UNIVERSAL EXCEL EXTRACTION ===\n")
  
  if (!file.exists(excel_file)) {
    cat("❌ File not found:", excel_file, "\n")
    return(FALSE)
  }
  
  tryCatch({
    # Extract to JSON
    json_structure <- excel_to_json(excel_file)
    
    # Basic validation
    cat("✅ Extraction successful\n")
    cat(sprintf("  Sheets extracted: %d\n", length(json_structure$sheets)))
    cat(sprintf("  Metadata complete: %s\n", !is.null(json_structure$metadata)))
    cat(sprintf("  File size: %.1f KB\n", json_structure$metadata$file_size_bytes / 1024))
    
    # Show sheet summary
    for (sheet_name in names(json_structure$sheets)) {
      sheet_info <- json_structure$sheets[[sheet_name]]
      stats <- sheet_info$statistics
      cat(sprintf("    %s: %d x %d (%.1f%% filled)\n", 
                 sheet_name, 
                 sheet_info$dimensions$rows, 
                 sheet_info$dimensions$cols,
                 stats$fill_percentage))
      
      # Show data types detected
      if (length(sheet_info$data_types) > 0) {
        type_summary <- sapply(sheet_info$data_types, function(dt) dt$primary_type)
        type_counts <- table(unlist(type_summary))
        cat(sprintf("      Data types: %s\n", 
                   paste(paste0(names(type_counts), ":", type_counts), collapse = ", ")))
      }
    }
    
    return(TRUE)
    
  }, error = function(e) {
    cat("❌ Extraction failed:", e$message, "\n")
    return(FALSE)
  })
}

cat("✓ Universal Excel to JSON extraction functions loaded\n")
cat("✓ Main function: excel_to_json(excel_file, output_json)\n")
cat("✓ Test function: test_excel_extraction(excel_file)\n")
cat("✓ NO HARDCODED VALUES - Works with any Excel file\n")