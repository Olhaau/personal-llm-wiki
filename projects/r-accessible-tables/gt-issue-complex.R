# GT Complex Character Issues Test Case
# This script demonstrates accessibility problems when GT tables contain
# column names with various problematic characters for HTML IDs

library(gt)
library(dplyr)

# Create test data with extremely problematic column names
test_data <- data.frame(
  `Patient ID` = c("P001", "P002", "P003"),                    # Spaces
  `Age (years)` = c(25, 30, 35),                               # Parentheses
  `BMI > 25` = c("Yes", "No", "Yes"),                          # Greater than symbol
  `Date: 2023-12-01` = c("Baseline", "Follow-up", "Final"),    # Colon and hyphens
  `Emoji Status 😊` = c("Happy", "Sad", "Neutral"),            # Emoji
  `Cost $USD` = c(100, 200, 150),                              # Dollar sign
  `Score %ile` = c(75, 85, 90),                                # Percent sign
  `A/B Test` = c("A", "B", "A"),                               # Slash
  `Co-morbidity` = c("None", "DM", "HTN"),                     # Hyphen
  `Treatment #1` = c("Drug A", "Drug B", "Placebo"),           # Hash/Number
  `p-value < 0.05` = c("Sig", "NS", "Sig"),                   # Less than
  `Measure@Time` = c(10.5, 12.3, 9.8),                        # At symbol
  `Multi  Spaces` = c("A", "B", "C"),                          # Multiple spaces
  `Tab	Character` = c("X", "Y", "Z"),                          # Tab character
  `Quote"Mark` = c("Val1", "Val2", "Val3"),                    # Quote mark
  `[Bracket]` = c("Item1", "Item2", "Item3"),                  # Square brackets
  `{Curly}` = c("Set1", "Set2", "Set3"),                       # Curly braces
  `Apos'trophe` = c("Don't", "Can't", "Won't"),                # Apostrophe
  `Ampersand&Co` = c("A&B", "C&D", "E&F"),                     # Ampersand
  `Equal=Sign` = c("X=1", "Y=2", "Z=3"),                       # Equal sign
  `Plus+Sign` = c("A+", "B+", "O+"),                           # Plus sign
  `Question?` = c("Yes?", "No?", "Maybe?"),                    # Question mark
  `Line
Break` = c("Multi", "Line", "Text"),                           # Line break
  `Unicode™Symbol` = c("TM1", "TM2", "TM3"),                   # Unicode symbol
  `Backslash\\Path` = c("C:\\", "D:\\", "E:\\"),                # Backslash
  `123Numbers` = c("Start", "Middle", "End"),                  # Starting with numbers
  check.names = FALSE  # Preserve the problematic names
)

cat("=== GT Complex Character Issues Test ===\n")
cat("Creating table with problematic column names...\n\n")

# Show the problematic column names
cat("Problematic column names:\n")
for(i in seq_along(names(test_data))) {
  cat(sprintf("%2d. '%s'\n", i, names(test_data)[i]))
}
cat("\n")

# Create GT table (this will have accessibility issues)
problematic_table <- test_data |>
  gt() |>
  tab_header(
    title = "Complex Character Test Table",
    subtitle = "Demonstrating various problematic characters in column names"
  ) |>
  tab_source_note("This table has accessibility issues due to invalid HTML IDs")

cat("Creating GT table with problematic characters...\n")

# Save the problematic table
tryCatch({
  # Convert to HTML to see the issues
  html_output <- as.character(as_raw_html(problematic_table, inline_css = FALSE))
  
  # Write to file
  writeLines(html_output, "gt-issue-complex.html")
  cat("✓ Saved problematic table to: gt-issue-complex.html\n")
  
  # Analyze the HTML for accessibility issues
  cat("\n=== Accessibility Issues Analysis ===\n")
  
  # Extract column header IDs from HTML
  header_ids <- regmatches(html_output, gregexpr('id="[^"]*"', html_output))[[1]]
  header_ids <- gsub('id="|"', '', header_ids)
  header_ids <- header_ids[grepl("^[a-zA-Z0-9_-]+$", header_ids, invert = TRUE)]
  
  if(length(header_ids) > 0) {
    cat("Found", length(header_ids), "potentially invalid HTML IDs:\n")
    for(id in header_ids[1:min(10, length(header_ids))]) {
      cat(sprintf("  - '%s'\n", id))
    }
    if(length(header_ids) > 10) cat("  ... and", length(header_ids) - 10, "more\n")
  }
  
  # Check for headers attribute mismatches
  headers_attrs <- regmatches(html_output, gregexpr('headers="[^"]*"', html_output))[[1]]
  headers_attrs <- gsub('headers="|"', '', headers_attrs)
  
  cat("\n=== Header Reference Issues ===\n")
  cat("Sample headers attributes (may not match IDs):\n")
  for(attr in headers_attrs[1:min(5, length(headers_attrs))]) {
    cat(sprintf("  - headers='%s'\n", attr))
  }
  
}, error = function(e) {
  cat("Error creating table:", conditionMessage(e), "\n")
})

# Test specific problem characters
cat("\n=== Problem Character Analysis ===\n")
problem_chars <- c(
  " " = "Space",
  "(" = "Left Parenthesis", 
  ")" = "Right Parenthesis",
  ">" = "Greater Than",
  "<" = "Less Than",
  ":" = "Colon",
  ";" = "Semicolon",
  "\"" = "Quote Mark",
  "'" = "Apostrophe",
  "$" = "Dollar Sign",
  "%" = "Percent",
  "&" = "Ampersand",
  "/" = "Forward Slash",
  "\\" = "Backslash",
  "#" = "Hash/Pound",
  "@" = "At Symbol",
  "!" = "Exclamation",
  "?" = "Question Mark",
  "=" = "Equal Sign",
  "+" = "Plus Sign",
  "[" = "Left Bracket",
  "]" = "Right Bracket",
  "{" = "Left Brace",
  "}" = "Right Brace",
  "\n" = "Line Break",
  "\t" = "Tab",
  "™" = "Unicode Symbol",
  "😊" = "Emoji"
)

cat("Characters that cause HTML ID problems:\n")
for(char in names(problem_chars)) {
  if(char == "\n") {
    cat(sprintf("  - '\\n' (%s)\n", problem_chars[char]))
  } else if(char == "\t") {
    cat(sprintf("  - '\\t' (%s)\n", problem_chars[char]))
  } else {
    cat(sprintf("  - '%s' (%s)\n", char, problem_chars[char]))
  }
}

cat("\n=== Valid HTML ID Requirements ===\n")
cat("HTML ID attributes must:\n")
cat("  - Start with a letter (a-z, A-Z) or underscore (_)\n")
cat("  - Contain only letters, digits, hyphens (-), underscores (_), colons (:), and periods (.)\n")
cat("  - Be unique within the document\n")
cat("  - Not contain spaces or most special characters\n")
cat("  - Be case-sensitive\n")

cat("\n=== Next Steps ===\n")
cat("1. Run fix_gt_headers_enhanced.R to see the enhanced fix\n")
cat("2. Compare gt-issue-complex.html with gt-issue-complex-fixed.html\n")
cat("3. Validate accessibility improvements\n")

cat("\nTest completed. Check gt-issue-complex.html to see the accessibility issues.\n")