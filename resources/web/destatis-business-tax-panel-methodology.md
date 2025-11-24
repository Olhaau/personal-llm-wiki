# Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken

> **Full Curated Version**: See [resources/paper/destatis-business-tax-panel-2023/](../paper/destatis-business-tax-panel-2023/00_index.md) for chunked knowledge articles.

## Metadata

| Field | Value |
|-------|-------|
| **Title** | Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken |
| **English Title** | Business Tax Panel - Merging Corporate Tax Statistics |
| **Author** | Annette Kristiansen |
| **Institution** | Statistisches Bundesamt (DESTATIS) |
| **Publication** | WISTA - Wirtschaft und Statistik, 4/2023 |
| **Published** | 2023-08-15 |
| **Pages** | 15 |
| **Language** | German |
| **URL** | https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/2023/04/business-tax-panel-042023.html |
| **PDF** | https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/2023/04/business-tax-panel-042023.pdf?__blob=publicationFile |
| **Local PDF** | [raw/pdf/business-tax-panel-042023-article.pdf](../../raw/pdf/business-tax-panel-042023-article.pdf) |

## Summary

The **Business-Tax-Panel** is a longitudinal microdata linkage project by the German Federal Statistical Office (DESTATIS) that combines corporate tax statistics (Ertragsteuerstatistiken) with VAT statistics (Umsatzsteuerstatistiken) for the same business entities over time. This panel strengthens empirical tax research with official corporate tax data and creates diverse analytical opportunities for academia and policy research.

### Core Achievement
- **First comprehensive longitudinal panel** of German corporate tax statistics
- Enables both cross-sectional and longitudinal research designs
- Links 5 tax statistics for ~50 million observations (2013-2018)

### Panel Specifications

| Characteristic | Value |
|----------------|-------|
| Time Period | 2013-2018 |
| Total Observations | >50 million |
| Annual Average | ~9 million |
| Variables | >2,000 |
| Panel Type | Unbalanced |

## Data Sources Integrated

### Primary Tax Statistics
1. **Gewerbesteuerstatistik** (EVAS 73511) - Trade Tax Statistics
2. **Körperschaftsteuerstatistik** (EVAS 73211) - Corporate Income Tax Statistics
3. **Statistik über Personengesellschaften und Gemeinschaften** (EVAS 73121) - Partnership Statistics
4. **Umsatzsteuerstatistik-Voranmeldungen** (EVAS 73311) - VAT Advance Returns
5. **Umsatzsteuerstatistik-Veranlagungen** (EVAS 73321) - VAT Assessments

### Supplementary Sources
6. **Einnahmenüberschussrechnung** (EVAS 73111) - Income-Expense Statement
7. **Statistisches Unternehmensregister** (EVAS 52111) - Statistical Business Register

All tax statistics are **complete enumerations** (Vollerhebungen), not samples.

## Linkage Methodology

The panel uses **Record Linkage** (exact matching via identifiers) in three steps:

### Step 1: Tax Number-Based Linkage
- Link VAT statistics (advance + assessment) via current/old tax numbers
- Link income taxes (trade + corporate) via current/old tax numbers
- Cross-link via all tax number combinations
- Integrate business register and income-expense statement
- **Result**: ~50,000 additional annual matches

### Step 2: Commercial Register + Manual Verification
- Use commercial register entries with structural variables
- Manual verification for high-turnover entities
- **Result**: ~3,000 additional annual matches

### Step 3: Cluster Tax Numbers + Longitudinal Linkage
- Create cluster tax numbers combining all identifiers per entity/year
- Bridge asynchronous identifier changes across statistics
- Enable entity tracking over time (3-year window)
- **Result**: ~6,000 additional annual matches

## Coverage Statistics (2018)

| Legal Form | Total Units | Linked Units | Rate | Turnover Coverage |
|------------|-------------|--------------|------|-------------------|
| Kapitalgesellschaften | 1,379,448 | 936,337 | 67.9% | 93-94% |
| Personengesellschaften | 1,505,087 | 759,635 | 50.5% | 92-95% |
| Einzelunternehmen | 7,297,452 | 3,086,437 | 42.3% | - |
| Übrige jur. Personen | 175,318 | 46,650 | 26.6% | - |
| **Total** | **10,357,305** | **4,829,059** | **46.6%** | - |

**Key insight**: Despite linking only ~68% of corporations by count, linked entities represent **93-94% of total turnover**.

## Research Applications

### Enabled Analyses
- **Single-statistic longitudinal**: Tax type development over time
- **Cross-statistic**: Relationships between different tax types
- **Policy evaluation**: Effects of tax law changes
- **Tax burden**: Comprehensive corporate tax burden calculations
- **Fiscal unity**: Analysis of Organkreise (income tax and VAT)

