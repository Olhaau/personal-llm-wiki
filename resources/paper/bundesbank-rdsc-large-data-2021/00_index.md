# Working with Large Data at the RDSC: A Technical Guide

## Paper Metadata
| Field | Value |
|-------|-------|
| **Authors** | Matthias Gomolka, Jannick Blaschke, Christian Hirsch |
| **Institution** | Deutsche Bundesbank, Research Data and Service Centre (RDSC) |
| **Year** | 2021 |
| **Pages** | 17 |
| **Language** | en |

## Source References
- **Original PDF**: [bundesbank-rdsc-large-data-2021-04.pdf](../../raw/pdf/bundesbank-rdsc-large-data-2021-04.pdf)
- **External Link**: https://www.bundesbank.de/rdsc
- **Citation**: Gomolka, M., J. Blaschke and C. Hirsch (2021). Working with large data at the RDSC, Technical Report 2021-04 - Version 1.1. Deutsche Bundesbank, Research Data and Service Centre.

## Abstract
Technical report providing recommendations for writing efficient code when working with large datasets (up to 235 GB) in secure research data environments. Compares Stata and R performance, demonstrating that R with Parquet and data.table significantly outperforms optimized Stata solutions.

## Content Chunks

| File | Section | Description |
|------|---------|-------------|
| [01_summary.md](./01_summary.md) | Summary | Executive summary, key findings, decision framework |
| [02_file_formats.md](./02_file_formats.md) | File Formats | Parquet vs dta.gz comparison with benchmarks |
| [03_data_wrangling.md](./03_data_wrangling.md) | Data Wrangling | data.table vs gtools with code examples |
| [04_best_practices.md](./04_best_practices.md) | Best Practices | General recommendations and optimization tips |

## Quick Reference
**Core Objective**: Provide recommendations for efficient large data processing in R and Stata at research data centers.

**Key Takeaways**:
- R with Parquet is 65-79% faster than optimized Stata for data import
- data.table is 90% faster than gtools for aggregation operations
- Total time = programming time + computing time (consider proficiency)
- Simple optimizations (file format, column selection) yield 50%+ savings

## Knowledge Graph
- Apache Arrow - Core technology for Parquet format
- data.table - R package for large data manipulation
- Parquet - Columnar storage format
- R Performance Optimization - Broader R efficiency strategies
- Stata Performance - Stata optimization techniques
- FDZ Infrastructure - Research data center context

## Metadata
**Tags**: #paper #large-data #r-optimization #stata #parquet #arrow #data-table #rdsc #bundesbank
**Content Type**: paper
**Complexity**: intermediate
**Curated**: 2025-11-23
