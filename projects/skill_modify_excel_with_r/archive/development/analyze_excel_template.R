# Comprehensive Excel Template Analysis
# Analyze the Statistischer Bericht template for exact recreation

library(openxlsx2)
library(dplyr)
library(stringr)

# ---- File Loading and Basic Structure ----

# Load the template file
file_path <- "output/statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx"

if (!file.exists(file_path)) {
  stop("Template file not found: ", file_path)
}

cat("=== STATISTISCHER BERICHT TEMPLATE ANALYSIS ===\n")
cat("File:", file_path, "\n")
cat("Date:", Sys.Date(), "\n\n")

# Load workbook
wb <- wb_load(file_path)

# Get sheet names
sheet_names <- wb_get_sheet_names(wb)
cat("SHEET STRUCTURE:\n")
cat(sprintf("Total sheets: %d\n", length(sheet_names)))

for (i in seq_along(sheet_names)) {
  cat(sprintf("  %2d. %s\n", i, sheet_names[i]))
}
cat("\n")

# ---- Detailed Sheet Analysis ----

sheet_analysis <- list()

for (sheet_name in sheet_names) {
  cat(sprintf("=== ANALYZING SHEET: %s ===\n", sheet_name))
  
  analysis <- list(
    name = sheet_name,
    dimensions = NA,
    data_rows = 0,
    key_cells = list(),
    table_structure = NA,
    formatting_notes = list()
  )
  
  tryCatch({
    # Read the entire sheet
    data <- wb_to_df(wb, sheet = sheet_name, col_names = FALSE, na.strings = c("", "NA"))
    
    if (nrow(data) > 0 && ncol(data) > 0) {
      analysis$dimensions <- paste(nrow(data), "x", ncol(data))
      analysis$data_rows <- sum(!is.na(data[,1]) & data[,1] != "")
      
      cat(sprintf("Dimensions: %s\n", analysis$dimensions))
      cat(sprintf("Non-empty rows: %d\n", analysis$data_rows))
      
      # Extract key cells (first 10 rows, first 6 columns)
      key_cells <- list()
      for (row in 1:min(10, nrow(data))) {
        for (col in 1:min(6, ncol(data))) {
          cell_value <- data[row, col]
          if (!is.na(cell_value) && cell_value != "") {
            cell_ref <- paste0(LETTERS[col], row)
            key_cells[[cell_ref]] <- as.character(cell_value)
          }
        }
      }
      analysis$key_cells <- key_cells
      
      # Display key content
      cat("\nKey cell contents:\n")
      for (cell_ref in names(key_cells)) {
        content <- str_trunc(key_cells[[cell_ref]], 60)
        cat(sprintf("  %s: %s\n", cell_ref, content))
      }
      
      # Analyze table structure
      if (analysis$data_rows > 1) {
        # Look for table headers (typically in row 1 or first non-empty row)
        first_row <- which(!is.na(data[,1]) & data[,1] != "")[1]
        if (!is.na(first_row)) {
          headers <- data[first_row, ]
          headers <- headers[!is.na(headers) & headers != ""]
          if (length(headers) > 1) {
            analysis$table_structure <- paste("Headers:", paste(headers[1:min(3, length(headers))], collapse = ", "), "...")
            cat(sprintf("\nTable structure: %s\n", analysis$table_structure))
          }
        }
      }
      
      # Identify sheet type
      if (grepl("^\\d{5}-\\d{2}$", sheet_name)) {
        analysis$formatting_notes <- append(analysis$formatting_notes, "Data table (EVAS format)")
      } else if (grepl("^csv-", sheet_name)) {
        analysis$formatting_notes <- append(analysis$formatting_notes, "CSV data table")
      } else if (grepl("Inhalt|Übersicht", sheet_name)) {
        analysis$formatting_notes <- append(analysis$formatting_notes, "Table of contents")
      } else if (grepl("Titel", sheet_name)) {
        analysis$formatting_notes <- append(analysis$formatting_notes, "Title page")
      } else if (grepl("Information", sheet_name)) {
        analysis$formatting_notes <- append(analysis$formatting_notes, "Information sheet")
      } else if (grepl("Impressum", sheet_name)) {
        analysis$formatting_notes <- append(analysis$formatting_notes, "Legal notice")
      }
      
    } else {
      cat("Empty or unreadable sheet\n")
    }
    
  }, error = function(e) {
    cat(sprintf("Error reading sheet: %s\n", e$message))
    analysis$formatting_notes <- append(analysis$formatting_notes, paste("Read error:", e$message))
  })
  
  sheet_analysis[[sheet_name]] <- analysis
  cat("\n")
}

# ---- Pattern Recognition ----

cat("=== PATTERN ANALYSIS ===\n")

# Identify sheet categories
data_tables <- sheet_names[grepl("^\\d{5}-\\d{2}$", sheet_names)]
csv_tables <- sheet_names[grepl("^csv-", sheet_names)]
barrier_free_tables <- sheet_names[grepl("-b\\d{2}$", sheet_names)]
info_sheets <- sheet_names[!sheet_names %in% c(data_tables, csv_tables, barrier_free_tables)]

cat("Sheet categories:\n")
cat(sprintf("  Data tables (%d): %s\n", length(data_tables), paste(data_tables, collapse = ", ")))
cat(sprintf("  CSV tables (%d): %s\n", length(csv_tables), paste(csv_tables, collapse = ", ")))
cat(sprintf("  Barrier-free (%d): %s\n", length(barrier_free_tables), paste(barrier_free_tables, collapse = ", ")))
cat(sprintf("  Information (%d): %s\n", length(info_sheets), paste(info_sheets, collapse = ", ")))
cat("\n")

