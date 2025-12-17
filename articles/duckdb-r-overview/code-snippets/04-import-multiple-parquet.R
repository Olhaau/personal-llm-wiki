# Importing Multiple Parquet Files with DuckDB
# ============================================================
# This script demonstrates how to read multiple Parquet files efficiently

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
  library(arrow)
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create directory structure with multiple Parquet files ----
dir.create("parquet_data", showWarnings = FALSE)
dir.create("parquet_data/2024", showWarnings = FALSE)
dir.create("parquet_data/2024/01", showWarnings = FALSE)
dir.create("parquet_data/2024/02", showWarnings = FALSE)

# Generate partitioned data (e.g., by month)
generate_monthly_data <- function(year, month, n = 5000) {
  data.frame(
    id = 1:n,
    year = year,
    month = month,
    date = seq.Date(
      from = as.Date(sprintf("%d-%02d-01", year, month)),
      length.out = n,
      by = "hour"
    ),
    value = rnorm(n, mean = 50 + month * 2, sd = 10),
    category = sample(c("A", "B", "C"), n, replace = TRUE),
    metric = sample(c("sales", "visits", "conversions"), n, replace = TRUE)
  )
}

# Create monthly Parquet files
jan_data <- generate_monthly_data(2024, 1)
feb_data <- generate_monthly_data(2024, 2)

arrow::write_parquet(jan_data, "parquet_data/2024/01/data.parquet")
arrow::write_parquet(feb_data, "parquet_data/2024/02/data.parquet")

print("Created partitioned Parquet files:")
print(list.files("parquet_data", recursive = TRUE))

# Method 1: Read all Parquet files in a directory ----
data1 <- dbGetQuery(con, "
  SELECT 
    month,
    COUNT(*) as records
  FROM read_parquet('parquet_data/2024/*/*.parquet')
  GROUP BY month
  ORDER BY month
")

print("Method 1 - Read all files with glob pattern:")
print(data1)

# Method 2: Read with explicit file list ----
data2 <- dbGetQuery(con, "
  SELECT 
    month,
    category,
    AVG(value) as mean_value
  FROM read_parquet([
    'parquet_data/2024/01/data.parquet',
    'parquet_data/2024/02/data.parquet'
  ])
  GROUP BY month, category
  ORDER BY month, category
")

print("Method 2 - Explicit file list:")
print(data2)

# Method 3: Create view over multiple files ----
dbExecute(con, "
  CREATE VIEW all_monthly_data AS
  SELECT * FROM read_parquet('parquet_data/2024/*/*.parquet')
")

# Query the view
view_summary <- dbGetQuery(con, "
  SELECT 
    year,
    month,
    metric,
    COUNT(*) as n,
    AVG(value) as mean_value
  FROM all_monthly_data
  GROUP BY year, month, metric
  ORDER BY year, month, metric
")

print("Method 3 - View over multiple files:")
print(view_summary)

# Method 4: Hive-style partitioning ----
# Create Hive-style partitioned structure
dir.create("parquet_hive", showWarnings = FALSE)
dir.create("parquet_hive/year=2024", showWarnings = FALSE)
dir.create("parquet_hive/year=2024/month=01", showWarnings = FALSE)
dir.create("parquet_hive/year=2024/month=02", showWarnings = FALSE)

# Write data without year/month columns (they're in the path)
jan_hive <- jan_data[, !(names(jan_data) %in% c("year", "month"))]
feb_hive <- feb_data[, !(names(feb_data) %in% c("year", "month"))]

arrow::write_parquet(jan_hive, "parquet_hive/year=2024/month=01/data.parquet")
arrow::write_parquet(feb_hive, "parquet_hive/year=2024/month=02/data.parquet")

# Read with hive partitioning enabled
hive_data <- dbGetQuery(con, "
  SELECT 
    year,
    month,
    category,
    COUNT(*) as n
  FROM read_parquet('parquet_hive/**/*.parquet', hive_partitioning = true)
  GROUP BY year, month, category
  ORDER BY year, month, category
  LIMIT 10
")

print("Method 4 - Hive-style partitioning:")
print(hive_data)

# Method 5: Filter by partition (efficient) ----
# DuckDB can skip reading entire partitions
filtered_partition <- dbGetQuery(con, "
  SELECT 
    category,
    AVG(value) as mean_value,
    COUNT(*) as n
  FROM read_parquet('parquet_data/2024/01/*.parquet')
  GROUP BY category
")

print("Method 5 - Filter specific partition (January only):")
print(filtered_partition)

# Method 6: Union of different schemas ----
# Create files with slightly different schemas
schema1 <- data.frame(
  id = 1:100,
  value = rnorm(100),
  type = "A"
)

schema2 <- data.frame(
  id = 101:200,
  value = rnorm(100),
  type = "B",
  extra_field = "new"  # Additional column
)

dir.create("parquet_union", showWarnings = FALSE)
arrow::write_parquet(schema1, "parquet_union/part1.parquet")
arrow::write_parquet(schema2, "parquet_union/part2.parquet")

# Read with union_by_name to handle different schemas
union_data <- dbGetQuery(con, "
  SELECT 
    type,
    COUNT(*) as n,
    COUNT(extra_field) as has_extra_field
  FROM read_parquet('parquet_union/*.parquet', union_by_name = true)
  GROUP BY type
")

print("Method 6 - Union with different schemas:")
print(union_data)

# Method 7: Performance - aggregation across multiple files ----
# DuckDB can efficiently aggregate without loading all data into memory
time_multi <- system.time({
  result <- dbGetQuery(con, "
    SELECT 
      month,
      category,
      metric,
      COUNT(*) as total_records,
      AVG(value) as mean_value,
      STDDEV(value) as sd_value,
      MIN(value) as min_value,
      MAX(value) as max_value,
      PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) as median_value
    FROM read_parquet('parquet_data/2024/*/*.parquet')
    GROUP BY month, category, metric
    ORDER BY month, category, metric
  ")
})

print("Method 7 - Complex aggregation across multiple files:")
print(result)
print(paste("Query time:", round(time_multi["elapsed"], 3), "seconds"))

# Method 8: Export to partitioned Parquet ----
output_dir <- "parquet_output"
dir.create(output_dir, showWarnings = FALSE)

dbExecute(con, sprintf("
  COPY (
    SELECT * 
    FROM read_parquet('parquet_data/2024/*/*.parquet')
    WHERE value > 50
  ) TO '%s' (FORMAT PARQUET, PARTITION_BY (month, category))
", output_dir))

print("Method 8 - Exported to partitioned Parquet:")
print(list.files(output_dir, recursive = TRUE))

# Count files and records in output
output_stats <- dbGetQuery(con, sprintf("
  SELECT 
    month,
    category,
    COUNT(*) as records
  FROM read_parquet('%s/**/*.parquet', hive_partitioning = true)
  GROUP BY month, category
  ORDER BY month, category
", output_dir))

print("Output partitions summary:")
print(output_stats)

# Best practices summary ----
print("\n=== Best Practices for Multiple Parquet Files ===")
print("1. Use glob patterns for flexible file selection")
print("2. Leverage Hive partitioning for efficient filtering")
print("3. Create views over multiple files for reusable queries")
print("4. Use COPY with PARTITION_BY for organized output")
print("5. DuckDB automatically parallelizes reads across files")
print("6. Partition filtering avoids reading unnecessary data")

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
unlink("parquet_data", recursive = TRUE)
unlink("parquet_hive", recursive = TRUE)
unlink("parquet_union", recursive = TRUE)
unlink("parquet_output", recursive = TRUE)
print("\nConnections closed and example files removed")
