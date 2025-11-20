# Test script to demonstrate the fix_gt_headers function
library(gt)
source("fix_gt_headers.R")

# Recreate the problematic table from gt-issue.R
df <- data.frame(
  `married_low income` = c(30, 2),
  `married_high income` = c(30, 4),
  `single_low income` = c(20, 1),
  `single_high income` = c(20, 2),
  col = c("age", "hsize"),
  check.names = FALSE
)

# Create the original table with the issue
original_table <- gt(df, rowname_col = "col") |> 
  tab_spanner_delim(delim = "_")

# Fix the headers issue - now returns a gt table object
fixed_table <- original_table |> fix_gt_headers()

# Verify the function returns a gt table
cat("Original table class:", class(original_table), "\n")
cat("Fixed table class:", class(fixed_table), "\n")

# Save both versions for comparison
save_html(original_table, "gt-issue-original.html")
save_html(fixed_table, "gt-issue-fixed.html")

# Print confirmation
cat("Original table saved to: gt-issue-original.html\n")
cat("Fixed table saved to: gt-issue-fixed.html\n")
cat("\nThe fixed version should have matching header IDs and headers attributes.\n")

# Test that the fixed table can still be modified with gt functions
cat("\nTesting that the fixed table can still be modified...\n")
further_modified <- fixed_table |> 
  tab_header(title = "Accessibility Fixed Table")

save_html(further_modified, "gt-issue-with-title.html")
cat("Modified fixed table saved to: gt-issue-with-title.html\n")