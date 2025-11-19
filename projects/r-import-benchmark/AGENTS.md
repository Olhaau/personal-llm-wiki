# AGENTS.md - R Import Benchmark Project

## Project Overview
R performance benchmarking project comparing CSV reading methods across data.table, duckdb, readr, arrow, polars, and base R.

## Build/Test Commands
- **Generate data**: `Rscript generate_benchmark_data.R` (creates ~1GB test files)
- **Run simplified benchmark**: `Rscript compare_fix_methods.R` (works with base R only)
- **Run full benchmark**: `Rscript csv_reading_benchmark.R` (requires all packages)
- **Single test**: `Rscript -e "source('compare_fix_methods.R')"` for quick validation
- **Clean data**: `rm *.csv *.parquet *.qs` to remove generated test files

## Code Style Guidelines
- **Headers**: Include descriptive comments with author/date for all scripts
- **Functions**: Use snake_case naming, include parameter documentation
- **Libraries**: Load with `library()` at script top, use `suppressPackageStartupMessages()` for clean output
- **Error handling**: Use `tryCatch()` for package checks, `stopifnot()` for validation
- **Memory**: Call `gc()` after large operations, `rm()` temporary objects
- **Output**: Use `cat()` for progress messages, `print()` for data frames
- **Data**: Set `stringsAsFactors = FALSE` in data.frame(), use `set.seed()` for reproducibility
- **Timing**: Use `Sys.time()` for simple benchmarks, `microbenchmark` for detailed analysis

## File Organization
Large data files (*.csv, *.parquet) are git-ignored - regenerate locally using data generation scripts.