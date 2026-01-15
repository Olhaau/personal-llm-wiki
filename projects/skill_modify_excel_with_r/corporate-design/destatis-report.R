# Destatis Statistical Report: Motor Vehicle Analysis
# ===================================================
#
# This script creates a "Statistischer Bericht" following Destatis formatting
# standards using the cars dataset as a test for the Excel-R Expert skill.

# ---- Setup and Dependencies ----
suppressPackageStartupMessages({
  library(openxlsx2)
  library(dplyr)
  library(tidyr)
  library(forcats)
  library(lubridate)
})

# Source the Excel examples
source("../../.opencode/examples/excel-r-examples.R")

# ---- Data Preparation ----

#' Prepare Cars Dataset for Statistical Report
prepare_cars_for_destatis <- function() {
  # Use the cars dataset and enhance it for statistical reporting
  data(cars)
  
  # Create enhanced cars dataset with German-style statistical categories
  cars_enhanced <- cars %>%
    mutate(
      # Create speed categories (km/h - converted from mph)
      speed_kmh = round(speed * 1.60934, 1),
      geschwindigkeit_kategorie = case_when(
        speed_kmh < 30 ~ "Niedrig (< 30 km/h)",
        speed_kmh < 50 ~ "Mittel (30-49 km/h)",
        speed_kmh < 70 ~ "Hoch (50-69 km/h)",
        TRUE ~ "Sehr hoch (≥ 70 km/h)"
      ),
      
      # Create distance categories (meters - converted from feet)
      bremsweg_meter = round(dist * 0.3048, 1),
      bremsweg_kategorie = case_when(
        bremsweg_meter < 10 ~ "Kurz (< 10 m)",
        bremsweg_meter < 30 ~ "Mittel (10-29 m)",
        bremsweg_meter < 50 ~ "Lang (30-49 m)",
        TRUE ~ "Sehr lang (≥ 50 m)"
      ),
      
      # Add reporting period (current date)
      berichtszeitraum = format(Sys.Date(), "%Y-%m"),
      
      # Add sequential numbering for statistical presentation
      laufende_nummer = row_number()
    ) %>%
    select(
      laufende_nummer,
      geschwindigkeit_mph = speed,
      geschwindigkeit_kmh = speed_kmh,
      geschwindigkeit_kategorie,
      bremsweg_feet = dist,
      bremsweg_meter,
      bremsweg_kategorie,
      berichtszeitraum
    )
  
  return(cars_enhanced)
}

#' Create Summary Statistics Table
create_summary_statistics <- function(data) {
  summary_stats <- data %>%
    summarise(
      anzahl_beobachtungen = n(),
      geschwindigkeit_mittelwert_kmh = round(mean(geschwindigkeit_kmh, na.rm = TRUE), 1),
      geschwindigkeit_median_kmh = round(median(geschwindigkeit_kmh, na.rm = TRUE), 1),
      geschwindigkeit_min_kmh = round(min(geschwindigkeit_kmh, na.rm = TRUE), 1),
      geschwindigkeit_max_kmh = round(max(geschwindigkeit_kmh, na.rm = TRUE), 1),
      bremsweg_mittelwert_m = round(mean(bremsweg_meter, na.rm = TRUE), 1),
      bremsweg_median_m = round(median(bremsweg_meter, na.rm = TRUE), 1),
      bremsweg_min_m = round(min(bremsweg_meter, na.rm = TRUE), 1),
      bremsweg_max_m = round(max(bremsweg_meter, na.rm = TRUE), 1)
    ) %>%
    pivot_longer(
      everything(),
      names_to = "kennzahl",
      values_to = "wert"
    ) %>%
    mutate(
      kennzahl_deutsch = case_when(
        kennzahl == "anzahl_beobachtungen" ~ "Anzahl Beobachtungen",
        kennzahl == "geschwindigkeit_mittelwert_kmh" ~ "Geschwindigkeit Mittelwert (km/h)",
        kennzahl == "geschwindigkeit_median_kmh" ~ "Geschwindigkeit Median (km/h)", 
        kennzahl == "geschwindigkeit_min_kmh" ~ "Geschwindigkeit Minimum (km/h)",
        kennzahl == "geschwindigkeit_max_kmh" ~ "Geschwindigkeit Maximum (km/h)",
        kennzahl == "bremsweg_mittelwert_m" ~ "Bremsweg Mittelwert (m)",
        kennzahl == "bremsweg_median_m" ~ "Bremsweg Median (m)",
        kennzahl == "bremsweg_min_m" ~ "Bremsweg Minimum (m)",
        kennzahl == "bremsweg_max_m" ~ "Bremsweg Maximum (m)",
        TRUE ~ kennzahl
      )
    ) %>%
    select(
      kennzahl = kennzahl_deutsch,
      wert
    )
  
  return(summary_stats)
}

