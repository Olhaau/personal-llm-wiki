# Best Practices and General Recommendations

> **Paper**: Working with Large Data at the RDSC  
> **Chunk**: 4 of 4 | **Section**: Best Practices  
> **Source**: [bundesbank-rdsc-large-data-2021-04.pdf](../../raw/pdf/bundesbank-rdsc-large-data-2021-04.pdf) (pp. 14-16)

---

## 1. Start with Small Subsets

Always develop and test code on a subset of data first:
- Use a few days instead of full time series
- Catch programming errors before long-running jobs
- Reduces iterations and site visits

```r
# R: Test on first 1000 rows
test_data <- head(full_data, 1000)
# Develop pipeline on test_data first
```

```stata
* Stata: Test on subset
keep if _n <= 1000
* Develop code on subset first
```

## 2. Use Virtual Clients (VCs)

| Resource | Workstation | Virtual Client |
|----------|-------------|----------------|
| CPUs | 4 | 8 |
| Threads | 8 | 16 |
| RAM | 16 GB | 32-128 GB |
| Network | Standard | Fast connection |

VCs provide faster network connections to data storage, speeding up read/write operations significantly.

## 3. Consider the {targets} Package (R)

For advanced R users, the `targets` package helps manage long-running analyses:

```r
library(targets)

# Define pipeline in _targets.R
list(
  tar_target(raw_data, read_parquet("data.parquet")),
  tar_target(clean_data, clean_function(raw_data)),
  tar_target(results, analyze_function(clean_data))
)

# Run pipeline - skips unchanged steps
tar_make()
```

Benefits:
- Tracks dependencies between pipeline steps
- Skips unchanged computations on re-runs
- Reduces debugging time for complex workflows

## 4. Software Versions Reference

| Software | Version (as of Sept 2021) |
|----------|---------------------------|
| Stata SE | 16.1 |
| Stata MP | 16.1 |
| R | 4.0.2 |
| data.table | 1.14.0 |
| arrow | 4.0.1 |
| gtools | 1.1.2 |

## References

1. Bravo, M. C. (2018). GTOOLS: Stata module for fast group commands. [SSC](https://ideas.repec.org/c/boc/bocode/s458514.html)
2. Dowle, M., & Srinivasan, A. (2021). data.table: Extension of 'data.frame'. [CRAN](https://CRAN.R-project.org/package=data.table)
3. Gomolka, M. (2018). GZIPUTIL: Stata module for gzipped files. SSC
4. Gomolka, M., & Becker, T. (2021). sdcLog: Tools for SDC in Research Data Centers. [CRAN](https://CRAN.R-project.org/package=sdcLog)
5. Landau, W. M. (2021). The targets R package. [JOSS](https://doi.org/10.21105/joss.02959)
6. Richardson, N., et al. (2021). arrow: Integration to 'Apache' 'Arrow'. [CRAN](https://CRAN.R-project.org/package=arrow)

## Key Points
- Always prototype on small subsets
- Use Virtual Clients for faster I/O
- Consider {targets} for reproducible pipelines
- Keep software versions documented

## Related Chunks
- Previous: [03_data_wrangling.md](./03_data_wrangling.md) - Data Wrangling

---
*Index: [00_index.md](./00_index.md) | Paper: Working with Large Data at the RDSC*
