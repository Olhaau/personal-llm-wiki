# workflow.R - Benchmark Workflow Guide

## Overview

The `workflow.R` script orchestrates a comprehensive benchmarking workflow for testing different data reading methods on BTP synthetic data. It automatically creates both JSON and CSV output files for each benchmark run.

## Requirements

```r
install.packages(c("here", "arrow", "data.table", "vroom", "duckdb", "bench", "jsonlite"))
```

## What It Does

1. **Collects System Information**: Records hardware/software details for reproducibility
2. **Runs Benchmarks**: Tests multiple read methods on different dataset sizes
3. **Creates Dual Output**: Generates both JSON (detailed) and CSV (tabular) results
4. **Aggregates Results**: Combines all benchmark results for analysis

## Input Files

The workflow expects these data files:
- `data/btp_obs10/data.csv` - Small test dataset (10 units)
- `data/btp_obs100/data.csv` - Medium dataset (100 units)

Generate with:
```r
source("source/generate_btp_synth.R")
df <- generate_btp_synth(obs = 10, select = "all", balanced = TRUE, seed = 42)
write.csv(df, "data/btp_obs10/data.csv", row.names = FALSE)
```

## Benchmarked Methods

The workflow tests 6 different methods for reading and processing BTP data:

### 1. `rbase_fallzahl`
- **Method**: Base R `read.csv()`
- **Processing**: Base R loops with `sapply()`
- **Use case**: Baseline performance reference

### 2. `data_table_fallzahl`
- **Method**: `data.table::fread()`
- **Processing**: data.table operations (melt, aggregate, dcast)
- **Use case**: Fast data manipulation

### 3. `arrow_fallzahl`
- **Method**: `arrow::read_csv_arrow()`
- **Processing**: Arrow with base R operations
- **Use case**: Large CSV files

### 4. `vroom_fallzahl`
- **Method**: `vroom::vroom()`
- **Processing**: Lazy reading with base R operations
- **Use case**: Fast CSV reading

### 5. `arrow_parquet_fallzahl`
- **Method**: `arrow::read_parquet()`
- **Processing**: Columnar format reading
- **Use case**: Optimized binary format

### 6. `duckdb_fallzahl`
- **Method**: DuckDB SQL engine
- **Processing**: SQL-based operations
- **Use case**: SQL-style analytics

## Output Files

Each benchmark creates **two files** in the `results/` directory:

### JSON Files
**Format**: `bm_<input>_<runtime_ms>_<method>_<timestamp>.json`

**Content**: Full detailed results including:
- Complete result object (matrices, data frames)
- All performance metrics
- Complete timestamp information

**Example**: `bm_btp_obs10_data_0013_rbase_fallzahl_20251125_072208.json`

### CSV Files
**Format**: `bm_<input>_<runtime_ms>_<method>_<timestamp>.csv`

**Content**: One-line tabular format with header:
- function_name
- input_name
- input_path
- result (simplified: "matrix, array" or "data.frame[rows x cols]")
- filesize_bytes
- filesize_mb
- max_memory_mb
- runtime_seconds
- timestamp

**Example**: `bm_btp_obs10_data_0013_rbase_fallzahl_20251125_072208.csv`

## Running the Workflow

### Complete Workflow
```bash
Rscript workflow.R
```

This will:
1. Save system information to `results/system_info.json`
2. Run all 6 methods on all input files (2 files × 6 methods = 12 benchmarks)
3. Create 24 result files (12 JSON + 12 CSV)
4. Aggregate results
5. Display summary statistics

### Single Benchmark
```r
source("source/benchmark.R")

benchmark(
  input_path = "data/btp_obs10/data.csv",
  expr = read.csv,
  expr_name = "read_csv_test"
)
```

## Output Analysis

### Using CSV Files

The CSV format makes it easy to aggregate and analyze results:

```r
# Read all CSV results
csv_files <- list.files("results", pattern = "\\.csv$", full.names = TRUE)
results <- do.call(rbind, lapply(csv_files, read.csv))

# Compare methods by runtime
library(ggplot2)
ggplot(results, aes(x = function_name, y = runtime_seconds)) +
  geom_boxplot() +
  theme(axis.text.x = element.text(angle = 45, hjust = 1))

# Compare by memory usage
results[order(results$max_memory_mb), c("function_name", "input_name", "max_memory_mb")]
```

### Using JSON Files

For detailed analysis of result structures:

```r
library(jsonlite)
json_results <- fromJSON("results/bm_btp_obs10_data_0013_rbase_fallzahl_20251125_072208.json")

# Access the actual computation result
print(json_results$result)

# View all metrics
str(json_results)
```

## Workflow Structure

```
workflow.R
├── Load libraries (here, arrow)
├── Source functions
│   ├── benchmark.R (creates .json + .csv)
│   └── system_info.R
├── Collect system info
├── Define inputs (2 files)
├── Define expressions (6 methods)
├── Run benchmarks
│   └── For each input × expression
│       ├── Print progress
│       └── Call benchmark() → creates .json + .csv
├── Aggregate results
└── Display summary
```

## Customization

### Add New Method

```r
exprs <- list(
  # ... existing methods ...
  
  my_new_method = function(input) {
    # Your custom reading/processing code
    df <- my_read_function(input)
    # Return result
    return(result)
  }
)
```

### Add New Dataset Size

```r
inputs <- c(
  here("data", "btp_obs10", "data.csv"),
  here("data", "btp_obs100", "data.csv"),
  here("data", "btp_obs1000", "data.csv")  # Add this
)
```

### Change Computed Metric

Modify the function body in each expression to compute different statistics. The workflow structure remains the same.

## Performance Tips

1. **Start Small**: Test with `btp_obs10` before running on larger datasets
2. **Monitor Memory**: Watch `max_memory_mb` in CSV output
3. **Compare Methods**: Use CSV files for quick method comparison
4. **Check Results**: Verify computation correctness in JSON `result` field

## Troubleshooting

### "Input file does not exist"
Generate the required data files:
```r
source("source/generate_btp_synth.R")
# Generate required datasets
```

### "Package not found"
Install missing packages:
```r
install.packages(c("arrow", "data.table", "vroom", "duckdb"))
```

### Memory Issues
- Start with smaller datasets (obs = 10)
- Reduce number of methods tested
- Close other applications

## Aggregating Results

The workflow automatically calls `aggregate_benchmarks()` which:
- Combines all JSON results
- Creates summary statistics
- Exports aggregated data for analysis

See `source/aggregate_benchmarks.R` for details.

## Output Summary

After running the complete workflow, you'll see:

```
=== Benchmark Workflow Complete ===
Total JSON files: 12
Total CSV files: 12

Results saved in: results/
  - JSON files: Full detailed results
  - CSV files: One-line tabular format for easy aggregation
```

## Example Analysis

Quick comparison of methods:

```r
# Load CSV results
results <- read.csv(list.files("results", pattern = "csv$", full.names = TRUE)[1])

# Fastest method
results[which.min(results$runtime_seconds), c("function_name", "runtime_seconds")]

# Most memory efficient
results[which.min(results$max_memory_mb), c("function_name", "max_memory_mb")]

# Method rankings
results[order(results$runtime_seconds), c("function_name", "runtime_seconds", "max_memory_mb")]
```

## Version History

- **v2.0** (Nov 2025): Added automatic CSV export alongside JSON
- **v1.0**: Initial workflow with JSON-only output
