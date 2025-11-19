# Data Files Guide

## Files Tracked in Git ✅

These small result files are kept in version control:
- `benchmark_comparison.csv` - Summary benchmark results (~4KB)
- `benchmark_results_detailed.csv` - Detailed results (if generated)
- `benchmark_summary.csv` - Final rankings (if generated)

## Files Ignored by Git ❌

These large data files are excluded from version control (see `.gitignore`):

### Generated Test Data
- `benchmark_data.csv` - Large test dataset (~1GB)
- `benchmark_data.csv.gz` - Compressed version (~200-300MB)
- `benchmark_data.parquet` - Parquet format
- `benchmark_data.qs` - QS format
- `benchmark_data_simple.csv` - Simplified test data (~700MB)

### Temporary Files
- `temp_*.csv` - Temporary data chunks
- `test_data.*` - Test data files
- `file_generation_summary.csv` - Data generation metadata
- `file_summary.csv` - File size summaries

### Standard R Files
- `.RData`, `.Rhistory` - R session files
- `*.Rproj`, `.Rproj.user/` - RStudio project files
- Various R temporary and cache files

## Regenerating Data

To recreate the test data files locally:

```bash
# Generate full benchmark dataset (may create ~1GB files)
Rscript generate_benchmark_data.R

# Or generate smaller test dataset
Rscript simple_data_gen.R

# Run benchmarks
Rscript compare_fix_methods.R
```

## Why Exclude Large Data Files?

1. **Size**: Test datasets can be 700MB - 1GB+
2. **Repository efficiency**: Keeps Git repo lightweight
3. **Regeneratable**: All data files can be recreated from scripts
4. **Platform differences**: File sizes may vary across systems

The benchmark scripts are the important part - they can generate appropriate test data for any system.