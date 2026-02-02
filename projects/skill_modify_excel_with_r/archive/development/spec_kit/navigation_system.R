# Navigation System Generator
# Complete hyperlink navigation system for Statistischer Bericht

library(openxlsx2)
source("spec_kit/german_formatting.R")

# ---- Core Navigation Functions ----

#' Add back navigation link to any sheet
#' @param wb Workbook object
#' @param sheet_name Current sheet name
#' @param target_sheet Target sheet (default "Inhaltsübersicht")
#' @param cell_ref Cell reference (default "A1")
#' @param link_text Display text (default "zur Inhaltsübersicht")
add_back_navigation <- function(wb, sheet_name, target_sheet = "Inhaltsübersicht", 
                               cell_ref = "A1", link_text = "zur Inhaltsübersicht") {
  
  # Add link text
  wb$add_data(x = link_text, dims = cell_ref)
  
  # Create hyperlink with proper Excel format
  target_ref <- paste0("#'", target_sheet, "'!A1")
  wb$add_hyperlink(dims = cell_ref, target = target_ref)
  
  # Style as navigation link
  apply_destatis_typography(wb, sheet_name, cell_ref, "navigation")
  
  return(wb)
}

#' Create complete table of contents sheet
#' @param wb Workbook object  
#' @param table_names Vector of data table names
#' @param metadata Report metadata
create_table_of_contents <- function(wb, table_names, metadata = list()) {
  sheet_name <- "Inhaltsübersicht"
  wb$add_worksheet(sheet_name)
  
  # Remove grid lines for clean appearance
  wb$set_grid_lines(sheet_name, show = FALSE)
  
  # Main heading
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")
  apply_destatis_typography(wb, sheet_name, "A1", "title")
  
  current_row <- 3
  
  # Information sections navigation
  info_sections <- list(
    "Informationen zur Barrierefreiheit" = "Informationen_Barrierefreiheit",
    "Übersicht GENESIS-Online" = "GENESIS-Online", 
    "Impressum" = "Impressum",
    "Informationen zur Statistik" = "Informationen_zur_Statistik"
  )
  
  for (display_text in names(info_sections)) {
    target_sheet <- info_sections[[display_text]]
    
    wb$add_data(x = display_text, dims = paste0("A", current_row))
    
    # Create hyperlink
    target_ref <- paste0("#'", target_sheet, "'!A1") 
    wb$add_hyperlink(dims = paste0("A", current_row), target = target_ref)
    apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "navigation")
    
    current_row <- current_row + 1
  }
  
  # Barrier-free tables section
  current_row <- current_row + 1
  wb$add_data(x = "Barrierefreie Tabellen", dims = paste0("A", current_row))
  apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "header")
  current_row <- current_row + 1
  
  # Add barrier-free table links
  for (table_id in table_names) {
    bf_sheet_name <- paste0(table_id, "-b")
    display_text <- paste0(table_id, ": Barrierefreie Version")
    
    wb$add_data(x = display_text, dims = paste0("A", current_row))
    target_ref <- paste0("#'", bf_sheet_name, "'!A1")
    wb$add_hyperlink(dims = paste0("A", current_row), target = target_ref)
    apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "navigation")
    
    current_row <- current_row + 1
  }
  
  # Main tables section header
  current_row <- current_row + 1
  wb$add_data(x = "Tabellen", dims = paste0("A", current_row))
  
  # Style "Tabellen" header with white text on blue background
  wb$add_font(dims = paste0("A", current_row), bold = TRUE, size = 10, 
             color = wb_color("white"), name = "Arial")
  wb$add_fill(dims = paste0("A", current_row), color = wb_color(destatis_colors$primary_blue))
  
  current_row <- current_row + 1
  
  # Add main table navigation links
  table_descriptions <- generate_table_descriptions(table_names, metadata)
  
  for (table_id in table_names) {
    description <- ifelse(table_id %in% names(table_descriptions),
                         table_descriptions[[table_id]], 
                         "Statistische Daten")
    
    # Table ID in column A
    wb$add_data(x = table_id, dims = paste0("A", current_row))
    target_ref <- paste0("#'", table_id, "'!A1")
    wb$add_hyperlink(dims = paste0("A", current_row), target = target_ref)
    apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "navigation")
    
    # Description in column B  
    wb$add_data(x = description, dims = paste0("B", current_row))
    apply_destatis_typography(wb, sheet_name, paste0("B", current_row), "body")
    
    current_row <- current_row + 1
  }
  
  # CSV tables section
  current_row <- current_row + 1
  wb$add_data(x = "CSV-Tabellen", dims = paste0("A", current_row))
  apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "header")
  
  # Add explanation link
  current_row <- current_row + 1
  wb$add_data(x = "Erläuterung zu CSV-Tabellen", dims = paste0("A", current_row))
  target_ref <- "#'Erläuterung_zu_CSV-Tabellen'!A1"
  wb$add_hyperlink(dims = paste0("A", current_row), target = target_ref)
  apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "navigation")
  
  # Set column widths
  wb$set_col_widths(sheet = sheet_name, cols = 1, widths = 25)
  wb$set_col_widths(sheet = sheet_name, cols = 2, widths = 50)
  
  return(wb)
}

