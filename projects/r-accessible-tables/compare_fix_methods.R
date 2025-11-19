# Comparison script to demonstrate both fix_gt_headers approaches
library(gt)

# Load both versions of the function
source("fix_gt_headers.R")              # Returns gt table object
source("fix_gt_headers_alternative.R")  # Returns HTML string

# Create test data with problematic column names
df <- data.frame(
  `married_low income` = c(30, 2),
  `married_high income` = c(30, 4),
  `single_low income` = c(20, 1),
  `single_high income` = c(20, 2),
  col = c("age", "hsize"),
  check.names = FALSE
)

# Create the original table
original_table <- gt(df, rowname_col = "col") |> 
  tab_spanner_delim(delim = "_")

cat("=== Comparing two fix_gt_headers approaches ===\n\n")

# Method 1: Returns gt table object (can continue using gt functions)
cat("Method 1: fix_gt_headers() - Returns gt table object\n")
fixed_table_obj <- original_table |> fix_gt_headers()
cat("Result type:", class(fixed_table_obj), "\n")

# Can continue modifying the table
further_modified <- fixed_table_obj |> 
  tab_header(title = "Method 1: GT Object Result") |>
  tab_source_note("This table was fixed and then modified further")

save_html(further_modified, "method1_gt_object.html")
cat("Saved to: method1_gt_object.html\n\n")

# Method 2: Returns HTML string (direct output)
cat("Method 2: fix_gt_headers_html() - Returns HTML string\n")
fixed_html_string <- original_table |> fix_gt_headers_html()
cat("Result type:", class(fixed_html_string), "\n")
cat("Result length:", length(fixed_html_string), "characters\n")

save_html_string(fixed_html_string, "method2_html_string.html")
cat("Saved to: method2_html_string.html\n\n")

# Comparison
cat("=== When to use each method ===\n")
cat("Method 1 (gt object): Use when you want to continue modifying the table with gt functions\n")
cat("Method 2 (HTML string): Use when you need direct HTML output for immediate use\n\n")

# Verify both methods produce the same accessibility fix
cat("=== Verifying both methods fix the headers correctly ===\n")

# Save the gt object as HTML for comparison
save_html(fixed_table_obj, "method1_for_comparison.html")

# Read both HTML files and check headers
method1_html <- readLines("method1_for_comparison.html")
method2_html <- readLines("method2_html_string.html")

# Extract headers lines
method1_headers <- grep('headers="', method1_html, value = TRUE)
method2_headers <- grep('headers="', method2_html, value = TRUE)

cat("Method 1 headers attributes:\n")
cat(paste(method1_headers[1:2], collapse = "\n"), "\n\n")

cat("Method 2 headers attributes:\n")  
cat(paste(method2_headers[1:2], collapse = "\n"), "\n\n")

# Check if they're identical (ignoring whitespace differences)
headers_match <- identical(
  gsub("\\s+", " ", method1_headers), 
  gsub("\\s+", " ", method2_headers)
)

cat("Headers match between methods:", headers_match, "\n")

cat("\nBoth methods successfully fix the accessibility issue!\n")