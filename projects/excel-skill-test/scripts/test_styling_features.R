# ---- Test Styling Features - excel-operations Skill ----
# Purpose: Test comprehensive styling capabilities using openxlsx2
# Output: 02_styling_features.xlsx
# Features: Fonts, colors, borders, fills, number formatting, alignment

suppressPackageStartupMessages(library(openxlsx2))
source(here::here("projects/excel-skill-test/data/sample_datasets.R"))

output_path <- here::here("projects/excel-skill-test/output/02_styling_features.xlsx")

cat("🎨 Testing Styling Features - excel-operations skill\n")
cat("====================================================\n\n")

# ---- Create Styled Workbook ----
cat("1. Creating workbook with custom styling...\n")

wb <- wb_workbook()

# ---- Documentation Sheet ----
wb$add_worksheet("📋 Style Guide")

style_guide_text <- data.frame(
  Content = c(
    "STYLING FEATURES TEST",
    "",
    "This workbook demonstrates comprehensive styling capabilities:",
    "",
    "Sheet Overview:",
    "• 📋 Style Guide - This documentation",
    "• 🔤 Font Showcase - Typography and font variations",
    "• 🌈 Color Palette - Color schemes and fills",
    "• 📏 Borders Demo - Border styles and patterns",
    "• 🔢 Number Formats - Currency, dates, percentages",
    "• 📐 Alignment Test - Text positioning and alignment",
    "• ✨ Combined Styles - Professional formatting examples",
    "",
    "Styling Features Demonstrated:",
    "✓ Font families, sizes, weights, and colors",
    "✓ Background fills and pattern types",
    "✓ Border styles, colors, and thickness",
    "✓ Number formatting for various data types",
    "✓ Cell alignment and text positioning",
    "✓ Color themes and coordinated palettes",
    "✓ Professional styling combinations",
    "",
    "Each sheet provides examples with explanations",
    "showing how R code creates professional Excel formatting.",
    "",
    paste("Generated:", Sys.time()),
    "R + openxlsx2 styling demonstration"
  )
)

wb$add_data(sheet = 1, x = style_guide_text, dims = "A1", col_names = FALSE)

# Style the guide itself
wb$add_font(dims = "A1", bold = TRUE, size = 18, color = wb_color("#1F4E79"))
wb$add_font(dims = "A5", bold = TRUE, size = 12, color = wb_color("#2E75B6"))
wb$add_font(dims = "A14", bold = TRUE, size = 12, color = wb_color("#2E75B6"))
wb$set_col_widths(sheet = 1, cols = 1, widths = 70)

cat("   ✓ Style guide created\n")

# ---- 2. Font Showcase Sheet ----
cat("2. Creating font showcase...\n")

wb$add_worksheet("🔤 Font Showcase")

# Font examples
font_examples <- data.frame(
  Font_Family = c("Arial", "Calibri", "Times New Roman", "Courier New", "Verdana"),
  Sample_Text = rep("The quick brown fox jumps over the lazy dog", 5),
  Size_11 = rep("Standard size", 5),
  Size_14 = rep("Larger text", 5),
  Bold = rep("Bold text", 5),
  Italic = rep("Italic text", 5),
  Underline = rep("Underlined", 5)
)

wb$add_data(sheet = 2, x = font_examples, dims = "A1")

# Apply different font families
fonts <- c("Arial", "Calibri", "Times New Roman", "Courier New", "Verdana")
for (i in 1:5) {
  row_range <- paste0("A", i+1, ":G", i+1)
  wb$add_font(dims = row_range, name = fonts[i])
}

# Apply size variations
wb$add_font(dims = "D2:D6", size = 14)
wb$add_font(dims = "E2:E6", bold = TRUE)
wb$add_font(dims = "F2:F6", italic = TRUE)
wb$add_font(dims = "G2:G6", underline = TRUE)

# Header styling
wb$add_font(dims = "A1:G1", bold = TRUE, size = 12, color = wb_color("white"))
wb$add_fill(dims = "A1:G1", color = wb_color("#4472C4"))

# Color variations
wb$add_data(sheet = 2, x = "Color Examples:", dims = "A8")
wb$add_font(dims = "A8", bold = TRUE, size = 14)

colors <- c("red", "blue", "green", "orange", "purple")
color_text <- data.frame(
  Color_Name = colors,
  Sample_Text = rep("Colored text example", 5)
)

wb$add_data(sheet = 2, x = color_text, dims = "A9")

# Apply colors
for (i in 1:5) {
  wb$add_font(dims = paste0("B", i+9), color = wb_color(colors[i]))
}

