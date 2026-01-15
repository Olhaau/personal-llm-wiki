# ============================================================================
# FIXED Statistischer Bericht Generator
# ============================================================================
# Creates Excel reports following exact Destatis formatting standards
# Fixes: hyperlinks, fonts, "Tabellen" formatting, grid lines

library(openxlsx2)

# Helper function to convert number to column letter
int2col <- function(x) {
  result <- character(length(x))
  for (i in seq_along(x)) {
    if (x[i] <= 26) {
      result[i] <- LETTERS[x[i]]
    } else {
      first <- (x[i] - 1) %/% 26
      second <- (x[i] - 1) %% 26 + 1
      result[i] <- paste0(LETTERS[first], LETTERS[second])
    }
  }
  return(result)
}

# Apply German number formatting
apply_german_formatting <- function(wb, sheet_name, data, start_row) {
  for (col in 1:ncol(data)) {
    if (is.numeric(data[[col]])) {
      range <- paste0(int2col(col), start_row, ":", int2col(col), start_row + nrow(data) - 1)
      
      # Check if values are percentages or large numbers
      max_val <- max(abs(data[[col]]), na.rm = TRUE)
      
      if (any(grepl("%", as.character(data[[col]])), na.rm = TRUE)) {
        # Already formatted as percentage text
        next
      } else if (max_val >= 1000) {
        # Large numbers: space separator, comma decimal
        wb$add_numfmt(dims = range, numfmt = "# ##0,00")
      } else {
        # Regular numbers: comma decimal  
        wb$add_numfmt(dims = range, numfmt = "0,00")
      }
    }
  }
}

# Create title sheet
create_title_sheet <- function(wb, title, period, evas_number) {
  wb$add_worksheet("Titel")
  
  # Content
  wb$add_data(x = "Statistischer Bericht", dims = "A1")
  wb$add_data(x = title, dims = "A2")  
  wb$add_data(x = period, dims = "A3")
  wb$add_data(x = paste("EVAS-Nummer:", evas_number), dims = "A4")
  
  # Formatting - ALL ARIAL
  wb$add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("#004B76"), name = "Arial")
  wb$add_font(dims = "A2", bold = TRUE, size = 14, name = "Arial")
  wb$add_font(dims = "A3", bold = FALSE, size = 12, name = "Arial")
  wb$add_font(dims = "A4", bold = FALSE, size = 10, name = "Arial")
}

# Create accessibility info sheet
create_accessibility_sheet <- function(wb) {
  wb$add_worksheet("Informationen_Barrierefreiheit")
  
  # Back navigation
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
  wb$add_hyperlink(dims = "A1", target = "Inhaltsübersicht!A1")  # FIXED: no #
  wb$add_font(dims = "A1", color = wb_color("blue"), name = "Arial")
  
  # Content
  wb$add_data(x = "Informationen zur Barrierefreiheit", dims = "A2")
  wb$add_font(dims = "A2", bold = TRUE, size = 14, color = wb_color("#004B76"), name = "Arial")
  
  wb$add_data(x = "Dieses Dokument wurde nach den Richtlinien für Barrierefreiheit erstellt.", dims = "A4")
  wb$add_font(dims = "A4", name = "Arial")
}

# Create table of contents with FIXED formatting
create_table_of_contents <- function(wb, data_list) {
  wb$add_worksheet("Inhaltsübersicht")
  
  # CRITICAL: Remove grid lines
  wb$set_grid_lines("Inhaltsübersicht", show = FALSE)
  
  # Navigation items (matching original structure exactly)
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")
  wb$add_data(x = "Informationen zur Barrierefreiheit", dims = "A2")
  wb$add_data(x = "Übersicht GENESIS-Online", dims = "A3")  
  wb$add_data(x = "Impressum", dims = "A4")
  wb$add_data(x = "Informationen zur Statistik", dims = "A5")
  wb$add_data(x = "Barrierefreie Tabellen", dims = "A6")
  
  # Add hyperlinks for navigation items
  wb$add_hyperlink(dims = "A2", target = "Informationen_Barrierefreiheit!A1")
  wb$add_hyperlink(dims = "A3", target = "GENESIS-Online!A1")
  wb$add_hyperlink(dims = "A4", target = "Impressum!A1") 
  wb$add_hyperlink(dims = "A5", target = "Informationen_zur_Statistik!A1")
  
  # Format navigation links
  wb$add_font(dims = "A2:A6", color = wb_color("blue"), name = "Arial")
  
  # "Tabellen" header - WHITE TEXT ON BLUE BACKGROUND
  wb$add_data(x = "Tabellen", dims = "A9")
  wb$add_font(dims = "A9", bold = TRUE, size = 10, color = wb_color("white"), name = "Arial")
  wb$add_fill(dims = "A9", color = wb_color("#004B76"))
  
  # Add table links starting at row 10
  current_row <- 10
  for (table_name in names(data_list)) {
    # Main table link
    wb$add_data(x = table_name, dims = paste0("A", current_row))
    wb$add_hyperlink(dims = paste0("A", current_row), target = paste0(table_name, "!A1"))
    wb$add_font(dims = paste0("A", current_row), color = wb_color("blue"), name = "Arial")
    
    current_row <- current_row + 1
  }
  
  # Ensure ALL cells use Arial font
  wb$add_font(dims = "A1:A20", name = "Arial", size = 10)
}

