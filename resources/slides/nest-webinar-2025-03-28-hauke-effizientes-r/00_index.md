# Effizientes Programmieren mit R

## Presentation Metadata
| Field | Value |
|-------|-------|
| **Presenter** | Oliver Hauke |
| **Institution** | Statistisches Bundesamt (Destatis), IT-Kompetenzzentrum "Analyse und Auswertung" |
| **Event** | NeSt-Webinar |
| **Date** | 2025-03-28 |
| **Slides** | 13 |
| **Language** | de |

## Source References
- **Original PDF**: [nest-webinar-2025-03-28-hauke-effizientes-r.pdf](../../raw/pdf/nest-webinar-2025-03-28-hauke-effizientes-r.pdf)
- **Contact**: oliver.hauke@destatis.de

## Abstract
Demonstration of efficient R programming in a modern data infrastructure using the Business-Tax-Panel (BTP) as an example. Shows how Parquet format and Arrow package enable analysis of 840 GB datasets with minimal resources (< 4 GB RAM, seconds instead of hours).

## Content Files

| File | Description |
|------|-------------|
| [slides.qmd](./slides.qmd) | Quarto reveal.js presentation (render with `quarto render slides.qmd`) |
| [notes.md](./notes.md) | Speaker notes and technical details |

## Quick Reference
**Core Message**: R with Arrow/Parquet enables efficient analysis of large datasets (840 GB → 19 GB, hours → seconds)

**Key Takeaways**:
- Parquet reduces BTP from 840 GB to 19 GB (95% compression)
- Arrow enables out-of-memory processing with lazy evaluation
- Typical queries run in < 20 seconds using < 4 GB RAM
- New FDZ infrastructure provides 3 TB RAM across 6 servers

**Tech Stack**:
- File format: Parquet (partitioned by stat/Jahr)
- R packages: arrow, data.table
- Infrastructure: FDZ On-Site Server (512 GB RAM per server)

## Key Resources
- [Apache Parquet](https://parquet.apache.org/)
- [Apache Arrow](https://arrow.apache.org/)
- [Arrow R Documentation](https://arrow.apache.org/docs/r/)
- [Arrow R Cookbook](https://arrow.apache.org/cookbook/r)
- [Awesome Arrow R](https://github.com/thisisnic/awesome-arrow-r)
- [R for Data Science - Arrow Chapter](https://r4ds.hadley.nz/arrow)
- [FDZ BTP Documentation](https://www.forschungsdatenzentrum.de/de/steuern/btp)

## Knowledge Graph
- Apache Arrow - Core technology for out-of-memory processing
- Parquet - Columnar storage format enabling compression
- data.table - In-memory alternative for smaller subsets
- [Bundesbank RDSC Large Data](../paper/bundesbank-rdsc-large-data-2021/00_index.md) - Related paper on large data optimization

## Metadata
**Tags**: #slides #r-optimization #arrow #parquet #fdz #btp #destatis
**Content Type**: slides
**Complexity**: intermediate
**Curated**: 2025-11-23
