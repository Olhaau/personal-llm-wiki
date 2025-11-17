# Arrow R Package - Reading and Writing Data Files

## Knowledge Article Metadata
- **Source**: Arrow R Package Reading/Writing Files Documentation v22.0.0
- **URL**: https://arrow.apache.org/docs/r/articles/read_write.html
- **Last Updated**: Current as of [[2024-11]]
- **File Modified**: [[2024-11-17]]
- **Scope**: Comprehensive file I/O operations across formats
- **Type**: Technical Guide - File Operations

## Executive Summary

Arrow R provides high-performance file I/O capabilities supporting multiple data formats including Parquet, Arrow/Feather, CSV, TSV, and JSON. The package offers both local and cloud storage integration with optimized reading strategies and metadata preservation for round-trip operations.

## Core I/O Functions Matrix

### Reading Functions
| Format | Function | Primary Use Case | Performance Notes |
|--------|----------|------------------|-------------------|
| **Parquet** | `read_parquet()` | Analytics data, long-term storage | Columnar format, excellent compression |
| **Arrow/Feather** | `read_feather()` | Fast interchange, temporary storage | Optimized for speed, cross-language |
| **CSV** | `read_csv_arrow()` | Text data import | High-performance CSV parsing |
| **TSV** | `read_tsv_arrow()` | Tab-delimited files | Specialized delimiter handling |
| **Delimited** | `read_delim_arrow()` | Custom delimiters | Flexible text file processing |
| **JSON** | `read_json_arrow()` | Structured/nested data | Line-delimited JSON only |

### Writing Functions
| Format | Function | Features | Best For |
|--------|----------|----------|----------|
| **Parquet** | `write_parquet()` | Compression, column pruning | Data warehouses, analytics |
| **Arrow/Feather** | `write_feather()` | Speed, metadata preservation | Temporary storage, interchange |
| **CSV** | `write_csv_arrow()` | Text output, compatibility | Reports, legacy systems |

## Format-Specific Implementation Guides

### Parquet Format: Analytics Optimized Storage

#### Core Characteristics
- **Columnar storage**: Optimized for analytical queries
- **Built-in compression**: Snappy compression by default
- **Column pruning**: Read only required columns
- **Metadata preservation**: Schema and statistics included

#### Basic Operations
```r
library(arrow, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)

# Write with compression
file_path <- tempfile()
write_parquet(starwars, file_path)

# Read entire file
data_frame <- read_parquet(file_path)

# Read as Arrow Table for continued processing
arrow_table <- read_parquet(file_path, as_data_frame = FALSE)
```

#### Advanced Features
```r
# Column selection (efficient - only reads selected columns)
subset_data <- read_parquet(
  file_path, 
  col_select = c("name", "height", "mass")
)

# Fine-grained control over reader properties
read_parquet(
  file_path,
  props = ParquetArrowReaderProperties$create()
)
```

#### Performance Optimization
- **Column selection**: Use `col_select` to read only needed columns
- **Compression options**: Choose between snappy (default), gzip, brotli
- **Row group size**: Optimize for query patterns
- **Predicate pushdown**: Filters applied at file level

### Arrow/Feather Format: Speed-Optimized Interchange

#### Design Philosophy
- **Speed first**: Optimized for fast read/write operations
- **Cross-language**: Consistent format across Arrow implementations
- **Metadata preservation**: Complete schema and attribute preservation
- **Version 2**: Modern Arrow IPC file format

#### Implementation Patterns
```r
# Basic write/read cycle
file_path <- tempfile()
write_feather(starwars, file_path)

# Read with column selection and format control
arrow_data <- read_feather(
  file = file_path,
  col_select = c("name", "height", "mass"),
  as_data_frame = FALSE
)
```

#### Use Case Scenarios
- **Temporary storage**: Fast intermediate results
- **Cross-language workflows**: R ↔ Python data exchange
- **Metadata preservation**: Attributes like `sf::sf` objects
- **Development workflows**: Rapid prototyping and testing

### CSV Format: High-Performance Text Processing

#### Arrow vs Base R Performance
- **Speed**: Significantly faster than base R CSV functions
- **Memory efficiency**: Streaming processing capabilities
- **Type inference**: Intelligent column type detection
- **Compatibility**: Mirrors `readr` conventions

