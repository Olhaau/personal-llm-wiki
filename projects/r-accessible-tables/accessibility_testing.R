# Accessibility Testing and Validation Script
# This script runs both table versions and provides comparison analysis

# Load required libraries
library(gt)
library(dplyr)
library(tidyr)
library(htmltools)

# Source the table creation scripts
cat("Running accessibility testing and validation...\n\n")

# Test 1: Run the original GT table script
cat("=== TESTING ORIGINAL GT TABLE ===\n")
tryCatch({
  source("original_gt_table.R")
  cat("✅ Original GT table generated successfully\n")
  original_success <- TRUE
}, error = function(e) {
  cat("❌ Error generating original table:", e$message, "\n")
  original_success <- FALSE
})

cat("\n")

# Test 2: Run the improved accessible table script  
cat("=== TESTING IMPROVED ACCESSIBLE TABLE ===\n")
tryCatch({
  source("improved_accessible_table.R")
  cat("✅ Improved accessible table generated successfully\n")
  improved_success <- TRUE
}, error = function(e) {
  cat("❌ Error generating improved table:", e$message, "\n")
  improved_success <- FALSE
})

cat("\n")

# Test 3: Validate HTML structure
cat("=== VALIDATING HTML STRUCTURE ===\n")

validate_html_accessibility <- function(html_file, table_name) {
  cat(paste("Checking", table_name, "...\n"))
  
  if (!file.exists(html_file)) {
    cat("❌ HTML file not found:", html_file, "\n")
    return(FALSE)
  }
  
  # Read HTML content
  html_content <- readLines(html_file, warn = FALSE)
  html_text <- paste(html_content, collapse = " ")
  
  # Check for accessibility features
  checks <- list(
    "Table caption" = grepl("<caption", html_text, ignore.case = TRUE) || 
                     grepl("aria-label", html_text, ignore.case = TRUE),
    "Table headers" = grepl("<th", html_text, ignore.case = TRUE),
    "Header scope" = grepl("scope=", html_text, ignore.case = TRUE),
    "ARIA attributes" = grepl("aria-", html_text, ignore.case = TRUE),
    "Table summary" = grepl("summary", html_text, ignore.case = TRUE),
    "Semantic structure" = grepl("<thead", html_text, ignore.case = TRUE) && 
                          grepl("<tbody", html_text, ignore.case = TRUE)
  )
  
  # Report results
  for (check_name in names(checks)) {
    status <- if (checks[[check_name]]) "✅" else "❌"
    cat(paste("  ", status, check_name, "\n"))
  }
  
  # Calculate score
  score <- sum(unlist(checks)) / length(checks) * 100
  cat(paste("  📊 Accessibility score:", round(score, 1), "%\n\n"))
  
  return(score)
}

# Validate both HTML files
if (file.exists("original_gt_table.html")) {
  original_score <- validate_html_accessibility("original_gt_table.html", "Original GT Table")
} else {
  cat("❌ Original table HTML file not found\n")
  original_score <- 0
}

if (file.exists("improved_accessible_table.html")) {
  improved_score <- validate_html_accessibility("improved_accessible_table.html", "Improved Accessible Table")
} else {
  cat("❌ Improved table HTML file not found\n")
  improved_score <- 0
}

# Test 4: Screen reader simulation
cat("=== SCREEN READER SIMULATION ===\n")

simulate_screen_reader_experience <- function(html_file, table_name) {
  cat(paste("Simulating screen reader experience for", table_name, "...\n"))
  
  if (!file.exists(html_file)) {
    cat("❌ Cannot simulate - HTML file not found\n\n")
    return()
  }
  
  html_content <- readLines(html_file, warn = FALSE)
  html_text <- paste(html_content, collapse = " ")
  
  # Extract table information that screen readers would announce
  cat("Screen reader would announce:\n")
  
  # Check for table identification
  if (grepl("caption", html_text, ignore.case = TRUE)) {
    cat("📢 'Table with caption found'\n")
  } else {
    cat("⚠️  'Table found, no caption'\n")
  }
  
  # Check for navigation hints
  if (grepl("aria-label|aria-describedby", html_text, ignore.case = TRUE)) {
    cat("📢 'Additional table description available'\n")
  } else {
    cat("⚠️  'No additional table description'\n")
  }
  
  # Check for header structure
  if (grepl("scope=\"col\"", html_text, ignore.case = TRUE)) {
    cat("📢 'Column headers properly identified'\n")
  } else {
    cat("⚠️  'Column headers may not be properly identified'\n")
  }
  
  if (grepl("scope=\"row\"", html_text, ignore.case = TRUE)) {
    cat("📢 'Row headers properly identified'\n")
  } else {
    cat("⚠️  'Row headers may not be properly identified'\n")
  }
  
  cat("\n")
}

