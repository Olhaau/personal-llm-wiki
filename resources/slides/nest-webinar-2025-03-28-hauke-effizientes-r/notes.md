# Speaker Notes: Effizientes Programmieren mit R

> **Presentation**: Effizientes Programmieren mit R  
> **Source**: [nest-webinar-2025-03-28-hauke-effizientes-r.pdf](../../raw/pdf/nest-webinar-2025-03-28-hauke-effizientes-r.pdf)

---

## Technical Context

### Business-Tax-Panel (BTP)
- NeSt product released in 2024
- Combines 6 corporate tax statistics + business register
- Time series: 2013-2019
- Scale: 67 million observations, 2,700+ variables

### The Problem
Traditional SAS/Stata workflows on this data:
- Data preparation: ~54 minutes
- Scientific analysis: ~2 hours
- Memory requirements exceed typical workstation capacity

## Infrastructure Details

### Old FDZ Infrastructure
- Shared server with 754 GB RAM
- Max 128 GB per user
- 72 cores, but <36 recommended per session
- Limited capacity, varying availability

### New On-Site Server (2025)
- 6 dedicated servers
- 3 TB total RAM (512 GB each)
- 96 cores (16 per server)
- Exclusive FDZ access
- Unified for all On-Site usage

## Technical Solution

### Why Parquet?
1. **Columnar storage**: Only reads needed columns
2. **Built-in compression**: Snappy by default
3. **Partitioning**: Splits data by stat/Jahr for efficient filtering
4. **Schema enforcement**: Consistent types across files

### Why Arrow?
1. **Out-of-memory processing**: Query data larger than RAM
2. **Lazy evaluation**: Only executes when needed
3. **Parallel execution**: Uses multiple cores automatically
4. **dplyr compatibility**: Familiar R syntax

### Data Structure
```
btp/
  stat=e/           # Partitioned by statistic type
    Jahr=2013/      # Partitioned by year
      part-0.parquet
      part-1.parquet
    Jahr=2014/
    ...
  stat=g/
  stat=k/
  stat=p/
  stat=r/
  stat=u/
  stat=v/
```

### Schema Definition
```r
Schema_btp <- schema(
  stat = utf8(),
  Jahr = int32(),
  g_k2119 = int64(),
  # ... additional columns
)
```

Ensures consistent data types across all partitions.

## Performance Results

| Task | Time | RAM |
|------|------|-----|
| Fallzahlen (counts) | ~20 sec | < 4 GB |
| Numerische Kennzahlen | ~6 sec | - |
| Lorenzkurve | < 2 sec | < 700 MB |
| Verknüpfung + Logit | < 12 sec | - |

### Compression Achievement
- Original Stata: 840 GB
- Original SAS: 301 GB
- Parquet: **19 GB** (95% reduction from Stata)

## Key Code Patterns

### Opening Dataset
```r
library(arrow)

btp <- open_dataset("btp/", schema = Schema_btp)
```

### Lazy Query
```r
result <- btp |>
  filter(Jahr == 2019, stat == "e") |>
  select(g_k2119, some_var) |>
  collect()  # Execution happens here
```

### Aggregation
```r
counts <- btp |>
  group_by(Jahr, stat) |>
  summarise(n = n()) |>
  collect()
```

## Next Steps (mentioned in presentation)

1. **Infrastructure**: Roll out FDZ On-Site Servers
2. **Documentation**: Sample syntax and guides
3. **Dissemination**: Presentations at Statistische Woche 2025
4. **Support**: Researcher consulting

## Related Resources

- [Apache Parquet](https://parquet.apache.org/)
- [Apache Arrow](https://arrow.apache.org/)
- [Arrow R Docs](https://arrow.apache.org/docs/r/)
- [Arrow R Cookbook](https://arrow.apache.org/cookbook/r)
- [R4DS Arrow Chapter](https://r4ds.hadley.nz/arrow)
- [FDZ BTP Info](https://www.forschungsdatenzentrum.de/de/steuern/btp)

---
*Index: [00_index.md](./00_index.md) | Slides: [slides.qmd](./slides.qmd)*
