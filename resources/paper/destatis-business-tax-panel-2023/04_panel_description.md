# Panel Description and Descriptive Statistics

> **Paper**: Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken  
> **Chunk**: 4 of 6 | **Section**: Business-Tax-Panel (4.1 Beschreibung, 4.2 Deskriptive Einblicke)  
> **Source**: [business-tax-panel-042023-article.pdf](../../../raw/pdf/business-tax-panel-042023-article.pdf) (pp. 6-9)

---

## Panel Structure

### Basic Characteristics

| Attribute | Value |
|-----------|-------|
| **Panel Type** | Unbalanced |
| **Time Period** | 2013-2018 |
| **Total Observations** | >50 million |
| **Annual Average** | ~9 million |
| **Variables Available** | >2,000 |

### Unbalanced Nature
Units may not appear in every year due to:
- Business closures
- New establishments
- Different threshold limits between statistics
- Legal form restrictions (e.g., corporations vs. partnerships)

### Data Completeness
- **50%** of observations: Information from 3+ statistics
- **33%** of observations: Information from 4+ statistics
- All underlying statistics (GewSt, KSt, UStVA, UStV, PersGes, EÜR) fully available
- Both single-statistic and cross-statistic analyses possible

## Coverage by Legal Form (2018)

| Legal Form Group | Total Units | Linked Units | Rate |
|------------------|-------------|--------------|------|
| **Kapitalgesellschaften** (Corporations, cooperatives, mutual insurance associations) | 1,379,448 | 936,337 | **67.9%** |
| **Personengesellschaften** (Partnerships) | 1,505,087 | 759,635 | 50.5% |
| **Einzelunternehmen** (Sole proprietorships) | 7,297,452 | 3,086,437 | 42.3% |
| **Übrige jur. Personen** (Other legal entities) | 175,318 | 46,650 | 26.6% |
| **Total** | 10,357,305 | 4,829,059 | 46.6% |

*"Linked" = units with VAT assessment data AND either corporate tax, income-expense statement, or partnership statistics*

## Turnover Coverage Analysis

### For Corporations (2013-2018)
The linked entities represent the vast majority of economic activity:

| Year | Turnover Coverage |
|------|-------------------|
| 2013 | 94.4% |
| 2014 | 94.2% |
| 2015 | 93.9% |
| 2016 | 93.9% |
| 2017 | 93.7% |
| 2018 | 93.4% |

**Pattern**: Despite linking only ~68% of corporations by count, they represent 93-94% of total turnover.

### For Partnerships (2013-2018)
| Year | Turnover Coverage |
|------|-------------------|
| 2013 | 95.3% |
| 2014 | 95.3% |
| 2015 | 94.8% |
| 2016 | 94.5% |
| 2017 | 92.8% |
| 2018 | 94.5% |

## Corporation Detailed Coverage (2018)

**Hierarchical Coverage Analysis:**

| Coverage Level | Rate | Base Count |
|----------------|------|------------|
| In Trade Tax and/or Corporate Tax Statistics | 100% | 1,252,871 |
| Linked between Trade Tax and Corporate Tax | 94.2% | - |
| Linked with Business Register | 52.5% | - |
| With employees, balance sheet profit/loss, and business profit/loss | 36.5% | - |

*Excluding fiscal unity subsidiaries (Organgesellschaften)*

## Key Tax Metrics Coverage (Corporations, 2018)

| Tax Metric | Coverage Rate |
|------------|---------------|
| Gewinn aus Gewerbebetrieb (Business Profit) | 64.5% |
| Verlust aus Gewerbebetrieb (Business Loss) | 56.6% |
| Abgerundeter Gewerbeertrag (Rounded Trade Income) | 69.5% |
| Gewerbesteuer (Trade Tax) | 67.4% |
| Bilanzgewinn (Balance Sheet Profit) | 71.6% |
| Bilanzverlust (Balance Sheet Loss) | 64.6% |
| Festgesetzte KSt + SolZ (Corporate Tax + Solidarity Surcharge) | 56.6% |

*Coverage = linked entities' share of total value for that metric*

## Variable Selection Approach

### Selection Criteria
Variables selected based on:
1. Content of former publication series (Fachserien/Statistische Berichte)
2. Previous research and policy requests

### Structural Variables Handling
- Concatenated across statistics (each source's value preserved)
- Indicator variable shows which statistics contain each observation
- Combined variables created for:
  - VAT statistics group
  - Income tax statistics group
- Note: Fiscal unity structures may cause divergent values across sources

### Extensibility
**Selection is not final** - additional variables from underlying statistics can be added on request.

## Limitations

### Business Register Linkage
- Only contains tax numbers from VAT advance returns
- Units only in Trade Tax and/or Corporate Tax (not in VAT) are not linked to business register
- Full business register linkage requires separate request (AFiD-Panel Unternehmensregister)

### Fiscal Unity Coverage
- Corporate tax statistics capture both parents and subsidiaries
- VAT statistics only capture the fiscal unity parent
- For VAT fiscal unity analysis, use business register information

## Key Points

- Unbalanced panel with comprehensive coverage for economically significant units
- ~68% of corporations linked by count, but 93%+ of turnover covered
- Variable selection based on practical research needs
- Additional variables available on request
- Fiscal unity treatment differs between income tax and VAT contexts
- Business register linkage has known limitations

---

## Related Chunks
- Previous: [03_methodology.md](./03_methodology.md) - Linkage Methodology
- Next: [05_research_applications.md](./05_research_applications.md) - Research Applications

---
*Index: [00_index.md](./00_index.md) | Paper: Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken*
