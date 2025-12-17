# Using DuckDB in R: A Comprehensive Overview

## Introduction

DuckDB is an in-process SQL OLAP database management system designed for analytical workloads. It combines the convenience of SQLite with the performance characteristics of columnar databases, making it an excellent choice for data analysis in R.

### Why Use DuckDB in R?

- **Performance**: Fast analytical queries, especially on large datasets
- **Memory efficiency**: Can work with datasets larger than RAM
- **SQL interface**: Familiar SQL syntax with R integration
- **Zero configuration**: No server setup required
- **Parquet support**: Native support for columnar file formats
- **Integration**: Works seamlessly with dplyr and data.table

## Installation and Setup

Install DuckDB from CRAN:

```r
install.packages("duckdb")
```

See [`code-snippets/01-setup.R`](code-snippets/01-setup.R) for a complete connection setup example.

## Data Import

### Importing CSV Files

DuckDB can read CSV files directly using SQL queries, which is often faster than base R's `read.csv()` for large files.

```r
# Read CSV directly into DuckDB
con <- dbConnect(duckdb::duckdb())
data <- dbGetQuery(con, "SELECT * FROM read_csv_auto('data.csv')")
```

See [`code-snippets/02-import-csv.R`](code-snippets/02-import-csv.R) for a complete example with options.

### Importing Parquet Files

Parquet is a columnar storage format that works excellently with DuckDB:

```r
# Read single Parquet file
data <- dbGetQuery(con, "SELECT * FROM read_parquet('data.parquet')")
```

See [`code-snippets/03-import-parquet.R`](code-snippets/03-import-parquet.R) for additional options and filtering.

### Importing Multiple Parquet Files

DuckDB can efficiently read multiple Parquet files as a single table using glob patterns:

```r
# Read all Parquet files in a directory
data <- dbGetQuery(con, "
  SELECT * FROM read_parquet('data/*.parquet')
")
```

See [`code-snippets/04-import-multiple-parquet.R`](code-snippets/04-import-multiple-parquet.R) for more advanced patterns.

## Data Analysis

### Grouped Counts

DuckDB excels at aggregation queries:

```r
# Count by group
counts <- dbGetQuery(con, "
  SELECT category, COUNT(*) as n
  FROM data
  GROUP BY category
  ORDER BY n DESC
")
```

See [`code-snippets/05-grouped-counts.R`](code-snippets/05-grouped-counts.R) for more examples including multiple grouping variables.

### Computing Means by Groups

Calculate summary statistics efficiently:

```r
# Mean by group
means <- dbGetQuery(con, "
  SELECT 
    category,
    AVG(value) as mean_value,
    STDDEV(value) as sd_value,
    COUNT(*) as n
  FROM data
  GROUP BY category
")
```

See [`code-snippets/06-grouped-means.R`](code-snippets/06-grouped-means.R) for additional aggregation functions.

### Linear Models

Use DuckDB to prepare data for statistical modeling:

```r
# Load data from DuckDB
model_data <- dbGetQuery(con, "
  SELECT outcome, predictor1, predictor2, predictor3
  FROM large_dataset
  WHERE predictor1 IS NOT NULL
")

# Fit linear model
lm_fit <- lm(outcome ~ predictor1 + predictor2 + predictor3, 
             data = model_data)
summary(lm_fit)
```

See [`code-snippets/07-linear-model.R`](code-snippets/07-linear-model.R) for a complete workflow including diagnostics.

### Decision Tree Models

DuckDB can efficiently sample and prepare data for machine learning:

```r
# Sample data for training
library(rpart)

train_data <- dbGetQuery(con, "
  SELECT * FROM large_dataset
  WHERE random() < 0.7
")

# Fit decision tree
tree_fit <- rpart(outcome ~ ., data = train_data, method = "class")
```

See [`code-snippets/08-decision-tree.R`](code-snippets/08-decision-tree.R) for a complete example with cross-validation.

## Performance Considerations

### Memory Management

DuckDB uses streaming and columnar storage to handle datasets larger than available RAM:

- Query only needed columns: `SELECT col1, col2` instead of `SELECT *`
- Use `WHERE` clauses to filter early
- Leverage DuckDB's lazy evaluation

### Indexing and Optimization

```r
# Create index for faster queries
dbExecute(con, "CREATE INDEX idx_category ON data(category)")

# Analyze query plans
dbGetQuery(con, "EXPLAIN SELECT * FROM data WHERE category = 'A'")
```

### Parallel Processing

DuckDB automatically uses multiple CPU cores for query execution. Control thread count with:

```r
dbExecute(con, "SET threads TO 4")
```

## Best Practices

### Connection Management

Always close connections when done:

