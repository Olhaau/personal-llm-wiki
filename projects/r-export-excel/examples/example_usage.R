# example_usage.R ----
# Example demonstrating excelize() function with gt tables

# Setup ----
suppressPackageStartupMessages({
  library(gt)
  library(dplyr)
})

# Source the excelize function
source("R/excelize.R")

# Create output directory if it doesn't exist
if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# Example 1: Basic gt table with mtcars data ----
cat("\n=== Example 1: Basic mtcars table ===\n")

# Create a formatted gt table
mtcars_table <- mtcars |>
  head(10) |>
  gt(rownames_to_stub = TRUE) |>
  tab_header(
    title = "Motor Trend Car Road Tests",
    subtitle = "Sample of 10 vehicles from 1974 Motor Trend magazine"
  ) |>
  fmt_number(
    columns = c(mpg, disp, drat, wt, qsec),
    decimals = 1
  ) |>
  fmt_number(
    columns = c(hp),
    decimals = 0
  ) |>
  cols_label(
    mpg = "MPG",
    cyl = "Cylinders",
    disp = "Displacement",
    hp = "Horsepower",
    drat = "Rear Axle",
    wt = "Weight",
    qsec = "1/4 Mile",
    vs = "Engine",
    am = "Transmission",
    gear = "Gears",
    carb = "Carburetors"
  )

# Export to Excel
excelize(
  gt_object = mtcars_table,
  filename = "output/example1_mtcars.xlsx",
  sheet_name = "Motor Trend Data",
  heading = "Motor Trend Car Road Tests - 1974",
  freeze_rows = 1,  # Freeze header row
  freeze_cols = 1,  # Freeze row names column
  add_index_link = FALSE,
  create_index = FALSE
)

# Example 2: Multiple summary tables with index ----
cat("\n=== Example 2: Multiple tables with index sheet ===\n")

# Table 1: Summary by cylinder count
cyl_summary <- mtcars |>
  group_by(cyl) |>
  summarise(
    Count = n(),
    `Avg MPG` = mean(mpg),
    `Avg HP` = mean(hp),
    `Avg Weight` = mean(wt),
    .groups = "drop"
  ) |>
  gt() |>
  fmt_number(columns = c(`Avg MPG`, `Avg HP`, `Avg Weight`), decimals = 1) |>
  cols_label(cyl = "Cylinders")

# Table 2: Summary by transmission type
am_summary <- mtcars |>
  mutate(Transmission = ifelse(am == 0, "Automatic", "Manual")) |>
  group_by(Transmission) |>
  summarise(
    Count = n(),
    `Avg MPG` = mean(mpg),
    `Avg HP` = mean(hp),
    `Min MPG` = min(mpg),
    `Max MPG` = max(mpg),
    .groups = "drop"
  ) |>
  gt() |>
  fmt_number(columns = c(`Avg MPG`, `Avg HP`, `Min MPG`, `Max MPG`), decimals = 1)

# Table 3: Summary by gear count
gear_summary <- mtcars |>
  group_by(gear) |>
  summarise(
    Count = n(),
    `Avg MPG` = mean(mpg),
    `Avg HP` = mean(hp),
    `Avg 1/4 Mile` = mean(qsec),
    .groups = "drop"
  ) |>
  gt() |>
  fmt_number(columns = c(`Avg MPG`, `Avg HP`, `Avg 1/4 Mile`), decimals = 1) |>
  cols_label(gear = "Gears")

# Export first table (creates workbook)
excelize(
  gt_object = cyl_summary,
  filename = "output/example2_multi_tables.xlsx",
  sheet_name = "By Cylinders",
  heading = "Vehicle Summary by Cylinder Count",
  freeze_rows = 1,
  freeze_cols = 0,
  add_index_link = TRUE,
  create_index = TRUE,
  append = FALSE
)

# Export second table (appends to workbook)
excelize(
  gt_object = am_summary,
  filename = "output/example2_multi_tables.xlsx",
  sheet_name = "By Transmission",
  heading = "Vehicle Summary by Transmission Type",
  freeze_rows = 1,
  freeze_cols = 0,
  add_index_link = TRUE,
  create_index = TRUE,
  append = TRUE
)

