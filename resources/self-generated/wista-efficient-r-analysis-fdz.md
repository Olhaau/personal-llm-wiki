# Efficient R Analysis Tools for Research Data at German Statistical Office

**Source Type:** Internal Draft Paper  
**Original File:** raw-wista-content.md  
**Language:** German (with English summary)  
**Institution:** Federal Statistical Office of Germany (Destatis)  
**Last Updated:** November 2025  
**Status:** Curated Knowledge Article

---

## Overview

This article documents the development and deployment of efficient R-based analysis tools for large-scale research data at the German Federal Statistical Office's Research Data Centre (Forschungsdatenzentrum, FDZ). The work focuses on enabling researchers to process large tax statistics datasets using modern data tools.

---

## Key Technologies

| Technology | Purpose | Documentation |
|------------|---------|---------------|
| **Apache Arrow** | In-memory columnar data format | [arrow.apache.org/docs/r/](https://arrow.apache.org/docs/r/) |
| **Parquet** | Efficient columnar file storage | Part of Arrow ecosystem |
| **DuckDB** | Embedded analytical SQL database | [duckdb.org/docs/](https://duckdb.org/docs/) |

---

## Context: Network for Empirical Tax Research (NeSt)

The Network for Empirical Tax Research (Netzwerk empirische Steuerforschung, NeSt) is a collaboration between the German Federal Ministry of Finance (BMF) and academic researchers focusing on evidence-based tax policy research.

**Challenge:** Traditional data analysis methods struggle with the scale and complexity of German tax statistics data, creating bottlenecks for both internal statistical production and external research projects.

---

## Primary Use Case: Business-Tax-Panel (BTP)

### Dataset Characteristics

| Metric | Value |
|--------|-------|
| **Observations** | 77.8 million |
| **Unique Entities** | 16.7 million |
| **Variables** | 2,700+ |
| **Time Period** | 2013-2020 |
| **Data Sources** | 6+ tax statistics |

### Included Statistics

- Gewerbesteuer (trade tax)
- Körperschaftsteuer (corporate tax)
- Umsatzsteuer-Voranmeldung/-Veranlagung (VAT)
- Statistik über Personengesellschaften (partnerships)
- Einnahmenüberschussrechnung (income-expenditure accounting)
- Statistisches Unternehmensregister (business register)

### Technical Requirements

The dataset's size creates significant demands on:
- Storage capacity
- RAM (working memory)
- CPU processing power

These requirements challenge both internal Destatis systems and the FDZ infrastructure serving external researchers.

---

## FDZ Infrastructure Development

### Current State (2025)

| Access Method | Status | Description |
|---------------|--------|-------------|
| **On-Site Access** | Active | Secure physical workstations |
| **Remote Access** | New (Jan 2025) | Remote Scientific Use Files |
| **Tax Data Remote** | Under review | Remote access for tax statistics being evaluated |

### Infrastructure Goals

1. Deploy modern analysis tools with larger capacities
2. Enable efficient processing of resource-intensive datasets
3. Provide standardized workflows for researchers
4. Support reproducible research practices

---

## Efficient Analysis Methods

### Core Workflow Pattern

```r
# Recommended R workflow for large FDZ datasets
library(arrow)
library(duckdb)
library(dplyr)

# 1. Open dataset without loading into memory
ds <- open_dataset("path/to/btp_parquet", format = "parquet")

# 2. Filter and aggregate using Arrow
result <- ds |>
  filter(berichtsjahr >= 2018) |>
  group_by(wirtschaftszweig) |>
  summarise(
    n = n(),
    mean_umsatz = mean(umsatz, na.rm = TRUE)
  ) |>
  collect()

# 3. For complex SQL queries, use DuckDB
con <- dbConnect(duckdb::duckdb())
duckdb::duckdb_register_arrow(con, "btp", ds)

query_result <- dbGetQuery(con, "
  SELECT wirtschaftszweig, 
         COUNT(*) as n,
         PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY gewinn) as median_gewinn
  FROM btp
  WHERE berichtsjahr = 2020
  GROUP BY wirtschaftszweig
")
```

### Key Benefits

| Benefit | Description |
|---------|-------------|
| **Low RAM Usage** | Process datasets larger than available memory |
| **Fast Execution** | Seconds instead of minutes/hours |
| **Minimal Code** | Concise, readable R syntax |
| **SQL Compatibility** | Familiar interface for complex queries |

### Demonstrated Analyses

- Frequency distributions
- Distribution analyses (including Lorenz curves)
- Estimation models (regression, logistic regression)
- Data recoding (e.g., economic activity classification)
- Metadata report generation

---

## Implementation Status

### Completed

- Infrastructure capacity expansion
- Apache Arrow/Parquet/DuckDB deployment
- Initial use cases with Business-Tax-Panel

### In Progress

- Remote access evaluation for tax statistics
- Documentation for FDZ users

### Planned

- Annual BTP updates
- Integration of income tax data (Lohn- und Einkommensteuer)
- Template syntax for researchers (developed with NeSt collaboration)

---

## Authors and Contacts

| Author | Role | Department |
|--------|------|------------|
| **Oliver Hauke** | Lead Developer | IT Competence Centre Analysis |
| **Annette Kristiansen** | Tax Statistics Expert | Corporate/VAT Statistics |
| **Dr. Veronika Chakraverty** | Research Data Specialist | FDZ Health Data |

---

## Key References

1. **Arrow R Documentation:** https://arrow.apache.org/docs/r/index.html
2. **Arrow R Cookbook:** https://arrow.apache.org/cookbook/r/index.html
3. **DuckDB R Client:** https://duckdb.org/docs/stable/clients/r.html
4. **Arrays and Tables in Arrow (Blog):** https://blog.djnavarro.net/posts/2022-05-25_arrays-and-tables-in-arrow/

### Academic References

- Brenzel & Zwick (2022): FDZ infrastructure development. *Wirtschaft und Statistik* 6/2022.
- Kristiansen (2023): Business-Tax-Panel methodology. *Wirtschaft und Statistik* 3/2023.
- Kristiansen et al. (2025a): Tax statistics data for research. *Steuern und Wirtschaft* Sonderheft 2025.
- Sachverständigenrat (2023): Infrastructure critique. *Jahresgutachten* 2023/24.
- Wissenschaftlicher Beirat BMF (2020): Data infrastructure recommendations. *Gutachten* 5/2020.

---

## Implementation Notes for Agents

### When to Use These Methods

- Processing FDZ microdata with millions of observations
- Tax statistics analysis requiring cross-tabulation
- Panel data with many time periods
- Memory-constrained environments (e.g., FDZ workstations)

### Prerequisites

```r
# Required R packages
install.packages(c("arrow", "duckdb", "dplyr"))
```

### Data Format Recommendations

| Format | Use Case |
|--------|----------|
| **Parquet** | Storage, archival, data exchange |
| **Arrow Table** | In-memory analysis |
| **DuckDB** | Complex SQL queries, joins |

---

*Curated from internal Destatis draft paper for AI agent context usage.*
