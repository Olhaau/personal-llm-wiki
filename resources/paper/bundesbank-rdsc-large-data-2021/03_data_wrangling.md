# Data Wrangling Packages

> **Paper**: Working with Large Data at the RDSC  
> **Chunk**: 3 of 4 | **Section**: Data Wrangling  
> **Source**: [bundesbank-rdsc-large-data-2021-04.pdf](../../raw/pdf/bundesbank-rdsc-large-data-2021-04.pdf) (pp. 10-13)

---

## Stata: gtools Package

The `gtools` package reimplements Stata commands 10-20x faster:

| Command | Replaces |
|---------|----------|
| `gcollapse` | `collapse` |
| `greshape` | `reshape` |
| `gegen` | `egen` |

### Code Examples

```stata
* Aggregate data with gtools
gcollapse (sum) VOLUMEN, by(MP_anon)

* Compare to base Stata (much slower):
* collapse (sum) VOLUMEN, by(MP_anon)
```

## R: data.table Package

`data.table` is designed for large data (100+ GB in RAM):

### Code Examples

```r
library(data.table)

# Collapse/aggregate - concise syntax
mifid_collapsed <- mifid[, sum(VOLUMEN), by = MP_anon]

# Compare to base R (verbose and slower):
# aggregate(df[["VOLUMEN"]], by = list(df[["MP_anon"]]), sum, drop = FALSE)

# Multiple aggregations
result <- mifid[, .(
  total_vol = sum(VOLUMEN),
  avg_vol = mean(VOLUMEN),
  count = .N
), by = MP_anon]
```

## Benchmark Results: Aggregation

| Method | Time (seconds) | vs Base Stata |
|--------|----------------|---------------|
| Base Stata collapse | 34.3s | - |
| Stata gtools gcollapse | 8.2s | 76.2% faster |
| Base R aggregate | 12.4s | 63.8% faster |
| **R data.table** | **0.8s** | **97.7% faster** |

**data.table is 90.1% faster than gtools** (already optimized Stata)

## Column Type Optimization

### Stata

```stata
* Compress before saving (sets minimum required type per variable)
compress
savegz "my_data.dta.gz"

* Convert strings to labeled values
* See: help label, help encode
```

### R

```r
# Type conversion
df <- type.convert(df)
write_parquet(df, "my_data.parquet")

# For data.table: convert strings to factors
DT[, .(var := factor(var, levels = 1:10, labels = letters[1:10]))]
```

## Key Points
- gtools makes Stata 10-20x faster but still slower than R
- data.table syntax is concise and extremely fast
- Type optimization reduces memory and improves performance
- Use `compress` in Stata, `type.convert()` in R

## Related Chunks
- Previous: [02_file_formats.md](./02_file_formats.md) - File Formats
- Next: [04_best_practices.md](./04_best_practices.md) - Best Practices

---
*Index: [00_index.md](./00_index.md) | Paper: Working with Large Data at the RDSC*
