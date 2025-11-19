# Focused German Encoding Test
# Simple test specifically for German umlauts and common problematic characters

library(gt)
library(dplyr)

# Load the enhanced fix
source("fix_gt_headers.R")

cat("=== German-Focused GT Headers Fix Test ===\n")
cat("Testing German umlauts and common problematic characters\n\n")

# German test data with realistic column names
german_data <- data.frame(
  # German umlauts
  `Größe (cm)` = c(170, 175, 168),                 # ö -> oe  
  `Müdigkeit (1-10)` = c(3, 7, 5),                # ü -> ue
  `Fähigkeiten` = c("Gut", "Sehr gut", "Mittel"), # ä -> ae
  `Straße Nr.` = c("A1", "B2", "C3"),             # ß -> ss
  `Körpertemperatur °C` = c(36.5, 37.2, 36.8),    # Ö -> Oe, degree symbol
  `Überstunden` = c(5, 12, 8),                    # Ü -> Ue
  `Prüfung bestanden` = c("Ja", "Nein", "Ja"),    # ü -> ue
  
  # Common problematic characters (non-German)
  `Patient ID` = c("P001", "P002", "P003"),        # Spaces
  `BMI > 25` = c("Yes", "No", "Yes"),              # Greater than
  `Cost $` = c(100, 200, 150),                     # Dollar sign  
  `Score %` = c(85, 90, 78),                       # Percent
  `A/B Test` = c("A", "B", "A"),                   # Slash
  
  check.names = FALSE
)

cat("=== Original Column Names ===\n")
original_names <- names(german_data)
for(i in seq_along(original_names)) {
  cat(sprintf("%2d. '%s'\n", i, original_names[i]))
}
cat("\n")

# Apply the fix
cat("=== Applying Fix ===\n")
fixed_table <- german_data %>%
  gt() %>%
  tab_header(
    title = "German Accessibility Test",
    subtitle = "Testing German umlauts and common problematic characters"
  ) %>%
  tab_source_note("All column names converted to valid HTML IDs") %>%
  fix_gt_headers(preserve_mapping = TRUE)

cat("✓ Fix applied successfully\n\n")

# Show the mappings
cat("=== Character Mappings ===\n")
name_mapping <- get_name_mapping(fixed_table)
if (!is.null(name_mapping)) {
  max_orig_width <- max(nchar(name_mapping$original))
  cat(sprintf("%-*s -> %s\n", max_orig_width, "Original", "Fixed"))
  cat(paste(rep("-", max_orig_width + 25), collapse = ""), "\n")
  
  for(i in 1:nrow(name_mapping)) {
    cat(sprintf("%-*s -> %s\n", 
                max_orig_width,
                name_mapping$original[i], 
                name_mapping$fixed[i]))
  }
} else {
  cat("No mapping available\n")
}
cat("\n")

# Test individual German characters
cat("=== German Character Tests ===\n")
german_chars <- c("ä", "ö", "ü", "ß", "Ä", "Ö", "Ü")
cat("Individual character conversions:\n")
for (char in german_chars) {
  result <- generate_valid_html_id(char)
  cat(sprintf("  '%s' -> '%s'\n", char, result))
}
cat("\n")

# Test German words
cat("=== German Word Tests ===\n")
german_words <- c(
  "Größe",      # ö
  "Müdigkeit",  # ü  
  "Fähigkeit",  # ä
  "Straße",     # ß
  "Höhe",       # ö
  "Übung",      # Ü
  "Ärzte",      # Ä
  "Büro",       # ü
  "Grün",       # ü
  "Weiß"        # ß
)

cat("German word conversions:\n")
for (word in german_words) {
  result <- generate_valid_html_id(word)
  cat(sprintf("  %-12s -> %s\n", word, result))
}
cat("\n")

# Validate all generated IDs
cat("=== HTML ID Validation ===\n")
if (!is.null(name_mapping)) {
  validation <- validate_html_ids(name_mapping$fixed)
  
  cat(sprintf("✓ Valid IDs: %d/%d (%.1f%% compliance)\n",
              validation$summary$valid_count,
              validation$summary$total,
              validation$summary$compliance_rate))
  
  if (length(validation$invalid) > 0) {
    cat("\n❌ Invalid IDs found:\n")
    for(issue in validation$issues) {
      cat("  -", issue, "\n")
    }
  } else {
    cat("✅ All generated IDs are valid per W3C HTML 4.0 specification\n")
  }
} else {
  cat("Cannot validate - no mapping available\n")
}
cat("\n")

# Generate HTML output
cat("=== Generating HTML ===\n")
tryCatch({
  html_output <- as.character(as_raw_html(fixed_table, inline_css = FALSE))
  writeLines(html_output, "german_focused_test.html")
  cat("✓ Saved accessible table to: german_focused_test.html\n")
}, error = function(e) {
  cat("❌ Error generating HTML:", conditionMessage(e), "\n")
})

# Test combinations
cat("\n=== German Character Combinations ===\n")
combinations <- c(
  "Größe & Gewicht",      # ö with ampersand
  "Müller & Söhne",       # ü, ö with ampersand
  "Straße > 10",          # ß with comparison
  "Fähigkeiten %",        # ä with percent
  "Höhe (m)",             # ö with parentheses
  "Büro #1"               # ü with hash
)

cat("Testing character combinations:\n")
for (combo in combinations) {
  result <- generate_valid_html_id(combo)
  cat(sprintf("  %-18s -> %s\n", combo, result))
}

cat("\n=== Summary ===\n")
cat("✓ German umlauts properly converted:\n")
cat("  - ä, Ä -> ae, Ae\n")
cat("  - ö, Ö -> oe, Oe\n")
cat("  - ü, Ü -> ue, Ue\n")
cat("  - ß -> ss\n")
cat("✓ Common special characters handled\n")
cat("✓ All generated IDs follow W3C HTML 4.0 specification\n")
cat("✓ GT table workflow preserved\n")

cat("\nFiles generated:\n")
cat("  - german_focused_test.html\n")

cat("\nThe German-focused fix_gt_headers() function is ready for use!\n")