#' Create Category Cross-tabulation
create_category_crosstab <- function(data) {
  crosstab <- data %>%
    count(geschwindigkeit_kategorie, bremsweg_kategorie) %>%
    pivot_wider(
      names_from = bremsweg_kategorie,
      values_from = n,
      values_fill = 0
    ) %>%
    rename(geschwindigkeit = geschwindigkeit_kategorie)
  
  return(crosstab)
}

# ---- Destatis Excel Creation Function ----

#' Create Destatis-Style Statistical Report Excel
create_destatis_statistical_report <- function(filename = "statistischer_bericht_kraftfahrzeuge.xlsx") {
  
  cat("Erstelle Statistischen Bericht im Destatis-Format...\n")
  
  # Prepare data
  cars_data <- prepare_cars_for_destatis()
  summary_data <- create_summary_statistics(cars_data)
  crosstab_data <- create_category_crosstab(cars_data)
  
  # Create workbook with Destatis styling
  wb <- wb_workbook()
  
  # Set document properties
  wb$set_properties(
    title = "Statistischer Bericht - Kraftfahrzeuge",
    subject = "Geschwindigkeit und Bremswege von Kraftfahrzeugen",
    creator = "Statistisches Bundesamt",
    category = "Verkehr und Transport",
    keywords = "Kraftfahrzeuge, Geschwindigkeit, Bremsweg, Verkehrssicherheit"
  )
  
  # ---- Create Index Sheet ----
  wb$add_worksheet("Inhaltsverzeichnis")
  create_index_content(wb)
  
  # ---- Create Main Data Sheet ----
  wb$add_worksheet("Tabelle_1_Rohdaten")
  create_main_data_sheet(wb, cars_data)
  
  # ---- Create Summary Statistics Sheet ----
  wb$add_worksheet("Tabelle_2_Kennzahlen")
  create_summary_sheet(wb, summary_data)
  
  # ---- Create Cross-tabulation Sheet ----
  wb$add_worksheet("Tabelle_3_Kreuztabelle")
  create_crosstab_sheet(wb, crosstab_data)
  
  # ---- Create Methodology Sheet ----
  wb$add_worksheet("Erläuterungen")
  create_methodology_sheet(wb)
  
  # Save the workbook
  wb$save(filename)
  
  cat("✓ Statistischer Bericht erstellt:", filename, "\n")
  cat("  Anzahl Arbeitsblätter:", length(wb$get_sheet_names()), "\n")
  cat("  Datensätze:", nrow(cars_data), "\n")
  
  return(filename)
}

# ---- Sheet Creation Functions ----

