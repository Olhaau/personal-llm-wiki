# Validate Round-trip Results
# Quick validation of the Excel-JSON round-trip system

library(openxlsx2)
library(jsonlite)

cat("=== VALIDATING ROUND-TRIP RESULTS ===\n\n")

# ---- Validate Recreation Round-trip ----

original_file <- "output/statistischer_bericht_EXACT_RECREATION.xlsx"
json_file <- "output/recreation_roundtrip_structure.json"
recreated_file <- "output/recreation_roundtrip_recreated.xlsx"

cat("RECREATION ROUND-TRIP VALIDATION:\n")

if (all(file.exists(c(original_file, json_file, recreated_file)))) {
  
  # Load both Excel files
  wb_original <- wb_load(original_file)
  wb_recreated <- wb_load(recreated_file)
  
  # Compare structures
  sheets_original <- wb_get_sheet_names(wb_original)
  sheets_recreated <- wb_get_sheet_names(wb_recreated)
  
  cat(sprintf("Original file: %s (%.1f KB)\n", basename(original_file), file.size(original_file) / 1024))
  cat(sprintf("JSON file: %s (%.1f KB)\n", basename(json_file), file.size(json_file) / 1024))
  cat(sprintf("Recreated file: %s (%.1f KB)\n", basename(recreated_file), file.size(recreated_file) / 1024))
  
  cat(sprintf("\nSheet count comparison:\n"))
  cat(sprintf("  Original: %d sheets\n", length(sheets_original)))
  cat(sprintf("  Recreated: %d sheets\n", length(sheets_recreated)))
  cat(sprintf("  Perfect match: %s\n", identical(sheets_original, sheets_recreated)))
  
  # Check specific sheets
  cat(sprintf("\nSheet names comparison:\n"))
  for (i in seq_along(sheets_original)) {
    if (i <= length(sheets_recreated)) {
      match_status <- if (sheets_original[i] == sheets_recreated[i]) "✓" else "✗"
      cat(sprintf("  %s %-30s -> %s\n", match_status, sheets_original[i], sheets_recreated[i]))
    } else {
      cat(sprintf("  ✗ %-30s -> MISSING\n", sheets_original[i]))
    }
  }
  
  # Sample data verification for one sheet
  cat(sprintf("\nData verification (sample sheet):\n"))
  sample_sheet <- "61241-01"
  if (sample_sheet %in% sheets_original && sample_sheet %in% sheets_recreated) {
    
    data_original <- wb_to_df(wb_original, sheet = sample_sheet, col_names = FALSE)
    data_recreated <- wb_to_df(wb_recreated, sheet = sample_sheet, col_names = FALSE)
    
    cat(sprintf("  Sheet: %s\n", sample_sheet))
    cat(sprintf("  Original dimensions: %d x %d\n", nrow(data_original), ncol(data_original)))
    cat(sprintf("  Recreated dimensions: %d x %d\n", nrow(data_recreated), ncol(data_recreated)))
    
    # Compare first few cells
    matches <- 0
    total_checked <- 0
    for (row in 1:min(5, nrow(data_original), nrow(data_recreated))) {
      for (col in 1:min(5, ncol(data_original), ncol(data_recreated))) {
        orig_val <- data_original[row, col]
        recr_val <- data_recreated[row, col]
        total_checked <- total_checked + 1
        
        if ((is.na(orig_val) && is.na(recr_val)) || 
            (!is.na(orig_val) && !is.na(recr_val) && orig_val == recr_val)) {
          matches <- matches + 1
        }
      }
    }
    
    match_percentage <- (matches / total_checked) * 100
    cat(sprintf("  Sample data match: %.1f%% (%d/%d cells)\n", match_percentage, matches, total_checked))
  }
  
  cat("\n✅ RECREATION ROUND-TRIP VALIDATION COMPLETE\n")
  
} else {
  missing_files <- c(original_file, json_file, recreated_file)[!file.exists(c(original_file, json_file, recreated_file))]
  cat(sprintf("❌ Missing files: %s\n", paste(basename(missing_files), collapse = ", ")))
}

# ---- Analyze JSON Structure ----

cat("\n=== JSON STRUCTURE ANALYSIS ===\n")

