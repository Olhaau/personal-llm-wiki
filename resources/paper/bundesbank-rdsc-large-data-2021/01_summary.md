# Executive Summary

> **Paper**: Working with Large Data at the RDSC  
> **Chunk**: 1 of 4 | **Section**: Summary  
> **Source**: [bundesbank-rdsc-large-data-2021-04.pdf](../../raw/pdf/bundesbank-rdsc-large-data-2021-04.pdf) (pp. 1-6)

---

## The Optimization Problem

The report frames language choice as an optimization problem:

```
min(t_overall) where t_overall = t_programming + t_computing
```

**Critical insight**: Computing time savings are only valuable if they aren't offset by increased programming time. Researchers unfamiliar with R may spend more total time despite R's performance advantages.

## Dataset Context

The RDSC provides datasets ranging from 0.5 GB (Monthly Balance Sheet Statistics) to 235 GB (MiFID data). Benchmark dataset:
- **Rows**: 13.7 million
- **Columns**: 46
- **Daily file size**: Up to 2.5 GB in memory
- **Daily observations**: Up to 8.5 million

## Key Performance Results

| Operation | Best Stata | Best R | R Advantage |
|-----------|------------|--------|-------------|
| File import | dta.gz: 77.6s | Parquet: 27.1s | 65% faster |
| Column selection | 51.3s | 16.3s | 79% faster |
| Aggregation | gtools: 8.2s | data.table: 0.8s | 90% faster |

## Decision Framework

**Choose R if**:
- Proficient in R (especially data.table)
- Computing time is the bottleneck
- Working with very large datasets (50+ GB)
- Need Parquet/Arrow ecosystem

**Choose Stata if**:
- Stata expert with limited R experience
- Programming time would offset computing gains
- Institutional standards require Stata

## Recommended Stack

| Task | R Stack | Stata Stack |
|------|---------|-------------|
| File format | Parquet | dta.gz |
| Import | arrow::read_parquet | gziputil::usegz |
| Wrangling | data.table | gtools |
| Export | arrow::write_parquet | gziputil::savegz |

## Related Chunks
- Next: [02_file_formats.md](./02_file_formats.md) - File Formats

---
*Index: [00_index.md](./00_index.md) | Paper: Working with Large Data at the RDSC*
