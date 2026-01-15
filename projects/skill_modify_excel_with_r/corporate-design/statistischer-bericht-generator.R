# ============================================================================
# Statistischer Bericht Generator
# ============================================================================
# Generate official German statistical reports following Destatis standards
# Based on analysis of actual Statistischer Bericht Excel files

library(openxlsx2)

#' Create Complete Statistischer Bericht
#' 
#' Generates an Excel report following official Destatis design standards
#' 
#' @param data_list Named list of data frames
#' @param filename Output filename
#' @param title Main report title
#' @param period Reporting period (e.g., "Dezember 2025")
#' @param evas_number EVAS statistical number (optional)
#' @return wb object
#' @export
create_statistischer_bericht <- function(data_list, filename, title, 
                                        period = format(Sys.Date(), "%B %Y"),
                                        evas_number = NULL) {
  wb <- wb_workbook()
  
  # Set base formatting - Arial font for accessibility
  wb$set_base_font(font_name = "Arial", font_size = 10)
  
  # Set document properties
  wb$set_properties(
    title = title,
    subject = "Statistischer Bericht", 
    creator = "Statistisches Bundesamt",
    category = "Amtliche Statistik"
  )
  
  # 1. Create Titel sheet ----
  wb$add_worksheet("Titel")
  wb$add_data(x = "Statistischer Bericht", dims = "A1")$
    add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("#004B76"))
  
  wb$add_data(x = title, dims = "A2")$
    add_font(dims = "A2", bold = TRUE, size = 14)
  
  wb$add_data(x = period, dims = "A3")$
    add_font(dims = "A3", size = 12)
  
  if (!is.null(evas_number)) {
    wb$add_data(x = "EVAS-Nummer", dims = "A4")$
      add_data(x = evas_number, dims = "A5")
  }
  
  # 2. Create Informationen_Barrierefreiheit sheet ----
  wb$add_worksheet("Informationen_Barrierefreiheit")
  wb$add_data(x = "Informationen zur Barrierefreiheit", dims = "A1")$
    add_font(dims = "A1", bold = TRUE, size = 14, color = wb_color("#004B76"))
  
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A2")$
    add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")$
    add_font(dims = "A2", color = wb_color("blue"))
  
  accessibility_text <- "Diese Publikation enthält eine oder mehrere barrierefreie Tabellen, die durch die Tabellenbezeichnung \"-b\" erkennbar und am Anfang des Tabellenteils zu finden sind."
  wb$add_data(x = accessibility_text, dims = "A3")
  
  # 3. Create Inhaltsübersicht (main navigation) ----
  wb$add_worksheet("Inhaltsübersicht")
  
  # Title with official formatting
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")$
    add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("white"))$
    add_fill(dims = "A1", color = wb_color("#004B76"))$
    add_cell_style(dims = "A1", horizontal = "center", vertical = "center")$
    merge_cells(dims = "A1:B1")$
    set_row_heights(rows = 1, heights = 25)
  
  # Navigation links
  nav_items <- c(
    "Informationen zur Barrierefreiheit",
    "GENESIS-Online",
    "Impressum", 
    "Informationen zur Statistik"
  )
  
  current_row <- 2
  for (item in nav_items) {
    sheet_ref <- gsub(" ", "_", item)
    wb$add_data(x = item, dims = paste0("A", current_row))$
      add_hyperlink(dims = paste0("A", current_row), target = paste0("#", sheet_ref, "!A1"))$
      add_font(dims = paste0("A", current_row), color = wb_color("blue"))
    current_row <- current_row + 1
  }
  
  # Add data table links
  current_row <- current_row + 1
  wb$add_data(x = "Tabellen", dims = paste0("A", current_row))$
    add_font(dims = paste0("A", current_row), bold = TRUE, size = 12)
  
  current_row <- current_row + 1
  for (table_name in names(data_list)) {
    # Regular table
    wb$add_data(x = paste(table_name, "- Layout-Tabelle"), dims = paste0("A", current_row))$
      add_hyperlink(dims = paste0("A", current_row), target = paste0("#", table_name, "!A1"))$
      add_font(dims = paste0("A", current_row), color = wb_color("blue"))
    
    # Barrier-free version
    wb$add_data(x = paste(table_name, "-b - Barrierefreie Tabelle"), dims = paste0("A", current_row + 1))$
      add_hyperlink(dims = paste0("A", current_row + 1), target = paste0("#", table_name, "-b!A1"))$
      add_font(dims = paste0("A", current_row + 1), color = wb_color("blue"))
    
    current_row <- current_row + 2
  }
  
  # Set column widths
  wb$set_col_widths(cols = 1, widths = 40)$
    set_col_widths(cols = 2, widths = 30)
  
  # 4. Create placeholder info sheets ----
  info_sheets <- c("GENESIS-Online", "Impressum", "Informationen_zur_Statistik")
  for (sheet_name in info_sheets) {
    wb$add_worksheet(sheet_name)
    wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")$
      add_hyperlink(dims = "A1", target = "#Inhaltsübersicht!A1")$
      add_font(dims = "A1", color = wb_color("blue"))
    
    wb$add_data(x = gsub("_", " ", sheet_name), dims = "A2")$
      add_font(dims = "A2", bold = TRUE, size = 14, color = wb_color("#004B76"))
  }
  
  # 5. Create data tables ----
  for (table_name in names(data_list)) {
    data <- data_list[[table_name]]
    
    # Regular layout table
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

#' Create Layout Table (Official Format)
create_layout_table <- function(wb, table_name, data, report_title) {
  wb$add_worksheet(table_name)
  
  # Navigation link
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A1")$
    add_hyperlink(dims = "A1", target = "#Inhaltsübersicht!A1")$
    add_font(dims = "A1", color = wb_color("blue"))
  
  # Table title
  table_title <- paste0(table_name, ": ", report_title)
  wb$add_data(x = table_title, dims = "A2")$
    add_font(dims = "A2", bold = TRUE, size = 12, color = wb_color("#004B76"))
  
  # Additional info row
  wb$add_data(x = "Monat und Jahr", dims = "A3")
  
  # Data starting from row 4
  wb$add_data(x = data, dims = "A4")
  
  # Header formatting
  header_range <- paste0("A4:", int2col(ncol(data)), "4")
  wb$add_font(dims = header_range, bold = TRUE)$
    add_fill(dims = header_range, color = wb_color("#E6E6E6"))
  
  # Apply German statistical number formatting
  apply_german_statistical_formatting(wb, table_name, data, 5)
  
  # Auto-size columns
  wb$set_col_widths(cols = 1:ncol(data), widths = "auto")
}

#' Create Barrier-Free Table
create_barrier_free_table <- function(wb, table_name, data) {
  bf_name <- paste0(table_name, "-b")
  wb$add_worksheet(bf_name)
  
  # Accessibility description
  description <- paste0(bf_name, ": ", "Tabelle mit ", nrow(data), " Zeilen und ", 
                       ncol(data), " Spalten für barrierefreien Zugang.")
  wb$add_data(x = description, dims = "A1")
  
  # Navigation link
  wb$add_data(x = "zur Inhaltsübersicht", dims = "A2")$
    add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")$
    add_font(dims = "A2", color = wb_color("blue"))
  
  # Simple data layout
  wb$add_data(x = data, dims = "A4")
  
  # Minimal formatting for maximum accessibility
  wb$add_font(dims = paste0("A4:", int2col(ncol(data)), "4"), bold = TRUE)
  
  # German formatting for numbers
  apply_german_statistical_formatting(wb, bf_name, data, 5)
}

#' Create CSV Version Table  
create_csv_table <- function(wb, table_name, data) {
  csv_name <- paste0("csv-", table_name)
  wb$add_worksheet(csv_name)
  
  # Add standard statistical metadata columns
  csv_data <- data.frame(
    Statistik = "Erzeugerpreise gewerblicher Produkte",
    stringsAsFactors = FALSE
  )
  
  # Add the original data
  csv_data <- cbind(csv_data, data)
  
  # Simple layout without formatting
  wb$add_data(x = csv_data, dims = "A1")
  wb$set_col_widths(cols = 1:ncol(csv_data), widths = "auto")
}

#' Apply German Statistical Number Formatting
apply_german_statistical_formatting <- function(wb, sheet, data, start_row) {
  for (col in 1:ncol(data)) {
    if (is.numeric(data[[col]])) {
      range <- paste0(int2col(col), start_row, ":", int2col(col), start_row + nrow(data) - 1)
      
      # Determine appropriate format
      max_val <- max(abs(data[[col]]), na.rm = TRUE)
      has_decimals <- any(data[[col]] != floor(data[[col]]), na.rm = TRUE)
      
      if (max_val >= 1000 && has_decimals) {
        # Large numbers with decimals: 1 234,56
        wb$add_numfmt(dims = range, numfmt = "# ##0,00")
      } else if (max_val >= 1000) {
        # Large integers: 1 234
        wb$add_numfmt(dims = range, numfmt = "# ##0")
      } else if (has_decimals) {
        # Small numbers with decimals: 123,45
        wb$add_numfmt(dims = range, numfmt = "0,00")
      } else {
        # Small integers: 123
        wb$add_numfmt(dims = range, numfmt = "0")
      }
    }
  }
}

# Example usage ----
if (FALSE) {
  # Sample data for demonstration
  sample_data <- list(
    "61241-01" = data.frame(
      Erzeugnis = c("Motorenbenzin E 5", "Dieselkraftstoff"),
      EUR_je_hl_2024 = c(132.73, 121.86),
      EUR_je_hl_2025 = c(128.89, 117.83)
    ),
    "61241-02" = data.frame(
      Monat = c("Januar", "Februar", "März"),
      Jahr = c(2025, 2025, 2025),
      Preis = c(91.19, 92.71, 93.64)
    )
  )
  
  # Create official statistical report
  create_statistischer_bericht(
    data_list = sample_data,
    filename = "statistischer_bericht_demo.xlsx",
    title = "Preise für ausgewählte Mineralölerzeugnisse", 
    period = "Dezember 2025",
    evas_number = "61241"
  )
}