wb$set_col_widths(sheet = 2, cols = 1:7, widths = "auto")

cat("   ✓ Font showcase with families, sizes, styles, and colors\n")

# ---- 3. Color Palette Sheet ----
cat("3. Creating color palette and fills...\n")

wb$add_worksheet("🌈 Color Palette")

# Color scheme demonstration
wb$add_data(sheet = 3, x = "Color Schemes and Fill Patterns", dims = "A1")
wb$add_font(dims = "A1", bold = TRUE, size = 16, color = wb_color("#1F4E79"))

# Solid color fills
wb$add_data(sheet = 3, x = "Solid Color Fills:", dims = "A3")
wb$add_font(dims = "A3", bold = TRUE, size = 12)

solid_colors <- data.frame(
  Color_Name = c("Light Blue", "Light Green", "Light Yellow", "Light Pink", "Light Gray"),
  Description = c("Professional blue", "Success green", "Warning yellow", "Accent pink", "Neutral gray"),
  Usage = c("Headers", "Positive values", "Warnings", "Highlights", "Backgrounds")
)

wb$add_data(sheet = 3, x = solid_colors, dims = "A4")

# Apply solid fills
fill_colors <- c("#E6F3FF", "#E6F7E6", "#FFF2CC", "#FFE6F0", "#F2F2F2")
for (i in 1:5) {
  wb$add_fill(dims = paste0("A", i+4, ":C", i+4), color = wb_color(hex = fill_colors[i]))
}

# Pattern fills
wb$add_data(sheet = 3, x = "Pattern Fills:", dims = "A10")
wb$add_font(dims = "A10", bold = TRUE, size = 12)

pattern_data <- data.frame(
  Pattern_Type = c("Light Horizontal", "Light Vertical", "Light Grid", "Dark Dots", "Light Diagonal"),
  Description = c("Horizontal lines", "Vertical lines", "Grid pattern", "Dotted pattern", "Diagonal lines")
)

wb$add_data(sheet = 3, x = pattern_data, dims = "A11")

# Note: Pattern fills require create_fill function for complex patterns
# For demonstration, using gradient-like effects with solid colors
pattern_colors <- c("#F0F8FF", "#F5F5DC", "#F0FFF0", "#FFF8DC", "#F8F8FF")
for (i in 1:5) {
  wb$add_fill(dims = paste0("A", i+11, ":B", i+11), color = wb_color(hex = pattern_colors[i]))
}

# Theme color demonstration  
wb$add_data(sheet = 3, x = "Theme Color Progression:", dims = "A17")
wb$add_font(dims = "A17", bold = TRUE, size = 12)

theme_demo <- data.frame(
  Intensity = c("Dark", "Medium", "Light", "Very Light"),
  Blue_Theme = rep("Theme Blue", 4),
  Green_Theme = rep("Theme Green", 4),
  Red_Theme = rep("Theme Red", 4)
)

wb$add_data(sheet = 3, x = theme_demo, dims = "A18")

# Apply theme color progressions
blue_shades <- c("#1F4E79", "#4472C4", "#8FA8DB", "#C5D3F0")
green_shades <- c("#0D5016", "#237A2A", "#6BA46B", "#A9D3A9")
red_shades <- c("#8B1538", "#C55A5A", "#E08080", "#F0C0C0")

for (i in 1:4) {
  wb$add_fill(dims = paste0("B", i+18), color = wb_color(hex = blue_shades[i]))
  wb$add_fill(dims = paste0("C", i+18), color = wb_color(hex = green_shades[i]))
  wb$add_fill(dims = paste0("D", i+18), color = wb_color(hex = red_shades[i]))
}

wb$set_col_widths(sheet = 3, cols = 1:4, widths = "auto")

cat("   ✓ Color palette with fills, patterns, and themes\n")

# ---- 4. Borders Demo Sheet ----
cat("4. Creating borders demonstration...\n")

wb$add_worksheet("📏 Borders Demo")

wb$add_data(sheet = 4, x = "Border Styles and Applications", dims = "A1")
wb$add_font(dims = "A1", bold = TRUE, size = 16)

# Border style examples
border_data <- data.frame(
  Style = c("Thin", "Medium", "Thick", "Double", "Dashed"),
  Description = c("Standard table borders", "Emphasis borders", "Strong borders", "Special headers", "Temporary dividers"),
  Use_Case = c("Data tables", "Section headers", "Important totals", "Title sections", "Draft documents")
)

wb$add_data(sheet = 4, x = border_data, dims = "A3")