#### Advanced CSV Processing
```r
# Basic CSV operations
file_path <- tempfile()
write_csv_arrow(mtcars, file_path)

# Selective column reading with dplyr-style selection
subset_data <- read_csv_arrow(
  file_path, 
  col_select = starts_with("d")
)

# Fine-grained parsing control
data <- read_csv_arrow(
  file_path,
  schema = schema(
    mpg = float64(),
    cyl = int32(),
    hp = int32()
  ),
  parse_options = CsvParseOptions$create(
    delimiter = ",",
    quote_char = "\"",
    escape_char = "\\"
  )
)
```

#### CSV Processing Options
- **Schema specification**: Explicit column types via `schema()`
- **Parse options**: Delimiter, quote, escape character control
- **Convert options**: Type conversion behavior
- **Read options**: Memory and processing constraints

### JSON Format: Structured Data Import

#### Current Capabilities
- **Line-delimited JSON**: NDJSON format support
- **Type inference**: Automatic schema detection
- **Nested structures**: Handles complex JSON objects
- **Read-only**: Writing not currently supported

#### JSON Processing Example
```r
# Create line-delimited JSON file
file_path <- tempfile()
writeLines('
  { "hello": 3.5, "world": false, "yo": "thing" }
  { "hello": 3.25, "world": null }
  { "hello": 0.0, "world": true, "yo": null }
', file_path, useBytes = TRUE)

# Read with automatic type inference
json_data <- read_json_arrow(file_path)
```

## Return Format Control Strategy

### Data Frame vs Arrow Table Decision Matrix
| Use Case | Return Format | Function Call |
|----------|---------------|---------------|
| **Immediate analysis** | data.frame | `as_data_frame = TRUE` (default) |
| **Further Arrow processing** | Arrow Table | `as_data_frame = FALSE` |
| **dplyr pipeline** | Arrow Table | `as_data_frame = FALSE` |
| **Visualization/reporting** | data.frame | `as_data_frame = TRUE` |
| **Memory efficiency** | Arrow Table | `as_data_frame = FALSE` |

### Implementation Pattern
```r
# Return data.frame for immediate use
df <- read_parquet(file_path)                    # Default behavior
df <- read_parquet(file_path, as_data_frame = TRUE)  # Explicit

# Return Arrow Table for continued processing
tbl <- read_parquet(file_path, as_data_frame = FALSE)

# Chain with dplyr operations
result <- read_parquet(file_path, as_data_frame = FALSE) |>
  filter(category == "important") |>
  select(id, value, timestamp) |>
  collect()  # Convert to data.frame at end
```

## Metadata and Schema Preservation

### Round-Trip Compatibility
Arrow preserves R object attributes during write/read cycles, enabling:
- **Spatial data**: `sf::sf` objects maintain geometry
- **Labeled data**: `haven::labelled` columns preserve labels  
- **Custom attributes**: User-defined metadata survives round-trip
- **Factor levels**: Factor structure and ordering maintained

### Implementation Example
```r
# Create data with attributes
data_with_attrs <- starwars
attr(data_with_attrs, "source") <- "Star Wars API"
attr(data_with_attrs$name, "encoding") <- "UTF-8"

# Write and read preserves attributes
write_parquet(data_with_attrs, "test.parquet")
restored_data <- read_parquet("test.parquet")

# Verify attribute preservation
identical(
  attr(data_with_attrs, "source"),
  attr(restored_data, "source")
)
```

## Cloud Storage Integration

### Supported Providers
- **Amazon S3**: Native S3 protocol support
- **Google Cloud Storage**: Direct GCS integration  
- **Azure Blob Storage**: Via filesystem abstraction
- **Local filesystem**: Standard file operations

### Cloud I/O Patterns
```r
# Direct cloud reading (no local download required)
s3_data <- read_parquet("s3://bucket/path/data.parquet")
gcs_data <- read_parquet("gs://bucket/path/data.parquet")

# Cloud writing with authentication
write_parquet(data, "s3://bucket/output/result.parquet")

# Mixed cloud/local workflows
local_data <- read_csv_arrow("local_file.csv")
write_parquet(local_data, "s3://bucket/processed/data.parquet")
```

## Performance Optimization Strategies

### File Format Selection
| Scenario | Recommended Format | Rationale |
|----------|-------------------|-----------|
| **Long-term storage** | Parquet | Compression, column pruning |
| **Temporary files** | Arrow/Feather | Speed, metadata preservation |
| **Data exchange** | Arrow/Feather | Cross-language compatibility |
| **Legacy systems** | CSV | Universal compatibility |
| **Nested data** | Parquet or JSON | Complex structure support |

