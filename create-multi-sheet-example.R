# Multi-Sheet Excel Example - Clean Destatis Style
# ===============================================
#
# Creates a comprehensive multi-sheet Excel report with:
# - Index/Navigation sheet
# - Multiple data tables
# - Clean formatting throughout
# - Professional German statistical report structure

# Load the clean formatter
source(".opencode/skills/excel-r-expert/code/simple-clean-formatter.R")

cat("Creating Multi-Sheet Excel Example...\n")

#' Create Comprehensive Multi-Sheet Excel Report
#' 
#' @param filename Output Excel filename
#' @return Path to created Excel file
create_multi_sheet_example <- function(filename = "output/multi_sheet_destatis_example.xlsx") {
  
  destatis_blue <- "004B76"
  
  # Prepare multiple datasets
  cat("Preparing datasets...\n")
  
  # Dataset 1: Regional Economic Data
  wirtschaft_data <- data.frame(
    Bundesland = c("Bayern", "Nordrhein-Westfalen", "Baden-Württemberg", "Niedersachsen", "Hessen", "Sachsen"),
    Einwohner = c(13124737, 17932651, 11100394, 7993608, 6265809, 4071971),
    BIP_Mrd_Euro = c(632.9, 704.2, 524.3, 310.5, 294.4, 132.3),
    BIP_pro_Kopf = c(48243, 39259, 47249, 38845, 46989, 32500),
    Arbeitslosenquote = c(3.1, 6.8, 3.2, 5.1, 4.2, 7.5),
    Unternehmen = c(725630, 838492, 627459, 394821, 341289, 198765),
    stringsAsFactors = FALSE
  )
  
  # Dataset 2: Demographics
  demografie_data <- data.frame(
    Altersgruppe = c("0-17 Jahre", "18-29 Jahre", "30-49 Jahre", "50-64 Jahre", "65+ Jahre"),
    Anteil_Prozent = c(16.5, 14.8, 27.3, 21.9, 19.5),
    Anzahl_Millionen = c(13.7, 12.3, 22.7, 18.2, 16.2),
    Veränderung_5Jahre = c(-2.1, -8.4, -5.2, 3.7, 12.8),
    stringsAsFactors = FALSE
  )
  
  # Dataset 3: Education Statistics  
  bildung_data <- data.frame(
    Schulart = c("Grundschule", "Gymnasium", "Realschule", "Hauptschule", "Gesamtschule", "Berufsschule"),
    Schulen_Anzahl = c(15654, 3141, 2312, 2093, 1387, 8456),
    Schüler = c(2832123, 2356789, 1234567, 567890, 987654, 1543210),
    Lehrer = c(212345, 156789, 98765, 45678, 76543, 123456),
    Schüler_pro_Lehrer = c(13.3, 15.0, 12.5, 12.4, 12.9, 12.5),
    stringsAsFactors = FALSE
  )
  
  # Dataset 4: Energy Statistics
  energie_data <- data.frame(
    Energieträger = c("Braunkohle", "Steinkohle", "Erdgas", "Kernenergie", "Wind", "Solar", "Wasserkraft"),
    Kapazität_MW = c(20183, 23674, 29678, 8113, 59312, 54937, 5632),
    Produktion_TWh = c(131.3, 207.1, 91.1, 64.4, 132.1, 60.2, 24.7),
    Anteil_Prozent = c(18.5, 29.2, 12.8, 9.1, 18.6, 8.5, 3.5),
    CO2_Mio_Tonnen = c(175.2, 285.4, 36.8, 0.0, 0.0, 0.0, 0.0),
    stringsAsFactors = FALSE
  )
  
  wb <- wb_workbook()
  
  # Set document properties
  wb$set_properties(
    title = "Statistischer Bericht Deutschland",
    creator = "Statistisches Bundesamt",
    subject = "Umfassender statistischer Bericht mit Wirtschaft, Demografie, Bildung und Energie"
  )
  
  cat("Creating index sheet...\n")
  
  # ---- Create Index Sheet ----
  wb$add_worksheet("Index")
  
  # Main title style
  main_title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 16,
    text_bold = TRUE,
    font_color = wb_color(hex = destatis_blue)
  )
  
  # Section header style
  section_style <- create_cell_style(
    font_name = "Arial",
    font_size = 12,
    text_bold = TRUE,
    font_color = wb_color(hex = "333333")
  )
  
  # Link style
  link_style <- create_cell_style(
    font_name = "Arial",
    font_size = 11,
    font_color = wb_color(hex = "0563C1"),
    text_decoration = "underline"
  )
  
  # Add main title and metadata
  wb$add_data(sheet = "Index", x = "Statistischer Bericht Deutschland", start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = "Index", dims = "A1", style = main_title_style)
  
  wb$add_data(sheet = "Index", x = "Umfassende Datensammlung zu Wirtschaft, Gesellschaft und Umwelt", start_col = 1, start_row = 2)
  
  wb$add_data(sheet = "Index", x = paste("Berichtszeitraum:", format(Sys.Date(), "%B %Y")), start_col = 1, start_row = 3)
  wb$add_data(sheet = "Index", x = paste("Erstellt am:", format(Sys.Date(), "%d.%m.%Y")), start_col = 1, start_row = 4)
  
  # Add navigation section
  wb$add_data(sheet = "Index", x = "Inhaltsverzeichnis", start_col = 1, start_row = 6)
  wb$add_cell_style(sheet = "Index", dims = "A6", style = section_style)
  
  # Prepare sheet data
  sheets_data <- list(
    list(name = "Wirtschaft", title = "Wirtschaftsdaten der Bundesländer", data = wirtschaft_data),
    list(name = "Demografie", title = "Demografische Struktur nach Altersgruppen", data = demografie_data), 
    list(name = "Bildung", title = "Bildungsstatistiken nach Schularten", data = bildung_data),
    list(name = "Energie", title = "Energieproduktion nach Energieträgern", data = energie_data)
  )
  
  # Add links to data sheets
  for (i in seq_along(sheets_data)) {
    sheet_info <- sheets_data[[i]]
    index_row <- 7 + i
    
    # Add sheet link
    link_text <- paste(i, "-", sheet_info$title)
    link_formula <- sprintf('HYPERLINK("#%s!A1", "%s")', sheet_info$name, link_text)
    wb$add_formula(sheet = "Index", x = link_formula, start_col = 1, start_row = index_row)
    wb$add_cell_style(sheet = "Index", dims = paste0("A", index_row), style = link_style)
  }
  
  # Add footer information
  footer_row <- 7 + length(sheets_data) + 2
  wb$add_data(sheet = "Index", x = "Hinweise:", start_col = 1, start_row = footer_row)
  wb$add_cell_style(sheet = "Index", dims = paste0("A", footer_row), style = section_style)
  
  wb$add_data(sheet = "Index", x = "• Alle Zahlen sind auf Basis der neuesten verfügbaren Daten", start_col = 1, start_row = footer_row + 1)
  wb$add_data(sheet = "Index", x = "• Klicken Sie auf die Links oben, um zu den einzelnen Tabellen zu navigieren", start_col = 1, start_row = footer_row + 2)
  wb$add_data(sheet = "Index", x = "• Jede Tabelle enthält einen Link zurück zu diesem Inhaltsverzeichnis", start_col = 1, start_row = footer_row + 3)
  
  # Set column widths for index
  wb$set_col_widths(sheet = "Index", cols = 1, widths = 70)
  
  cat("Creating data sheets...\n")
  
  # ---- Create Data Sheets ----
  for (i in seq_along(sheets_data)) {
    sheet_info <- sheets_data[[i]]
    sheet_name <- sheet_info$name
    sheet_title <- sheet_info$title
    data <- sheet_info$data
    
    cat(paste("  Creating sheet:", sheet_name, "\n"))
    
    # Add worksheet
    wb$add_worksheet(sheet_name)
    
    current_row <- 1
    
    # Add back navigation link
    back_link <- 'HYPERLINK("#Index!A1", "← Zurück zum Inhaltsverzeichnis")'
    wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = current_row)
    wb$add_cell_style(sheet = sheet_name, dims = paste0("A", current_row), style = link_style)
    current_row <- current_row + 2
    
    # Add sheet title
    wb$add_data(sheet = sheet_name, x = sheet_title, start_col = 1, start_row = current_row)
    
    # Title style for individual sheets
    sheet_title_style <- create_cell_style(
      font_name = "Arial",
      font_size = 14,
      text_bold = TRUE,
      font_color = wb_color(hex = destatis_blue)
    )
    wb$add_cell_style(sheet = sheet_name, dims = paste0("A", current_row), style = sheet_title_style)
    current_row <- current_row + 2
    
    # Add table using clean formatting
    add_clean_table_to_sheet(wb, sheet_name, data, current_row)
    
    # Add data summary
    summary_row <- current_row + nrow(data) + 3
    wb$add_data(sheet = sheet_name, x = "Zusammenfassung:", start_col = 1, start_row = summary_row)
    wb$add_cell_style(sheet = sheet_name, dims = paste0("A", summary_row), style = section_style)
    
    # Add sheet-specific summary
    summary_text <- generate_summary_text(sheet_name, data)
    wb$add_data(sheet = sheet_name, x = summary_text, start_col = 1, start_row = summary_row + 1)
  }
  
  cat("Finalizing workbook...\n")
  
  # Save the workbook
  wb$save(filename)
  
  cat("✓ Multi-sheet Excel report created:", filename, "\n")
  cat("  Sheets:", length(sheets_data) + 1, "(Index + 4 data sheets)\n")
  cat("  Style: Clean Destatis formatting throughout\n")
  cat("  Navigation: Full hyperlink navigation system\n")
  cat("  Content: Economic, demographic, education, and energy data\n")
  
  return(filename)
}

