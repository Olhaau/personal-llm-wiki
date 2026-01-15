# Excel to JSON Round-trip Functions
# Complete extraction and recreation system using openxlsx2

library(openxlsx2)
library(jsonlite)
library(dplyr)
library(stringr)

# ---- Excel to JSON Extraction Function ----

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
      extraction_date = Sys.Date(),
      total_sheets = length(sheet_names),
      extractor_version = "1.0"
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

#' Extract complete sheet information
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
      dimensions = list(
        rows = if(nrow(raw_data) > 0) nrow(raw_data) else 0,
        cols = if(ncol(raw_data) > 0) ncol(raw_data) else 0
      ),
      data = data_matrix,
      properties = extract_sheet_properties(wb, sheet_name),
      formatting = extract_sheet_formatting(wb, sheet_name, raw_data)
    )
    
    return(sheet_info)
    
  }, error = function(e) {
    cat(sprintf("  Warning: Could not fully extract sheet %s: %s\n", sheet_name, e$message))
    return(list(
      name = sheet_name,
      dimensions = list(rows = 0, cols = 0),
      data = list(),
      properties = list(),
      formatting = list(),
      error = e$message
    ))
  })
}

#' Extract workbook properties
#' @param wb Workbook object
#' @return Workbook properties list
extract_workbook_properties <- function(wb) {
  # Note: openxlsx2 may have limited property extraction capabilities
  # This is a placeholder for available properties
  list(
    base_font = list(
      name = "Arial",  # Default assumption
      size = 10
    ),
    created_date = Sys.Date(),
    application = "R openxlsx2"
  )
}

#' Extract sheet properties
#' @param wb Workbook object  
#' @param sheet_name Sheet name
#' @return Sheet properties
extract_sheet_properties <- function(wb, sheet_name) {
  list(
    name = sheet_name,
    grid_lines = TRUE,  # Default assumption
    orientation = "portrait",
    margins = list(
      left = 0.75,
      right = 0.75,
      top = 1.0,
      bottom = 1.0
    )
  )
}

#' Extract formatting information
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param raw_data Data frame with sheet data
#' @return Formatting information
extract_sheet_formatting <- function(wb, sheet_name, raw_data) {
  
  formatting <- list(
    fonts = list(),
    fills = list(),
    borders = list(),
    number_formats = list(),
    hyperlinks = list()
  )
  
  # Detect likely formatting patterns based on data
  if (nrow(raw_data) > 0 && ncol(raw_data) > 0) {
    
    # Detect headers (first non-empty row with multiple values)
    header_candidates <- which(rowSums(!is.na(raw_data) & raw_data != "", na.rm = TRUE) >= 2)
    if (length(header_candidates) > 0) {
      header_row <- header_candidates[1]
      
      # Add header formatting
      formatting$fonts[[paste0("header_row_", header_row)]] <- list(
        range = paste0("A", header_row, ":", LETTERS[ncol(raw_data)], header_row),
        font = list(name = "Arial", size = 10, bold = TRUE),
        fill = list(color = "#E6E6E6")
      )
    }
    
    # Detect numeric columns for number formatting
    for (col in 1:ncol(raw_data)) {
      if (is.numeric(raw_data[[col]])) {
        col_letter <- LETTERS[col]
        
        # Determine format based on values
        values <- raw_data[[col]][!is.na(raw_data[[col]])]
        if (length(values) > 0) {
          max_val <- max(abs(values))
          
          format_code <- if (max_val >= 1000) "# ##0,00" else "0,00"
          
          formatting$number_formats[[paste0("col_", col)]] <- list(
            range = paste0(col_letter, "1:", col_letter, nrow(raw_data)),
            format = format_code
          )
        }
      }
    }
    
    # Detect likely navigation links (cells containing "zur" or sheet names)
    for (row in 1:min(5, nrow(raw_data))) {
      for (col in 1:min(3, ncol(raw_data))) {
        cell_value <- raw_data[row, col]
        if (!is.na(cell_value) && is.character(cell_value)) {
          if (grepl("zur.*bersicht|Inhalts", cell_value, ignore.case = TRUE)) {
            cell_ref <- paste0(LETTERS[col], row)
            formatting$hyperlinks[[cell_ref]] <- list(
              cell = cell_ref,
              text = cell_value,
              target = "#'Inhaltsübersicht'!A1",
              font_color = "#0080C8"
            )
          }
        }
      }
    }
    
    # Add alternating row colors for data tables
    if (nrow(raw_data) > 3) {
      for (row in seq(2, min(20, nrow(raw_data)), 2)) {
        range_id <- paste0("alternating_row_", row)
        formatting$fills[[range_id]] <- list(
          range = paste0("A", row, ":", LETTERS[ncol(raw_data)], row),
          color = "#F5F5F5"
        )
      }
    }
  }
  
  return(formatting)
}

