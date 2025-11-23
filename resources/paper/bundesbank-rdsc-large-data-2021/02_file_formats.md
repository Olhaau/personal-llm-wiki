# File Format Recommendations

> **Paper**: Working with Large Data at the RDSC  
> **Chunk**: 2 of 4 | **Section**: File Formats  
> **Source**: [bundesbank-rdsc-large-data-2021-04.pdf](../../raw/pdf/bundesbank-rdsc-large-data-2021-04.pdf) (pp. 7-9)

---

## Stata: Use dta.gz with gziputil

| Format | Tool | Performance | Notes |
|--------|------|-------------|-------|
| dta | native | Slow from network | No compression |
| **dta.gz** | gziputil | **Recommended** | ~90% size reduction |

### Code Examples

```stata
* Install gziputil package
* Use as drop-in replacements:
usegz    " instead of use
savegz   " instead of save  
mergegz  " instead of merge
appendgz " instead of append

* Example: Import compressed data
global mifid_dtagz : dir "." files "*.dta.gz", respectcase
clear
appendgz using ${mifid_dtagz}

* Import only specific columns
appendgz using ${mifid_dtagz}, keep(BGNR-KURS)

* Single file with column selection
usegz BGNR-KURS using "my_data.dta.gz"
```

## R: Use Parquet with Arrow

| Format | Package | Performance | Notes |
|--------|---------|-------------|-------|
| rds | base R | Moderate | Default compression |
| **parquet** | arrow | **Fastest** | Column-oriented, Apache Arrow |

### Code Examples

```r
library(arrow)
library(data.table)

# Create file list
mifid_parquet <- dir(pattern = ".parquet")

# Import and combine
mifid <- rbindlist(lapply(mifid_parquet, read_parquet))

# Import only specific columns
mifid_subset <- rbindlist(
  lapply(mifid_parquet, read_parquet, col_select = 1:20)
)
```

## Benchmark Results

### Full Import (46 columns)

| Method | Time (seconds) | Speedup vs Baseline |
|--------|----------------|---------------------|
| Stata dta (baseline) | 124.9 | - |
| Stata dta.gz | 77.6 | 37.9% faster |
| R rds (baseline) | 83.9 | - |
| **R parquet** | **27.1** | **78.3% faster** |

**R Parquet is 65.1% faster than optimized Stata dta.gz**

### Selective Import (20 of 46 columns)

| Method | Full Import | 20 Columns | Savings |
|--------|-------------|------------|---------|
| Stata dta.gz | 77.6s | 51.3s | 33.9% |
| R parquet | 27.1s | 16.3s | 39.9% |

**Optimized R is 79% faster than optimized Stata**

### Projected Full Dataset Import

| Scenario | Computing Time |
|----------|----------------|
| Stata dta (unoptimized) | 18.0 hours |
| Stata dta.gz + columns | 7.4 hours |
| R rds (unoptimized) | 10.5 hours |
| **R parquet + columns** | **2.4 hours** |

## Key Points
- Simple file format change saves 10+ hours on large imports
- Column selection provides additional 30-40% savings
- Parquet's columnar format excels at selective column reads

## Related Chunks
- Previous: [01_summary.md](./01_summary.md) - Summary
- Next: [03_data_wrangling.md](./03_data_wrangling.md) - Data Wrangling

---
*Index: [00_index.md](./00_index.md) | Paper: Working with Large Data at the RDSC*