#' Helper function to add clean table to existing sheet (enhanced version)
add_clean_table_to_sheet <- function(wb, sheet_name, data, start_row) {
  destatis_blue <- "004B76"
  
  # Header style
  header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = destatis_blue),
    horizontal = "center",
    vertical = "center"
  )
  
  # Data styles (clean, no individual borders)
  data_style <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    horizontal = "left",
    vertical = "center",
    num_fmt = "# ##0,00"
  )
  
  data_style_alt <- create_cell_style(
    font_name = "Arial",
    font_size = 10,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = "F8F8F8"),
    horizontal = "left",
    vertical = "center",
    num_fmt = "# ##0,00"
  )
  
  # Add data
  wb$add_data(sheet = sheet_name, x = data, start_col = 1, start_row = start_row)
  
  # Apply formatting
  n_cols <- ncol(data)
  n_rows <- nrow(data)
  
  # Style headers
  for (col in 1:n_cols) {
    cell <- paste0(LETTERS[col], start_row)
    wb$add_cell_style(sheet = sheet_name, dims = cell, style = header_style)
  }
  
  # Style data cells with alternating rows
  for (row in 1:n_rows) {
    actual_row <- start_row + row
    for (col in 1:n_cols) {
      cell <- paste0(LETTERS[col], actual_row)
      
      if (row %% 2 == 0) {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = data_style_alt)
      } else {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = data_style)
      }
    }
  }
  
  # Add outer border around entire table
  table_end_row <- start_row + n_rows
  table_end_col <- LETTERS[n_cols]
  table_range <- paste0("A", start_row, ":", table_end_col, table_end_row)
  
  wb$add_border(
    sheet = sheet_name,
    dims = table_range,
    top_border = "medium",
    bottom_border = "medium",
    left_border = "medium", 
    right_border = "medium",
    top_color = wb_color(hex = destatis_blue),
    bottom_color = wb_color(hex = destatis_blue),
    left_color = wb_color(hex = destatis_blue),
    right_color = wb_color(hex = destatis_blue)
  )
  
  # Auto-size columns
  for (col in 1:n_cols) {
    wb$set_col_widths(sheet = sheet_name, cols = col, widths = "auto")
  }
}

