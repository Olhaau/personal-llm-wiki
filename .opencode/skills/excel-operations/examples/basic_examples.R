# ---- Basic openxlsx2 Examples ----

library(openxlsx2)

# ---- Example 1: Simple Data Export ----
simple_export_example <- function() {
  # Create workbook and add data
  wb <- wb_workbook() %>%
    wb_add_worksheet("Cars") %>%
    wb_add_data(x = mtcars)
  
  # Save to file
  wb_save(wb, "simple_cars.xlsx")
  
  message("Created simple_cars.xlsx")
}

# ---- Example 2: Styled Headers ----
styled_headers_example <- function() {
  wb <- wb_workbook() %>%
    wb_add_worksheet("Styled Data") %>%
    wb_add_data(x = iris)
  
  # Style the header row
  wb %>%
    wb_add_font(dims = "A1:E1", bold = TRUE, size = 12) %>%
    wb_add_fill(dims = "A1:E1", color = wb_color("lightblue")) %>%
    wb_add_border(dims = "A1:E1", 
                  top_style = "thick", 
                  bottom_style = "thick",
                  left_style = "thin", 
                  right_style = "thin") %>%
    wb_set_col_widths(cols = 1:5, widths = "auto")
  
  wb_save(wb, "styled_headers.xlsx")
  message("Created styled_headers.xlsx")
}

# ---- Example 3: Multiple Sheets ----
multi_sheet_example <- function() {
  wb <- wb_workbook()
  
  # Add multiple sheets with different datasets
  datasets <- list(
    "Cars" = mtcars,
    "Flowers" = iris, 
    "Trees" = trees
  )
  
  for (sheet_name in names(datasets)) {
    wb %>%
      wb_add_worksheet(sheet_name) %>%
      wb_add_data(x = datasets[[sheet_name]], with_filter = TRUE) %>%
      wb_set_col_widths(sheet = sheet_name, cols = 1:ncol(datasets[[sheet_name]]), widths = "auto")
  }
  
  wb_save(wb, "multi_sheet.xlsx")
  message("Created multi_sheet.xlsx with", length(datasets), "sheets")
}

# ---- Example 4: Number Formatting ----
number_formatting_example <- function() {
  # Create sample financial data
  financial_data <- data.frame(
    Item = c("Revenue", "Costs", "Profit", "Margin"),
    Q1 = c(125000, -75000, 50000, 0.4),
    Q2 = c(140000, -85000, 55000, 0.39),
    Q3 = c(160000, -95000, 65000, 0.41),
    Q4 = c(180000, -110000, 70000, 0.39)
  )
  
  wb <- wb_workbook() %>%
    wb_add_worksheet("Financial") %>%
    wb_add_data(x = financial_data)
  
  # Format currency columns (Q1-Q4)  
  wb %>%
    wb_add_numfmt(dims = "B2:E4", numfmt = "$#,##0") %>%  # Currency for first 3 rows
    wb_add_numfmt(dims = "B5:E5", numfmt = "0.00%") %>%   # Percentage for margin row
    wb_add_font(dims = "A1:E1", bold = TRUE) %>%          # Bold headers
    wb_set_col_widths(cols = 1:5, widths = "auto")
  
  wb_save(wb, "financial_format.xlsx")
  message("Created financial_format.xlsx")
}

# ---- Example 5: Conditional Formatting ----
conditional_formatting_example <- function() {
  # Create sample sales data
  sales_data <- data.frame(
    Salesperson = paste("Sales Rep", 1:10),
    Q1_Sales = round(runif(10, 50000, 150000)),
    Q2_Sales = round(runif(10, 60000, 160000)),
    Target = 100000,
    Performance = round(runif(10, 0.8, 1.3), 2)
  )
  
  wb <- wb_workbook() %>%
    wb_add_worksheet("Sales") %>%
    wb_add_data(x = sales_data)
  
  # Add conditional formatting
  wb %>%
    # Color scale for Q1 sales
    wb_add_conditional_formatting(
      dims = "B2:B11",
      rule = "colorScale", 
      style = c("#F8696B", "#FFEB84", "#63BE7B")
    ) %>%
    # Data bars for Q2 sales
    wb_add_conditional_formatting(
      dims = "C2:C11",
      rule = "dataBar",
      style = create_dxfs_style(bg_fill = wb_color("#4472C4"))
    ) %>%
    # Highlight performance above target
    wb_add_conditional_formatting(
      dims = "E2:E11", 
      rule = ">1",
      style = create_dxfs_style(bg_fill = wb_color("lightgreen"))
    ) %>%
    wb_set_col_widths(cols = 1:5, widths = "auto")
  
  wb_save(wb, "conditional_format.xlsx") 
  message("Created conditional_format.xlsx")
}

