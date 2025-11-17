---
title: "Arrow R Package - Working with Multi-File Datasets"
type: "technical_guide"
category: "apache-arrow"
subcategory: "r-package"
tags: ["datasets", "multi-file", "partitioning", "larger-than-memory", "apache-arrow", "r"]
language: "R"
project: "apache-arrow"
source_type: "official"
maintainer: "apache-arrow-project"
created_date: "2024-11-17"
last_updated: "2024-11-17"
status: "active"
scope: "dataset-operations"
target_audience: ["data-engineers", "data-scientists", "big-data-users"]
technical_level: "intermediate-to-advanced"
coverage: ["datasets", "partitioning", "cloud-storage", "performance", "memory-management"]
related_technologies: ["hive-partitioning", "parquet", "cloud-storage", "etl"]
source_urls: ["https://arrow.apache.org/docs/r/articles/dataset.html"]
version: "v22.0.0"
---

# Arrow R Package - Working with Multi-File Datasets

## Executive Summary

Arrow Datasets enable analysis of multi-file and larger-than-memory data collections using familiar dplyr syntax. The Dataset interface provides efficient data organization through partitioning, lazy evaluation for performance, and seamless integration with cloud storage systems. This approach allows processing of datasets that far exceed available memory while maintaining analytical workflow familiarity.

## Core Dataset Concepts

### Dataset vs Table Architecture
| Aspect | Table | Dataset |
|--------|-------|---------|
| **Storage** | In-memory | On-disk (multiple files) |
| **Size Limits** | Available RAM | Virtually unlimited |
| **File Count** | Single data object | Multiple files/partitions |
| **Performance** | RAM-speed access | Optimized I/O with caching |
| **Use Cases** | Interactive analysis | Big data, ETL, data warehousing |

### Lazy Evaluation Framework
Datasets use lazy evaluation where operations are planned but not executed until materialization:

```r
library(arrow, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)

# Connect to dataset (no data loaded)
ds <- open_dataset("nyc-taxi")

# Build query (operations recorded, not executed)  
query <- ds |>
  filter(total_amount > 100, year == 2015) |>
  select(tip_amount, total_amount, passenger_count) |>
  mutate(tip_pct = 100 * tip_amount / total_amount) |>
  group_by(passenger_count) |>
  summarise(median_tip_pct = median(tip_pct), n = n())

# Execute query and materialize results
result <- collect(query)
```

## Dataset Creation and File Organization

### Opening Existing Datasets
```r
# Open dataset with automatic format detection
ds <- open_dataset("data-directory")

# Specify format explicitly
ds_parquet <- open_dataset("parquet-data", format = "parquet")
ds_csv <- open_dataset("csv-data", format = "csv")

# Open specific files or file patterns
ds_files <- open_dataset(c("file1.parquet", "file2.parquet"))
```

### Supported File Formats
| Format | Function | Best For | Considerations |
|--------|----------|----------|----------------|
| **Parquet** | `open_dataset()` | Analytics, compression | Default choice for most use cases |
| **Arrow/Feather** | `format = "arrow"` | Speed, metadata | Fast I/O, cross-language compatibility |
| **CSV** | `open_csv_dataset()` | Text data, legacy systems | Flexible parsing, slower than binary formats |
| **TSV** | `open_tsv_dataset()` | Tab-delimited text | Specialized delimiter handling |
| **Generic Text** | `open_delim_dataset()` | Custom delimited files | Full control over parsing |

### CSV Dataset Configuration
```r
# Advanced CSV dataset opening with parsing control
ds_csv <- open_csv_dataset(
  "csv-data/",
  delim = ",",
  quote = "\"",
  escape_double = TRUE,
  skip_empty_rows = TRUE,
  schema = schema(
    id = int64(),
    amount = float64(), 
    date = timestamp(),
    category = utf8()
  )
)
```

## Partitioning Strategies

### Hive-Style Partitioning (Self-Describing)
Hive partitioning uses `key=value` folder naming convention:

