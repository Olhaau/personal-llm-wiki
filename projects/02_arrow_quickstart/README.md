# 02_arrow_quickstart

Small R script toolkit for high-volume CSV/Parquet/Stata conversion, schema control,
and performance-oriented numeric profiling.

## Requirements

- R 4.2+
- `arrow`
- `data.table`
- `tidyselect`
- `haven` (only for `.dta` export)

Install:

```bash
Rscript -e "install.packages(c('arrow','data.table','tidyselect','haven'))"
```

## Files

- `csv_to_parquet.R`: simplest CSV -> Parquet conversion.
- `csv_to_parquet_with_int64_fix.R`: streaming type inference with int64 safety.
- `csv_numeric_ranges_datatable.R`: chunked numeric min/max extraction and schema-from-ranges conversion.
- `parquet_to_dta.R`: Parquet -> Stata `.dta` export with optional Stata `compress`.
- `benchmark_csv_to_parquet.sh`: runtime/RAM/file size benchmark helper.

## Function Reference

### `csv_to_parquet.R`

- `convert_csv_to_parquet(csv_path, parquet_path = NULL, compression = "snappy")`
  - Reads a CSV with Arrow and writes a Parquet file.
  - Uses a default output path (`.csv` -> `.parquet`) when `parquet_path` is not provided.

### `csv_to_parquet_with_int64_fix.R`

- `default_parquet_path(csv_path)`
  - Returns default Parquet output path for a CSV input.

- `check_big_integer(values, na = c("", "NA"), int32_max = 2147483647)`
  - Checks whether integer-like values exceed int32 limits.

- `infer_column_type_streaming(csv_path, column_name, na = c("", "NA"), block_size = 1048576L)`
  - Reads one column in streaming chunks and infers Arrow type (`int32`, `int64`, `float64`, `utf8`).

- `generate_csv_arrow_schema(csv_path, na = c("", "NA"), block_size = 1048576L)`
  - Builds full Arrow schema for CSV by scanning columns one by one.
  - Returns schema and names of overflow columns promoted to int64.

- `convert_csv_to_parquet_pipe(csv_path, parquet_path = NULL, schema = NULL, compression = "snappy", na = c("", "NA"))`
  - Converts CSV to Parquet using optional explicit schema.

- `detect_csv_arrow_types(csv_path, na = c("", "NA"), block_size = 1048576L)`
  - Convenience wrapper returning inferred schema + int32-overflow columns.

- `convert_csv_to_parquet_int64_safe(csv_path, parquet_path = NULL, compression = "snappy", na = c("", "NA"), block_size = 1048576L)`
  - End-to-end int64-safe CSV -> Parquet conversion.

### `csv_numeric_ranges_datatable.R`

- `extract_numeric_ranges_csv(csv_path, output_path = NULL, chunk_nrows = 1000000L, probe_nrows = 100000L, na_strings = c("", "NA", "NaN", "NULL"), show_progress = TRUE)`
  - Uses `data.table::fread()` with `select` + `nrows` chunking to scan only numeric columns.
  - Computes min/max per numeric variable and optionally writes a ranges dataset.

- `is_integer_string(x)`
  - Checks if a single string is an integer-like token.

- `int64_outside_int32(min_value, max_value)`
  - Checks whether integer range exceeds int32 bounds.

- `build_arrow_schema_from_ranges(csv_path, ranges_dt, probe_nrows = 100000L, na_strings = c("", "NA", "NaN", "NULL"))`
  - Builds Arrow schema from a ranges dataset (`variable`, `type`, `min_value`, `max_value`).
  - Promotes integer columns to `int64` when range exceeds int32.

- `convert_csv_to_parquet_from_ranges(csv_path, ranges_path, parquet_path = NULL, compression = "snappy", probe_nrows = 100000L, na_strings = c("", "NA", "NaN", "NULL"))`
  - Loads ranges, builds schema, reads CSV with that schema, and writes Parquet.

### `parquet_to_dta.R`

- `find_stata_executable()`
  - Finds available Stata executable (`stata-mp`, `stata-se`, or `stata`).

- `run_stata_compress(stata_exe, dta_path)`
  - Runs a temporary Stata do-file to `compress` an existing `.dta`.

- ``%||%`(x, y)`
  - Null-coalescing helper: returns `y` if `x` is `NULL`.

- `convert_parquet_to_dta(parquet_path, dta_path = NULL, use_stata_compress = TRUE, stata_exe = NULL)`
  - Converts Parquet to Stata `.dta` (version 15 via `haven`).
  - Warns when `integer64` values may lose precision in Stata.
  - Optionally runs Stata `compress` after export.

## Typical Workflows

### 1) Simple CSV -> Parquet

```bash
Rscript -e "source('csv_to_parquet.R'); convert_csv_to_parquet('data/example.csv')"
```

### 2) Int64-safe CSV -> Parquet

```bash
Rscript -e "source('csv_to_parquet_with_int64_fix.R'); convert_csv_to_parquet_int64_safe('data/int_overflow_example.csv')"
```

### 3) High-volume range scan -> schema -> Parquet

```bash
Rscript -e "source('csv_numeric_ranges_datatable.R'); extract_numeric_ranges_csv('data/benchmark_1gb.csv', output_path='data/benchmark_1gb_numeric_ranges.csv', chunk_nrows=1000000L, show_progress=FALSE); convert_csv_to_parquet_from_ranges('data/benchmark_1gb.csv', 'data/benchmark_1gb_numeric_ranges.csv', parquet_path='data/benchmark_1gb_from_ranges.parquet')"
```

### 4) Parquet -> Stata

```bash
Rscript -e "source('parquet_to_dta.R'); convert_parquet_to_dta('data/int_overflow_example.parquet', use_stata_compress = FALSE)"
```