#' Create Index Content
create_index_content <- function(wb) {
  # Destatis blue color scheme
  destatis_blue <- "004B76"
  destatis_light_blue <- "E6F2F8"
  
  # Title style
  title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 18,
    text_bold = TRUE,
    font_color = wb_color(hex = destatis_blue)
  )
  
  # Subtitle style  
  subtitle_style <- create_cell_style(
    font_name = "Arial",
    font_size = 14,
    text_bold = TRUE,
    font_color = wb_color(hex = "000000")
  )
  
  # Link style
  link_style <- create_cell_style(
    font_name = "Arial",
    font_size = 12,
    font_color = wb_color(hex = "0563C1"),
    text_decoration = "underline"
  )
  
  # Add content
  wb$add_data(sheet = "Inhaltsverzeichnis", x = "Statistischer Bericht", start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = "Inhaltsverzeichnis", dims = "A1", style = title_style)
  
  wb$add_data(sheet = "Inhaltsverzeichnis", x = "Kraftfahrzeuge - Geschwindigkeit und Bremswege", start_col = 1, start_row = 2)
  wb$add_cell_style(sheet = "Inhaltsverzeichnis", dims = "A2", style = subtitle_style)
  
  # Current date and period
  current_date <- format(Sys.Date(), "%B %Y")
  wb$add_data(sheet = "Inhaltsverzeichnis", x = paste("Berichtszeitraum:", current_date), start_col = 1, start_row = 4)
  
  # Table of contents
  wb$add_data(sheet = "Inhaltsverzeichnis", x = "Inhaltsverzeichnis", start_col = 1, start_row = 6)
  wb$add_cell_style(sheet = "Inhaltsverzeichnis", dims = "A6", style = subtitle_style)
  
  # Links to tables
  tables <- list(
    "Tabelle 1: Rohdaten der Kraftfahrzeug-Messungen" = "Tabelle_1_Rohdaten",
    "Tabelle 2: Zusammenfassende Kennzahlen" = "Tabelle_2_Kennzahlen", 
    "Tabelle 3: Kreuztabelle nach Kategorien" = "Tabelle_3_Kreuztabelle",
    "Erläuterungen zur Methodik" = "Erläuterungen"
  )
  
  row <- 8
  for (table_name in names(tables)) {
    link_formula <- sprintf('HYPERLINK("#%s!A1", "%s")', tables[[table_name]], table_name)
    wb$add_formula(sheet = "Inhaltsverzeichnis", x = link_formula, start_col = 1, start_row = row)
    wb$add_cell_style(sheet = "Inhaltsverzeichnis", dims = paste0("A", row), style = link_style)
    row <- row + 1
  }
  
  # Set column width
  wb$set_col_widths(sheet = "Inhaltsverzeichnis", cols = 1, widths = 50)
}

#' Create Main Data Sheet
create_main_data_sheet <- function(wb, data) {
  sheet_name <- "Tabelle_1_Rohdaten"
  
  # Destatis styling
  destatis_styles <- create_destatis_styles()
  
  # Add back to index link
  back_link <- 'HYPERLINK("#Inhaltsverzeichnis!A1", "← Zurück zum Inhaltsverzeichnis")'
  wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = sheet_name, dims = "A1", style = destatis_styles$link)
  
  # Add title
  title <- "Tabelle 1: Kraftfahrzeug-Messungen - Geschwindigkeit und Bremsweg"
  wb$add_data(sheet = sheet_name, x = title, start_col = 1, start_row = 3)
  wb$merge_cells(sheet = sheet_name, dims = "A3:H3")
  wb$add_cell_style(sheet = sheet_name, dims = "A3:H3", style = destatis_styles$title)
  
  # Add subtitle with period
  subtitle <- paste("Berichtszeitraum:", format(Sys.Date(), "%Y-%m"))
  wb$add_data(sheet = sheet_name, x = subtitle, start_col = 1, start_row = 4)
  wb$merge_cells(sheet = sheet_name, dims = "A4:H4")
  wb$add_cell_style(sheet = sheet_name, dims = "A4:H4", style = destatis_styles$subtitle)
  
  # Add data starting from row 6
  wb$add_data(sheet = sheet_name, x = data, start_col = 1, start_row = 6)
  
  # Style headers
  for (col in 1:ncol(data)) {
    cell <- paste0(LETTERS[col], "6")
    wb$add_cell_style(sheet = sheet_name, dims = cell, style = destatis_styles$header)
  }
  
  # Style data cells
  for (row in 1:nrow(data)) {
    for (col in 1:ncol(data)) {
      actual_row <- row + 6
      cell <- paste0(LETTERS[col], actual_row)
      
      # Alternate row colors
      if (row %% 2 == 0) {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = destatis_styles$data_alt)
      } else {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = destatis_styles$data)
      }
    }
  }
  
  # Freeze panes
  wb$freeze_pane(sheet = sheet_name, first_active_row = 7, first_active_col = 2)
  
  # Auto-size columns
  for (col in 1:ncol(data)) {
    wb$set_col_widths(sheet = sheet_name, cols = col, widths = "auto")
  }
}