### Reading Optimization
```r
# Optimize large file reading
data <- read_parquet(
  "large_file.parquet",
  col_select = c("id", "value", "timestamp"),  # Read only needed columns
  as_data_frame = FALSE                        # Avoid unnecessary conversion
) |>
  filter(timestamp > as.Date("2023-01-01")) |>  # Push down predicates
  collect()                                     # Materialize when needed
```

### Writing Optimization
```r
# Optimize for downstream reading
write_parquet(
  data,
  "optimized.parquet",
  compression = "snappy",        # Balance speed/compression
  use_dictionary = TRUE,         # Efficient string encoding
  write_statistics = TRUE        # Enable predicate pushdown
)
```

## Integration with Larger-Than-Memory Workflows

### Single File Processing
```r
# Process large CSV without loading entirely into memory
large_csv_path <- "very_large_file.csv"

# Convert to partitioned Parquet for efficient processing
open_dataset(large_csv_path, format = "csv") |>
  group_by(year, month) |>
  write_dataset("partitioned_data/", format = "parquet")

# Now process efficiently
open_dataset("partitioned_data/") |>
  filter(year == 2023) |>
  summarize(total = sum(value)) |>
  collect()
```

### Streaming Workflows
- **Chunk processing**: Handle files larger than memory
- **Lazy evaluation**: Build complex pipelines without materializing
- **Memory management**: Process data in batches
- **Incremental results**: Process and write results iteratively

## Error Handling and Diagnostics

### Common Issues and Solutions
```r
# Handle missing files gracefully
tryCatch({
  data <- read_parquet("might_not_exist.parquet")
}, error = function(e) {
  if (grepl("not found", e$message)) {
    warning("File not found, using default data")
    data <- data.frame()
  } else {
    stop(e)
  }
})

# Validate file format before processing
file_info <- file.info("unknown_format.dat")
if (file_info$size > 0) {
  # Attempt to read with error handling
}
```

### Performance Monitoring
- **File size considerations**: Monitor memory usage vs file size
- **Read time profiling**: Identify bottlenecks in I/O operations
- **Compression ratios**: Evaluate storage efficiency
- **Cloud transfer costs**: Monitor data movement in cloud workflows

## Advanced Use Cases

### Incremental Data Processing
```r
# Process new data files as they arrive
process_new_files <- function(data_dir) {
  new_files <- list.files(data_dir, pattern = "*.parquet", full.names = TRUE)
  
  for (file in new_files) {
    # Process each file
    data <- read_parquet(file, as_data_frame = FALSE)
    
    # Transform and append
    processed <- data |>
      filter(quality_score > 0.8) |>
      mutate(processed_date = Sys.Date())
    
    # Write to processed directory
    write_parquet(processed, file.path("processed", basename(file)))
  }
}
```

### Format Migration Workflows
```r
# Convert legacy CSV files to optimized Parquet
migrate_csv_to_parquet <- function(csv_dir, parquet_dir) {
  csv_files <- list.files(csv_dir, pattern = "*.csv", full.names = TRUE)
  
  for (csv_file in csv_files) {
    base_name <- tools::file_path_sans_ext(basename(csv_file))
    parquet_file <- file.path(parquet_dir, paste0(base_name, ".parquet"))
    
    read_csv_arrow(csv_file, as_data_frame = FALSE) |>
      write_parquet(parquet_file)
  }
}
```

## Integration Points

### Related Documentation
- **[Dataset Operations](./dataset.html)**: Multi-file and larger-than-memory processing
- **[Cloud Storage](./fs.html)**: Remote filesystem integration
- **[Data Types](./data_types.html)**: Understanding type mappings and conversions
- **[Metadata](./metadata.html)**: Schema management and attribute preservation

### Ecosystem Integration
- **dplyr**: Seamless integration with data manipulation pipelines
- **DBI/dbplyr**: Database connectivity and SQL translation
- **reticulate**: Cross-language data sharing with Python
- **Cloud providers**: Direct integration with AWS, GCP, Azure storage

This comprehensive guide provides the foundation for effective file I/O operations with Arrow R, emphasizing performance, format selection, and integration with broader data processing workflows.