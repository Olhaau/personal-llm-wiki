# Arrow R Package - Data Analysis with dplyr Syntax

## Knowledge Article Metadata
- **Source**: Arrow R Package Data Wrangling Documentation v22.0.0
- **URL**: https://arrow.apache.org/docs/r/articles/data_wrangling.html
- **Last Updated**: Current as of [2024-11]
- **File Modified**: [2024-11-17]
- **Scope**: Comprehensive dplyr integration and data manipulation
- **Type**: Technical Guide - Data Analysis

## Executive Summary

Arrow R provides a comprehensive dplyr backend that enables familiar tidyverse syntax for data manipulation on Arrow Tables and Datasets. The integration supports lazy evaluation, extensive function coverage, and seamless transitions between Arrow and R data structures, making it possible to analyze larger-than-memory datasets with familiar R syntax.

## Core dplyr Integration Architecture

### Lazy Evaluation Framework
Arrow implements lazy evaluation where operations are recorded but not executed until explicitly requested via `collect()` or `compute()`:

```r
library(dplyr, warn.conflicts = FALSE)
library(arrow, warn.conflicts = FALSE)

sw <- arrow_table(starwars, as_data_frame = FALSE)

# Operations are recorded, not executed
query <- sw |>
  filter(homeworld == "Tatooine") |>
  rename(height_cm = height, mass_kg = mass) |>
  mutate(height_in = height_cm / 2.54, mass_lbs = mass_kg * 2.2046) |>
  arrange(desc(birth_year)) |>
  select(name, height_in, mass_lbs)

# Shows query plan, not results
query
#> Table (query)
#> name: string
#> height_in: double
#> mass_lbs: double
#> * Filter: (homeworld == "Tatooine")
#> * Sorted by birth_year [desc]
```

### Materialization Control
Two primary functions control when and how computations are executed:

#### `compute()`: Return Arrow Table
```r
# Returns Arrow Table for continued Arrow processing
arrow_result <- compute(query)
class(arrow_result)  # "Table" "ArrowTabular" "ArrowObject" "R6"
```

#### `collect()`: Return R Data Frame
```r
# Returns R data.frame for immediate use or R-specific operations
r_result <- collect(query)
class(r_result)  # "tbl_df" "tbl" "data.frame"
```

## Supported dplyr Verbs and Operations

### Single-Table Verbs
| Verb | Support Level | Arrow-Specific Notes |
|------|---------------|----------------------|
| `filter()` | ✅ Full | Predicate pushdown optimization |
| `select()` | ✅ Full | Column pruning, helper functions supported |
| `mutate()` | ✅ Full | Extensive function library |
| `rename()` | ✅ Full | Multiple column renaming |
| `arrange()` | ✅ Full | Multiple column sorting, desc() support |
| `group_by()` | ✅ Full | Efficient grouping operations |
| `summarize()` | ✅ Full | Wide range of aggregation functions |
| `count()` | ✅ Full | Optimized counting operations |
| `distinct()` | ✅ Full | Deduplication with optional column selection |
| `slice()` | ✅ Partial | Head/tail operations, some variants |

### Advanced Aggregation Examples
```r
# Complex grouping and summarization
sw |>
  group_by(species) |>
  summarize(
    mean_height = mean(height, na.rm = TRUE),
    median_mass = median(mass, na.rm = TRUE),
    count = n(),
    height_range = max(height, na.rm = TRUE) - min(height, na.rm = TRUE)
  ) |>
  filter(count > 1) |>
  arrange(desc(mean_height)) |>
  collect()
```

### Two-Table Verbs (Joins)
```r
# Equality joins are fully supported
jedi <- data.frame(
  name = c("C-3PO", "Luke Skywalker", "Obi-Wan Kenobi"),
  jedi = c(FALSE, TRUE, TRUE)
)

sw |>
  select(name, height, mass) |>
  right_join(jedi, by = "name") |>
  collect()
```

#### Supported Join Types
- `inner_join()`: Intersection of matching rows
- `left_join()`: All left rows, matching right rows
- `right_join()`: All right rows, matching left rows
- `full_join()`: All rows from both tables
- `semi_join()`: Left rows with matches in right
- `anti_join()`: Left rows without matches in right

## Expression Support and Function Coverage

### Mathematical Functions
```r
sw |>
  mutate(
    height_m = height / 100,
    bmi = mass / (height_m^2),
    height_log = log(height),
    height_sqrt = sqrt(height),
    height_rounded = round(height, -1)
  ) |>
  collect()
```

