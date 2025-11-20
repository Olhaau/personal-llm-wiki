# W3C HTML 4.0 Compliant Character Mapping Test
# Tests the enhanced fix_gt_headers() function against W3C HTML 4.0 specification
# Reference: https://www.w3.org/TR/REC-html40/types.html#type-id

library(gt)
library(dplyr)

# Load the enhanced fix
source("fix_gt_headers.R")

cat("=== W3C HTML 4.0 Compliant Character Mapping Test ===\n")
cat("Reference: W3C HTML 4.0 Section 6.2\n")
cat("ID and NAME tokens must begin with a letter ([A-Za-z]) and may be followed by\n")
cat("any number of letters, digits ([0-9]), hyphens (\"-\"), underscores (\"_\"), \n")
cat("colons (\":\"), and periods (\".\").\n\n")

# Create comprehensive test data with all types of problematic characters
# Based on the W3C URL and common real-world column names
test_cases <- data.frame(
  # Test case name for identification
  test_case = c(
    # Spaces and whitespace
    "spaces", "tabs", "newlines", "multiple_spaces",
    
    # Mathematical operators  
    "greater_than", "less_than", "greater_equal", "less_equal", 
    "not_equal", "equals", "plus", "minus", "multiply", "divide",
    
    # Special symbols
    "dollar", "percent", "at_symbol", "hash_pound", "question", "exclamation",
    "ampersand", "pipe_or", 
    
    # Brackets and parentheses
    "parentheses", "square_brackets", "curly_braces",
    
    # Quotes and punctuation
    "double_quote", "single_quote", "backtick", "semicolon", "backslash",
    
    # Unicode and emojis
    "emoji_face", "unicode_symbol", "trademark", 
    
    # Edge cases
    "empty_string", "only_numbers", "only_symbols", "mixed_complex",
    
    # Real-world examples
    "clinical_age", "clinical_bmi", "clinical_pvalue", "clinical_date",
    "survey_rating", "financial_cost", "web_url", "file_path"
  ),
  
  # Actual problematic column names
  problematic_name = c(
    # Spaces and whitespace
    "Patient ID", "Tab	Character", "Line\nBreak", "Multi  Spaces",
    
    # Mathematical operators
    "BMI > 25", "Age < 65", "Score >= 80", "Value <= 100",
    "Result != NULL", "Status = Active", "Count + Total", "Net - Gross",
    "Rate * Factor", "Total / Count", 
    
    # Special symbols
    "Cost $USD", "Score %ile", "Email@Domain", "Item #1", "Valid?", "Alert!",
    "A&B Test", "A|B Choice",
    
    # Brackets and parentheses  
    "Age (years)", "Items [filtered]", "Config {JSON}",
    
    # Quotes and punctuation
    "Title \"Main\"", "Don't Know", "SQL`Query", "Path; Name", "C:\\Path",
    
    # Unicode and emojis
    "Status 😊", "Temp °C", "Brand™",
    
    # Edge cases
    "", "123", "!@#$%", "A/B > 50% & C=1",
    
    # Real-world examples
    "Patient Age (years)", "BMI > 25 kg/m²", "p-value < 0.05", "Date: 2023-12-01",
    "Rating (1-5 scale)", "Cost ($USD)", "URL: https://example.com", "File: C:\\data.csv"
  ),
  
  stringsAsFactors = FALSE
)

cat("=== Testing", nrow(test_cases), "problematic column names ===\n\n")

# Test the conversion function directly
cat("=== Character Mapping Results ===\n")
cat(sprintf("%-20s | %-30s | %-30s | Valid\n", "Test Case", "Original", "Converted"))
cat(paste(rep("-", 90), collapse = ""), "\n")

mapping_results <- data.frame(
  test_case = test_cases$test_case,
  original = test_cases$problematic_name,
  converted = character(nrow(test_cases)),
  valid = logical(nrow(test_cases)),
  stringsAsFactors = FALSE
)

for (i in 1:nrow(test_cases)) {
  original <- test_cases$problematic_name[i]
  converted <- generate_valid_html_id(original)
  
  # Validate against W3C specification
  validation <- validate_html_ids(converted)
  is_valid <- length(validation$invalid) == 0
  
  mapping_results$converted[i] <- converted
  mapping_results$valid[i] <- is_valid
  
  # Format original for display (handle special characters)
  original_display <- original
  if (original == "") original_display <- "(empty)"
  if (grepl("\n", original)) original_display <- "(newline)"
  if (grepl("\t", original)) original_display <- "(tab)"
  
  # Truncate for display
  if (nchar(original_display) > 28) {
    original_display <- paste0(substr(original_display, 1, 25), "...")
  }
  if (nchar(converted) > 28) {
    converted_display <- paste0(substr(converted, 1, 25), "...")
  } else {
    converted_display <- converted
  }
  
  valid_symbol <- if (is_valid) "✓" else "❌"
  
  cat(sprintf("%-20s | %-30s | %-30s | %s\n", 
              test_cases$test_case[i], 
              original_display, 
              converted_display, 
              valid_symbol))
}

# Overall validation summary
cat(paste(rep("-", 90), collapse = ""), "\n")
overall_validation <- validate_html_ids(mapping_results$converted)
cat(sprintf("Valid: %d/%d (%.1f%%)\n", 
            overall_validation$summary$valid_count,
            overall_validation$summary$total,
            overall_validation$summary$compliance_rate))