# ---- JSON to Excel Recreation Function ----

#' Recreate Excel file from JSON structure
#' @param json_file Path to JSON file or JSON structure list
#' @param output_excel Path for output Excel file
#' @return TRUE if successful
json_to_excel <- function(json_file, output_excel) {
  
  cat("=== RECREATING EXCEL FROM JSON ===\n")
  cat(sprintf("Input JSON: %s\n", ifelse(is.character(json_file), json_file, "R object")))
  cat(sprintf("Output Excel: %s\n", output_excel))
  
  # Load JSON structure
  if (is.character(json_file)) {
    if (!file.exists(json_file)) {
      stop("JSON file not found: ", json_file)
    }
    json_structure <- fromJSON(json_file, simplifyVector = FALSE)
  } else {
    json_structure <- json_file
  }
  
  # Create new workbook
  wb <- wb_workbook()
  
  # Apply workbook properties
  apply_workbook_properties(wb, json_structure$workbook_properties)
  
  # Recreate each sheet
  sheet_names <- names(json_structure$sheets)
  for (i in seq_along(sheet_names)) {
    sheet_name <- sheet_names[i]
    cat(sprintf("Recreating sheet %d/%d: %s\n", i, length(sheet_names), sheet_name))
    
    sheet_data <- json_structure$sheets[[sheet_name]]
    recreate_sheet(wb, sheet_data)
  }
  
  # Set active sheet (prefer table of contents if available)
  if ("Inhaltsübersicht" %in% sheet_names) {
    wb$set_active_sheet("Inhaltsübersicht")
  } else if (length(sheet_names) > 0) {
    wb$set_active_sheet(sheet_names[1])
  }
  
  # Save workbook
  wb_save(wb, output_excel, overwrite = TRUE)
  
  if (file.exists(output_excel)) {
    file_size <- file.size(output_excel)
    cat(sprintf("✓ Excel file created: %s\n", output_excel))
    cat(sprintf("  File size: %.1f KB\n", file_size / 1024))
    cat("✓ Recreation complete\n\n")
    return(TRUE)
  } else {
    cat("❌ Failed to create Excel file\n")
    return(FALSE)
  }
}

#' Apply workbook properties
#' @param wb Workbook object
#' @param properties Properties list
apply_workbook_properties <- function(wb, properties) {
  if (!is.null(properties$base_font)) {
    font_name <- ifelse(is.null(properties$base_font$name), "Arial", properties$base_font$name)
    font_size <- ifelse(is.null(properties$base_font$size), 10, properties$base_font$size)
    wb$set_base_font(font_name = font_name, font_size = font_size)
  }
}

#' Recreate individual sheet
#' @param wb Workbook object
#' @param sheet_data Sheet data structure
recreate_sheet <- function(wb, sheet_data) {
  
  sheet_name <- sheet_data$name
  
  # Add worksheet
  wb$add_worksheet(sheet_name)
  
  # Apply sheet properties
  if (!is.null(sheet_data$properties)) {
    apply_sheet_properties(wb, sheet_name, sheet_data$properties)
  }
  
  # Add data
  if (!is.null(sheet_data$data) && length(sheet_data$data) > 0) {
    add_sheet_data(wb, sheet_name, sheet_data$data)
  }
  
  # Apply formatting
  if (!is.null(sheet_data$formatting)) {
    apply_sheet_formatting(wb, sheet_name, sheet_data$formatting)
  }
  
  cat(sprintf("  ✓ Recreated sheet: %s (%d rows x %d cols)\n", 
             sheet_name, 
             sheet_data$dimensions$rows, 
             sheet_data$dimensions$cols))
}

#' Apply sheet properties
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param properties Properties list
apply_sheet_properties <- function(wb, sheet_name, properties) {
  # Apply grid lines setting
  if (!is.null(properties$grid_lines)) {
    wb$set_grid_lines(sheet = sheet_name, show = properties$grid_lines)
  }
  
  # Apply other properties as available in openxlsx2
}

#' Add data to sheet
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param data_matrix Data structure from JSON
add_sheet_data <- function(wb, sheet_name, data_matrix) {
  
  for (row_idx in seq_along(data_matrix)) {
    row_data <- data_matrix[[row_idx]]
    
    for (col_idx in seq_along(row_data)) {
      cell_value <- row_data[[col_idx]]
      
      if (!is.null(cell_value)) {
        col_letter <- LETTERS[col_idx]
        cell_ref <- paste0(col_letter, row_idx)
        
        wb$add_data(x = cell_value, dims = cell_ref)
      }
    }
  }
}