#' Create Summary Sheet
create_summary_sheet <- function(wb, summary_data) {
  sheet_name <- "Tabelle_2_Kennzahlen"
  destatis_styles <- create_destatis_styles()
  
  # Add back link
  back_link <- 'HYPERLINK("#Inhaltsverzeichnis!A1", "← Zurück zum Inhaltsverzeichnis")'
  wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = sheet_name, dims = "A1", style = destatis_styles$link)
  
  # Add title
  title <- "Tabelle 2: Zusammenfassende Kennzahlen"
  wb$add_data(sheet = sheet_name, x = title, start_col = 1, start_row = 3)
  wb$merge_cells(sheet = sheet_name, dims = "A3:B3")
  wb$add_cell_style(sheet = sheet_name, dims = "A3:B3", style = destatis_styles$title)
  
  # Add data
  wb$add_data(sheet = sheet_name, x = summary_data, start_col = 1, start_row = 5)
  
  # Style the table
  apply_destatis_table_style(wb, sheet_name, summary_data, start_row = 5)
}

#' Create Cross-tabulation Sheet
create_crosstab_sheet <- function(wb, crosstab_data) {
  sheet_name <- "Tabelle_3_Kreuztabelle"
  destatis_styles <- create_destatis_styles()
  
  # Add back link
  back_link <- 'HYPERLINK("#Inhaltsverzeichnis!A1", "← Zurück zum Inhaltsverzeichnis")'
  wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = sheet_name, dims = "A1", style = destatis_styles$link)
  
  # Add title
  title <- "Tabelle 3: Kreuztabelle - Geschwindigkeit × Bremsweg"
  wb$add_data(sheet = sheet_name, x = title, start_col = 1, start_row = 3)
  wb$merge_cells(sheet = sheet_name, dims = paste0("A3:", LETTERS[ncol(crosstab_data)], "3"))
  wb$add_cell_style(sheet = sheet_name, dims = paste0("A3:", LETTERS[ncol(crosstab_data)], "3"), style = destatis_styles$title)
  
  # Add data
  wb$add_data(sheet = sheet_name, x = crosstab_data, start_col = 1, start_row = 5)
  
  # Style the table
  apply_destatis_table_style(wb, sheet_name, crosstab_data, start_row = 5)
}

#' Create Methodology Sheet
create_methodology_sheet <- function(wb) {
  sheet_name <- "Erläuterungen"
  destatis_styles <- create_destatis_styles()
  
  # Add back link
  back_link <- 'HYPERLINK("#Inhaltsverzeichnis!A1", "← Zurück zum Inhaltsverzeichnis")'
  wb$add_formula(sheet = sheet_name, x = back_link, start_col = 1, start_row = 1)
  wb$add_cell_style(sheet = sheet_name, dims = "A1", style = destatis_styles$link)
  
  # Add title
  title <- "Erläuterungen zur Methodik und Datenqualität"
  wb$add_data(sheet = sheet_name, x = title, start_col = 1, start_row = 3)
  wb$add_cell_style(sheet = sheet_name, dims = "A3", style = destatis_styles$title)
  
  # Add methodology text
  methodology_text <- c(
    "Datengrundlage:",
    "Die Daten basieren auf dem R-Datensatz 'cars', der Geschwindigkeits- und Bremswegmessungen",
    "von Kraftfahrzeugen aus den 1920er Jahren enthält.",
    "",
    "Umrechnungen:",
    "- Geschwindigkeit: von Meilen pro Stunde (mph) zu Kilometer pro Stunde (km/h)",
    "- Bremsweg: von Fuß (feet) zu Meter (m)",
    "",
    "Kategorisierung:",
    "Geschwindigkeitskategorien: Niedrig (<30 km/h), Mittel (30-49 km/h), Hoch (50-69 km/h), Sehr hoch (≥70 km/h)",
    "Bremswegkategorien: Kurz (<10 m), Mittel (10-29 m), Lang (30-49 m), Sehr lang (≥50 m)",
    "",
    "Qualitätshinweise:",
    "Die Daten stammen aus historischen Messungen und dienen als Demonstration",
    "statistischer Berichterstattung im Destatis-Format."
  )
  
  start_row <- 5
  for (i in seq_along(methodology_text)) {
    wb$add_data(sheet = sheet_name, x = methodology_text[i], start_col = 1, start_row = start_row + i - 1)
  }
  
  # Set column width for readability
  wb$set_col_widths(sheet = sheet_name, cols = 1, widths = 80)
}

