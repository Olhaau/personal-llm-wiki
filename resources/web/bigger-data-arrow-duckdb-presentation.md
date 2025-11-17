---
title: "Bigger Data with Arrow and DuckDB - Tom Mock & Edgar Ruiz Presentation"
type: "presentation_materials"
category: "apache-arrow"
subcategory: "integration"
tags: ["presentation", "duckdb", "integration", "bigger-data", "apache-arrow", "r"]
language: "R"
project: "apache-arrow"
source_type: "presentation"
maintainer: "external"
created_date: "2024-11-17"
last_updated: "2024-11-17"
status: "archived"
scope: "integration-focused"
target_audience: ["data-scientists", "analysts", "r-developers"]
technical_level: "intermediate-to-advanced"
coverage: ["arrow-duckdb-integration", "sql-analytics", "performance", "bigger-data"]
related_technologies: ["duckdb", "sql", "analytics", "performance-optimization"]
source_urls: ["https://jthomasmock.github.io/bigger-data/#1"]
presenters: ["tom-mock", "edgar-ruiz"]
event_type: "R Conference"
---

# Bigger Data with Arrow and DuckDB - Tom Mock & Edgar Ruiz Presentation

## Overview

This presentation explores the powerful combination of Apache Arrow and DuckDB for handling larger-than-memory datasets in R. The materials demonstrate practical workflows that leverage Arrow's columnar format with DuckDB's high-performance SQL analytics engine, providing R users with a scalable solution for big data processing.

## Key Integration Concepts

### Arrow + DuckDB Synergy
- **Zero-Copy Integration**: Arrow tables can be passed directly to DuckDB without serialization overhead
- **Columnar Optimization**: Both systems optimize for columnar data processing
- **Memory Efficiency**: Streaming and out-of-core processing capabilities
- **SQL Analytics**: Leverage SQL for complex analytics while maintaining R workflow integration

### Workflow Architecture
```r
library(arrow)
library(duckdb)
library(dplyr)

# Arrow for data ingestion and basic processing
dataset <- open_dataset("large_data/") %>%
  filter(date >= "2022-01-01") %>%
  select(date, category, value, region)

# DuckDB for complex SQL analytics
con <- dbConnect(duckdb())
result <- dataset %>%
  to_duckdb(con, "analysis_table") %>%
  # Switch to SQL for complex operations
  dbGetQuery("
    WITH monthly_stats AS (
      SELECT 
        DATE_TRUNC('month', date) as month,
        category,
        region,
        AVG(value) as avg_value,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY value) as median_value,
        COUNT(*) as record_count
      FROM analysis_table 
      GROUP BY month, category, region
    ),
    regional_rankings AS (
      SELECT *,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY avg_value DESC) as rank
      FROM monthly_stats
    )
    SELECT * FROM regional_rankings WHERE rank <= 10
  ")
```

## Technical Implementation Details

### Data Pipeline Architecture
```r
# Stage 1: Arrow-based data preparation
prepare_data <- function(source_path, filters = list()) {
  dataset <- open_dataset(source_path)
  
  # Apply basic filters using Arrow (predicate pushdown)
  if (length(filters) > 0) {
    for (filter_expr in filters) {
      dataset <- dataset %>% filter(!!filter_expr)
    }
  }
  
  return(dataset)
}

# Stage 2: DuckDB integration for analytics
analyze_with_duckdb <- function(arrow_dataset, sql_query) {
  con <- dbConnect(duckdb())
  
  # Register Arrow dataset as DuckDB table
  arrow_dataset %>% to_duckdb(con, "data")
  
  # Execute complex SQL analytics
  result <- dbGetQuery(con, sql_query)
  
  # Cleanup
  dbDisconnect(con, shutdown = TRUE)
  
  return(result)
}
```