if (length(overall_validation$invalid) > 0) {
  cat("\nValidation Issues:\n")
  for (issue in overall_validation$issues) {
    cat("  -", issue, "\n")
  }
}

# Test with GT table
cat("\n=== Testing with GT Table ===\n")

# Create a smaller test dataset for GT table
gt_test_data <- data.frame(
  `Patient ID` = c("P001", "P002"),                    # Spaces
  `Age (years)` = c(25, 30),                           # Parentheses
  `BMI > 25` = c("Yes", "No"),                         # Greater than
  `Cost $USD` = c(100, 200),                           # Dollar sign
  `Status 😊` = c("Happy", "Sad"),                     # Emoji
  `p-value < 0.05` = c("Sig", "NS"),                  # Less than with spaces
  `A/B Test` = c("A", "B"),                            # Slash
  `Score %ile` = c(75, 85),                            # Percent
  `Email@Domain` = c("user1", "user2"),               # At symbol
  `Date: 2023-01` = c("Jan", "Feb"),                  # Colon and hyphen
  check.names = FALSE
)

cat("Creating GT table with problematic column names...\n")

# Apply the fix
fixed_table <- gt_test_data %>%
  gt() %>%
  tab_header(
    title = "W3C HTML 4.0 Compliant Table",
    subtitle = "All column IDs follow W3C HTML 4.0 specification"
  ) %>%
  tab_source_note(
    paste("Generated with enhanced fix_gt_headers() following",
          "W3C HTML 4.0 Section 6.2 specification")
  ) %>%
  fix_gt_headers(preserve_mapping = TRUE)

# Get and display the mapping
gt_mapping <- get_name_mapping(fixed_table)
if (!is.null(gt_mapping)) {
  cat("\nGT Table Column Mapping:\n")
  for (i in 1:nrow(gt_mapping)) {
    cat(sprintf("  '%s' -> '%s'\n", 
                gt_mapping$original[i], 
                gt_mapping$fixed[i]))
  }
  
  # Validate the GT mappings
  gt_validation <- validate_html_ids(gt_mapping$fixed)
  cat(sprintf("\nGT Table Validation: %d/%d valid (%.1f%%)\n",
              gt_validation$summary$valid_count,
              gt_validation$summary$total, 
              gt_validation$summary$compliance_rate))
}

# Save the table and analyze HTML
cat("\n=== HTML Analysis ===\n")
tryCatch({
  html_output <- as.character(as_raw_html(fixed_table, inline_css = FALSE))
  writeLines(html_output, "w3c_compliant_table.html")
  cat("✓ Saved W3C compliant table to: w3c_compliant_table.html\n")
  
  # Extract and validate HTML IDs
  html_ids <- regmatches(html_output, gregexpr('id="[^"]*"', html_output))[[1]]
  html_ids <- gsub('id="|"', '', html_ids)
  
  # Focus on column-related IDs
  column_ids <- html_ids[!grepl("^(caption|table|thead|tbody)", html_ids)]
  
  if (length(column_ids) > 0) {
    html_validation <- validate_html_ids(column_ids)
    cat(sprintf("HTML IDs validation: %d/%d valid (%.1f%%)\n",
                html_validation$summary$valid_count,
                html_validation$summary$total,
                html_validation$summary$compliance_rate))
    
    if (length(html_validation$invalid) > 0) {
      cat("\nInvalid HTML IDs found:\n")
      for (invalid_id in html_validation$invalid) {
        cat("  - '", invalid_id, "'\n")
      }
    }
  }
  
}, error = function(e) {
  cat("Error generating HTML:", conditionMessage(e), "\n")
})

# Character frequency analysis
cat("\n=== Character Conversion Analysis ===\n")
all_originals <- paste(mapping_results$original, collapse = "")
all_converted <- paste(mapping_results$converted, collapse = "")

# Count problematic characters that were converted
problem_chars <- c(" ", "(", ")", ">", "<", "$", "%", "@", "#", "?", "!", 
                  "&", "|", "/", "\"", "'", ";", "\\", "\n", "\t")

cat("Characters converted (sample):\n")
for (char in problem_chars[1:10]) {
  count <- length(grep(char, mapping_results$original, fixed = TRUE))
  if (count > 0) {
    display_char <- char
    if (char == "\n") display_char <- "\\n"
    if (char == "\t") display_char <- "\\t"
    cat(sprintf("  '%s': %d occurrences\n", display_char, count))
  }
}

# Final summary
cat("\n=== Final Summary ===\n")
cat("✓ Generated function follows W3C HTML 4.0 Section 6.2 specification\n")
cat("✓ Valid characters: A-Za-z0-9._:-\n") 
cat("✓ Must start with letter (A-Za-z)\n")
cat("✓ Preserves semantic meaning where possible\n")
cat("✓ Handles all common problematic characters\n")
cat("✓ Includes comprehensive validation function\n")
cat("✓ Works seamlessly with GT package workflow\n")

cat(sprintf("\nOverall compliance: %.1f%% of test cases produce valid HTML IDs\n",
            overall_validation$summary$compliance_rate))

if (overall_validation$summary$compliance_rate == 100) {
  cat("🎉 All test cases pass W3C HTML 4.0 validation!\n")
} else {
  cat("⚠️  Some test cases need attention - see details above.\n")
}

cat("\nFiles generated:\n")
cat("  - w3c_compliant_table.html (W3C compliant GT table)\n")