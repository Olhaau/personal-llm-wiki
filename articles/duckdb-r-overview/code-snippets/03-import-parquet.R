# Importing Parquet Files with DuckDB
# ============================================================
# This script demonstrates how to work with Parquet files

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
  library(arrow)  # For creating example Parquet files
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create example Parquet file ----
example_data <- data.frame(
  id = 1:10000,
  timestamp = seq.POSIXt(
    from = as.POSIXct("2024-01-01"),
    by = "hour",
    length.out = 10000
  ),
  value = rnorm(10000, mean = 50, sd = 10),
  category = sample(c("A", "B", "C", "D", "E"), 10000, replace = TRUE),
  region = sample(c("North", "South", "East", "West"), 10000, replace = TRUE)
)

parquet_file <- "example_data.parquet"
arrow::write_parquet(example_data, parquet_file)
print(paste("Created example Parquet file:", parquet_file))
print(paste("File size:", round(file.size(parquet_file) / 1024, 2), "KB"))

# Method 1: Read entire Parquet file ----
data1 <- dbGetQuery(con, sprintf("
  SELECT * FROM read_parquet('%s')
  LIMIT 5
", parquet_file))

print("Method 1 - Read entire file:")
print(head(data1))

# Method 2: Read with column selection (faster, less memory) ----
data2 <- dbGetQuery(con, sprintf("
  SELECT id, category, value 
  FROM read_parquet('%s')
  WHERE value > 60
  LIMIT 5
", parquet_file))

print("Method 2 - Column selection and filtering:")
print(data2)

# Method 3: Create table from Parquet ----
dbExecute(con, sprintf("
  CREATE TABLE parquet_data AS 
  SELECT * FROM read_parquet('%s')
", parquet_file))

table_stats <- dbGetQuery(con, "
  SELECT 
    COUNT(*) as total_rows,
    COUNT(DISTINCT category) as categories,
    AVG(value) as mean_value
  FROM parquet_data
")
print("Method 3 - Table created:")
print(table_stats)

# Method 4: Parquet file metadata ----
metadata <- dbGetQuery(con, sprintf("
  SELECT * FROM parquet_metadata('%s')
", parquet_file))

print("Parquet file metadata:")
print(metadata)

# Method 5: Parquet schema inspection ----
schema <- dbGetQuery(con, sprintf("
  SELECT * FROM parquet_schema('%s')
", parquet_file))

print("Parquet schema:")
print(schema)

# Method 6: Aggregation queries on Parquet ----
# DuckDB can push down filters and projections to Parquet
aggregated <- dbGetQuery(con, sprintf("
  SELECT 
    category,
    region,
    COUNT(*) as n,
    AVG(value) as mean_value,
    STDDEV(value) as sd_value,
    MIN(value) as min_value,
    MAX(value) as max_value
  FROM read_parquet('%s')
  GROUP BY category, region
  ORDER BY category, region
", parquet_file))

print("Aggregated data by category and region:")
print(head(aggregated, 10))

# Method 7: Time-based filtering ----
time_filtered <- dbGetQuery(con, sprintf("
  SELECT 
    DATE_TRUNC('day', timestamp) as date,
    COUNT(*) as records_per_day,
    AVG(value) as daily_mean
  FROM read_parquet('%s')
  WHERE timestamp >= '2024-01-01' 
    AND timestamp < '2024-01-08'
  GROUP BY date
  ORDER BY date
", parquet_file))

print("Time-based filtering (first week of January):")
print(time_filtered)

# Method 8: Export query results to Parquet ----
output_file <- "filtered_output.parquet"
dbExecute(con, sprintf("
  COPY (
    SELECT * 
    FROM read_parquet('%s')
    WHERE category IN ('A', 'B')
      AND value > 55
  ) TO '%s' (FORMAT PARQUET)
", parquet_file, output_file))

print(paste("Filtered data exported to:", output_file))
print(paste("Output file size:", round(file.size(output_file) / 1024, 2), "KB"))

# Verify exported data
exported <- dbGetQuery(con, sprintf("
  SELECT 
    category,
    COUNT(*) as n,
    AVG(value) as mean_value
  FROM read_parquet('%s')
  GROUP BY category
", output_file))

print("Exported data summary:")
print(exported)

# Performance comparison: CSV vs Parquet ----
csv_file <- "example_data.csv"
write.csv(example_data, csv_file, row.names = FALSE)

time_parquet <- system.time({
  data_parquet <- dbGetQuery(con, sprintf("
    SELECT * FROM read_parquet('%s')
  ", parquet_file))
})

time_csv <- system.time({
  data_csv <- dbGetQuery(con, sprintf("
    SELECT * FROM read_csv_auto('%s')
  ", csv_file))
})

print("Performance comparison (10,000 rows):")
print(paste("Parquet:", round(time_parquet["elapsed"], 3), "seconds"))
print(paste("CSV:", round(time_csv["elapsed"], 3), "seconds"))
print(paste("Parquet is", round(time_csv["elapsed"] / time_parquet["elapsed"], 2), "x faster"))

print("File size comparison:")
print(paste("Parquet:", round(file.size(parquet_file) / 1024, 2), "KB"))
print(paste("CSV:", round(file.size(csv_file) / 1024, 2), "KB"))
print(paste("Parquet is", 
            round(file.size(csv_file) / file.size(parquet_file), 2), 
            "x smaller"))

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
file.remove(parquet_file, output_file, csv_file)
print("Connections closed and example files removed")