### Performance Optimization Strategies
```r
# Memory-efficient processing with chunking
process_large_dataset_chunks <- function(dataset_path, chunk_size = 1000000) {
  con <- dbConnect(duckdb())
  
  # Initialize DuckDB table structure
  first_batch <- open_dataset(dataset_path) %>%
    head(1000) %>%
    collect()
  
  dbWriteTable(con, "accumulator", first_batch, overwrite = TRUE)
  
  # Process in chunks
  dataset <- open_dataset(dataset_path)
  total_rows <- dataset %>% count() %>% pull()
  chunks <- ceiling(total_rows / chunk_size)
  
  for (i in seq_len(chunks)) {
    start_row <- (i - 1) * chunk_size + 1
    end_row <- min(i * chunk_size, total_rows)
    
    chunk <- dataset %>%
      slice(start_row:end_row) %>%
      to_duckdb(con, "current_chunk")
    
    # Process chunk with SQL
    dbExecute(con, "
      INSERT INTO accumulator 
      SELECT * FROM current_chunk 
      WHERE some_condition = true
    ")
  }
  
  # Final result
  result <- dbGetQuery(con, "SELECT * FROM accumulator")
  dbDisconnect(con, shutdown = TRUE)
  return(result)
}
```

## Real-World Use Cases Demonstrated

### Financial Time Series Analysis
```r
# High-frequency trading data analysis
analyze_trading_data <- function(data_path, symbol_filter = NULL) {
  trading_data <- open_dataset(data_path) %>%
    filter(trade_date >= as.Date("2022-01-01"))
  
  if (!is.null(symbol_filter)) {
    trading_data <- trading_data %>% filter(symbol %in% symbol_filter)
  }
  
  con <- dbConnect(duckdb())
  analysis <- trading_data %>%
    to_duckdb(con, "trades") %>%
    dbGetQuery("
      WITH minute_bars AS (
        SELECT 
          symbol,
          DATE_TRUNC('minute', timestamp) as minute,
          FIRST(price ORDER BY timestamp) as open_price,
          MAX(price) as high_price,
          MIN(price) as low_price,
          LAST(price ORDER BY timestamp) as close_price,
          SUM(volume) as volume
        FROM trades
        GROUP BY symbol, minute
      ),
      volatility_calc AS (
        SELECT *,
          (high_price - low_price) / open_price as minute_volatility,
          LAG(close_price) OVER (PARTITION BY symbol ORDER BY minute) as prev_close
        FROM minute_bars
      )
      SELECT 
        symbol,
        DATE_TRUNC('hour', minute) as hour,
        AVG(minute_volatility) as avg_volatility,
        SUM(volume) as total_volume,
        COUNT(*) as trades_count
      FROM volatility_calc
      WHERE prev_close IS NOT NULL
      GROUP BY symbol, hour
      ORDER BY symbol, hour
    ")
  
  dbDisconnect(con, shutdown = TRUE)
  return(analysis)
}
```

### Customer Analytics at Scale
```r
# Large-scale customer behavior analysis
customer_segmentation <- function(events_path, customers_path) {
  # Load customer events (potentially billions of records)
  events <- open_dataset(events_path)
  customers <- open_dataset(customers_path)
  
  con <- dbConnect(duckdb())
  
  # Register both datasets
  events %>% to_duckdb(con, "events")
  customers %>% to_duckdb(con, "customers")
  
  # Complex segmentation analysis
  segments <- dbGetQuery(con, "
    WITH customer_metrics AS (
      SELECT 
        e.customer_id,
        c.registration_date,
        c.demographic_segment,
        COUNT(DISTINCT e.event_date) as active_days,
        COUNT(*) as total_events,
        SUM(CASE WHEN e.event_type = 'purchase' THEN e.event_value ELSE 0 END) as total_spend,
        MAX(e.event_date) as last_activity,
        MIN(e.event_date) as first_activity
      FROM events e
      JOIN customers c ON e.customer_id = c.customer_id
      WHERE e.event_date >= '2022-01-01'
      GROUP BY e.customer_id, c.registration_date, c.demographic_segment
    ),
    rfm_analysis AS (
      SELECT *,
        NTILE(5) OVER (ORDER BY last_activity) as recency_score,
        NTILE(5) OVER (ORDER BY active_days) as frequency_score,
        NTILE(5) OVER (ORDER BY total_spend) as monetary_score
      FROM customer_metrics
    )
    SELECT 
      demographic_segment,
      recency_score,
      frequency_score,
      monetary_score,
      COUNT(*) as customer_count,
      AVG(total_spend) as avg_spend,
      AVG(active_days) as avg_active_days
    FROM rfm_analysis
    GROUP BY demographic_segment, recency_score, frequency_score, monetary_score
    ORDER BY demographic_segment, monetary_score DESC, frequency_score DESC
  ")
  
  dbDisconnect(con, shutdown = TRUE)
  return(segments)
}
```