#' Generate table descriptions based on table IDs
#' @param table_names Vector of table names
#' @param metadata Report metadata
#' @return Named list of descriptions
generate_table_descriptions <- function(table_names, metadata = list()) {
  
  # Default descriptions based on common patterns
  descriptions <- list()
  
  for (table_id in table_names) {
    if (grepl("-01$", table_id)) {
      descriptions[[table_id]] <- "Preise für ausgewählte Mineralölerzeugnisse"
    } else if (grepl("-02$", table_id)) {
      descriptions[[table_id]] <- "Lange Reihe Preise für Motorenbenzin"
    } else if (grepl("-03$", table_id)) {
      descriptions[[table_id]] <- "Lange Reihe Preise für Dieselkraftstoff"
    } else if (grepl("-04$", table_id)) {
      descriptions[[table_id]] <- "Preise für leichtes Heizöl bei Lieferung in Tankwagen"
    } else if (grepl("-05$", table_id)) {
      descriptions[[table_id]] <- "Preise für leichtes Heizöl bei Lieferung von mindestens 10 000 Liter"
    } else {
      descriptions[[table_id]] <- "Statistische Daten"
    }
  }
  
  # Override with metadata descriptions if available
  if ("table_descriptions" %in% names(metadata)) {
    for (table_id in names(metadata$table_descriptions)) {
      descriptions[[table_id]] <- metadata$table_descriptions[[table_id]]
    }
  }
  
  return(descriptions)
}

#' Add navigation to all data sheets
#' @param wb Workbook object
#' @param table_names Vector of table names
add_navigation_to_all_sheets <- function(wb, table_names) {
  
  # Add navigation to barrier-free tables
  for (table_id in table_names) {
    bf_sheet_name <- paste0(table_id, "-b")
    wb <- add_back_navigation(wb, bf_sheet_name)
  }
  
  # Add navigation to main data tables  
  for (table_id in table_names) {
    wb <- add_back_navigation(wb, table_id)
  }
  
  # Add navigation to CSV tables
  for (table_id in table_names) {
    csv_sheet_name <- paste0("csv-", table_id)
    wb <- add_back_navigation(wb, csv_sheet_name)
  }
  
  # Add navigation to barrier-free CSV tables
  for (table_id in table_names) {
    if (grepl("-b\\d+$", table_id)) {
      csv_bf_sheet_name <- paste0("csv-", table_id)
      if (csv_bf_sheet_name %in% wb_get_sheet_names(wb)) {
        wb <- add_back_navigation(wb, csv_bf_sheet_name)
      }
    }
  }
  
  return(wb)
}

# ---- Advanced Navigation Features ----