### Linkage with Business Statistics
The panel can be linked with:
- AFiD-Panel Unternehmensstrukturstatistiken (SBS-Panel)
- Cost structure surveys
- Investment surveys
- Production and environmental statistics

**Legal restriction**: Partnership statistics and income-expense statement cannot be linked to business statistics.

## Data Access

### Forschungsdatenzentrum (FDZ)
Access through the German Research Data Centers:

| Resource | URL |
|----------|-----|
| FDZ Tax Statistics | https://www.forschungsdatenzentrum.de/de/steuern |
| FDZ Main Site | https://www.forschungsdatenzentrum.de |
| DESTATIS Methods | https://www.destatis.de/DE/Methoden/_inhalt.html |

### Access Requirements
- Scientific research purpose
- Application through FDZ
- On-site or remote data access
- Data use agreement

## Future Developments

| Planned Enhancement | Expected Impact |
|--------------------|-----------------|
| Regular updates | Current data availability |
| Forschungszulage integration | R&D tax credit analysis |
| E-Bilanz (electronic balance sheet) | **Substantial information gain** |
| Historical extension | Pre-2013 data (requires additional work) |

## Legal Framework

**Steuerstatistikgesetz (StStatG)**:
- **§ 7a Abs. 1**: Permits linking tax statistics for scientific analysis
- **§ 7a Abs. 2**: Allows longitudinal studies of linked datasets

## Context: NeSt Network

The Business-Tax-Panel was developed in the context of the **Netzwerk empirische Steuerforschung (NeSt)**:
- Founded July 2023
- Connects academia, tax administration, and official statistics
- Supported by Federal Ministry of Finance
- Mission Statement signed by Finance Minister Christian Lindner

## Chunked Knowledge Articles

For detailed, context-optimized content, see the paper directory:

| Chunk | Topic | File |
|-------|-------|------|
| 1 | Executive Summary | [01_summary.md](../paper/destatis-business-tax-panel-2023/01_summary.md) |
| 2 | Data Sources | [02_data_sources.md](../paper/destatis-business-tax-panel-2023/02_data_sources.md) |
| 3 | Linkage Methodology | [03_methodology.md](../paper/destatis-business-tax-panel-2023/03_methodology.md) |
| 4 | Panel Description | [04_panel_description.md](../paper/destatis-business-tax-panel-2023/04_panel_description.md) |
| 5 | Research Applications | [05_research_applications.md](../paper/destatis-business-tax-panel-2023/05_research_applications.md) |
| 6 | Conclusion & Outlook | [06_conclusion.md](../paper/destatis-business-tax-panel-2023/06_conclusion.md) |

## Citation

```bibtex
@article{kristiansen2023btp,
  author = {Kristiansen, Annette},
  title = {Business-Tax-Panel -- Zusammenführung von Unternehmenssteuerstatistiken},
  journal = {WISTA -- Wirtschaft und Statistik},
  year = {2023},
  volume = {4},
  pages = {1--15},
  publisher = {Statistisches Bundesamt},
  url = {https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/2023/04/business-tax-panel-042023.html}
}
```

## Key Terms (German-English)

| German | English |
|--------|---------|
| Ertragsteuerstatistik | Income tax statistics |
| Umsatzsteuerstatistik | VAT statistics |
| Unternehmenssteuer | Corporate tax |
| Gewerbesteuer | Trade tax |
| Körperschaftsteuer | Corporate income tax |
| Erhebungseinheit | Survey unit / statistical unit |
| Zusammenführung | Linkage / merging |
| Zeitverlauf | Over time / longitudinal |
| Forschungsdatenzentrum | Research Data Center |
| Organschaft | Fiscal unity / tax group |
| Steuernummer | Tax identification number |
| Vollerhebung | Complete enumeration / census |

## Related Resources

### Local Knowledge Articles
- [NeSt Netzwerk](bmf-nest-netzwerk-empirische-steuerforschung.md) - Network for empirical tax research
- [NeSt Webinare](bmf-nest-webinare-empirische-steuerforschung.md) - Webinar series on tax research
- [Bundesbank RDSC Large Data Methodology](bundesbank-rdsc-large-data-methodology.md) - Related approaches for large administrative data

### External Resources
- [WISTA Archive](https://www.destatis.de/SiteGlobals/Forms/Suche/WiSta/DE/WiStaSuche_Formular.html) - DESTATIS scientific journal archive
- [FDZ Tax Statistics](https://www.forschungsdatenzentrum.de/de/steuern) - Research data center tax data overview
- [NeSt Network (BMF)](https://www.bundesfinanzministerium.de/NeSt) - Official NeSt page

## Tags

#tax-research #germany #destatis #panel-data #corporate-tax #vat #longitudinal #fdz #official-statistics #methodology #wista #data-linkage #nest #microdata #record-linkage #gewerbesteuer #körperschaftsteuer #umsatzsteuer