### Geospatial Analysis
```r
# Large-scale geospatial processing
analyze_location_data <- function(gps_data_path, poi_data_path) {
  con <- dbConnect(duckdb())
  
  # Install spatial extension
  dbExecute(con, "INSTALL spatial; LOAD spatial;")
  
  # Load datasets
  open_dataset(gps_data_path) %>% to_duckdb(con, "gps_points")
  open_dataset(poi_data_path) %>% to_duckdb(con, "points_of_interest")
  
  # Spatial analysis with SQL
  proximity_analysis <- dbGetQuery(con, "
    SELECT 
      poi.category as poi_category,
      COUNT(DISTINCT gps.user_id) as unique_users,
      COUNT(*) as total_visits,
      AVG(ST_Distance_Sphere(
        ST_Point(gps.longitude, gps.latitude),
        ST_Point(poi.longitude, poi.latitude)
      )) as avg_distance_meters
    FROM gps_points gps
    CROSS JOIN points_of_interest poi
    WHERE ST_DWithin(
      ST_Point(gps.longitude, gps.latitude),
      ST_Point(poi.longitude, poi.latitude),
      500  -- 500 meter radius
    )
    AND gps.timestamp >= '2022-01-01'
    GROUP BY poi.category
    ORDER BY total_visits DESC
  ")
  
  dbDisconnect(con, shutdown = TRUE)
  return(proximity_analysis)
}
```

## Performance Comparisons and Benchmarks

### Benchmark Setup
```r
# Performance comparison framework
benchmark_operations <- function(data_size = "medium") {
  # Generate test data
  test_data <- tibble(
    id = 1:(if(data_size == "small") 1e6 else if(data_size == "medium") 10e6 else 100e6),
    category = sample(letters[1:10], n(), replace = TRUE),
    value = rnorm(n()),
    date = sample(seq.Date(as.Date("2020-01-01"), as.Date("2023-12-31"), by = "day"), n(), replace = TRUE)
  )
  
  # Write to different formats
  write_parquet(test_data, "test_data.parquet")
  
  # Benchmark different approaches
  results <- list()
  
  # Base R approach
  results$base_r <- system.time({
    data <- read_parquet("test_data.parquet")
    result <- data %>%
      filter(date >= as.Date("2022-01-01")) %>%
      group_by(category) %>%
      summarise(
        mean_value = mean(value),
        count = n(),
        .groups = "drop"
      )
  })
  
  # Arrow-only approach
  results$arrow_only <- system.time({
    result <- open_dataset("test_data.parquet") %>%
      filter(date >= as.Date("2022-01-01")) %>%
      group_by(category) %>%
      summarise(
        mean_value = mean(value),
        count = n(),
        .groups = "drop"
      ) %>%
      collect()
  })
  
  # Arrow + DuckDB approach
  results$arrow_duckdb <- system.time({
    con <- dbConnect(duckdb())
    result <- open_dataset("test_data.parquet") %>%
      to_duckdb(con, "data") %>%
      dbGetQuery("
        SELECT 
          category,
          AVG(value) as mean_value,
          COUNT(*) as count
        FROM data 
        WHERE date >= '2022-01-01'
        GROUP BY category
      ")
    dbDisconnect(con, shutdown = TRUE)
  })
  
  return(results)
}
```

### Performance Insights
- **Small Data (< 1M rows)**: Base R often fastest due to overhead
- **Medium Data (1M - 10M rows)**: Arrow shows significant improvements
- **Large Data (> 10M rows)**: Arrow + DuckDB combination excels
- **Complex Analytics**: DuckDB SQL engine provides substantial performance gains for window functions, CTEs, and complex joins

## Integration Best Practices

### Memory Management
```r
# Efficient memory usage patterns
efficient_workflow <- function(large_dataset_path) {
  # Use Arrow for filtering and projection (reduces data size)
  filtered_data <- open_dataset(large_dataset_path) %>%
    filter(relevant_condition) %>%
    select(needed_columns)
  
  # Stream to DuckDB for analytics without materializing in R
  con <- dbConnect(duckdb())
  on.exit(dbDisconnect(con, shutdown = TRUE))
  
  # Process without loading into R memory
  result <- filtered_data %>%
    to_duckdb(con, "data") %>%
    dbGetQuery("SELECT * FROM complex_analysis_view")
  
  return(result)
}
```