#' Generate summary text for each sheet
generate_summary_text <- function(sheet_name, data) {
  n_rows <- nrow(data)
  n_cols <- ncol(data)
  
  if (sheet_name == "Wirtschaft") {
    total_pop <- sum(data$Einwohner, na.rm = TRUE)
    total_gdp <- sum(data$BIP_Mrd_Euro, na.rm = TRUE)
    return(paste("Insgesamt", n_rows, "Bundesländer mit", format(total_pop, big.mark = " "), "Einwohnern und", format(total_gdp, big.mark = " "), "Mrd. Euro BIP"))
  } else if (sheet_name == "Demografie") {
    return(paste("Demografische Verteilung über", n_rows, "Altersgruppen, Gesamtbevölkerung:", format(sum(data$Anzahl_Millionen), big.mark = " "), "Millionen"))
  } else if (sheet_name == "Bildung") {
    total_students <- sum(data$Schüler, na.rm = TRUE)
    total_schools <- sum(data$Schulen_Anzahl, na.rm = TRUE)
    return(paste("Bildungssystem:", format(total_schools, big.mark = " "), "Schulen mit", format(total_students, big.mark = " "), "Schülern"))
  } else if (sheet_name == "Energie") {
    total_capacity <- sum(data$Kapazität_MW, na.rm = TRUE)
    total_production <- sum(data$Produktion_TWh, na.rm = TRUE)
    return(paste("Energiesektor:", format(total_capacity, big.mark = " "), "MW Kapazität,", format(total_production, big.mark = " "), "TWh Produktion"))
  }
  
  return(paste("Tabelle enthält", n_rows, "Datensätze mit", n_cols, "Variablen"))
}

# Execute the example
if (!interactive()) {
  create_multi_sheet_example()
  
  cat("\n=== Multi-Sheet Excel Example Complete ===\n")
  cat("Professional German statistical report created with:\n")
  cat("  • Index sheet with navigation\n")
  cat("  • 4 data sheets with clean formatting\n") 
  cat("  • Hyperlink navigation system\n")
  cat("  • Consistent Destatis styling\n")
  cat("  • Border only around tables\n")
  cat("  • Space thousands separators\n")
  cat("  • 14pt Arial headings in Destatis blue\n")
}

cat("Multi-sheet example script loaded!\n")
cat("Run: create_multi_sheet_example() to generate the report\n")