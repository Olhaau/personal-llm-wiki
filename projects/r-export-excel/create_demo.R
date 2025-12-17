# Create demo Excel file using excelize
source('R/excelize.R')
library(gt)

# Create sample data
sample_data <- data.frame(
  Region = c('North', 'South', 'East', 'West'),
  Population = c(12500000, 18300000, 9800000, 15200000),
  Area_km2 = c(25000, 35000, 18000, 28000),
  Density = c(500, 523, 544, 543)
)

# Create gt table
my_table <- gt(sample_data) |>
  tab_header(title = 'Regional Statistics') |>
  fmt_number(columns = c(Population, Area_km2, Density), decimals = 0)

# Create output directory if needed
if (!dir.exists('output')) dir.create('output')

# Export to Excel
excelize(
  my_table,
  filename = 'output/demo_statistics.xlsx',
  sheet_name = 'Regional_Data',
  heading = 'German Regional Statistics 2024',
  freeze_rows = 2,
  freeze_cols = 1
)

cat('Excel file created successfully!\n')