# ---- Example 6: Data Table with Filters ----
data_table_example <- function() {
  # Create larger dataset for filtering
  large_data <- data.frame(
    Date = seq(Sys.Date() - 100, Sys.Date(), by = "day")[1:50],
    Category = sample(c("A", "B", "C"), 50, replace = TRUE),
    Value1 = round(rnorm(50, 100, 20), 2),
    Value2 = round(rnorm(50, 50, 10), 2),
    Status = sample(c("Active", "Inactive", "Pending"), 50, replace = TRUE)
  )
  
  wb <- wb_workbook() %>%
    wb_add_worksheet("Data Table")
  
  # Add as Excel Table (with built-in filtering)
  wb %>%
    wb_add_data_table(
      x = large_data,
      table_style = "TableStyleMedium9",
      table_name = "SalesTable", 
      with_filter = TRUE
    ) %>%
    wb_set_col_widths(cols = 1:5, widths = "auto")
  
  wb_save(wb, "data_table.xlsx")
  message("Created data_table.xlsx with Excel Table")
}

# ---- Example 7: Sparklines ----
sparklines_example <- function() {
  # Create monthly data
  monthly_data <- data.frame(
    Product = c("Product A", "Product B", "Product C", "Product D"),
    Jan = c(10, 15, 8, 20),
    Feb = c(12, 18, 12, 18), 
    Mar = c(15, 20, 10, 25),
    Apr = c(18, 22, 15, 22),
    May = c(20, 25, 18, 28),
    Jun = c(25, 30, 20, 30)
  )
  
  wb <- wb_workbook() %>%
    wb_add_worksheet("Sparklines") %>%
    wb_add_data(x = monthly_data)
  
  # Create sparklines
  sparklines <- create_sparklines(
    sheet = 1,
    dims = "B2:G5",      # Data range (4 products x 6 months)
    sqref = "H2:H5",     # Where to place sparklines
    type = "line",
    markers = TRUE,
    high = TRUE,
    low = TRUE,
    color_series = wb_color("blue"),
    color_high = wb_color("green"),
    color_low = wb_color("red")
  )
  
  wb %>%
    wb_add_sparklines(sparklines = sparklines) %>%
    wb_set_col_widths(cols = 1:8, widths = "auto")
  
  wb_save(wb, "sparklines.xlsx")
  message("Created sparklines.xlsx")
}

# ---- Example 8: Reading Data Back ----
read_data_example <- function() {
  # First create a file to read
  test_data <- data.frame(
    Names = c("Alice", "Bob", "Charlie"),
    Ages = c(25, 30, 35),
    Salaries = c(50000, 60000, 70000),
    Start_Date = Sys.Date() - c(365, 200, 100)
  )
  
  # Write to Excel
  write_xlsx(test_data, "test_read.xlsx")
  
  # Read back different ways
  
  # Method 1: Quick read
  df1 <- read_xlsx("test_read.xlsx")
  print("Method 1 - Quick read:")
  print(df1)
  
  # Method 2: Load workbook then convert
  wb <- wb_load("test_read.xlsx")
  df2 <- wb_to_df(wb)
  print("Method 2 - Via workbook:")
  print(df2)
  
  # Method 3: Read specific range
  df3 <- read_xlsx("test_read.xlsx", dims = "A1:C4")
  print("Method 3 - Specific range:")
  print(df3)
  
  # Clean up
  file.remove("test_read.xlsx")
  
  message("Demonstrated different ways to read Excel data")
}

# ---- Run all examples ----
run_all_examples <- function() {
  message("Running openxlsx2 examples...")
  
  simple_export_example()
  styled_headers_example()  
  multi_sheet_example()
  number_formatting_example()
  conditional_formatting_example()
  data_table_example()
  sparklines_example()
  read_data_example()
  
  message("All examples completed! Check the generated Excel files.")
}

# Uncomment to run examples:
# run_all_examples()