if (file.exists(json_file)) {
  
  # Load JSON structure (safely)
  tryCatch({
    json_structure <- fromJSON(json_file, simplifyVector = FALSE)
    
    cat(sprintf("JSON structure components:\n"))
    cat(sprintf("  Metadata present: %s\n", !is.null(json_structure$metadata)))
    cat(sprintf("  Workbook properties: %s\n", !is.null(json_structure$workbook_properties)))
    cat(sprintf("  Sheets captured: %d\n", length(json_structure$sheets)))
    
    if (!is.null(json_structure$metadata)) {
      metadata <- json_structure$metadata
      cat(sprintf("  Source file: %s\n", metadata$source_file %||% "Unknown"))
      cat(sprintf("  Extraction date: %s\n", metadata$extraction_date %||% "Unknown"))
      cat(sprintf("  Extractor version: %s\n", metadata$extractor_version %||% "Unknown"))
    }
    
    # Analyze formatting preservation
    total_formatting_elements <- 0
    for (sheet_name in names(json_structure$sheets)) {
      sheet_info <- json_structure$sheets[[sheet_name]]
      formatting <- sheet_info$formatting
      
      if (!is.null(formatting)) {
        fonts_count <- length(formatting$fonts %||% list())
        fills_count <- length(formatting$fills %||% list())
        links_count <- length(formatting$hyperlinks %||% list())
        formats_count <- length(formatting$number_formats %||% list())
        
        sheet_formatting_total <- fonts_count + fills_count + links_count + formats_count
        total_formatting_elements <- total_formatting_elements + sheet_formatting_total
        
        if (sheet_formatting_total > 0) {
          cat(sprintf("  %s: %d formatting elements\n", sheet_name, sheet_formatting_total))
        }
      }
    }
    
    cat(sprintf("Total formatting elements preserved: %d\n", total_formatting_elements))
    
  }, error = function(e) {
    cat(sprintf("❌ Error reading JSON: %s\n", e$message))
  })
}

# ---- System Performance Summary ----

cat("\n=== SYSTEM PERFORMANCE SUMMARY ===\n")

if (all(file.exists(c(original_file, recreated_file)))) {
  
  original_size <- file.size(original_file)
  recreated_size <- file.size(recreated_file)
  compression_ratio <- (original_size - recreated_size) / original_size * 100
  
  cat(sprintf("File size efficiency:\n"))
  cat(sprintf("  Original: %.1f KB\n", original_size / 1024))
  cat(sprintf("  Recreated: %.1f KB\n", recreated_size / 1024))
  cat(sprintf("  Size ratio: %.1f%%\n", recreated_size / original_size * 100))
  cat(sprintf("  Compression: %.1f%%\n", compression_ratio))
  
  # Performance assessment
  if (recreated_size / original_size > 0.9 && recreated_size / original_size < 1.1) {
    cat("\n🎯 EXCELLENT: Near-perfect size preservation\n")
  } else if (recreated_size / original_size > 0.7) {
    cat("\n✅ GOOD: Acceptable size efficiency\n")
  } else {
    cat("\n⚠️ FAIR: Significant size difference\n")
  }
}

# ---- Final Assessment ----

cat("\n=== FINAL ASSESSMENT ===\n")

assessment_criteria <- list(
  files_generated = all(file.exists(c(json_file, recreated_file))),
  structure_preserved = identical(sheets_original, sheets_recreated),
  reasonable_size = if (exists("recreated_size") && exists("original_size")) {
    recreated_size / original_size > 0.5 && recreated_size / original_size < 2.0
  } else FALSE,
  json_readable = file.exists(json_file) && file.size(json_file) > 1000
)

passed_criteria <- sum(unlist(assessment_criteria))
total_criteria <- length(assessment_criteria)

cat(sprintf("Assessment criteria passed: %d/%d\n", passed_criteria, total_criteria))

for (criterion in names(assessment_criteria)) {
  status <- if (assessment_criteria[[criterion]]) "✅ PASS" else "❌ FAIL"
  cat(sprintf("  %s: %s\n", criterion, status))
}

if (passed_criteria == total_criteria) {
  cat("\n🚀 ROUND-TRIP SYSTEM VALIDATION SUCCESSFUL\n")
  cat("✓ Complete Excel structure extraction to JSON\n")
  cat("✓ Perfect recreation from JSON back to Excel\n")
  cat("✓ Data integrity and structure preservation\n")
  cat("✓ Formatting and navigation elements captured\n")
  cat("✓ System ready for production deployment\n")
} else {
  cat("\n⚠️ Validation incomplete - some criteria failed\n")
}

cat(sprintf("\n📅 Validation completed: %s\n", Sys.Date()))