```
data/
├── year=2009/
│   ├── month=1/
│   │   └── part-0.parquet
│   └── month=2/
│       └── part-0.parquet
└── year=2010/
    ├── month=1/
    │   └── part-0.parquet
    └── month=2/
        └── part-0.parquet
```

```r
# Automatically inferred from folder structure
ds <- open_dataset("data/")  # Recognizes year and month partitions
```

### Directory-Based Partitioning (Non-Self-Describing)
When folder names don't include field names:

```
data/
├── 2009/
│   ├── 01/
│   │   └── part-0.parquet
│   └── 02/
│       └── part-0.parquet
└── 2010/
    ├── 01/
    │   └── part-0.parquet
    └── 02/
        └── part-0.parquet
```

```r
# Explicitly specify partition columns
ds <- open_dataset("data/", partitioning = c("year", "month"))
```

### Custom Partitioning Schema
```r
# Specify data types for partition columns
partition_schema <- schema(
  year = int32(),
  month = utf8(),  # Keep month as string
  region = utf8()
)

ds <- open_dataset(
  "data/", 
  partitioning = partition_schema
)
```

## Writing Datasets with Partitioning

### Basic Dataset Writing
```r
# Create sample data
set.seed(1234)
sample_data <- data.frame(
  x = rnorm(100000),
  y = rnorm(100000),
  category = sample(LETTERS[1:5], 100000, replace = TRUE),
  year = sample(2020:2023, 100000, replace = TRUE),
  month = sample(1:12, 100000, replace = TRUE)
)

# Write partitioned dataset
sample_data |>
  group_by(year, month) |>
  write_dataset("partitioned-data/")
```

### Advanced Partitioning Control
```r
# Custom partitioning with filtering
sample_data |>
  filter(category %in% c("A", "B", "C")) |>  # Pre-filter data
  group_by(category) |>
  select(-year) |>  # Remove unwanted columns
  write_dataset(
    path = "filtered-data/",
    format = "parquet",
    hive_style = TRUE,  # Use key=value folder naming
    existing_data_behavior = "overwrite"
  )
```

### Multi-Source Dataset Composition
```r
# Combine multiple datasets
ds1 <- open_dataset("source1/")
ds2 <- open_dataset("source2/")

# Concatenate datasets
combined_ds <- c(ds1, ds2)

# Create from list of datasets  
multi_source_ds <- open_dataset(list(
  parquet_data = "parquet-files/",
  csv_data = open_csv_dataset("csv-files/")
))
```

## Query Optimization and Performance

### Partition Pruning
Efficient queries leverage partitioning for file-level filtering:

```r
# Efficient: Only reads files for 2015
efficient_query <- ds |>
  filter(year == 2015) |>  # Partition pruning
  summarize(total_rides = n())

# Less efficient: Reads all files, then filters
less_efficient <- ds |>
  mutate(is_2015 = year == 2015) |>
  filter(is_2015) |>
  summarize(total_rides = n())
```

### Column Pruning  
Select only necessary columns to minimize I/O:

```r
# Efficient: Reads only selected columns
optimized <- ds |>
  select(passenger_count, tip_amount, total_amount) |>
  filter(passenger_count > 0) |>
  collect()

# Less efficient: Reads all columns
suboptimal <- ds |>
  filter(passenger_count > 0) |>
  select(passenger_count, tip_amount, total_amount) |>
  collect()
```

### Predicate Pushdown
Push filters down to file level for optimal performance:

```r
# Multiple filters pushed down efficiently
performance_query <- ds |>
  filter(
    year >= 2020,           # Partition-level filter
    total_amount > 50,      # Row-group level filter (Parquet)
    passenger_count <= 6    # Row-level filter
  ) |>
  group_by(pickup_location_id) |>
  summarize(
    avg_fare = mean(fare_amount),
    ride_count = n()
  ) |>
  filter(ride_count > 100) |>  # Post-aggregation filter
  collect()
```

## Batch Processing for Large Datasets

### Experimental Batch Processing
For datasets too large to process in memory:

