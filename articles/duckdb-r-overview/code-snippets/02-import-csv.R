# Importing CSV Files with DuckDB
# ============================================================
# This script demonstrates various ways to import CSV files

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create example CSV file ----
example_data <- data.frame(
  id = 1:1000,
  name = paste0("Item_", 1:1000),
  value = rnorm(1000, mean = 100, sd = 15),
  category = sample(c("A", "B", "C", "D"), 1000, replace = TRUE),
  date = seq.Date(from = as.Date("2024-01-01"), by = "day", length.out = 1000)
)

csv_file <- "example_data.csv"
write.csv(example_data, csv_file, row.names = FALSE)

# Method 1: Read CSV with automatic type detection ----
data1 <- dbGetQuery(con, sprintf("
  SELECT * FROM read_csv_auto('%s')
", csv_file))

print("Method 1 - Automatic type detection:")
print(head(data1, 3))
print(str(data1))

# Method 2: Read CSV with explicit column types ----
data2 <- dbGetQuery(con, sprintf("
  SELECT * FROM read_csv(
    '%s',
    columns = {
      'id': 'INTEGER',
      'name': 'VARCHAR',
      'value': 'DOUBLE',
      'category': 'VARCHAR',
      'date': 'DATE'
    }
  )
", csv_file))

print("Method 2 - Explicit types:")
print(head(data2, 3))

# Method 3: Read specific columns only ----
data3 <- dbGetQuery(con, sprintf("
  SELECT id, category, value 
  FROM read_csv_auto('%s')
  WHERE value > 100
", csv_file))

print("Method 3 - Filtered columns and rows:")
print(head(data3, 3))
print(paste("Rows returned:", nrow(data3)))

# Method 4: Create table from CSV ----
dbExecute(con, sprintf("
  CREATE TABLE csv_data AS 
  SELECT * FROM read_csv_auto('%s')
", csv_file))

# Verify table creation
table_info <- dbGetQuery(con, "
  SELECT COUNT(*) as row_count FROM csv_data
")
print(paste("Table created with", table_info$row_count, "rows"))

# Method 5: Advanced CSV options ----
# Handle different delimiters, headers, quotes, etc.
csv_custom <- "example_custom.csv"
write.table(example_data[1:100, ], 
            csv_custom, 
            sep = ";", 
            row.names = FALSE,
            quote = TRUE)

data5 <- dbGetQuery(con, sprintf("
  SELECT * FROM read_csv(
    '%s',
    delim = ';',
    header = true,
    quote = '\"'
  )
  LIMIT 5
", csv_custom))

print("Method 5 - Custom CSV format (semicolon delimiter):")
print(head(data5, 3))

# Method 6: Performance comparison ----
# Compare DuckDB vs base R for large files
large_csv <- "large_example.csv"
large_data <- data.frame(
  id = 1:100000,
  value1 = rnorm(100000),
  value2 = rnorm(100000),
  value3 = rnorm(100000),
  category = sample(letters[1:10], 100000, replace = TRUE)
)
write.csv(large_data, large_csv, row.names = FALSE)

# Time DuckDB read
time_duckdb <- system.time({
  data_duckdb <- dbGetQuery(con, sprintf("
    SELECT * FROM read_csv_auto('%s')
  ", large_csv))
})

# Time base R read
time_base <- system.time({
  data_base <- read.csv(large_csv)
})

print("Performance comparison (100,000 rows):")
print(paste("DuckDB:", round(time_duckdb["elapsed"], 3), "seconds"))
print(paste("Base R:", round(time_base["elapsed"], 3), "seconds"))
print(paste("Speedup:", round(time_base["elapsed"] / time_duckdb["elapsed"], 2), "x"))

# Aggregation without loading into R ----
# This is memory efficient for large files
summary <- dbGetQuery(con, sprintf("
  SELECT 
    category,
    COUNT(*) as n,
    AVG(value) as mean_value,
    MIN(value) as min_value,
    MAX(value) as max_value
  FROM read_csv_auto('%s')
  GROUP BY category
  ORDER BY n DESC
", csv_file))

print("Summary statistics (computed in DuckDB):")
print(summary)

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
file.remove(csv_file, csv_custom, large_csv)
print("Connections closed and example files removed")
