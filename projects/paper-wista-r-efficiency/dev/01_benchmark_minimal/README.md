# Benchmark Minimal - Synthetic BTP Data Generator

## Overview

This subproject generates approximately 1 million rows of synthetic Business-Tax-Panel (BTP) data in multiple file formats for performance benchmarking and efficiency analysis.

## Purpose

The benchmark script creates synthetic BTP data with all statistics (g, k, u, p, v, e) and exports it in different formats to enable:
- File format comparison (CSV vs Parquet)
- Compression efficiency analysis
- I/O performance benchmarking
- Data partitioning strategies evaluation

## Generated Formats

The script produces the following output files:

1. **CSV (uncompressed)**: `btp_synth.csv`
   - Standard comma-separated values format
   - Baseline for size and performance comparison

2. **CSV.GZ (gzip compressed)**: `btp_synth.csv.gz`
   - Gzip-compressed CSV
   - Reduces storage size significantly

3. **Parquet (single file)**: `btp_synth.parquet`
   - Columnar storage format with Snappy compression
   - Optimized for analytical queries

4. **Parquet (year-partitioned)**: `btp_synth_partitioned/`
   - Multiple Parquet files partitioned by year (2013-2019)
   - Each year in a separate subfolder
   - Enables efficient year-based filtering

5. **Parquet (hash-partitioned)**: `btp_synth_hash_partitioned/`
   - 10 partitions based on hash of firm ID
   - Evenly distributed data across files
   - Supports parallel processing

## Usage

### Quick Start (Test Data)

Generate small test dataset and run benchmarks:

```bash
cd dev/01_benchmark_minimal

# Generate 50k rows split into 3 files
Rscript 00_test_setup.R obs=50000 n_files=3

# Run benchmarks with 2 cores
Rscript 02_benchmark_methods.R max_cores=2
```

### Generate Full Dataset

For production benchmarks with 1M rows using synth_btp:

```bash
cd dev/01_benchmark_minimal
Rscript 01_generate_data.R
```

### Test Data Configuration

The `00_test_setup.R` script accepts command-line parameters:

```bash
# Basic usage
Rscript 00_test_setup.R

# Custom parameters
Rscript 00_test_setup.R obs=100000 n_files=5

# Only Parquet format
Rscript 00_test_setup.R obs=1000000 n_files=10 formats=parquet

# Custom output directory
Rscript 00_test_setup.R obs=50000 output_dir=testdata
```

Parameters:
- `obs=N` - Number of observations (default: 10000)
- `n_files=N` - Number of split files (default: 1)
- `output_dir=PATH` - Output directory (default: data)
- `formats=csv,parquet` - File formats (default: csv,parquet)
- `seed=N` - Random seed (default: 42)

### Benchmark Configuration

The `02_benchmark_methods.R` script accepts these parameters:

```bash
# Run all methods with default settings
Rscript 02_benchmark_methods.R

# Specify data path
Rscript 02_benchmark_methods.R data_path=data

# Limit cores and select methods
Rscript 02_benchmark_methods.R max_cores=4 methods=data.table,arrow

# Full configuration
Rscript 02_benchmark_methods.R data_path=data max_cores=8 max_memory_gb=16 methods=arrow,data.table,tidyverse
```

Parameters:
- `data_path=PATH` - Path to data file or directory (default: data)
- `methods=m1,m2` - Comma-separated methods to benchmark (default: all)
- `max_cores=N` - Maximum CPU cores to use (default: unlimited)
- `max_memory_gb=N` - Memory limit in GB (monitoring only, default: unlimited)

Available methods: `arrow`, `polars`, `data.table`, `tidyverse`, `vroom`

## Requirements

### R Packages
- `data.table`: Fast data manipulation and CSV I/O
- `arrow`: Parquet file format support
- `jsonlite`: JSON parsing (dependency of synth_btp)

Install packages:
```r
install.packages(c("data.table", "arrow", "jsonlite"))
```

### Dependencies
- **synth_btp**: Located in `../experiment/00_gen_btp/synth_btp.R`
- **btp_variables.json**: Variable definitions in `../experiment/00_gen_btp/`
- **btp_obs_distribution.csv**: Year-specific statistics probabilities (optional)

## Output

The script generates detailed output including:

- Data generation statistics (rows, columns, time)
- File sizes for each format
- Compression ratios
- Export times
- Summary comparison table

Example output:

```
========================================
Summary
========================================

                        Format  Size_MB Time_Sec Compression_Pct
                           CSV   450.3     12.3             0.0
                        CSV.GZ    78.5     25.6            82.6
                       Parquet    95.2      8.7            78.9
  Parquet (year-partitioned)    96.1      9.2            78.7
Parquet (hash-10-partitioned)   95.8      9.5            78.7
```

## Data Characteristics

The generated synthetic BTP data includes:

- **Panel Structure**:
  - Unbalanced panel (default: 28.4% firms in all years)
  - Years: 2013-2019
  - ~1 million observations from ~150,000 firms

- **Variables**: ~3,000+ variables including:
  - Core panel identifiers (id, jahr, ags)
  - Linkage variables (verk, verk_qual)
  - Enterprise register variables (urs_*)
  - Tax statistics variables (g_*, k_*, u_*, p_*, v_*, e_*)