### String Functions
```r
sw |>
  mutate(
    name_upper = toupper(name),
    name_lower = tolower(name),
    name_length = nchar(name),
    first_char = substr(name, 1, 1),
    contains_sky = grepl("Sky", name)
  ) |>
  filter(contains_sky) |>
  collect()
```

### Date/Time Functions
```r
# Working with timestamps
data_with_dates |>
  mutate(
    year = year(timestamp),
    month = month(timestamp),
    day_of_week = wday(timestamp),
    date_only = as.Date(timestamp),
    formatted_date = strftime(timestamp, "%Y-%m-%d")
  ) |>
  collect()
```

### Conditional Logic
```r
sw |>
  mutate(
    size_category = case_when(
      height < 100 ~ "Very Short",
      height < 150 ~ "Short", 
      height < 180 ~ "Medium",
      height >= 180 ~ "Tall",
      TRUE ~ "Unknown"
    ),
    is_heavy = ifelse(mass > 100, "Heavy", "Light")
  ) |>
  collect()
```

## Custom Function Registration

### Registering Scalar Functions
Arrow allows registration of custom R functions for use in dplyr pipelines:

```r
# Define custom function (context as first parameter required)
to_snake_name <- function(context, string) {
  replace <- c(`'` = "", `"` = "", `-` = "", `\\.` = "_", ` ` = "_")
  string |>
    stringr::str_replace_all(replace) |>
    stringr::str_to_lower() |>
    stringi::stri_trans_general(id = "Latin-ASCII")
}

# Register function with Arrow
register_scalar_function(
  name = "to_snake_name",
  fun = to_snake_name,
  in_type = utf8(),
  out_type = utf8(),
  auto_convert = TRUE
)

# Use in dplyr pipeline
sw |>
  mutate(snake_name = to_snake_name(name)) |>
  select(name, snake_name) |>
  collect()
```

### Registration Parameters
- **name**: Function name for use in pipelines
- **fun**: The R function to register
- **in_type**: Expected input data type(s)
- **out_type**: Expected output data type
- **auto_convert**: Whether to auto-convert R inputs to Arrow types

## Error Handling and Fallback Strategies

### Automatic Collection for Tables
For in-memory Tables, Arrow automatically falls back to R when encountering unsupported functions:

```r
# Unsupported statistical modeling functions trigger automatic collection
sw |>
  filter(!is.na(height), !is.na(mass)) |>
  transmute(name, height, mass, res = residuals(lm(mass ~ height)))
#> Warning: Expression not supported in Arrow
#> > Pulling data into R
```

### Manual Collection for Datasets
For Datasets (potentially larger-than-memory), explicit collection is required:

```r
# Write to disk to create Dataset
dataset_path <- tempfile()
write_dataset(starwars, dataset_path)
sw_dataset <- open_dataset(dataset_path)

# Explicit collect() required for unsupported operations
sw_dataset |>
  filter(!is.na(height), !is.na(mass)) |>
  collect() |>  # Explicit collection before unsupported operation
  transmute(name, height, mass, res = residuals(lm(mass ~ height)))
```

## Performance Optimization Strategies

### Query Planning Optimization
```r
# Build complex queries before execution
optimized_query <- dataset |>
  # 1. Filter early (predicate pushdown)
  filter(date >= "2023-01-01", quality_score > 0.8) |>
  # 2. Select only needed columns (column pruning)  
  select(id, value, date, category) |>
  # 3. Group efficiently
  group_by(category) |>
  # 4. Aggregate
  summarize(
    avg_value = mean(value),
    total_records = n(),
    date_range = max(date) - min(date)
  ) |>
  # 5. Final filtering on aggregated results
  filter(total_records > 100)

# Execute once with collect()
results <- collect(optimized_query)
```

### Memory Management
```r
# For large intermediate results, use compute() instead of collect()
intermediate_table <- large_dataset |>
  complex_transformation() |>
  compute()  # Keep in Arrow format

# Continue processing
final_result <- intermediate_table |>
  additional_processing() |>
  collect()  # Only convert to R at the end
```

## Integration with External Systems

### DuckDB Integration
For operations not supported in Arrow, seamlessly transition to DuckDB:

```r
sw |>
  select(name, height, mass, hair_color) |>
  filter(!is.na(hair_color)) |>
  to_duckdb() |>  # Switch to DuckDB for unsupported operations
  group_by(hair_color) |>
  filter(height < mean(height, na.rm = TRUE)) |>  # Complex window operation
  to_arrow() |>   # Return to Arrow
  arrange(height) |>
  collect()