# Export third table (appends to workbook)
excelize(
  gt_object = gear_summary,
  filename = "output/example2_multi_tables.xlsx",
  sheet_name = "By Gears",
  heading = "Vehicle Summary by Number of Gears",
  freeze_rows = 1,
  freeze_cols = 0,
  add_index_link = TRUE,
  create_index = TRUE,
  append = TRUE
)

# Example 3: Iris dataset with species comparison ----
cat("\n=== Example 3: Iris species comparison ===\n")

iris_table <- iris |>
  group_by(Species) |>
  summarise(
    Count = n(),
    `Avg Sepal Length` = mean(Sepal.Length),
    `Avg Sepal Width` = mean(Sepal.Width),
    `Avg Petal Length` = mean(Petal.Length),
    `Avg Petal Width` = mean(Petal.Width),
    .groups = "drop"
  ) |>
  gt() |>
  tab_header(
    title = "Iris Species Measurements",
    subtitle = "Average measurements by species (n=50 per species)"
  ) |>
  fmt_number(
    columns = starts_with("Avg"),
    decimals = 2
  ) |>
  tab_spanner(
    label = "Sepal Measurements (cm)",
    columns = c(`Avg Sepal Length`, `Avg Sepal Width`)
  ) |>
  tab_spanner(
    label = "Petal Measurements (cm)",
    columns = c(`Avg Petal Length`, `Avg Petal Width`)
  )

excelize(
  gt_object = iris_table,
  filename = "output/example3_iris.xlsx",
  sheet_name = "Species Summary",
  heading = "Iris Species Comparison - Anderson's Dataset",
  freeze_rows = 1,
  freeze_cols = 1,
  add_index_link = FALSE,
  create_index = FALSE
)

# Example 4: Complex table with formatting ----
cat("\n=== Example 4: Sales data with conditional formatting ===\n")

# Create sample sales data
set.seed(42)
sales_data <- data.frame(
  Region = rep(c("North", "South", "East", "West"), each = 3),
  Quarter = rep(c("Q1", "Q2", "Q3"), 4),
  Revenue = round(runif(12, 50000, 200000), 0),
  Costs = round(runif(12, 30000, 100000), 0)
) |>
  mutate(
    Profit = Revenue - Costs,
    Margin = (Profit / Revenue) * 100
  )

sales_table <- sales_data |>
  gt() |>
  tab_header(
    title = "Regional Sales Performance",
    subtitle = "Quarterly revenue, costs, and profitability analysis"
  ) |>
  fmt_currency(
    columns = c(Revenue, Costs, Profit),
    currency = "EUR",
    decimals = 0
  ) |>
  fmt_percent(
    columns = Margin,
    decimals = 1,
    scale_values = FALSE
  ) |>
  cols_label(
    Region = "Sales Region",
    Quarter = "Quarter",
    Revenue = "Revenue",
    Costs = "Operating Costs",
    Profit = "Net Profit",
    Margin = "Profit Margin"
  ) |>
  tab_spanner(
    label = "Financial Metrics",
    columns = c(Revenue, Costs, Profit, Margin)
  )

excelize(
  gt_object = sales_table,
  filename = "output/example4_sales.xlsx",
  sheet_name = "Sales Analysis",
  heading = "2024 Regional Sales Performance Report",
  freeze_rows = 1,
  freeze_cols = 2,  # Freeze Region and Quarter columns
  add_index_link = FALSE,
  create_index = FALSE
)

cat("\n✓ All examples completed successfully!\n")
cat("Check the 'output/' directory for generated Excel files:\n")
cat("  - example1_mtcars.xlsx (single table)\n")
cat("  - example2_multi_tables.xlsx (multiple tables with index)\n")
cat("  - example3_iris.xlsx (iris species comparison)\n")
cat("  - example4_sales.xlsx (sales performance report)\n\n")
