#!/usr/bin/env Rscript
# Complete fix for hyperlinks in Excel round-trip process

library(openxlsx2)
library(jsonlite)

#' Parse hyperlinks from XML and convert to openxlsx2 format
parse_hyperlinks <- function(hyperlinks_xml) {
  
  if (is.null(hyperlinks_xml) || length(hyperlinks_xml) == 0 || 
      all(nchar(hyperlinks_xml) == 0)) {
    return(list())
  }
  
  cat("Parsing hyperlinks from XML...\n")
  
  # Extract hyperlink patterns
  # Pattern: <hyperlink ref="A3" location="'SheetName'!A1" display="Text"/>
  pattern <- '<hyperlink\\s+ref="([^"]+)"\\s+location="([^"]+)"\\s+display="([^"]*)"[^>]*/?>'
  
  matches <- regmatches(hyperlinks_xml, gregexpr(pattern, hyperlinks_xml, perl = TRUE))
  
  hyperlinks <- list()
  
  if (length(matches[[1]]) > 0) {
    for (match in matches[[1]]) {
      # Extract components
      ref <- gsub(pattern, "\\1", match, perl = TRUE)
      location <- gsub(pattern, "\\2", match, perl = TRUE)  
      display <- gsub(pattern, "\\3", match, perl = TRUE)
      
      # Convert location format for openxlsx2
      # From: 'SheetName'!A1 or SheetName!A1
      # To: #'SheetName'!A1
      
      target <- location
      if (!startsWith(target, "#")) {
        if (startsWith(target, "'") || !grepl("'", target)) {
          # Already has quotes or no quotes needed
          target <- paste0("#", target)
        } else {
          # Add quotes around sheet name
          parts <- strsplit(target, "!")[[1]]
          if (length(parts) == 2) {
            sheet_part <- parts[1]
            cell_part <- parts[2]
            target <- paste0("#'", sheet_part, "'!", cell_part)
          }
        }
      }
      
      hyperlinks[[length(hyperlinks) + 1]] <- list(
        ref = ref,
        target = target,
        display = display,
        original_location = location
      )
    }
  }
  
  cat(sprintf("Parsed %d hyperlinks\n", length(hyperlinks)))
  return(hyperlinks)
}

#' Enhanced JSON to Excel with proper hyperlink restoration
json_to_excel_with_hyperlinks <- function(json_path, excel_path) {
  
  cat("=== ENHANCED JSON TO EXCEL WITH HYPERLINK FIX ===\n")
  
  # Load JSON
  json_data <- read_json(json_path)
  
  # Create workbook
  wb <- wb_workbook()
  
  # Process each worksheet
  for (sheet_name in names(json_data$worksheets)) {
    sheet_data <- json_data$worksheets[[sheet_name]]
    
    cat("Processing sheet:", sheet_name, "\n")
    
    # Add worksheet
    wb$add_worksheet(sheet_name)
    
    # Restore data
    if (!is.null(sheet_data$data) && is.data.frame(sheet_data$data) && nrow(sheet_data$data) > 0) {
      wb$add_data(sheet_name, sheet_data$data, dims = "A1")
    }
    
    # Restore grid lines
    if (isTRUE(sheet_data$grid_lines_hidden)) {
      cat("✓ Restoring hidden grid lines for", sheet_name, "\n")
      wb$set_grid_lines(sheet_name, show = FALSE)
    }
    
    # CRITICAL: Restore hyperlinks with correct format
    if (!is.null(sheet_data$hyperlinks_xml) && length(sheet_data$hyperlinks_xml) > 0 && 
        any(nchar(sheet_data$hyperlinks_xml) > 0)) {
      
      cat("✓ Restoring hyperlinks for", sheet_name, "\n")
      
      # Parse hyperlinks from XML
      hyperlinks <- parse_hyperlinks(sheet_data$hyperlinks_xml)
      
      for (hyperlink in hyperlinks) {
        tryCatch({
          # Add hyperlink with correct openxlsx2 syntax
          wb$add_hyperlink(
            sheet = sheet_name,
            dims = hyperlink$ref,
            target = hyperlink$target
          )
          
          # Add the display text
          wb$add_data(
            sheet = sheet_name,
            x = hyperlink$display,
            dims = hyperlink$ref
          )
          
          # Style as hyperlink (blue, underlined)
          wb$add_font(
            sheet = sheet_name,
            dims = hyperlink$ref,
            color = wb_color("blue"),
            underline = TRUE
          )
          
          cat(sprintf("  ✓ Added hyperlink: %s -> %s\n", hyperlink$ref, hyperlink$target))
          
        }, error = function(e) {
          cat(sprintf("  ✗ Failed to add hyperlink %s: %s\n", hyperlink$ref, e$message))
        })
      }
    }
  }
  
  # Save workbook
  wb_save(wb, excel_path, overwrite = TRUE)
  
  cat("Enhanced Excel file with working hyperlinks saved to:", excel_path, "\n")
  return(wb)
}