# ---- Style Helper Functions ----

#' Create Destatis Styles
create_destatis_styles <- function() {
  list(
    title = create_cell_style(
      font_name = "Arial",
      font_size = 14,
      text_bold = TRUE,
      font_color = wb_color(hex = "FFFFFF"),
      fill_color = wb_color(hex = "004B76"),  # Destatis blue
      horizontal = "left",
      vertical = "center"
    ),
    
    subtitle = create_cell_style(
      font_name = "Arial",
      font_size = 11,
      text_bold = TRUE,
      font_color = wb_color(hex = "004B76"),
      horizontal = "left"
    ),
    
    header = create_cell_style(
      font_name = "Arial", 
      font_size = 10,
      text_bold = TRUE,
      font_color = wb_color(hex = "000000"),
      fill_color = wb_color(hex = "D9D9D9"),
      border = "TopBottomLeftRight",
      border_color = wb_color(hex = "808080"),
      horizontal = "center"
    ),
    
    data = create_cell_style(
      font_name = "Arial",
      font_size = 10,
      border = "TopBottomLeftRight", 
      border_color = wb_color(hex = "D9D9D9"),
      num_fmt = "# ### ##0,00"
    ),
    
    data_alt = create_cell_style(
      font_name = "Arial",
      font_size = 10,
      fill_color = wb_color(hex = "F8F8F8"),
      border = "TopBottomLeftRight",
      border_color = wb_color(hex = "D9D9D9"),
      num_fmt = "# ### ##0,00"
    ),
    
    link = create_cell_style(
      font_name = "Arial",
      font_size = 10,
      font_color = wb_color(hex = "0563C1"),
      text_decoration = "underline"
    )
  )
}

#' Apply Destatis Table Style
apply_destatis_table_style <- function(wb, sheet_name, data, start_row) {
  destatis_styles <- create_destatis_styles()
  
  # Style headers
  for (col in 1:ncol(data)) {
    cell <- paste0(LETTERS[col], start_row)
    wb$add_cell_style(sheet = sheet_name, dims = cell, style = destatis_styles$header)
  }
  
  # Style data
  for (row in 1:nrow(data)) {
    for (col in 1:ncol(data)) {
      actual_row <- start_row + row
      cell <- paste0(LETTERS[col], actual_row)
      
      if (row %% 2 == 0) {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = destatis_styles$data_alt)
      } else {
        wb$add_cell_style(sheet = sheet_name, dims = cell, style = destatis_styles$data)
      }
    }
  }
  
  # Auto-size columns
  for (col in 1:ncol(data)) {
    wb$set_col_widths(sheet = sheet_name, cols = col, widths = "auto")
  }
}

# ---- Main Execution ----

# Create the statistical report
if (!interactive()) {
  # Create output directory
  if (!dir.exists("output")) {
    dir.create("output")
  }
  
  # Generate the report
  filename <- create_destatis_statistical_report("output/statistischer_bericht_kraftfahrzeuge.xlsx")
  
  cat("\n=== Statistischer Bericht erstellt ===\n")
  cat("Datei:", filename, "\n")
  cat("Format: Destatis Statistischer Bericht\n")
  cat("Inhalt: Kraftfahrzeug-Geschwindigkeit und Bremswege\n")
  cat("Excel-R Expert Skill: ✓ Erfolgreich getestet\n")
}

cat("Destatis Cars Report Script geladen. Ausführung mit: create_destatis_statistical_report()\n")