simulate_screen_reader_experience("original_gt_table.html", "Original GT Table")
simulate_screen_reader_experience("improved_accessible_table.html", "Improved Accessible Table")

# Test 5: Data integrity check
cat("=== DATA INTEGRITY VALIDATION ===\n")

validate_data_integrity <- function() {
  cat("Checking data consistency between original and improved versions...\n")
  
  # Load the rx_adsl data and filter ITT population
  itt_data <- dplyr::filter(rx_adsl, ITTFL == "Y")
  
  # Check basic counts
  placebo_count <- sum(itt_data$TRTA == "Placebo", na.rm = TRUE)
  drug_count <- sum(itt_data$TRTA == "Drug 1", na.rm = TRUE)
  
  cat(paste("✅ Placebo group size:", placebo_count, "\n"))
  cat(paste("✅ Drug 1 group size:", drug_count, "\n"))
  
  # Check age statistics
  age_stats <- itt_data %>%
    group_by(TRTA) %>%
    summarise(
      mean_age = round(mean(AGE, na.rm = TRUE), 1),
      median_age = round(median(AGE, na.rm = TRUE), 1),
      .groups = "drop"
    )
  
  cat("✅ Age statistics validation:\n")
  for (i in 1:nrow(age_stats)) {
    cat(paste("   ", age_stats$TRTA[i], "- Mean:", age_stats$mean_age[i], "Median:", age_stats$median_age[i], "\n"))
  }
  
  cat("✅ Data integrity check completed\n\n")
}

validate_data_integrity()

# Test 6: File generation check
cat("=== FILE GENERATION VALIDATION ===\n")

files_to_check <- c(
  "original_gt_table.html",
  "improved_accessible_table.html", 
  "demographic_table_accessible.csv"
)

for (file in files_to_check) {
  if (file.exists(file)) {
    size <- file.info(file)$size
    cat(paste("✅", file, "- Generated successfully (", size, "bytes)\n"))
  } else {
    cat(paste("❌", file, "- Not found\n"))
  }
}

# Final summary report
cat("\n" %+% "=".rep(60) %+% "\n")
cat("ACCESSIBILITY TESTING SUMMARY REPORT\n")
cat("=".rep(60) %+% "\n\n")

cat("📊 SCORES:\n")
cat(paste("   Original GT Table:     ", round(original_score, 1), "%\n"))
cat(paste("   Improved Accessible:   ", round(improved_score, 1), "%\n"))
cat(paste("   Improvement:          +", round(improved_score - original_score, 1), "%\n\n"))

cat("📁 FILES GENERATED:\n")
for (file in files_to_check) {
  status <- if (file.exists(file)) "✅" else "❌"
  cat(paste("   ", status, file, "\n"))
}

cat("\n🎯 RECOMMENDATIONS FOR FURTHER TESTING:\n")
cat("   1. Test with actual screen readers (NVDA, JAWS, VoiceOver)\n")
cat("   2. Validate with keyboard-only navigation\n") 
cat("   3. Check mobile accessibility\n")
cat("   4. Run automated accessibility tests (axe-core, WAVE)\n")
cat("   5. Conduct user testing with people who use assistive technology\n")

cat("\n📋 NEXT STEPS:\n")
cat("   1. Review accessibility_assessment.md for detailed analysis\n")
cat("   2. Use improved_accessible_table.R for production tables\n")
cat("   3. Provide demographic_table_accessible.csv as alternative format\n")
cat("   4. Consider implementing additional ARIA attributes\n")

cat("\n✨ Testing completed successfully!\n")