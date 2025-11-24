# Arrow, Parquet, and DuckDB Resources for Official Statistics

**Compilation Date:** November 24, 2025  
**Author:** OpenCode Research Assistant  
**Status:** Active compilation - resources verified where possible

---

## Overview

This document compiles resources about the adoption and use of Apache Arrow, Parquet file format, and DuckDB in official statistics agencies, research data centres (Forschungsdatenzentren/FDZ), and government data analysis contexts. These modern data tools are increasingly relevant for processing large-scale microdata in statistical production and research environments.

---

## 1. Research Data Centres (Forschungsdatenzentren)

### Deutsche Bundesbank - Research Data and Service Centre (RDSC)

The Bundesbank's RDSC provides standardised access to microdata for independent scientific research projects. Their methodology reports offer insights into efficient data handling practices.

| Resource | Description | URL |
|----------|-------------|-----|
| **Working with Large Data at the RDSC** | Technical Report 2021-04 by Matthias Gomolka, Jannick Blaschke, Christian Hirsch. Covers efficient data handling methodologies for large-scale microdata. | [Methodology Reports](https://www.bundesbank.de/en/bundesbank/research/rdsc/publications/methodology-reports) |
| **RDSC Main Portal** | Access to research data, project information, and INEXDA network participation | [RDSC Homepage](https://www.bundesbank.de/en/bundesbank/research/rdsc) |
| **RDSC Data Reports** | Documentation for microdata on banks, securities, enterprises and households | [Data Reports](https://www.bundesbank.de/en/bundesbank/research/rdsc/publications/data-reports) |
| **RDSC Newsletter** | Updates on data availability and methodological developments | [Newsletter Subscription](https://www.bundesbank.de/dynamic/action/en/service/newsletter/-/809638/rdsc) |

### German Statistical Offices - Research Data Centre (FDZ)

The Research Data Centre of the Federal Statistical Office and the statistical offices of the Länder provides access to official German microdata.

| Resource | Description | URL |
|----------|-------------|-----|
| **FDZ Main Portal** | Central access point for German official statistics microdata | [forschungsdatenzentrum.de](https://www.forschungsdatenzentrum.de/en) |
| **Scientific Use Files** | Information on accessing microdata for research | [Scientific Use Files](https://www.forschungsdatenzentrum.de/en/scientific-use-files) |
| **Remote Access** | Remote Scientific Use File procedures | [Remote Access](https://www.forschungsdatenzentrum.de/en/remote-scientific-use-files) |

### German Federal Statistical Office (Destatis)

| Resource | Description | URL |
|----------|-------------|-----|
| **Open Data Portal** | API/web services and data access options | [Open Data](https://www.destatis.de/EN/Service/OpenData/_node.html) |
| **GENESIS-Online API** | Programmatic access to statistical data | [API Documentation](https://www.destatis.de/EN/Service/OpenData/api-webservice.html) |

---

## 2. CRAN Task View: Official Statistics & Survey Statistics

The CRAN Task View for Official Statistics provides a comprehensive overview of R packages used in official statistics production. While not explicitly mentioning Arrow/Parquet, it documents the R ecosystem for survey statistics.

| Resource | Description | URL |
|----------|-------------|-----|
| **Official Statistics Task View** | Comprehensive list of R packages for official statistics production aligned with GSBPM | [CRAN Task View](https://cran.r-project.org/web/views/OfficialStatistics.html) |

**Key Categories Covered:**
- Sampling methods (sampling, pps, BalancedSampling)
- Weighting and calibration (survey, svrep)
- Data editing and imputation (validate, VIM, simputation)
- Statistical disclosure control (sdcMicro, sdcTable)
- Small area estimation (sae, emdi)
- Access to official statistics data (eurostat, restatis, ipumsr)

**Maintainers:** Matthias Templ, Alexander Kowarik, Tobias Schoch

---

## 3. Apache Arrow Official Resources

### Core Documentation

| Resource | Description | URL |
|----------|-------------|-----|
| **Apache Arrow Main Site** | Official project website with documentation and downloads | [arrow.apache.org](https://arrow.apache.org/) |
| **Arrow R Package** | CRAN documentation for the R Arrow package | [CRAN arrow](https://cran.r-project.org/package=arrow) |
| **Arrow R Documentation** | Comprehensive R-specific documentation | [Arrow R Docs](https://arrow.apache.org/docs/r/) |
| **Arrow Cookbook (R)** | Practical recipes for R users | [R Cookbook](https://arrow.apache.org/cookbook/r/) |
| **Arrow Blog** | Project news and release announcements | [Arrow Blog](https://arrow.apache.org/blog/) |

### Key Arrow Blog Posts for Official Statistics Context

| Post | Date | Relevance |
|------|------|-----------|
| **DuckDB quacks Arrow** | Dec 2021 | Zero-copy data integration between DuckDB and Arrow | [Link](https://arrow.apache.org/blog/2021/12/03/arrow-duckdb/) |
| **Apache Arrow R 6.0.0 Release** | Nov 2021 | Major R package release with dplyr support | [Link](https://arrow.apache.org/blog/2021/11/08/r-6.0.0/) |
| **Arrow Flight SQL** | Feb 2022 | Database access protocol using Arrow | [Link](https://arrow.apache.org/blog/2022/02/16/introducing-arrow-flight-sql/) |
| **How Arrow Format Accelerates Query Transfer** | Jan 2025 | Technical deep-dive on Arrow performance | [Link](https://arrow.apache.org/blog/2025/01/10/arrow-result-transfer/) |

---

## 4. DuckDB Resources

DuckDB is an embedded analytical database that integrates seamlessly with Arrow and Parquet, making it highly relevant for statistical data processing.

| Resource | Description | URL |
|----------|-------------|-----|
| **DuckDB Main Site** | In-process SQL OLAP database management system | [duckdb.org](https://duckdb.org/) |
| **Why DuckDB** | Design philosophy and key characteristics | [Why DuckDB](https://duckdb.org/why_duckdb) |
| **DuckDB R Package** | CRAN package for R integration | [CRAN duckdb](https://cran.r-project.org/package=duckdb) |
| **DuckDB Documentation** | Comprehensive user documentation | [DuckDB Docs](https://duckdb.org/docs/) |
| **DuckDB Blog** | Engineering blog with technical articles | [DuckDB Blog](https://duckdb.org/news/) |

### DuckDB Key Features for Official Statistics

- **Embedded operation**: No server installation required
- **Parquet native support**: Direct querying of Parquet files
- **Arrow integration**: Zero-copy data exchange with Arrow
- **SQL compliance**: Familiar SQL interface for statisticians
- **Large dataset handling**: Efficient out-of-core processing

---

## 5. Tutorials and Workshops

### R-Focused Workshops

| Resource | Description | URL |
|----------|-------------|-----|
| **Larger-Than-Memory Data Workflows with Apache Arrow** | UseR! 2022 workshop by Danielle Navarro and Stephanie Hazlitt | [Workshop Materials](https://arrow-user2022.netlify.app/) |
| **Bigger Data with Arrow and DuckDB** | Presentation slides by Tom Mock & Edgar Ruiz | [Slides](https://jthomasmock.github.io/bigger-data/#1) |
| **awesome-arrow-r** | Comprehensive R-focused Arrow resources by Nic Crane | [GitHub](https://github.com/thisisnic/awesome-arrow-r) |

### Videos and Presentations

| Resource | Description | URL |
|----------|-------------|-----|
| **Doing More with Data: Arrow for R Users** | Video by Danielle Navarro | [YouTube](https://www.youtube.com/watch?v=O42LUmJZPx0) |
| **Efficient Data Analysis with DuckDB and Arrow** | Video by Tom Mock | [YouTube](https://www.youtube.com/watch?v=LvTX1ZAZy6M) |
| **New Directions for Apache Arrow** | Video by Wes McKinney | [YouTube](https://www.youtube.com/watch?v=u7DecbDw3QE) |

---

## 6. International Statistical Organizations

### R Packages for Accessing Official Statistics

| Package | Data Source | URL |
|---------|-------------|-----|
| **eurostat** | Eurostat data access | [CRAN](https://cran.r-project.org/package=eurostat) |
| **restatis** | German Federal Statistical System (GENESIS) | [CRAN](https://cran.r-project.org/package=restatis) |
| **OECD** | OECD data extraction | [CRAN](https://cran.r-project.org/package=OECD) |
| **Rilostat** | ILO statistical database | [CRAN](https://cran.r-project.org/package=Rilostat) |
| **rsdmx** | SDMX web services (multiple NSOs) | [CRAN](https://cran.r-project.org/package=rsdmx) |
| **pxweb** | PX-Web API (Nordic NSOs) | [CRAN](https://cran.r-project.org/package=pxweb) |
| **cbsodataR** | Statistics Netherlands (CBS) | [CRAN](https://cran.r-project.org/package=cbsodataR) |
| **ipumsr** | IPUMS census/survey data | [CRAN](https://cran.r-project.org/package=ipumsr) |

---

## 7. Related Tools for Official Statistics Production

### Data Processing and Validation

| Tool | Description | URL |
|------|-------------|-----|
| **validate** | Rule management and data validation | [CRAN](https://cran.r-project.org/package=validate) |
| **sdcMicro** | Statistical disclosure control for microdata | [CRAN](https://cran.r-project.org/package=sdcMicro) |
| **sdcTable** | Confidentiality protection for tabular data | [CRAN](https://cran.r-project.org/package=sdcTable) |
| **VIM** | Visualization and imputation of missing values | [CRAN](https://cran.r-project.org/package=VIM) |
| **survey** | Complex survey analysis | [CRAN](https://cran.r-project.org/package=survey) |

### Modern Data Infrastructure

| Tool | Description | URL |
|------|-------------|-----|
| **polars** | Fast DataFrame library built on Arrow | [polars.rs](https://www.pola.rs/) |
| **DataFusion** | Extensible query execution framework | [datafusion.apache.org](https://datafusion.apache.org/) |

---

## 8. Best Practices and Use Cases

### Why Arrow/Parquet/DuckDB for Official Statistics?

1. **Memory Efficiency**: Arrow's columnar format allows processing of larger-than-memory datasets
2. **Interoperability**: Seamless data exchange between R, Python, and other tools
3. **Performance**: Significant speed improvements over traditional CSV workflows
4. **Reproducibility**: Parquet files preserve data types and metadata
5. **Security**: Compatible with secure data environments (no external server required)

### Typical Use Cases in Research Data Centres

- **Large survey data processing**: Census, labour force surveys, household panels
- **Administrative data linking**: Tax records, business registers, health data
- **Multi-file dataset management**: Partitioned data storage and efficient querying
- **Reproducible research workflows**: Consistent data formats across projects

---

## 9. R Package Integration

### Key R Packages Using Arrow/Parquet

```r
# Core packages for modern data workflows
library(arrow)        # Apache Arrow R bindings
library(duckdb)       # DuckDB R interface
library(dplyr)        # Data manipulation (Arrow-compatible)

# Example: Reading partitioned Parquet data
ds <- open_dataset("path/to/partitioned/data", format = "parquet")
result <- ds |>
  filter(year >= 2020) |>
  group_by(region) |>
  summarise(total = sum(value)) |>
  collect()

# Example: DuckDB with Arrow
con <- dbConnect(duckdb::duckdb())
duckdb::duckdb_register_arrow(con, "my_data", arrow_table)
result <- dbGetQuery(con, "SELECT * FROM my_data WHERE x > 100")
```

---

## 10. Future Developments

### Emerging Trends

- **Cloud-native storage**: Arrow/Parquet integration with cloud object storage
- **Streaming analytics**: Arrow Flight for real-time data exchange
- **GPU acceleration**: RAPIDS cuDF for GPU-accelerated Arrow processing
- **Federated queries**: Cross-system querying with Arrow as interchange format

### Community Resources

| Resource | Description | URL |
|----------|-------------|-----|
| **Apache Arrow GitHub** | Main development repository | [GitHub](https://github.com/apache/arrow) |
| **DuckDB Discussions** | Community Q&A and feature requests | [GitHub Discussions](https://github.com/duckdb/duckdb/discussions) |
| **r-dbi/DBI** | Database interface for R | [GitHub](https://github.com/r-dbi/DBI) |

---

## References and Further Reading

1. Gomolka, M., Blaschke, J., & Hirsch, C. (2021). *Working with Large Data at the RDSC*. Deutsche Bundesbank Technical Report 2021-04.

2. McKinney, W. (2022). *Apache Arrow: A Cross-Language Development Platform for In-Memory Analytics*. Apache Arrow Documentation.

3. Raasveldt, M., & Mühleisen, H. (2019). *DuckDB: An Embeddable Analytical Database*. SIGMOD 2019.

4. Templ, M., Kowarik, A., & Schoch, T. (2025). *CRAN Task View: Official Statistics & Survey Statistics*. CRAN.

---

## Notes on Adoption

While direct public documentation of Arrow/Parquet/DuckDB adoption by national statistical offices is limited (many internal implementations are not publicly documented), the tools are increasingly mentioned in:

- Academic papers using FDZ/RDSC data
- Conference presentations at statistical computing events
- Training materials for research data centre users
- Open-source statistical production pipelines

**Key Observation**: The combination of Arrow + Parquet + DuckDB represents a modern, efficient stack for statistical data processing that addresses many challenges faced by official statistics producers, particularly for:
- Processing large microdata files
- Enabling reproducible research workflows
- Facilitating secure data access environments
- Supporting multi-language statistical computing (R, Python, etc.)

---

*Last updated: November 24, 2025*
