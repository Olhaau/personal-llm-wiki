# DuckDB Setup and Connection
# ============================================================
# This script demonstrates how to install and set up DuckDB in R

# Install DuckDB (run once) ----
# install.packages("duckdb")

# Load required libraries ----
suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
})

# Create an in-memory database ----
# Best for temporary analysis, data lost when connection closes
con_memory <- dbConnect(duckdb::duckdb())

# Verify connection
print("In-memory database connected:")
print(con_memory)

# Create a persistent database ----
# Data is saved to disk and persists between sessions
db_path <- "my_analysis.duckdb"
con_disk <- dbConnect(duckdb::duckdb(), dbdir = db_path)

print(paste("Persistent database created at:", db_path))

# Check DuckDB version ----
version_info <- dbGetQuery(con_memory, "SELECT version()")
print(paste("DuckDB version:", version_info$version))

# Configure DuckDB settings ----
# Set number of threads (default is all available cores)
dbExecute(con_memory, "SET threads TO 4")

# Set memory limit (e.g., 4GB)
dbExecute(con_memory, "SET memory_limit = '4GB'")

# Verify settings
settings <- dbGetQuery(con_memory, "
  SELECT name, value 
  FROM duckdb_settings() 
  WHERE name IN ('threads', 'memory_limit')
")
print("Current settings:")
print(settings)

# Create example table ----
dbExecute(con_memory, "
  CREATE TABLE example AS 
  SELECT 
    RANGE as id,
    CAST(RANGE * 1.5 AS DOUBLE) as value,
    CASE WHEN RANGE % 3 = 0 THEN 'A' 
         WHEN RANGE % 3 = 1 THEN 'B' 
         ELSE 'C' END as category
  FROM RANGE(1, 101)
")

# Verify table creation
result <- dbGetQuery(con_memory, "
  SELECT 
    COUNT(*) as row_count,
    COUNT(DISTINCT category) as categories
  FROM example
")
print("Example table created:")
print(result)

# List all tables in database ----
tables <- dbListTables(con_memory)
print("Available tables:")
print(tables)

# Proper connection cleanup ----
# Always close connections when done

# Close in-memory connection
dbDisconnect(con_memory, shutdown = TRUE)
print("In-memory connection closed")

# Close persistent connection
dbDisconnect(con_disk, shutdown = TRUE)
print("Persistent connection closed")

# Note: The persistent database file remains on disk
# and can be reopened later with:
# con <- dbConnect(duckdb::duckdb(), dbdir = db_path)

# Clean up example database file ----
if (file.exists(db_path)) {
  file.remove(db_path)
  print("Example database file removed")
}