# Extract EVAS number pattern
if (length(data_tables) > 0) {
  evas_pattern <- str_extract(data_tables[1], "^\\d{5}")
  cat(sprintf("EVAS number: %s\n", evas_pattern))
}

# ---- Navigation Analysis ----

cat("=== NAVIGATION ANALYSIS ===\n")

# Look for navigation patterns in the table of contents sheet
toc_sheets <- sheet_names[grepl("Inhalt|Übersicht", sheet_names, ignore.case = TRUE)]

if (length(toc_sheets) > 0) {
  toc_sheet <- toc_sheets[1]
  cat(sprintf("Analyzing navigation in: %s\n", toc_sheet))
  
  tryCatch({
    toc_data <- wb_to_df(wb, sheet = toc_sheet, col_names = FALSE)
    
    # Look for potential hyperlink text
    nav_items <- list()
    for (row in 1:min(20, nrow(toc_data))) {
      for (col in 1:min(3, ncol(toc_data))) {
        cell_value <- toc_data[row, col]
        if (!is.na(cell_value) && cell_value != "") {
          # Check if it looks like a navigation item
          if (grepl("^\\d{5}-\\d{2}$|Titel|Information|Impressum", cell_value)) {
            nav_items[[paste0(LETTERS[col], row)]] <- cell_value
          }
        }
      }
    }
    
    if (length(nav_items) > 0) {
      cat("Navigation items found:\n")
      for (cell in names(nav_items)) {
        cat(sprintf("  %s: %s\n", cell, nav_items[[cell]]))
      }
    }
    
  }, error = function(e) {
    cat(sprintf("Could not analyze navigation: %s\n", e$message))
  })
}

# ---- Data Structure Analysis ----

cat("\n=== DATA STRUCTURE ANALYSIS ===\n")

# Analyze the first data table in detail
if (length(data_tables) > 0) {
  first_table <- data_tables[1]
  cat(sprintf("Detailed analysis of: %s\n", first_table))
  
  tryCatch({
    table_data <- wb_to_df(wb, sheet = first_table, col_names = FALSE)
    
    # Identify data regions
    non_empty_rows <- which(rowSums(!is.na(table_data) & table_data != "", na.rm = TRUE) > 0)
    
    if (length(non_empty_rows) > 0) {
      cat(sprintf("Data region: Row %d to %d\n", min(non_empty_rows), max(non_empty_rows)))
      
      # Look for header patterns
      header_candidates <- non_empty_rows[1:min(5, length(non_empty_rows))]
      for (row in header_candidates) {
        row_content <- table_data[row, ]
        row_content <- row_content[!is.na(row_content) & row_content != ""]
        if (length(row_content) > 1) {
          cat(sprintf("  Row %d (%d cols): %s\n", row, length(row_content), 
                     paste(str_trunc(row_content[1:min(3, length(row_content))], 20), collapse = " | ")))
        }
      }
      
      # Identify numeric columns
      numeric_columns <- c()
      if (length(non_empty_rows) > 1) {
        data_start_row <- non_empty_rows[2]  # Assume first row is header
        for (col in 1:ncol(table_data)) {
          col_values <- table_data[data_start_row:max(non_empty_rows), col]
          col_values <- col_values[!is.na(col_values) & col_values != ""]
          
          # Check if most values are numeric (after German formatting)
          numeric_count <- sum(grepl("^[\\d\\s,-]+$", col_values))
          if (numeric_count / length(col_values) > 0.7) {
            numeric_columns <- c(numeric_columns, col)
          }
        }
        
        if (length(numeric_columns) > 0) {
          cat(sprintf("Numeric columns detected: %s\n", paste(LETTERS[numeric_columns], collapse = ", ")))
        }
      }
    }
    
  }, error = function(e) {
    cat(sprintf("Could not analyze data structure: %s\n", e$message))
  })
}

# ---- Summary Report ----

cat("\n=== TEMPLATE SPECIFICATION SUMMARY ===\n")

cat("File Structure:\n")
cat(sprintf("  Total sheets: %d\n", length(sheet_names)))
cat(sprintf("  Data tables: %d\n", length(data_tables)))
cat(sprintf("  CSV versions: %d\n", length(csv_tables)))
cat(sprintf("  Information sheets: %d\n", length(info_sheets)))

if (exists("evas_pattern")) {
  cat(sprintf("  EVAS number: %s\n", evas_pattern))
}

cat("\nRequired Implementation Components:\n")
cat("  1. Sheet creation functions for each type\n")
cat("  2. German number formatting system\n") 
cat("  3. Navigation/hyperlink system\n")
cat("  4. Corporate design application\n")
cat("  5. Data table generation from gt objects\n")
cat("  6. Accessibility features (barrier-free tables)\n")
cat("  7. CSV export functionality\n")

# ---- Save Analysis Results ----

# Create a structured summary for later use
analysis_summary <- list(
  file_info = list(
    path = file_path,
    analysis_date = Sys.Date(),
    total_sheets = length(sheet_names)
  ),
  sheet_categories = list(
    data_tables = data_tables,
    csv_tables = csv_tables,
    barrier_free_tables = barrier_free_tables,
    info_sheets = info_sheets
  ),
  patterns = list(
    evas_number = if(exists("evas_pattern")) evas_pattern else NA,
    navigation_sheet = if(length(toc_sheets) > 0) toc_sheets[1] else NA
  ),
  sheet_details = sheet_analysis
)

# Save to RDS for programmatic use
saveRDS(analysis_summary, "output/excel_template_analysis.rds")

cat(sprintf("\nAnalysis complete. Results saved to: output/excel_template_analysis.rds\n"))
cat("Use this analysis to implement the gt-to-Excel conversion system.\n")