# Create layout data table
create_layout_table <- function(wb, table_name, data, title) {
  wb$add_worksheet(table_name)
  
  # Back navigation link - FIXED
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
  wb$add_hyperlink(dims = "A1", target = "Inhaltsübersicht!A1")  # FIXED: no #
  wb$add_font(dims = "A1", color = wb_color("blue"), name = "Arial")
  
  # Table title
  table_title <- paste0(table_name, ": ", title)
  wb$add_data(x = table_title, dims = "A3")
  wb$add_font(dims = "A3", bold = TRUE, size = 10, name = "Arial")
  
  # Data table starting at row 4
  wb$add_data(x = data, dims = "A4")
  
  # Header formatting
  header_range <- paste0("A4:", int2col(ncol(data)), "4")
  wb$add_font(dims = header_range, bold = TRUE, name = "Arial", size = 10)
  wb$add_fill(dims = header_range, color = wb_color("#E6E6E6"))
  
  # Apply German number formatting to data rows
  apply_german_formatting(wb, table_name, data, start_row = 5)
  
  # Ensure ALL data uses Arial
  data_range <- paste0("A1:", int2col(ncol(data)), 4 + nrow(data))
  wb$add_font(dims = data_range, name = "Arial", size = 10)
}

# Create barrier-free version
create_barrier_free_table <- function(wb, table_name, data) {
  bf_name <- paste0(table_name, "-b")
  wb$add_worksheet(bf_name)
  
  # Accessibility description
  description <- paste0("Tabelle ", table_name, ". Sie erstreckt sich über ", 
                       ncol(data), " Spalten und ", nrow(data), " Zeilen.")
  wb$add_data(x = description, dims = "A1")
  wb$add_font(dims = "A1", name = "Arial", size = 10)
  
  # Back navigation
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A2") 
  wb$add_hyperlink(dims = "A2", target = "Inhaltsübersicht!A1")
  wb$add_font(dims = "A2", color = wb_color("blue"), name = "Arial")
  
  # Simple data table
  wb$add_data(x = data, dims = "A4")
  
  # Minimal formatting for accessibility
  header_range <- paste0("A4:", int2col(ncol(data)), "4") 
  wb$add_font(dims = header_range, bold = TRUE, name = "Arial")
  
  # Apply German formatting
  apply_german_formatting(wb, bf_name, data, start_row = 5)
  
  # All Arial fonts
  data_range <- paste0("A1:", int2col(ncol(data)), 4 + nrow(data))
  wb$add_font(dims = data_range, name = "Arial", size = 10)
}

# Create CSV table
create_csv_table <- function(wb, table_name, data) {
  csv_name <- paste0("csv-", table_name)
  wb$add_worksheet(csv_name)
  
  # Description
  wb$add_data(x = paste("CSV-Daten zu Tabelle", table_name), dims = "A1")
  wb$add_font(dims = "A1", bold = TRUE, name = "Arial")
  
  # Back navigation
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A2")
  wb$add_hyperlink(dims = "A2", target = "Inhaltsübersicht!A1")
  wb$add_font(dims = "A2", color = wb_color("blue"), name = "Arial")
  
  # Raw data without formatting for CSV export
  wb$add_data(x = data, dims = "A4")
  wb$add_font(dims = paste0("A1:", int2col(ncol(data)), 4 + nrow(data)), name = "Arial")
}

# Create info sheets  
create_info_sheets <- function(wb) {
  info_sheets <- c("GENESIS-Online", "Impressum", "Informationen_zur_Statistik")
  
  for (sheet_name in info_sheets) {
    wb$add_worksheet(sheet_name)
    
    # Back navigation
    wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")
    wb$add_hyperlink(dims = "A1", target = "Inhaltsübersicht!A1")
    wb$add_font(dims = "A1", color = wb_color("blue"), name = "Arial")
    
    # Sheet title
    display_name <- gsub("_", " ", sheet_name)
    wb$add_data(x = display_name, dims = "A3")
    wb$add_font(dims = "A3", bold = TRUE, size = 14, color = wb_color("#004B76"), name = "Arial")
  }
}

#' Create Complete Statistischer Bericht (FIXED VERSION)
#' 
#' @param data_list Named list of data frames
#' @param filename Output filename
#' @param title Main report title  
#' @param period Reporting period
#' @param evas_number EVAS number for the report
create_statistischer_bericht <- function(data_list, filename, title, period, evas_number) {
  # Create workbook with Arial base font
  wb <- wb_workbook()
  wb$set_base_font(font_name = "Arial", font_size = 10)
  
  # Set document properties
  wb$set_properties(
    title = title,
    subject = "Statistischer Bericht",
    creator = "Statistisches Bundesamt",
    category = "Amtliche Statistik"
  )
  
  # 1. Create title sheet
  create_title_sheet(wb, title, period, evas_number)
  
  # 2. Create accessibility info
  create_accessibility_sheet(wb)
  
  # 3. Create table of contents (FIXED)
  create_table_of_contents(wb, data_list)
  
  # 4. Create info sheets
  create_info_sheets(wb)
  
  # 5. Create all data tables
  for (table_name in names(data_list)) {
    data <- data_list[[table_name]]
    
    # Main layout table
    create_layout_table(wb, table_name, data, title)
    
    # Barrier-free version  
    create_barrier_free_table(wb, table_name, data)
    
    # CSV version
    create_csv_table(wb, table_name, data)
  }
  
  # Set active sheet and save
  wb$set_active_sheet("Inhaltsübersicht")
  wb_save(wb, filename, overwrite = TRUE)
  
  cat("✓ Statistischer Bericht created:", filename, "\n")
  cat("  Features:\n")
  cat("  - Official Destatis design standards\n")
  cat("  - Complete navigation system\n")
  cat("  - Barrier-free accessibility versions\n") 
  cat("  - German number formatting\n")
  cat("  - CSV data versions included\n")
  
  return(wb)
}