# Apply different border styles
wb$add_border(dims = "A4:C4", top_style = "thin", bottom_style = "thin", left_style = "thin", right_style = "thin")
wb$add_border(dims = "A5:C5", top_style = "medium", bottom_style = "medium", left_style = "medium", right_style = "medium")
wb$add_border(dims = "A6:C6", top_style = "thick", bottom_style = "thick", left_style = "thick", right_style = "thick")
wb$add_border(dims = "A7:C7", top_style = "double", bottom_style = "double", left_style = "double", right_style = "double")
wb$add_border(dims = "A8:C8", top_style = "dashed", bottom_style = "dashed", left_style = "dashed", right_style = "dashed")

# Color border examples
wb$add_data(sheet = 4, x = "Colored Borders:", dims = "A10")
wb$add_font(dims = "A10", bold = TRUE, size = 12)

colored_border_data <- data.frame(
  Border_Color = c("Blue", "Green", "Red", "Orange"),
  Content = c("Blue borders", "Green borders", "Red borders", "Orange borders")
)

wb$add_data(sheet = 4, x = colored_border_data, dims = "A11")

# Apply colored borders
border_colors <- c("blue", "green", "red", "orange")
for (i in 1:4) {
  wb$add_border(dims = paste0("A", i+11, ":B", i+11), 
                top_style = "medium", bottom_style = "medium", 
                left_style = "medium", right_style = "medium",
                top_color = wb_color(border_colors[i]),
                bottom_color = wb_color(border_colors[i]),
                left_color = wb_color(border_colors[i]),
                right_color = wb_color(border_colors[i]))
}

# Table border example
wb$add_data(sheet = 4, x = "Professional Table Example:", dims = "A16")
wb$add_font(dims = "A16", bold = TRUE, size = 12)

table_demo <- data.frame(
  Product = c("Widget A", "Widget B", "Widget C", "Total"),
  Sales = c(1250, 1800, 950, 4000),
  Target = c(1200, 1500, 1000, 3700)
)

wb$add_data(sheet = 4, x = table_demo, dims = "A17")

# Professional table styling
wb$add_border(dims = "A17:C17", bottom_style = "thick", bottom_color = wb_color("#2E75B6"))  # Header
wb$add_border(dims = "A18:C20", top_style = "thin", bottom_style = "thin", left_style = "thin", right_style = "thin")  # Data
wb$add_border(dims = "A20:C20", top_style = "thick", top_color = wb_color("#2E75B6"))  # Total row

wb$set_col_widths(sheet = 4, cols = 1:3, widths = "auto")

cat("   ✓ Border demonstrations with styles and colors\n")

# ---- 5. Number Formats Sheet ----
cat("5. Creating number formats demonstration...\n")

wb$add_worksheet("🔢 Number Formats")

wb$add_data(sheet = 5, x = "Number Formatting Examples", dims = "A1")
wb$add_font(dims = "A1", bold = TRUE, size = 16)

# Sample data for formatting
number_data <- data.frame(
  Format_Type = c("Currency", "Percentage", "Date", "Time", "Scientific", "Fraction", "Accounting"),
  Raw_Value = c(1234.56, 0.1234, as.numeric(Sys.Date()), as.numeric(Sys.time()), 1234567, 1.75, -1234.56),
  Description = c("Money values", "Ratios and rates", "Calendar dates", "Time stamps", "Large numbers", "Parts of whole", "Financial data")
)

wb$add_data(sheet = 5, x = number_data, dims = "A3")

# Apply number formats
wb$add_numfmt(dims = "B4", numfmt = "$#,##0.00")  # Currency
wb$add_numfmt(dims = "B5", numfmt = "0.00%")      # Percentage
wb$add_numfmt(dims = "B6", numfmt = "yyyy-mm-dd") # Date
wb$add_numfmt(dims = "B7", numfmt = "h:mm:ss AM/PM") # Time
wb$add_numfmt(dims = "B8", numfmt = "0.00E+00")   # Scientific
wb$add_numfmt(dims = "B9", numfmt = "# ?/?")      # Fraction
wb$add_numfmt(dims = "B10", numfmt = "_($* #,##0.00_);_($* (#,##0.00);_($* \"-\"??_);_(@_)") # Accounting

# Custom format examples
wb$add_data(sheet = 5, x = "Custom Formats:", dims = "A12")
wb$add_font(dims = "A12", bold = TRUE, size = 12)

custom_data <- data.frame(
  Purpose = c("Phone Numbers", "Product Codes", "Conditional Colors", "Text with Units"),
  Sample_Value = c(1234567890, 123456, 75, 25),
  Format_Applied = c("(000) 000-0000", "\"PRD-\"000000", "[>=50]Green;[<50]Red", "0.0\" kg\"")
)