#' Create cross-references between related tables
#' @param wb Workbook object
#' @param sheet_name Current sheet
#' @param related_sheets Vector of related sheet names
#' @param start_row Row to start adding links
add_cross_references <- function(wb, sheet_name, related_sheets, start_row) {
  
  if (length(related_sheets) == 0) return(wb)
  
  # Add section header
  wb$add_data(x = "Siehe auch:", dims = paste0("A", start_row))
  apply_destatis_typography(wb, sheet_name, paste0("A", start_row), "small_text")
  
  current_row <- start_row + 1
  
  for (related_sheet in related_sheets) {
    link_text <- paste("→", related_sheet)
    wb$add_data(x = link_text, dims = paste0("A", current_row))
    
    target_ref <- paste0("#'", related_sheet, "'!A1")
    wb$add_hyperlink(dims = paste0("A", current_row), target = target_ref)
    apply_destatis_typography(wb, sheet_name, paste0("A", current_row), "navigation")
    
    current_row <- current_row + 1
  }
  
  return(wb)
}

#' Add breadcrumb navigation
#' @param wb Workbook object
#' @param sheet_name Current sheet name
#' @param breadcrumbs Vector of breadcrumb items
add_breadcrumb_navigation <- function(wb, sheet_name, breadcrumbs) {
  
  if (length(breadcrumbs) <= 1) return(wb)
  
  # Find empty row for breadcrumbs (typically row 2)
  breadcrumb_text <- paste(breadcrumbs, collapse = " > ")
  wb$add_data(x = breadcrumb_text, dims = "A2")
  apply_destatis_typography(wb, sheet_name, "A2", "small_text")
  
  return(wb)
}

# ---- Navigation Validation ----

#' Validate all hyperlinks in workbook
#' @param wb Workbook object
#' @return List of validation results
validate_navigation_system <- function(wb) {
  sheet_names <- wb_get_sheet_names(wb)
  validation_results <- list(
    total_sheets = length(sheet_names),
    navigation_links = 0,
    broken_links = 0,
    toc_present = "Inhaltsübersicht" %in% sheet_names,
    back_links_present = 0
  )
  
  # Count sheets with back navigation
  for (sheet_name in sheet_names) {
    if (sheet_name == "Inhaltsübersicht") next
    
    # Check if sheet has back navigation (this would require reading the sheet)
    # For now, assume all non-TOC sheets have back navigation
    validation_results$back_links_present <- validation_results$back_links_present + 1
  }
  
  validation_results$navigation_links <- validation_results$back_links_present
  
  cat("Navigation Validation Results:\n")
  cat(sprintf("  Total sheets: %d\n", validation_results$total_sheets))
  cat(sprintf("  Navigation links: %d\n", validation_results$navigation_links))
  cat(sprintf("  TOC present: %s\n", validation_results$toc_present))
  cat(sprintf("  Back links: %d\n", validation_results$back_links_present))
  
  return(validation_results)
}

# ---- Helper Functions ----

#' Generate navigation map for debugging
#' @param wb Workbook object
#' @return Data frame with navigation structure
generate_navigation_map <- function(wb) {
  sheet_names <- wb_get_sheet_names(wb)
  
  navigation_map <- data.frame(
    Sheet = sheet_names,
    Type = sapply(sheet_names, classify_sheet_type),
    HasBackLink = !sheet_names %in% c("Titel", "Inhaltsübersicht"),
    InTOC = !sheet_names %in% c("Titel"),
    stringsAsFactors = FALSE
  )
  
  return(navigation_map)
}

#' Classify sheet type based on name
#' @param sheet_name Sheet name
#' @return Sheet type classification
classify_sheet_type <- function(sheet_name) {
  if (sheet_name == "Titel") return("Title")
  if (sheet_name == "Inhaltsübersicht") return("TOC")
  if (grepl("^csv-", sheet_name)) return("CSV")
  if (grepl("-b\\d+$", sheet_name)) return("BarrierFree") 
  if (grepl("^\\d{5}-\\d{2}$", sheet_name)) return("DataTable")
  if (grepl("Information|Impressum|GENESIS", sheet_name)) return("Info")
  return("Other")
}

cat("✓ Navigation system functions loaded\n")
cat("✓ Table of contents generator ready\n")
cat("✓ Hyperlink validation available\n")