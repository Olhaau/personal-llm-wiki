#!/usr/bin/env Rscript
# Test formatting preservation in Excel round-trip

library(openxlsx2)
library(jsonlite)

cat("=== TESTING FORMATTING PRESERVATION ===\n")

# Create test Excel with various formatting
test_wb <- wb_workbook()
test_wb$add_worksheet("Test")

# Add some data
test_data <- data.frame(
  Name = c("Test1", "Test2", "Test3"),
  Value = c(100, 200, 300),
  Color = c("Red", "Green", "Blue")
)

test_wb$add_data("Test", test_data, dims = "B2")

# Apply various formatting
# 1. Bold headers
test_wb$add_style(
  dims = "B2:D2", 
  style = wb_style(font_bold = TRUE, bg_fill = wb_color("lightblue"))
)

# 2. Font color
test_wb$add_style(
  dims = "B3:D3", 
  style = wb_style(font_color = wb_color("red"))
)

# 3. Background color  
test_wb$add_style(
  dims = "B4:D4", 
  style = wb_style(bg_fill = wb_color("yellow"))
)

# 4. Remove grid lines
test_wb$set_grid_lines("Test", show = FALSE)

# 5. Set column widths
test_wb$set_col_widths("Test", cols = 2:4, widths = c(15, 12, 10))

# Save test file
test_path <- "output/formatting_preservation_test.xlsx"
wb_save(test_wb, test_path, overwrite = TRUE)

cat("Created test file with formatting\n")

# Now load it back and examine
loaded_wb <- wb_load(test_path)

cat("\n=== EXAMINING ORIGINAL FORMATTING ===\n")

# Check grid lines setting
ws1 <- loaded_wb$worksheets[[1]]
if (!is.null(ws1$sheetViews)) {
  cat("Grid lines setting found in sheetViews\n")
  print(ws1$sheetViews)
} else {
  cat("No sheetViews found\n")
}

# Check styles
if (length(loaded_wb$styles_mgr$styles) > 0) {
  cat("Styles found:", length(loaded_wb$styles_mgr$styles), "\n")
} else {
  cat("No styles found\n")
}

# Check column widths
if (!is.null(ws1$cols)) {
  cat("Column width information found\n")
  print(ws1$cols)
} else {
  cat("No column width information found\n")
}

cat("\n=== TESTING JSON ROUND-TRIP ===\n")

# Extract complete structure to JSON (like our current approach)
excel_structure <- list(
  worksheets = list(),
  styles = loaded_wb$styles_mgr$styles,
  sheet_views = list(),
  column_info = list()
)

# Extract each worksheet with its formatting
for (i in seq_along(loaded_wb$get_sheet_names())) {
  sheet_name <- loaded_wb$get_sheet_names()[i]
  ws <- loaded_wb$worksheets[[i]]
  
  # Extract data
  data <- wb_to_df(loaded_wb, sheet = sheet_name)
  
  # Extract formatting info
  sheet_info <- list(
    name = sheet_name,
    data = data,
    sheetViews = ws$sheetViews,
    cols = ws$cols,
    rows = ws$rows,
    cellXfs = ws$cellXfs
  )
  
  excel_structure$worksheets[[sheet_name]] <- sheet_info
}

# Save to JSON
json_path <- "output/formatting_test_structure.json"
write_json(excel_structure, json_path, auto_unbox = TRUE, pretty = TRUE)

cat("Saved structure to JSON\n")

# Now recreate from JSON
cat("\n=== RECREATING FROM JSON ===\n")

json_data <- read_json(json_path)

# Create new workbook
new_wb <- wb_workbook()

# Restore styles first
if (!is.null(json_data$styles) && length(json_data$styles) > 0) {
  cat("Restoring", length(json_data$styles), "styles\n")
  # Note: openxlsx2 doesn't have direct style restoration methods
  # This is a limitation we need to address
}

# Recreate worksheets
for (sheet_name in names(json_data$worksheets)) {
  sheet_data <- json_data$worksheets[[sheet_name]]
  
  new_wb$add_worksheet(sheet_name)
  
  # Add data
  if (!is.null(sheet_data$data) && nrow(sheet_data$data) > 0) {
    new_wb$add_data(sheet_name, sheet_data$data, dims = "B2")
  }
  
  # Try to restore formatting
  # 1. Grid lines
  if (!is.null(sheet_data$sheetViews)) {
    cat("Attempting to restore grid line settings for", sheet_name, "\n")
    # Check if showGridLines is FALSE
    # This is where our current approach might be losing formatting
    new_wb$set_grid_lines(sheet_name, show = FALSE)
  }
  
  # 2. Column widths
  if (!is.null(sheet_data$cols)) {
    cat("Attempting to restore column widths for", sheet_name, "\n")
    # Extract and apply column widths - this needs more work
  }
}

# Save recreated file
recreated_path <- "output/formatting_preservation_recreated.xlsx"
wb_save(new_wb, recreated_path, overwrite = TRUE)

cat("Recreated Excel file from JSON\n")

# Compare original vs recreated
cat("\n=== COMPARISON ===\n")

# Load both files
original_wb_check <- wb_load(test_path)
recreated_wb_check <- wb_load(recreated_path)

# Check grid lines
orig_views <- original_wb_check$worksheets[[1]]$sheetViews
recr_views <- recreated_wb_check$worksheets[[1]]$sheetViews

cat("Original grid lines setting preserved:", !is.null(orig_views), "\n")
cat("Recreated grid lines setting preserved:", !is.null(recr_views), "\n")

if (!is.null(orig_views) && !is.null(recr_views)) {
  cat("Grid line settings match:", identical(orig_views, recr_views), "\n")
}

cat("\n=== CONCLUSION ===\n")
cat("The round-trip process needs enhancement to preserve:\n")
cat("1. Grid line settings\n")
cat("2. Cell formatting (colors, fonts)\n") 
cat("3. Column widths\n")
cat("4. Row heights\n")
cat("5. Style definitions\n")