#' Test the complete hyperlink fix
test_hyperlink_fix <- function() {
  
  cat("=== TESTING HYPERLINK FIX ===\n")
  
  # Use the existing JSON structure from previous conversion
  json_path <- "output/complete_fixed_structure.json"
  excel_path <- "output/hyperlinks_fixed.xlsx"
  
  if (file.exists(json_path)) {
    
    cat("Using existing JSON structure...\n")
    
    # Convert with hyperlink fix
    json_to_excel_with_hyperlinks(json_path, excel_path)
    
    # Validate the results
    cat("\n=== VALIDATION ===\n")
    
    # Load the recreated file
    wb_fixed <- wb_load(excel_path)
    
    # Check the table of contents sheet
    toc_candidates <- grep('bersicht', wb_fixed$get_sheet_names(), value = TRUE)
    
    if (length(toc_candidates) > 0) {
      toc_sheet <- toc_candidates[1]
      sheet_idx <- which(wb_fixed$get_sheet_names() == toc_sheet)
      ws_toc_fixed <- wb_fixed$worksheets[[sheet_idx]]
      
      if (!is.null(ws_toc_fixed$hyperlinks)) {
        cat("✅ Hyperlinks successfully restored in", toc_sheet, "\n")
        
        # Check if they use the correct format
        if (grepl('#', ws_toc_fixed$hyperlinks)) {
          cat("✅ Hyperlinks use correct '#SheetName'!A1 format\n")
        } else {
          cat("❌ Hyperlinks missing # prefix\n")
        }
        
        # Show a sample
        sample_hyperlink <- substr(ws_toc_fixed$hyperlinks, 1, 200)
        cat("Sample hyperlink:", sample_hyperlink, "...\n")
        
      } else {
        cat("❌ No hyperlinks found in recreated file\n")
      }
    }
    
    cat("\nRecreated file with fixed hyperlinks:", excel_path, "\n")
    
  } else {
    cat("JSON structure file not found. Run complete_formatting_fix.R first.\n")
  }
}

# Create a function to fix existing JSON with hyperlinks
fix_json_hyperlinks <- function() {
  
  cat("=== ENHANCING JSON WITH HYPERLINK DATA ===\n")
  
  # Load original Excel to extract hyperlinks
  original_path <- "output/statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx"
  json_path <- "output/complete_fixed_structure.json"
  
  if (file.exists(json_path)) {
    
    # Load existing JSON
    json_data <- read_json(json_path)
    
    # Load original Excel for hyperlink extraction
    wb_original <- wb_load(original_path)
    
    # Update JSON with hyperlink information
    for (sheet_name in names(json_data$worksheets)) {
      if (sheet_name %in% wb_original$get_sheet_names()) {
        sheet_idx <- which(wb_original$get_sheet_names() == sheet_name)
        ws_original <- wb_original$worksheets[[sheet_idx]]
        
        # Add hyperlinks to JSON structure
        if (!is.null(ws_original$hyperlinks)) {
          json_data$worksheets[[sheet_name]]$hyperlinks_xml <- ws_original$hyperlinks
          cat("Added hyperlinks for sheet:", sheet_name, "\n")
        }
      }
    }
    
    # Save updated JSON
    write_json(json_data, json_path, auto_unbox = TRUE, pretty = TRUE)
    cat("Updated JSON with hyperlink data\n")
    
  } else {
    cat("JSON file not found\n")
  }
}

# Run the complete fix
cat("=== COMPLETE HYPERLINK FIX PROCESS ===\n")

# Step 1: Enhance JSON with hyperlink data
fix_json_hyperlinks()

# Step 2: Test the hyperlink restoration
test_hyperlink_fix()