### Error Handling and Robustness
```r
# Robust processing with error handling
safe_arrow_duckdb_process <- function(dataset_path, analysis_sql) {
  tryCatch({
    # Validate dataset exists and is readable
    if (!file.exists(dataset_path)) {
      stop("Dataset path does not exist: ", dataset_path)
    }
    
    dataset <- open_dataset(dataset_path)
    
    # Validate dataset schema
    required_columns <- extract_columns_from_sql(analysis_sql)
    available_columns <- names(dataset$schema)
    missing_columns <- setdiff(required_columns, available_columns)
    
    if (length(missing_columns) > 0) {
      stop("Missing required columns: ", paste(missing_columns, collapse = ", "))
    }
    
    # Execute analysis
    con <- dbConnect(duckdb())
    on.exit({
      if (dbIsValid(con)) {
        dbDisconnect(con, shutdown = TRUE)
      }
    })
    
    result <- dataset %>%
      to_duckdb(con, "data") %>%
      dbGetQuery(analysis_sql)
    
    return(result)
    
  }, error = function(e) {
    warning("Analysis failed: ", e$message)
    return(NULL)
  })
}
```

## Advanced Integration Patterns

### Custom SQL Functions in DuckDB
```r
# Register custom R functions in DuckDB
register_r_functions <- function(con) {
  # Custom aggregation function
  dbExecute(con, "
    CREATE OR REPLACE MACRO weighted_avg(values, weights) AS (
      SUM(values * weights) / SUM(weights)
    )
  ")
  
  # Custom date function
  dbExecute(con, "
    CREATE OR REPLACE MACRO business_days_between(start_date, end_date) AS (
      -- Simplified business day calculation
      GREATEST(0, 
        (date_diff('day', start_date, end_date) * 5 - 
         (dayofweek(start_date) - 1) - (6 - dayofweek(end_date))) / 7 * 5 +
        LEAST(dayofweek(end_date), 5) - LEAST(dayofweek(start_date), 5)
      )
    )
  ")
}
```

### Multi-Stage Processing Pipelines
```r
# Complex multi-stage pipeline
multi_stage_pipeline <- function(raw_data_path, output_path) {
  con <- dbConnect(duckdb())
  on.exit(dbDisconnect(con, shutdown = TRUE))
  
  register_r_functions(con)
  
  # Stage 1: Data cleaning and standardization
  stage1 <- open_dataset(raw_data_path) %>%
    filter(!is.na(key_column)) %>%
    to_duckdb(con, "raw_data")
  
  dbExecute(con, "
    CREATE TABLE cleaned_data AS
    SELECT 
      standardize_id(id) as clean_id,
      normalize_text(description) as clean_description,
      COALESCE(value, 0) as clean_value,
      date_column
    FROM raw_data
    WHERE data_quality_score > 0.8
  ")
  
  # Stage 2: Feature engineering
  dbExecute(con, "
    CREATE TABLE features AS
    SELECT *,
      LAG(clean_value) OVER (PARTITION BY clean_id ORDER BY date_column) as prev_value,
      AVG(clean_value) OVER (
        PARTITION BY clean_id 
        ORDER BY date_column 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ) as rolling_avg_7d
    FROM cleaned_data
  ")
  
  # Stage 3: Final analytics
  result <- dbGetQuery(con, "
    SELECT 
      clean_id,
      COUNT(*) as record_count,
      AVG(clean_value) as avg_value,
      CORR(clean_value, rolling_avg_7d) as trend_correlation
    FROM features
    WHERE prev_value IS NOT NULL
    GROUP BY clean_id
    HAVING record_count >= 10
    ORDER BY trend_correlation DESC
  ")
  
  # Save results
  write_parquet(result, output_path)
  return(result)
}
```

## Presentation Key Takeaways

### When to Use Arrow + DuckDB
1. **Dataset Size**: > 1GB or when memory becomes a constraint
2. **Query Complexity**: Complex SQL analytics, window functions, CTEs
3. **Performance Requirements**: Need for fast analytical queries
4. **Integration Needs**: Want to stay within R ecosystem while gaining SQL power

### Architecture Benefits
- **Zero-Copy Performance**: Minimal data movement between systems
- **Familiar Interfaces**: SQL for complex analytics, R/dplyr for data manipulation
- **Scalability**: Handle datasets larger than available memory
- **Flexibility**: Can process data without loading entirely into memory

This presentation demonstrates a powerful pattern for scaling R analytics beyond traditional memory constraints while maintaining familiar R workflows and gaining access to high-performance SQL analytics capabilities.