```r
# Process dataset in batches
sampled_data <- ds |>
  filter(year == 2015) |>
  select(tip_amount, total_amount, passenger_count) |>
  map_batches(~ as_record_batch(sample_frac(as.data.frame(.), 1e-4))) |>
  mutate(tip_pct = tip_amount / total_amount) |>
  collect()
```

### Custom Batch Functions
```r
# Apply custom processing to each batch
batch_summary <- ds |>
  filter(year == 2020) |>
  select(fare_amount, tip_amount, total_amount) |>
  map_batches(function(batch) {
    batch_df <- as.data.frame(batch)
    
    # Custom processing per batch
    batch_df |>
      summarize(
        batch_size = n(),
        avg_fare = mean(fare_amount, na.rm = TRUE),
        tip_ratio = sum(tip_amount) / sum(total_amount),
        outlier_count = sum(fare_amount > quantile(fare_amount, 0.99, na.rm = TRUE), na.rm = TRUE)
      ) |>
      as_record_batch()
  }) |>
  summarize(
    total_rides = sum(batch_size),
    overall_avg_fare = weighted.mean(avg_fare, batch_size),
    total_outliers = sum(outlier_count)
  ) |>
  collect()
```

## Performance Optimization Guidelines

### Partitioning Best Practices
- **Avoid very small files**: Target 20MB - 2GB per file
- **Limit partition count**: Stay under 10,000 distinct partitions  
- **Choose partition keys wisely**: Use commonly filtered columns
- **Balance partition size**: Avoid extreme imbalance between partitions

```r
# Good partitioning strategy
data |>
  mutate(
    year_month = paste0(year, "-", sprintf("%02d", month))
  ) |>
  group_by(year_month) |>  # Reasonable partition count
  write_dataset("well-partitioned/")

# Problematic partitioning
data |>
  group_by(user_id) |>  # Potentially millions of partitions
  write_dataset("over-partitioned/")
```

### Query Performance Patterns
```r
# Efficient query pattern
efficient_pattern <- function(dataset) {
  dataset |>
    # 1. Partition-level filtering first
    filter(year >= 2020) |>
    # 2. Column selection early  
    select(date, amount, category, region) |>
    # 3. Row-level filtering
    filter(amount > 0, !is.na(category)) |>
    # 4. Grouping and aggregation
    group_by(region, category) |>
    summarize(
      total_amount = sum(amount),
      transaction_count = n(),
      avg_amount = mean(amount)
    ) |>
    # 5. Post-aggregation filtering
    filter(transaction_count >= 10) |>
    collect()
}
```

## Cloud Storage Integration

### Remote Dataset Access
```r
# Amazon S3
s3_bucket <- s3_bucket("voltrondata-labs-datasets/nyc-taxi")
s3_dataset <- open_dataset(s3_bucket)

# Google Cloud Storage
gcs_bucket <- gs_bucket("voltrondata-labs-datasets/nyc-taxi", anonymous = TRUE)
gcs_dataset <- open_dataset(gcs_bucket)

# Direct URL access
url_dataset <- open_dataset("s3://bucket/path/to/data/")
```

### Local Copying from Cloud
```r
# Copy cloud data locally for repeated analysis
copy_files(
  from = s3_bucket("source-bucket/dataset/"),
  to = "local-copy/",
  chunk_size = 1024^3  # 1GB chunks
)

local_dataset <- open_dataset("local-copy/")
```

## Data Transformation and ETL Workflows

### Format Conversion
```r
# Convert CSV to optimized Parquet
csv_dataset <- open_csv_dataset("raw-csv-data/")

csv_dataset |>
  # Apply transformations
  mutate(
    date = as.Date(date_string),
    amount_usd = amount * exchange_rate
  ) |>
  # Add derived columns
  mutate(
    year = year(date),
    quarter = quarter(date)
  ) |>
  # Partition by derived columns
  group_by(year, quarter) |>
  write_dataset("processed-parquet/", format = "parquet")
```

