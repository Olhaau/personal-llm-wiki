# Demo: Creating Highly Accessible Excel Files with GT-style Formatting
#
# This script demonstrates how to create WCAG-compliant Excel files using openxlsx
# that match the appearance of GT tables while providing maximum accessibility features.

# Load required libraries
suppressPackageStartupMessages({
  library(openxlsx)
  library(dplyr)
})

# Source the accessibility functions
source("create_openxlsx_accessible.R")

cat("=== Demo: Accessible Excel with GT Formatting ===\n\n")

# ---- Example 1: Basic Usage ----

cat("Example 1: Basic accessible Excel creation\n")

# Create sample data with spanner structure
demo_data <- data.frame(
  `personal_name` = c("Alice Smith", "Bob Johnson", "Carol Davis"),
  `personal_age` = c(28, 35, 42),
  `financial_income` = c(55000, 68000, 72000),
  `financial_expenses` = c(45000, 52000, 58000),
  `location_city` = c("Berlin", "München", "Hamburg"),
  `location_state` = c("Berlin", "Bayern", "Hamburg"),
  check.names = FALSE
)

# Create accessible Excel file
create_openxlsx_accessible_table(
  data = demo_data,
  filename = "demo_accessible_basic.xlsx",
  title = "Employee Demographics & Financial Data",
  subtitle = "Demonstrating accessibility features with GT-style formatting",
  description = "Sample employee data showing personal, financial, and location information with full accessibility compliance",
  spanner_delimiter = "_",
  author = "Accessibility Demo",
  include_summary = TRUE,
  high_contrast = FALSE
)

cat("✓ Created: demo_accessible_basic.xlsx\n\n")

# ---- Example 2: High Contrast Version ----

cat("Example 2: High contrast version for enhanced visibility\n")

create_openxlsx_accessible_table(
  data = demo_data,
  filename = "demo_accessible_high_contrast.xlsx",
  title = "Employee Data - High Contrast Version",
  subtitle = "Enhanced visibility for users with visual impairments", 
  description = "Same data with high contrast colors meeting WCAG AAA standards",
  spanner_delimiter = "_",
  author = "Accessibility Demo",
  include_summary = TRUE,
  high_contrast = TRUE
)

cat("✓ Created: demo_accessible_high_contrast.xlsx\n\n")

# ---- Example 3: German Mikrozensus Data (if available) ----

cat("Example 3: Complex German statistical data\n")

if (file.exists("gt-issue.R")) {
  # Load the complex German dataset
  source("gt-issue.R")
  
  if (exists("df")) {
    create_openxlsx_accessible_table(
      data = df,
      filename = "demo_mikrozensus_accessible.xlsx",
      title = "German Mikrozensus 2023 - Production Ready",
      subtitle = "Official statistical data with full accessibility compliance",
      description = paste(
        "Comprehensive German micro census data with complex column names,",
        "special characters, and statistical terminology.",
        "Demonstrates professional accessibility implementation for government data."
      ),
      spanner_delimiter = "_",
      author = "German Federal Statistical Office",
      include_summary = TRUE,
      high_contrast = FALSE
    )
    
    cat("✓ Created: demo_mikrozensus_accessible.xlsx\n\n")
  }
}

# ---- Accessibility Features Summary ----

cat("=== Key Accessibility Features Implemented ===\n\n")

cat("WCAG 2.1 Compliance:\n")
cat("✓ AA/AAA color contrast ratios\n")
cat("✓ Structured table headers with scope information\n")
cat("✓ Alternative text via cell comments\n")
cat("✓ Logical reading order for screen readers\n")
cat("✓ Keyboard navigation support\n")
cat("✓ Multiple access methods (formatted + raw data)\n")
cat("✓ Comprehensive documentation\n\n")

cat("Excel-Specific Features:\n")
cat("✓ Proper table structure without merged data cells\n")
cat("✓ Frozen panes for easy navigation\n")
cat("✓ Auto-sized columns for optimal display\n")
cat("✓ Descriptive worksheet names and tab colors\n")
cat("✓ Professional GT-style formatting\n")
cat("✓ Summary statistics for numeric data\n\n")

cat("Multi-Worksheet Structure:\n")
cat("• GT_Table: Visually formatted main table\n")
cat("• Accessible_Data: Screen reader optimized version\n")
cat("• Column_Mapping: Structure and naming documentation\n") 
cat("• Summary_Statistics: Statistical overview of numeric columns\n")
cat("• Accessibility_Guide: User instructions and feature overview\n\n")

# ---- Usage Instructions ----

cat("=== Usage Instructions ===\n\n")

cat("For Screen Reader Users:\n")
cat("1. Open the Excel file in Excel 2016 or later\n")
cat("2. Navigate to 'Accessibility_Guide' worksheet first\n")
cat("3. Use 'Accessible_Data' worksheet for data analysis\n")
cat("4. Enable table navigation mode in your screen reader\n")
cat("5. Use Ctrl+Arrow keys for efficient navigation\n\n")

cat("For Visual Users:\n")
cat("1. Start with 'GT_Table' worksheet for formatted view\n")
cat("2. Use frozen panes to keep headers visible while scrolling\n")
cat("3. Hover over cells to read accessibility comments\n")
cat("4. Check 'Column_Mapping' for structure understanding\n")
cat("5. Review 'Summary_Statistics' for data overview\n\n")

cat("For Developers:\n")
cat("• Use create_openxlsx_accessible_table() function\n")
cat("• Set high_contrast=TRUE for enhanced visibility\n")
cat("• Customize spanner_delimiter for your data structure\n")
cat("• Include comprehensive descriptions for better context\n")
cat("• Test with Excel's built-in Accessibility Checker\n\n")

# ---- Testing and Validation ----

cat("=== Testing Recommendations ===\n\n")

cat("Automated Testing:\n")
cat("• Excel's Accessibility Checker (Review > Check Accessibility)\n")
cat("• Microsoft Accessibility Insights for Web\n")
cat("• WAVE Web Accessibility Evaluation Tool\n\n")

cat("Manual Testing:\n")
cat("• NVDA Screen Reader (free)\n")
cat("• JAWS Screen Reader (commercial)\n")
cat("• Keyboard-only navigation\n")
cat("• High contrast display settings\n")
cat("• Various zoom levels (150%, 200%)\n\n")

cat("Validation Checklist:\n")
cat("□ All worksheets have descriptive names\n")
cat("□ Headers are properly structured\n")
cat("□ Alternative text available via comments\n")
cat("□ Data is keyboard accessible\n")
cat("□ Color contrast meets WCAG standards\n")
cat("□ Logical reading order maintained\n")
cat("□ No critical information conveyed by color alone\n")
cat("□ Table structure works with screen readers\n\n")

cat("=== Demo Complete ===\n")
cat("Check the created Excel files to see the accessibility features in action!\n")
cat("For questions or issues, refer to the project documentation.\n")