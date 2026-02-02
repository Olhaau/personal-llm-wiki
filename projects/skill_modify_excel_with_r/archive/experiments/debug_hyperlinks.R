#!/usr/bin/env Rscript
# Debug hyperlink parsing issues

library(openxlsx2)

# Load the original file to examine hyperlinks in detail
original_path <- 'output/statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx'
wb_original <- wb_load(original_path)

# Focus on the table of contents sheet
toc_sheet <- grep('bersicht', wb_original$get_sheet_names(), value = TRUE)[1]
sheet_idx <- which(wb_original$get_sheet_names() == toc_sheet)
ws_toc <- wb_original$worksheets[[sheet_idx]]

cat("=== DEBUGGING HYPERLINKS ===\n")
cat("Table of contents sheet:", toc_sheet, "\n\n")

if (!is.null(ws_toc$hyperlinks)) {
  hyperlinks_xml <- ws_toc$hyperlinks
  cat("Raw hyperlinks XML:\n")
  cat(substr(hyperlinks_xml, 1, 500), "...\n\n")
  
  # Try different parsing approaches
  cat("=== PARSING ATTEMPT 1: Simple extraction ===\n")
  
  # Extract location patterns
  locations <- regmatches(hyperlinks_xml, gregexpr('location="[^"]*"', hyperlinks_xml))
  if (length(locations[[1]]) > 0) {
    cat("Found locations:\n")
    for (i in 1:min(5, length(locations[[1]]))) {
      cat(sprintf("%d. %s\n", i, locations[[1]][i]))
    }
  }
  
  cat("\n=== PARSING ATTEMPT 2: Individual hyperlinks ===\n")
  
  # Split into individual hyperlink tags
  individual_links <- regmatches(hyperlinks_xml, gregexpr('<hyperlink[^>]*/?>', hyperlinks_xml))
  
  if (length(individual_links[[1]]) > 0) {
    cat("Individual hyperlink tags:\n")
    for (i in 1:min(3, length(individual_links[[1]]))) {
      link <- individual_links[[1]][i]
      cat(sprintf("%d. %s\n", i, link))
      
      # Extract components
      ref_match <- regmatches(link, regexpr('ref="[^"]*"', link))
      if (length(ref_match) > 0) {
        ref <- gsub('ref="([^"]*)"', "\\1", ref_match)
        cat(sprintf("   ref: %s\n", ref))
      }
      
      location_match <- regmatches(link, regexpr('location="[^"]*"', link))
      if (length(location_match) > 0) {
        location <- gsub('location="([^"]*)"', "\\1", location_match)
        cat(sprintf("   location: %s\n", location))
        
        # Convert to proper format
        if (!startsWith(location, "#")) {
          if (startsWith(location, "'") || grepl("!", location)) {
            target <- paste0("#", location)
          } else {
            target <- paste0("#'", location, "'!A1")
          }
        } else {
          target <- location
        }
        cat(sprintf("   target: %s\n", target))
      }
      cat("\n")
    }
  }
  
  cat("\n=== TESTING SIMPLE HYPERLINK CREATION ===\n")
  
  # Create a test workbook with working hyperlinks
  wb_test <- wb_workbook()
  wb_test$add_worksheet("TestTOC")
  wb_test$add_worksheet("TestTarget")
  
  # Add some data
  wb_test$add_data("TestTOC", "Click here to go to TestTarget", dims = "A1")
  wb_test$add_data("TestTarget", "You reached the target!", dims = "A1")
  
  # Add hyperlink with correct syntax
  wb_test$add_hyperlink(
    sheet = "TestTOC",
    dims = "A1", 
    target = "#'TestTarget'!A1"
  )
  
  # Style the hyperlink
  wb_test$add_font(
    sheet = "TestTOC",
    dims = "A1",
    color = wb_color("blue"),
    underline = TRUE
  )
  
  wb_save(wb_test, "output/test_working_hyperlinks.xlsx", overwrite = TRUE)
  cat("Created test file with working hyperlinks: output/test_working_hyperlinks.xlsx\n")
  
  # Verify the hyperlinks work in the test file
  wb_test_check <- wb_load("output/test_working_hyperlinks.xlsx")
  ws_test_toc <- wb_test_check$worksheets[[1]]
  
  if (!is.null(ws_test_toc$hyperlinks)) {
    cat("Test file hyperlinks XML:\n")
    cat(ws_test_toc$hyperlinks, "\n")
  }
  
} else {
  cat("No hyperlinks found\n")
}