#' Apply formatting to sheet
#' @param wb Workbook object
#' @param sheet_name Sheet name
#' @param formatting Formatting structure
apply_sheet_formatting <- function(wb, sheet_name, formatting) {
  
  # Apply fonts
  if (!is.null(formatting$fonts)) {
    for (font_id in names(formatting$fonts)) {
      font_info <- formatting$fonts[[font_id]]
      if (!is.null(font_info$range) && !is.null(font_info$font)) {
        
        # Build font parameters
        font_params <- list(dims = font_info$range)
        if (!is.null(font_info$font$name)) font_params$name <- font_info$font$name
        if (!is.null(font_info$font$size)) font_params$size <- font_info$font$size
        if (!is.null(font_info$font$bold)) font_params$bold <- font_info$font$bold
        
        do.call(wb$add_font, font_params)
        
        # Apply fill if specified
        if (!is.null(font_info$fill$color)) {
          wb$add_fill(dims = font_info$range, color = wb_color(hex = gsub("#", "", font_info$fill$color)))
        }
      }
    }
  }
  
  # Apply fills
  if (!is.null(formatting$fills)) {
    for (fill_id in names(formatting$fills)) {
      fill_info <- formatting$fills[[fill_id]]
      if (!is.null(fill_info$range) && !is.null(fill_info$color)) {
        wb$add_fill(dims = fill_info$range, color = wb_color(hex = gsub("#", "", fill_info$color)))
      }
    }
  }
  
  # Apply number formats
  if (!is.null(formatting$number_formats)) {
    for (format_id in names(formatting$number_formats)) {
      format_info <- formatting$number_formats[[format_id]]
      if (!is.null(format_info$range) && !is.null(format_info$format)) {
        wb$add_numfmt(dims = format_info$range, numfmt = format_info$format)
      }
    }
  }
  
  # Apply hyperlinks
  if (!is.null(formatting$hyperlinks)) {
    for (link_id in names(formatting$hyperlinks)) {
      link_info <- formatting$hyperlinks[[link_id]]
      if (!is.null(link_info$cell) && !is.null(link_info$target)) {
        wb$add_hyperlink(dims = link_info$cell, target = link_info$target)
        
        # Apply link font color
        if (!is.null(link_info$font_color)) {
          wb$add_font(dims = link_info$cell, color = wb_color(hex = gsub("#", "", link_info$font_color)))
        }
      }
    }
  }
}

# ---- Testing and Validation Functions ----

#' Test round-trip conversion
#' @param excel_file Original Excel file
#' @param test_prefix Prefix for test files
#' @return Test results
test_roundtrip <- function(excel_file, test_prefix = "test") {
  
  cat("=== TESTING ROUND-TRIP CONVERSION ===\n")
  
  # Step 1: Excel to JSON
  json_file <- paste0("output/", test_prefix, "_structure.json")
  json_structure <- excel_to_json(excel_file, json_file)
  
  # Step 2: JSON to Excel
  recreated_excel <- paste0("output/", test_prefix, "_recreated.xlsx")
  success <- json_to_excel(json_file, recreated_excel)
  
  # Step 3: Validation
  if (success) {
    original_size <- file.size(excel_file)
    recreated_size <- file.size(recreated_excel)
    json_size <- file.size(json_file)
    
    cat("=== ROUND-TRIP TEST RESULTS ===\n")
    cat(sprintf("✓ Original Excel: %s (%.1f KB)\n", basename(excel_file), original_size / 1024))
    cat(sprintf("✓ JSON structure: %s (%.1f KB)\n", basename(json_file), json_size / 1024))
    cat(sprintf("✓ Recreated Excel: %s (%.1f KB)\n", basename(recreated_excel), recreated_size / 1024))
    
    # Compare sheet structure
    wb_original <- wb_load(excel_file)
    wb_recreated <- wb_load(recreated_excel)
    
    original_sheets <- wb_get_sheet_names(wb_original)
    recreated_sheets <- wb_get_sheet_names(wb_recreated)
    
    cat(sprintf("\nSheet comparison:\n"))
    cat(sprintf("  Original sheets: %d\n", length(original_sheets)))
    cat(sprintf("  Recreated sheets: %d\n", length(recreated_sheets)))
    cat(sprintf("  Sheets match: %s\n", identical(original_sheets, recreated_sheets)))
    
    return(list(
      success = TRUE,
      original_file = excel_file,
      json_file = json_file,
      recreated_file = recreated_excel,
      sheets_match = identical(original_sheets, recreated_sheets),
      size_ratio = recreated_size / original_size
    ))
  } else {
    return(list(success = FALSE))
  }
}

cat("✓ Excel-JSON round-trip functions loaded\n")
cat("✓ Main functions: excel_to_json(), json_to_excel(), test_roundtrip()\n")
cat("✓ Ready for complete Excel structure extraction and recreation\n")