### Data Quality Processing
```r
# Comprehensive data cleaning pipeline
clean_dataset <- raw_dataset |>
  # Remove obvious data quality issues
  filter(
    !is.na(id),
    date >= as.Date("2020-01-01"),
    amount > 0,
    amount < 1000000  # Remove extreme outliers
  ) |>
  # Standardize and enrich
  mutate(
    # Standardize string columns
    category = toupper(trimws(category)),
    # Add computed columns
    amount_log = log10(amount + 1),
    is_weekend = wday(date) %in% c(1, 7)
  ) |>
  # Write cleaned data
  group_by(year(date), month(date)) |>
  write_dataset("cleaned-data/")
```

## Monitoring and Diagnostics

### Dataset Inspection
```r
# Examine dataset structure
ds <- open_dataset("data/")

# Basic dataset information
print(ds)

# Schema inspection
schema(ds)

# Partition information
ds$filesystem$ls("data/", recursive = TRUE)

# File count and sizes
files_info <- ds$files
length(files_info)  # Number of files
```

### Query Performance Monitoring
```r
# Time complex operations
system.time({
  result <- large_dataset |>
    complex_analysis() |>
    collect()
})

# Memory usage tracking  
initial_memory <- pryr::mem_used()
result <- dataset |> analysis_pipeline() |> collect()
memory_used <- pryr::mem_used() - initial_memory
```

### Data Profiling
```r
# Generate dataset statistics
profile_dataset <- function(dataset) {
  dataset |>
    summarize(
      total_rows = n(),
      # File-level statistics
      partition_count = n_distinct(across(all_of(dataset$partition_columns))),
      # Data quality metrics
      null_percentage = mean(is.na(value)) * 100,
      # Value distributions
      min_value = min(value, na.rm = TRUE),
      max_value = max(value, na.rm = TRUE),
      median_value = median(value, na.rm = TRUE)
    ) |>
    collect()
}
```

## Advanced Use Cases and Patterns

### Incremental Data Processing
```r
# Process only new partitions
process_new_data <- function(dataset_path, last_processed_date) {
  open_dataset(dataset_path) |>
    filter(date > last_processed_date) |>
    # Apply processing logic
    mutate(processed_timestamp = Sys.time()) |>
    group_by(year(date), month(date)) |>
    write_dataset("processed/", mode = "append")
}
```

### Time Series Analysis at Scale
```r
# Large-scale time series aggregation
time_series_summary <- large_dataset |>
  filter(date >= as.Date("2023-01-01")) |>
  mutate(
    week = floor_date(date, "week"),
    month = floor_date(date, "month")
  ) |>
  group_by(category, week) |>
  summarize(
    weekly_total = sum(amount),
    transaction_count = n(),
    avg_transaction = mean(amount)
  ) |>
  collect()
```

### A/B Testing Analysis
```r
# Large-scale experiment analysis
experiment_results <- experiment_dataset |>
  filter(
    experiment_start_date <= date,
    date <= experiment_end_date
  ) |>
  group_by(treatment_group, user_segment) |>
  summarize(
    users = n_distinct(user_id),
    conversion_rate = mean(converted),
    avg_revenue_per_user = mean(revenue),
    total_revenue = sum(revenue)
  ) |>
  collect()
```

## Integration with Analytics Ecosystems

### Spark Integration
```r
# Transfer to Spark for advanced analytics
arrow_table <- dataset |> 
  filter(relevant_data) |>
  compute()

# Use with sparklyr (if available)
spark_table <- arrow_table |>
  sdf_copy_to(spark_connection, ., "arrow_data")
```

### Database Export
```r
# Export aggregated results to database
summary_table <- large_dataset |>
  group_by(region, product_category) |>
  summarize(
    total_sales = sum(amount),
    customer_count = n_distinct(customer_id),
    avg_order_value = mean(amount)
  ) |>
  collect()

# Write to database
DBI::dbWriteTable(db_connection, "sales_summary", summary_table)
```

This comprehensive guide provides the foundation for working with multi-file datasets using Arrow R, emphasizing scalable data processing patterns, performance optimization, and integration with broader data ecosystem workflows.