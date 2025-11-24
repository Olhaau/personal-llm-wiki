# Data Sources (Datengrundlage)

> **Paper**: Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken  
> **Chunk**: 2 of 6 | **Section**: Datengrundlage  
> **Source**: [business-tax-panel-042023-article.pdf](../../../raw/pdf/business-tax-panel-042023-article.pdf) (pp. 2-4)

---

## Overview

The Business-Tax-Panel integrates five tax statistics, supplemented by the income-expense statement (Einnahmenüberschussrechnung) and the statistical business register. All tax statistics are **complete enumerations** (Vollerhebungen), not samples.

## Data Collection Process

1. Tax data is reported to local tax offices (Finanzämter)
2. Transmitted via state tax authority computing centers to State Statistical Offices
3. After plausibility and duplicate checks, forwarded to Federal Statistical Office
4. Published at federal level

## Tax Statistics Included

### 1. Gewerbesteuerstatistik (Trade Tax Statistics)
**EVAS-Nr. 73511**

| Attribute | Value |
|-----------|-------|
| **Coverage** | All trade tax payers in Germany |
| **Entities** | Permanent businesses, market traders, itinerant traders |
| **Frequency** | Annual since 2011 (previously triennial 1995-2010) |
| **Key Variables** | Tax assessment amount, trade income, profit/loss, additions, reductions, exemptions, municipal tax rate |
| **Note** | For apportionment cases (Zerlegungsfälle), municipal tax rates are only available as rounded values |

### 2. Körperschaftsteuerstatistik (Corporate Income Tax Statistics)
**EVAS-Nr. 73211**

| Attribute | Value |
|-----------|-------|
| **Coverage** | All corporations, associations, and estates |
| **Tax Liability Types** | Unlimited, limited, or exempt from corporate income tax |
| **Frequency** | Annual since 2014 (previously triennial 1992-2013) |
| **Key Variables** | Corporate tax liability, income, taxable income, loss deductions, special incentives |
| **Basis** | Assessment procedure data (Festsetzungsverfahren) |

### 3. Statistik über Personengesellschaften und Gemeinschaften (Partnership Statistics)
**EVAS-Nr. 73121**

| Attribute | Value |
|-----------|-------|
| **Coverage** | All partnerships and communities with "unified and separate determination of tax bases" |
| **Frequency** | Annual since 2008 (previously triennial 1992-2007) |
| **Key Variables** | Types of income, trade tax assessment amount, number and type of partners, tonnage taxation for international shipping |
| **Note** | Income is determined at partnership level but taxed at partner level |

### 4. Umsatzsteuerstatistik-Voranmeldungen (VAT Advance Returns)
**EVAS-Nr. 73311**

| Attribute | Value |
|-----------|-------|
| **Coverage** | VAT-liable businesses that filed advance returns above threshold |
| **Frequency** | Annual since 1996 |
| **Threshold** | EUR 17,500 (2007-2019), EUR 22,000 (since 2020) |
| **Key Variables** | Taxable turnover, supplies at full/reduced rates, intra-EU acquisitions, tax-free supplies, §13b supplies, deductible input VAT |

### 5. Umsatzsteuerstatistik-Veranlagungen (VAT Assessments)
**EVAS-Nr. 73321**

| Attribute | Value |
|-----------|-------|
| **Coverage** | All VAT-liable businesses that filed annual returns |
| **Includes** | Small businesses (Kleinunternehmer) below the advance return threshold |
| **Frequency** | Annual since 2006 |
| **Key Variables** | Same as advance returns plus: input VAT corrections, detailed intra-EU acquisitions, triangular transactions, tax-free turnover details |

## Supplementary Data Sources

### Einnahmenüberschussrechnung (Income-Expense Statement)
**EVAS-Nr. 73111**

| Attribute | Value |
|-----------|-------|
| **Coverage** | Businesses not required to prepare balance sheets (simplified accounting) |
| **Frequency** | Annual since 2013 |
| **Key Variables** | Operating income and expenses with subcategories |
| **Note** | Simplified alternative to double-entry bookkeeping |

### Statistisches Unternehmensregister (Statistical Business Register)
**EVAS-Nr. 52111**

| Attribute | Value |
|-----------|-------|
| **Coverage** | All entities with a German address |
| **Frequency** | Annual snapshots since 2002 |
| **Key Variables** | Employees (subject to social insurance), turnover, business demographics (founding/closure dates) |
| **Unit Type Used** | Legal unit (Rechtliche Einheit) - smallest legal entity maintaining books |

## Structural Variables (Ordnungsmerkmale)

Available from all statistics:
- **Rechtsform** (Legal form)
- **Wirtschaftszweig** (Economic activity classification)
- **Amtlicher Gemeindeschlüssel** (Official municipality code)
- **Organschaftsverhältnisse** (Fiscal unity information)

## Fiscal Unity (Organschaft) Concepts

### Ertragsteuerliche Organschaft (Income Tax Fiscal Unity)
- Based on explicit profit transfer agreement
- Subsidiary results attributed to parent for taxation
- Only parent files trade tax return
- Subsidiary treated as branch of parent
- **Both parent and subsidiaries file corporate tax returns** (separate entities)

### Umsatzsteuerliche Organschaft (VAT Fiscal Unity)
- Arises automatically when criteria are met
- Parent represents the VAT-liable enterprise
- Subsidiaries are non-independent parts
- **Only parent files VAT returns**
- Parent's classification applies to entire group

## Panel Start Year Rationale

The panel begins in **2013** because:
- All included statistics became available as annual federal statistics by this year
- Earlier years: Ertragsteuern only available triennially
- End year 2018: Assessment period of 3.5 years (except VAT advance returns)

## Key Points

- All underlying statistics are complete enumerations, not samples
- Data originates from tax authority administrative records (secondary statistics)
- Legal form, economic activity, and location available from multiple sources
- Fiscal unity treatment differs between income tax and VAT contexts
- Variables selected based on former publication series and research requests

---

## Related Chunks
- Previous: [01_summary.md](./01_summary.md) - Summary
- Next: [03_methodology.md](./03_methodology.md) - Linkage Methodology

---
*Index: [00_index.md](./00_index.md) | Paper: Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken*