- **Statistics Coverage**:
  - g: Gewerbesteuer (Trade tax) - 328 variables
  - k: Körperschaftsteuer (Corporate tax) - 1,088 variables
  - u: Umsatzsteuer-Voranmeldung (VAT advance) - 75 variables
  - p: Personengesellschaften (Partnerships) - 1,078 variables
  - v: Umsatzsteuer-Veranlagung (VAT annual) - 120 variables
  - e: Einnahmenüberschussrechnung (EUR) - 349 variables

## Benchmarking Methods

### Run Benchmarks

After generating the data, run method comparison benchmarks:

```bash
cd dev/01_benchmark_minimal
Rscript 02_benchmark_methods.R
```

### Benchmark Task

The benchmark compares different R packages for a common data processing task:
- **Task**: Create a contingency table of years × statistics with observation counts
- **Operation**: Filter, group, aggregate, and pivot data
- **Methods compared**:
  - **Arrow**: Column-oriented query engine with lazy evaluation
  - **Polars**: Blazingly fast DataFrame library (Rust-based)
  - **data.table**: High-performance data manipulation in R
  - **tidyverse**: dplyr + tidyr for readable data transformations
  - **vroom**: Fast CSV reading with lazy evaluation

### Benchmark Output

Each benchmark run creates a timestamped results folder:

```
results/benchmark_YYYYMMDD_HHMMSS/
├── benchmark_results.json    # JSON format results
├── benchmark_results.csv     # CSV format results
├── sessioninfo.md            # System and R environment info
├── result_arrow.csv          # Arrow method output
├── result_polars.csv         # Polars method output
├── result_datatable.csv      # data.table method output
├── result_tidyverse.csv      # tidyverse method output
└── result_vroom.csv          # vroom method output
```

### Metrics Collected

For each method, the benchmark collects:

| Metric | Description |
|--------|-------------|
| **runtime_sec** | Total execution time in seconds |
| **max_memory_mb** | Peak memory usage in megabytes |
| **disk_space_mb** | Input file size on disk |
| **code_complexity** | Lines of code needed for the task |
| **timestamp** | Benchmark run timestamp |

### System Information

The `sessioninfo.md` file includes:
- R version and platform details
- CPU model and core count
- Total system memory
- Loaded package versions
- Data directory size and file count
- BLAS/LAPACK configuration
- System locale settings

### Example Results

```json
[
  {
    "method": "data.table",
    "runtime_sec": 2.145,
    "max_memory_mb": 1250.5,
    "disk_space_mb": 95.2,
    "code_complexity": 5,
    "timestamp": "20250124_143022"
  },
  {
    "method": "arrow",
    "runtime_sec": 1.823,
    "max_memory_mb": 850.3,
    "disk_space_mb": 95.2,
    "code_complexity": 8,
    "timestamp": "20250124_143022"
  }
]
```

## Required Packages

### Data Generation
```r
install.packages(c("data.table", "arrow", "jsonlite"))
```

### Benchmarking (install only what you want to test)
```r
# Core (always needed)
install.packages(c("data.table", "jsonlite"))

# Optional benchmark methods
install.packages(c("arrow", "dplyr", "tidyr", "readr", "vroom"))

# Polars (requires separate installation)
# See: https://pola-rs.github.io/r-polars/
```

## Project Structure

```
dev/01_benchmark_minimal/
├── 01_generate_data.R      # Data generation script
├── 02_benchmark_methods.R  # Benchmark comparison script
├── README.md               # This file
├── data/                   # Generated data (created by script)
│   ├── btp_synth.csv
│   ├── btp_synth.csv.gz
│   ├── btp_synth.parquet
│   ├── btp_synth_partitioned/
│   └── btp_synth_hash_partitioned/
└── results/                # Benchmark results (created by script)
    └── benchmark_YYYYMMDD_HHMMSS/
        ├── benchmark_results.json
        ├── benchmark_results.csv
        ├── sessioninfo.md
        └── result_*.csv
```

## Workflow

1. **Generate data** (one-time setup):
   ```bash
   Rscript 01_generate_data.R
   ```

2. **Run benchmarks** (can be run multiple times):
   ```bash
   Rscript 02_benchmark_methods.R
   ```

3. **Analyze results** in the `results/benchmark_*/` directory

## Notes

- Generation time varies based on system performance (typically 30-120 seconds)
- Total output size is approximately 450-500 MB (CSV) or 95-100 MB (Parquet)
- The script automatically sources `synth_btp.R` from the experiment directory
- All formats contain identical data for fair comparison
- Parquet files use Snappy compression by default

## Troubleshooting

**Error: synth_btp.R not found**
- Ensure you're running the script from `dev/01_benchmark_minimal/`
- Verify the path to `../experiment/00_gen_btp/synth_btp.R` exists

**Error: btp_variables.json not found**
- Check that `../experiment/00_gen_btp/btp_variables.json` exists
- This file is required for variable definitions

**Package not installed**
- Install required packages: `install.packages(c("data.table", "arrow", "jsonlite"))`

**Insufficient memory**
- Reduce `N_UNITS` to generate fewer rows
- Close other applications to free up RAM
