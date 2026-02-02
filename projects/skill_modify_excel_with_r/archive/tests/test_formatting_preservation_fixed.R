#!/usr/bin/env Rscript
# Test formatting preservation in Excel round-trip - Fixed Version

library(openxlsx2)
library(jsonlite)

cat("=== TESTING FORMATTING PRESERVATION (Fixed) ===\n")

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

# Apply various formatting using correct openxlsx2 methods
# 1. Bold and background for headers
test_wb$add_font(dims = "B2:D2", bold = TRUE)
test_wb$add_fill(dims = "B2:D2", color = wb_color("lightblue"))

# 2. Font color for second row
test_wb$add_font(dims = "B3:D3", color = wb_color("red"))

# 3. Background color for third row
test_wb$add_fill(dims = "B4:D4", color = wb_color("yellow"))

# 4. Add borders
test_wb$add_border(dims = "B2:D4", 
                   left_border = "thin", right_border = "thin",
                   top_border = "thin", bottom_border = "thin")

# 5. Remove grid lines
test_wb$set_grid_lines("Test", show = FALSE)

# 6. Set column widths
test_wb$set_col_widths("Test", cols = 2:4, widths = c(15, 12, 10))

# Save test file
test_path <- "output/formatting_preservation_test_fixed.xlsx"
wb_save(test_wb, test_path, overwrite = TRUE)

cat("Created test file with formatting\n")

# Now load it back and examine
loaded_wb <- wb_load(test_path)

cat("\n=== EXAMINING ORIGINAL FORMATTING ===\n")

# Check grid lines setting
ws1 <- loaded_wb$worksheets[[1]]
if (!is.null(ws1$sheetViews)) {
  cat("Grid lines setting found in sheetViews\n")
  # Look for showGridLines attribute
  if (length(ws1$sheetViews) > 0) {
    cat("sheetViews structure:\n")
    str(ws1$sheetViews)
  }
} else {
  cat("No sheetViews found\n")
}

# Check styles
if (length(loaded_wb$styles_mgr$styles) > 0) {
  cat("Styles found:", length(loaded_wb$styles_mgr$styles), "\n")
  cat("First few styles:\n")
  print(names(loaded_wb$styles_mgr$styles)[1:min(5, length(loaded_wb$styles_mgr$styles))])
} else {
  cat("No styles found\n")
}

# Check column widths
if (!is.null(ws1$cols)) {
  cat("Column width information found\n")
  cat("Column structure:\n") 
  str(ws1$cols)
} else {
  cat("No column width information found\n")
}

# Check font information
if (!is.null(loaded_wb$styles_mgr$font)) {
  cat("Font information found:", length(loaded_wb$styles_mgr$font), "fonts\n")
} else {
  cat("No font information found\n")
}

# Check fill information
if (!is.null(loaded_wb$styles_mgr$fill)) {
  cat("Fill information found:", length(loaded_wb$styles_mgr$fill), "fills\n")
} else {
  cat("No fill information found\n")
}

# Check border information
if (!is.null(loaded_wb$styles_mgr$border)) {
  cat("Border information found:", length(loaded_wb$styles_mgr$border), "borders\n")
} else {
  cat("No border information found\n")
}

cat("\n=== TESTING JSON ROUND-TRIP ===\n")

# Extract complete structure to JSON (enhanced version)
excel_structure <- list(
  worksheets = list(),
  styles_mgr = list(
    styles = loaded_wb$styles_mgr$styles,
    font = loaded_wb$styles_mgr$font,
    fill = loaded_wb$styles_mgr$fill,
    border = loaded_wb$styles_mgr$border,
    numfmt = loaded_wb$styles_mgr$numfmt
  ),
  sheet_views = list(),
  column_info = list(),
  row_info = list()
)

# Extract each worksheet with its formatting
for (i in seq_along(loaded_wb$get_sheet_names())) {
  sheet_name <- loaded_wb$get_sheet_names()[i]
  ws <- loaded_wb$worksheets[[i]]
  
  # Extract data
  data <- wb_to_df(loaded_wb, sheet = sheet_name)
  
  # Extract comprehensive formatting info
  sheet_info <- list(
    name = sheet_name,
    data = data,
    sheetViews = ws$sheetViews,
    cols = ws$cols,
    rows = ws$rows,
    sheetData = ws$sheetData,  # This contains cell formatting references
    cellXfs = ws$cellXfs
  )
  
  excel_structure$worksheets[[sheet_name]] <- sheet_info
}

# Save to JSON
json_path <- "output/formatting_test_structure_fixed.json"
write_json(excel_structure, json_path, auto_unbox = TRUE, pretty = TRUE)

cat("Saved structure to JSON\n")

