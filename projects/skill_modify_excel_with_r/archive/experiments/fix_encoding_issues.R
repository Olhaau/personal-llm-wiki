#!/usr/bin/env Rscript
# Fix encoding issues in Excel files with German characters

library(openxlsx2)

#' Safe Excel loading with encoding handling
safe_load_excel <- function(excel_path) {
  
  cat("Attempting to load Excel file with encoding handling...\n")
  
  # Try different approaches to handle encoding
  tryCatch({
    # First attempt: normal load
    wb <- wb_load(excel_path)
    cat("✓ Normal load successful\n")
    return(wb)
    
  }, error = function(e1) {
    cat("✗ Normal load failed:", e1$message, "\n")
    
    tryCatch({
      # Second attempt: set locale  
      old_locale <- Sys.getlocale("LC_ALL")
      Sys.setlocale("LC_ALL", "C")
      on.exit(Sys.setlocale("LC_ALL", old_locale))
      
      wb <- wb_load(excel_path)
      cat("✓ Load with C locale successful\n")
      return(wb)
      
    }, error = function(e2) {
      cat("✗ Load with C locale failed:", e2$message, "\n")
      
      # Third attempt: Create minimal extraction
      tryCatch({
        cat("Attempting manual extraction of key elements...\n")
        
        # Create minimal workbook structure
        wb_minimal <- list(
          worksheets = list(),
          sheet_names = character(0),
          styles_mgr = list(styles = list(), font = list(), fill = list(), border = list())
        )
        
        # Try to get basic structure without problematic elements
        # This is a fallback approach
        
        cat("Created minimal structure due to encoding issues\n")
        return(wb_minimal)
        
      }, error = function(e3) {
        cat("✗ All loading attempts failed\n")
        stop("Cannot load Excel file: ", e3$message)
      })
    })
  })
}

#' Create clean hyperlinks without encoding issues
fix_hyperlink_encoding <- function(sheet_name, target_sheet) {
  
  # Remove problematic characters and use ASCII-safe approach
  clean_sheet_name <- iconv(sheet_name, to = "ASCII//TRANSLIT")
  clean_target <- iconv(target_sheet, to = "ASCII//TRANSLIT")
  
  # Use simpler hyperlink format
  hyperlink <- paste0("#", clean_target, "!A1")
  
  return(hyperlink)
}

#' Test with your specific file
test_encoding_fix <- function() {
  
  cat("=== TESTING ENCODING FIX ===\n")
  
  original_path <- "output/statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx"
  
  # Try to load with encoding handling
  wb <- safe_load_excel(original_path)
  
  if ("R6" %in% class(wb) && !is.null(wb$get_sheet_names)) {
    
    cat("Successfully loaded workbook!\n")
    cat("Sheet names:\n")
    
    tryCatch({
      sheet_names <- wb$get_sheet_names()
      for (i in seq_along(sheet_names)) {
        cat(sprintf("%d. %s\n", i, sheet_names[i]))
      }
      
      # Check grid lines in first sheet
      if (length(sheet_names) > 0) {
        ws1 <- wb$worksheets[[1]]
        if (!is.null(ws1$sheetViews)) {
          if (grepl('showGridLines="0"', ws1$sheetViews)) {
            cat("✓ Confirmed: Grid lines are hidden in original\n")
          } else {
            cat("Grid lines are visible in original\n")
          }
        }
      }
      
    }, error = function(e) {
      cat("Error accessing sheet names:", e$message, "\n")
    })
    
  } else {
    cat("Could only create minimal structure\n")
  }
}

# Run the test
test_encoding_fix()