```

### Database Connectivity
```r
# Arrow Tables can be written to databases
arrow_table |>
  collect() |>
  DBI::dbWriteTable(conn, "processed_data", .)

# Or converted to database-specific formats
arrow_table |>
  to_duckdb() |>
  dbplyr::copy_to(dest = db_connection, df = ., name = "temp_table")
```

## Advanced Analytical Patterns

### Window Functions and Analytics
```r
# Time series analysis patterns
time_series_data |>
  arrange(date) |>
  mutate(
    # Lag/lead operations
    prev_value = lag(value, 1),
    next_value = lead(value, 1),
    # Rolling calculations (via custom functions or DuckDB)
    change_rate = (value - prev_value) / prev_value
  ) |>
  filter(!is.na(prev_value)) |>
  collect()
```

### Conditional Aggregation
```r
# Complex business logic with multiple conditions
sales_data |>
  group_by(region, quarter) |>
  summarize(
    total_sales = sum(amount),
    high_value_sales = sum(ifelse(amount > 1000, amount, 0)),
    transaction_count = n(),
    avg_transaction = mean(amount),
    top_10_pct_threshold = quantile(amount, 0.9)
  ) |>
  mutate(
    performance_category = case_when(
      total_sales > 1000000 ~ "Excellent",
      total_sales > 500000 ~ "Good",
      total_sales > 100000 ~ "Fair",
      TRUE ~ "Poor"
    )
  ) |>
  collect()
```

### Data Quality and Validation
```r
# Comprehensive data quality checks
data_quality_report <- raw_data |>
  summarize(
    total_rows = n(),
    missing_ids = sum(is.na(id)),
    invalid_dates = sum(is.na(as.Date(date_string))),
    negative_amounts = sum(amount < 0, na.rm = TRUE),
    duplicate_count = n() - n_distinct(id),
    # Value range checks
    amount_min = min(amount, na.rm = TRUE),
    amount_max = max(amount, na.rm = TRUE),
    amount_mean = mean(amount, na.rm = TRUE)
  ) |>
  collect()
```

## Debugging and Development Workflow

### Query Inspection
```r
# Examine query plans before execution
query_plan <- data |>
  filter(category == "important") |>
  group_by(region) |>
  summarize(total = sum(value))

# Inspect without executing
print(query_plan)

# Check what columns/operations are planned
names(query_plan)
```

### Performance Profiling
```r
# Time complex operations
system.time({
  result <- large_dataset |>
    complex_analysis_pipeline() |>
    collect()
})

# Profile memory usage
pryr::mem_used()
result <- dataset |> analysis_pipeline() |> collect()
pryr::mem_used()
```

### Error Diagnosis
```r
# Incremental pipeline building for debugging
debug_step1 <- dataset |> filter(date > "2023-01-01")
debug_step2 <- debug_step1 |> mutate(processed_value = value * 2)
debug_step3 <- debug_step2 |> group_by(category)

# Test each step
try(collect(debug_step1))
try(collect(debug_step2))
try(collect(debug_step3))
```

## Best Practices and Patterns

### Efficient Pipeline Design
1. **Filter Early**: Apply filters as early as possible in the pipeline
2. **Select Sparingly**: Choose only necessary columns to reduce data movement
3. **Group Strategically**: Consider group cardinality and downstream operations
4. **Aggregate Wisely**: Use appropriate aggregation functions for your data types
5. **Materialize Late**: Keep data in Arrow format as long as possible

### Memory Management
```r
# Good: Minimal memory usage
result <- large_dataset |>
  filter(relevant_subset) |>      # Reduce rows early
  select(needed_columns) |>       # Reduce columns early  
  group_by(analysis_dimension) |>
  summarize(metrics) |>          # Aggregate to smaller result
  collect()                      # Materialize small result

# Avoid: Premature materialization  
# large_df <- collect(large_dataset)  # Loads everything into R memory
# result <- large_df |> dplyr_operations()
```

### Error Handling Patterns
```r
# Robust pipeline with error handling
safe_analysis <- function(dataset_path) {
  tryCatch({
    open_dataset(dataset_path) |>
      validate_schema() |>
      apply_business_logic() |>
      compute()
  }, error = function(e) {
    warning("Analysis failed: ", e$message)
    return(arrow_table())  # Return empty table
  })
}
```

This comprehensive guide provides the foundation for effective data analysis using Arrow's dplyr integration, emphasizing performance, debugging strategies, and best practices for scaling analytical workflows from prototype to production.