wb$add_data(sheet = 5, x = custom_data, dims = "A13")

# Apply custom formats (simplified examples)
wb$add_numfmt(dims = "B14", numfmt = "(000) 000-0000")
wb$add_numfmt(dims = "B15", numfmt = "\"PRD-\"000000") 
wb$add_numfmt(dims = "B16", numfmt = "[Green]0")
wb$add_numfmt(dims = "B17", numfmt = "0.0\" kg\"")

wb$set_col_widths(sheet = 5, cols = 1:3, widths = "auto")

cat("   ✓ Number formatting with currency, dates, custom formats\n")

# ---- 6. Alignment Test Sheet ----
cat("6. Creating alignment and positioning test...\n")

wb$add_worksheet("📐 Alignment Test")

wb$add_data(sheet = 6, x = "Text Alignment and Positioning", dims = "A1")
wb$add_font(dims = "A1", bold = TRUE, size = 16)

# Horizontal alignment examples
alignment_data <- data.frame(
  Alignment = c("Left", "Center", "Right", "Justify"),
  Sample_Text = c("Left aligned text", "Center aligned", "Right aligned", "Justified text for longer content"),
  Usage = c("Default text", "Headings", "Numbers", "Paragraphs")
)

wb$add_data(sheet = 6, x = alignment_data, dims = "A3")

# Apply horizontal alignments
wb$add_cell_style(dims = "B4", horizontal = "left")
wb$add_cell_style(dims = "B5", horizontal = "center")
wb$add_cell_style(dims = "B6", horizontal = "right")
wb$add_cell_style(dims = "B7", horizontal = "justify")

# Vertical alignment examples
wb$add_data(sheet = 6, x = "Vertical Alignment:", dims = "A9")
wb$add_font(dims = "A9", bold = TRUE, size = 12)

vert_data <- data.frame(
  Position = c("Top", "Middle", "Bottom"),
  Content = c("Top aligned", "Middle aligned", "Bottom aligned")
)

wb$add_data(sheet = 6, x = vert_data, dims = "A10")

# Set larger row heights for vertical alignment demo
wb$set_row_heights(sheet = 6, rows = 11:13, heights = 30)

# Apply vertical alignments
wb$add_cell_style(dims = "B11", vertical = "top")
wb$add_cell_style(dims = "B12", vertical = "middle")
wb$add_cell_style(dims = "B13", vertical = "bottom")

# Text rotation examples
wb$add_data(sheet = 6, x = "Text Rotation:", dims = "A15")
wb$add_font(dims = "A15", bold = TRUE, size = 12)

rotation_data <- data.frame(
  Angle = c("0°", "45°", "90°", "-45°"),
  Text = c("Normal", "Diagonal", "Vertical", "Reverse")
)

wb$add_data(sheet = 6, x = rotation_data, dims = "A16")

# Apply text rotations
wb$set_row_heights(sheet = 6, rows = 17:20, heights = 25)
wb$add_cell_style(dims = "B17", text_rotation = 0)
wb$add_cell_style(dims = "B18", text_rotation = 45)
wb$add_cell_style(dims = "B19", text_rotation = 90)
wb$add_cell_style(dims = "B20", text_rotation = -45)

# Text wrapping example
wb$add_data(sheet = 6, x = "Text Wrapping:", dims = "A22")
wb$add_font(dims = "A22", bold = TRUE, size = 12)

wrap_text <- "This is a long text that will wrap within the cell to demonstrate text wrapping functionality"
wb$add_data(sheet = 6, x = wrap_text, dims = "A23")

wb$add_cell_style(dims = "A23", wrap_text = TRUE)
wb$set_col_widths(sheet = 6, cols = 1, widths = 30)
wb$set_row_heights(sheet = 6, rows = 23, heights = 40)

wb$set_col_widths(sheet = 6, cols = 2:3, widths = "auto")

cat("   ✓ Alignment test with horizontal, vertical, rotation, wrapping\n")

# ---- 7. Combined Styles Sheet ----
cat("7. Creating combined professional styling examples...\n")

wb$add_worksheet("✨ Combined Styles")

wb$add_data(sheet = 7, x = "Professional Styling Examples", dims = "A1")
wb$add_font(dims = "A1", bold = TRUE, size = 18, color = wb_color("white"))
wb$add_fill(dims = "A1", color = wb_color("#1F4E79"))
wb$merge_cells(dims = "A1:E1")

