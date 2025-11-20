#!/usr/bin/env Rscript

# Test script to reproduce the leading 's' removal issue in fix_gt_headers()

library(gt)
source("fix_gt_headers.R")
source("table.R")

cat("=== Testing fix_gt_headers with table.R data ===\n")

cat("\nOriginal column names:\n")
print(names(df))

# Create GT table
gt_table <- df |> gt()

cat("\nOriginal GT table column names:\n")
print(names(gt_table$`_data`))

# Apply fix_gt_headers with mapping preservation
fixed_table <- fix_gt_headers(gt_table, preserve_mapping = TRUE)

cat("\nFixed GT table column names:\n")
print(names(fixed_table$`_data`))

# Show the mapping to see what happened
mapping <- get_name_mapping(fixed_table)
cat("\nColumn name mapping:\n")
print(mapping)

# Test individual column names with generate_valid_html_id
cat("\n=== Testing individual column name processing ===\n")

test_names <- c("single_low income", "single_high income", "married_low income", "married_high income")

for (name in test_names) {
  result <- generate_valid_html_id(name)
  cat(sprintf("'%s' -> '%s'\n", name, result))
}

cat("\n=== Testing generate_valid_html_id step by step for 'single_low income' ===\n")

# Let's trace through the function step by step
test_name <- "single_low income"
cat(sprintf("Original: '%s'\n", test_name))

# Test character mapping step
id <- test_name
cat(sprintf("After initial assignment: '%s'\n", id))

# Test the character mapping section manually
# Look for 's' in CHARACTER_MAPPING
if ("s" %in% names(CHARACTER_MAPPING)) {
  cat("WARNING: 's' found in CHARACTER_MAPPING!\n")
  cat(sprintf("Replacement would be: '%s'\n", CHARACTER_MAPPING[["s"]]))
} else {
  cat("'s' not found in CHARACTER_MAPPING (good)\n")
}

# Test space replacement
id_after_spaces <- gsub("[\\s\\t]+", "-", id)
cat(sprintf("After space replacement: '%s'\n", id_after_spaces))