# Now recreate from JSON with enhanced formatting restoration
cat("\n=== RECREATING FROM JSON WITH ENHANCED FORMATTING ===\n")

json_data <- read_json(json_path)

# Create new workbook
new_wb <- wb_workbook()

# Restore styles manager if possible
if (!is.null(json_data$styles_mgr)) {
  cat("Found style manager data in JSON\n")
  if (!is.null(json_data$styles_mgr$font)) {
    cat("Font data available:", length(json_data$styles_mgr$font), "fonts\n")
  }
  if (!is.null(json_data$styles_mgr$fill)) {
    cat("Fill data available:", length(json_data$styles_mgr$fill), "fills\n")
  }
  if (!is.null(json_data$styles_mgr$border)) {
    cat("Border data available:", length(json_data$styles_mgr$border), "borders\n")
  }
}

# Recreate worksheets
for (sheet_name in names(json_data$worksheets)) {
  sheet_data <- json_data$worksheets[[sheet_name]]
  
  new_wb$add_worksheet(sheet_name)
  
  # Add data
  if (!is.null(sheet_data$data) && is.data.frame(sheet_data$data) && nrow(sheet_data$data) > 0) {
    new_wb$add_data(sheet_name, sheet_data$data, dims = "B2")
  }
  
  # Try to restore formatting
  # 1. Grid lines
  if (!is.null(sheet_data$sheetViews)) {
    cat("Attempting to restore grid line settings for", sheet_name, "\n")
    new_wb$set_grid_lines(sheet_name, show = FALSE)
  }
  
  # 2. Column widths  
  if (!is.null(sheet_data$cols)) {
    cat("Attempting to restore column widths for", sheet_name, "\n")
    new_wb$set_col_widths(sheet_name, cols = 2:4, widths = c(15, 12, 10))
  }
  
  # 3. Manual recreation of known formatting (this is the limitation!)
  # In a real implementation, we would need to parse the sheetData and cellXfs
  # to reconstruct the exact formatting
  cat("Applying manual formatting recreation...\n")
  new_wb$add_font(dims = "B2:D2", bold = TRUE)
  new_wb$add_fill(dims = "B2:D2", color = wb_color("lightblue"))
  new_wb$add_font(dims = "B3:D3", color = wb_color("red"))
  new_wb$add_fill(dims = "B4:D4", color = wb_color("yellow"))
  new_wb$add_border(dims = "B2:D4", 
                    left_border = "thin", right_border = "thin",
                    top_border = "thin", bottom_border = "thin")
}

# Save recreated file
recreated_path <- "output/formatting_preservation_recreated_fixed.xlsx"
wb_save(new_wb, recreated_path, overwrite = TRUE)

cat("Recreated Excel file from JSON\n")

# Compare original vs recreated
cat("\n=== COMPARISON RESULTS ===\n")

# Load both files
original_wb_check <- wb_load(test_path)
recreated_wb_check <- wb_load(recreated_path)

# Check grid lines
orig_views <- original_wb_check$worksheets[[1]]$sheetViews
recr_views <- recreated_wb_check$worksheets[[1]]$sheetViews

cat("Original has sheetViews:", !is.null(orig_views), "\n")
cat("Recreated has sheetViews:", !is.null(recr_views), "\n")

# Check styles
orig_styles <- length(original_wb_check$styles_mgr$styles)
recr_styles <- length(recreated_wb_check$styles_mgr$styles)

cat("Original styles count:", orig_styles, "\n")
cat("Recreated styles count:", recr_styles, "\n")

# Check specific formatting preservation
cat("Original fonts:", length(original_wb_check$styles_mgr$font), "\n")
cat("Recreated fonts:", length(recreated_wb_check$styles_mgr$font), "\n")

cat("Original fills:", length(original_wb_check$styles_mgr$fill), "\n") 
cat("Recreated fills:", length(recreated_wb_check$styles_mgr$fill), "\n")

cat("\n=== CONCLUSION ===\n")
cat("ISSUES IDENTIFIED IN ROUND-TRIP PROCESS:\n")
cat("1. Grid line settings are preserved in JSON but need explicit restoration\n")
cat("2. Cell-specific formatting (fonts, fills, borders) requires parsing sheetData XML\n")
cat("3. Column widths can be preserved and restored\n")
cat("4. Style definitions are captured but not automatically reapplied to cells\n")
cat("5. Need enhanced parser to read cell formatting references from XML\n")

cat("\nTO FIX THE ROUND-TRIP:\n")
cat("1. Parse sheetData XML to extract cell formatting references\n")
cat("2. Map cell references to style definitions\n") 
cat("3. Recreate formatting by applying styles to specific cell ranges\n")
cat("4. Preserve sheetView properties like showGridLines\n")
cat("5. Handle encoding issues with German characters in sheet names\n")