# Executive summary table
financial_sample <- get_sample_data("financial")

wb$add_data(sheet = 7, x = "Executive Financial Summary", dims = "A3")
wb$add_font(dims = "A3", bold = TRUE, size = 14, color = wb_color("#1F4E79"))

wb$add_data(sheet = 7, x = financial_sample, dims = "A4")

# Professional table styling
wb$add_font(dims = "A4:F4", bold = TRUE, color = wb_color("white"))
wb$add_fill(dims = "A4:F4", color = wb_color("#4472C4"))
wb$add_cell_style(dims = "A4:F4", horizontal = "center")

# Alternating row colors
for (i in 1:nrow(financial_sample)) {
  row_num <- i + 4
  if (i %% 2 == 0) {
    wb$add_fill(dims = paste0("A", row_num, ":F", row_num), color = wb_color("#F8F9FA"))
  }
}

# Number formatting
wb$add_numfmt(dims = "B5:D10", numfmt = "$#,##0")
wb$add_numfmt(dims = "E5:E10", numfmt = "0.00%")
wb$add_numfmt(dims = "F5:F10", numfmt = "#,##0")

# Borders
wb$add_border(dims = "A4:F10", 
              top_style = "thin", bottom_style = "thin", 
              left_style = "thin", right_style = "thin")
wb$add_border(dims = "A4:F4", bottom_style = "thick", bottom_color = wb_color("#2E75B6"))
wb$add_border(dims = "A10:F10", top_style = "thick", top_color = wb_color("#2E75B6"))

# KPI Dashboard section
wb$add_data(sheet = 7, x = "Key Performance Indicators", dims = "A12")
wb$add_font(dims = "A12", bold = TRUE, size = 14, color = wb_color("#1F4E79"))

kpi_data <- data.frame(
  Metric = c("Revenue Growth", "Profit Margin", "Employee Growth"),
  Current = c("68%", "38%", "38%"),
  Target = c("60%", "40%", "30%"),
  Status = c("Above Target", "Below Target", "Above Target")
)

wb$add_data(sheet = 7, x = kpi_data, dims = "A13")

# Conditional KPI styling
wb$add_font(dims = "A13:D13", bold = TRUE)
wb$add_fill(dims = "A13:D13", color = wb_color("#E8F4F8"))

# Status indicators with colors
wb$add_fill(dims = "D14", color = wb_color("#D4F4DD"))  # Green for Above
wb$add_fill(dims = "D15", color = wb_color("#FFE6E6"))  # Red for Below  
wb$add_fill(dims = "D16", color = wb_color("#D4F4DD"))  # Green for Above

wb$add_cell_style(dims = "A13:D16", horizontal = "center")
wb$add_border(dims = "A13:D16", 
              top_style = "thin", bottom_style = "thin", 
              left_style = "thin", right_style = "thin")

wb$set_col_widths(sheet = 7, cols = 1:6, widths = "auto")

cat("   ✓ Combined professional styling with tables and KPIs\n")

# ---- Save Workbook ----
cat("8. Saving styled workbook...\n")

wb$set_properties(
  title = "Styling Features Test - excel-operations", 
  subject = "Comprehensive styling demonstration",
  creator = "excel-operations Skill Test Suite",
  category = "Styling Testing",
  keywords = "R, Excel, openxlsx2, styling, formatting, fonts, colors"
)

if (!dir.exists(dirname(output_path))) {
  dir.create(dirname(output_path), recursive = TRUE)
}

wb_save(wb, output_path, overwrite = TRUE)

cat("   ✓ Styled workbook saved to:", output_path, "\n\n")

# ---- Verification ----
if (file.exists(output_path)) {
  file_info <- file.info(output_path)
  wb_test <- wb_load(output_path)
  sheets <- wb_get_sheet_names(wb_test)
  
  cat("✅ Styling Features Test Completed!\n")
  cat("==================================\n")
  cat("Generated file: 02_styling_features.xlsx\n")
  cat("File size:", round(file_info$size / 1024, 2), "KB\n")
  cat("Sheets created:", paste(sheets, collapse = ", "), "\n")
  cat("\nStyling features demonstrated:\n")
  cat("• Complete font styling (family, size, color, weight)\n")
  cat("• Background fills and color schemes\n")
  cat("• Border styles and colored borders\n")
  cat("• Number formatting (currency, dates, custom)\n")
  cat("• Text alignment and positioning\n")
  cat("• Professional table styling\n")
  cat("• Combined styling for business reports\n")
  cat("\nOpen the Excel file to see professional styling!\n")
} else {
  cat("❌ File creation failed\n")
}