```r
# Open connection
con <- dbConnect(duckdb::duckdb(), dbdir = "my_database.duckdb")

# Work with data
# ...

# Close connection
dbDisconnect(con, shutdown = TRUE)
```

### Using dplyr with DuckDB

DuckDB integrates seamlessly with dplyr:

```r
library(dplyr)

# Create table in DuckDB
duckdb_register(con, "my_table", my_data)

# Use dplyr verbs
result <- tbl(con, "my_table") |>
  filter(value > 100) |>
  group_by(category) |>
  summarise(mean_value = mean(value)) |>
  collect()
```

### Persistent vs In-Memory Databases

```r
# In-memory (temporary)
con <- dbConnect(duckdb::duckdb())

# Persistent (saved to disk)
con <- dbConnect(duckdb::duckdb(), dbdir = "my_analysis.duckdb")
```

### Working with Large Files

```r
# Read large file in chunks
dbExecute(con, "CREATE TABLE data AS 
  SELECT * FROM read_csv_auto('large_file.csv')")

# Query without loading into R memory
result <- dbGetQuery(con, "
  SELECT category, COUNT(*) as n
  FROM data
  GROUP BY category
")
```

## Common Patterns

### ETL Workflow

```r
# Extract: Load data from multiple sources
dbExecute(con, "CREATE TABLE raw_data AS 
  SELECT * FROM read_parquet('source/*.parquet')")

# Transform: Clean and prepare data
dbExecute(con, "CREATE TABLE clean_data AS
  SELECT 
    col1,
    CAST(col2 AS INTEGER) as col2,
    CASE WHEN col3 > 0 THEN col3 ELSE 0 END as col3
  FROM raw_data
  WHERE col1 IS NOT NULL")

# Load: Export results
dbExecute(con, "COPY clean_data TO 'output.parquet' (FORMAT PARQUET)")
```

### Joining Multiple Datasets

```r
result <- dbGetQuery(con, "
  SELECT 
    a.id,
    a.value,
    b.category,
    c.metadata
  FROM dataset_a a
  LEFT JOIN dataset_b b ON a.id = b.id
  LEFT JOIN dataset_c c ON a.id = c.id
  WHERE a.value > 100
")
```

## Resources and Further Reading

### Official Documentation
- DuckDB R Package: https://duckdb.org/docs/api/r
- DuckDB SQL Reference: https://duckdb.org/docs/sql/introduction
- DuckDB Functions: https://duckdb.org/docs/sql/functions/overview

### Performance Tuning
- DuckDB Performance Guide: https://duckdb.org/docs/guides/performance/overview
- Parquet Best Practices: https://duckdb.org/docs/data/parquet/overview

### Community Resources
- DuckDB GitHub: https://github.com/duckdb/duckdb
- R Package Repository: https://github.com/duckdb/duckdb-r

## Comparison with Other Tools

| Feature | DuckDB | data.table | Arrow | Base R |
|---------|---------|------------|-------|--------|
| In-memory speed | Fast | Very Fast | Fast | Moderate |
| Out-of-core support | Yes | Limited | Yes | No |
| SQL interface | Native | No | Via DuckDB | Via sqldf |
| Parquet support | Native | Via arrow | Native | Via arrow |
| Learning curve | Moderate | Steep | Moderate | Easy |
| Setup complexity | Minimal | Minimal | Minimal | None |

## Conclusion

DuckDB provides a powerful, efficient solution for data analysis in R. Its combination of SQL expressiveness, columnar performance, and seamless R integration makes it ideal for:

- Analyzing large CSV or Parquet files
- Performing complex aggregations and joins
- Preparing data for statistical modeling
- Building ETL pipelines
- Working with datasets larger than RAM

The examples in this article and the accompanying code snippets provide a foundation for incorporating DuckDB into your R workflows. Start with simple queries and gradually explore more advanced features as your needs grow.

## Code Snippets Summary

All example code is available in the `code-snippets/` directory:

1. [`01-setup.R`](code-snippets/01-setup.R) - Installation and connection setup
2. [`02-import-csv.R`](code-snippets/02-import-csv.R) - CSV import with options
3. [`03-import-parquet.R`](code-snippets/03-import-parquet.R) - Single Parquet file import
4. [`04-import-multiple-parquet.R`](code-snippets/04-import-multiple-parquet.R) - Multiple Parquet files
5. [`05-grouped-counts.R`](code-snippets/05-grouped-counts.R) - Aggregation with GROUP BY
6. [`06-grouped-means.R`](code-snippets/06-grouped-means.R) - Computing summary statistics
7. [`07-linear-model.R`](code-snippets/07-linear-model.R) - Linear regression workflow
8. [`08-decision-tree.R`](code-snippets/08-decision-tree.R) - Decision tree modeling

---

*Last updated: December 2025*
