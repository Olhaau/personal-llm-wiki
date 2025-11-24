# Linkage Methodology (Zusammenführung)

> **Paper**: Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken  
> **Chunk**: 3 of 6 | **Section**: Zusammenführung der Unternehmenssteuerstatistiken  
> **Source**: [business-tax-panel-042023-article.pdf](../../../raw/pdf/business-tax-panel-042023-article.pdf) (pp. 4-6)

---

## Overview

The Business-Tax-Panel uses **Record Linkage** methodology - matching identical units via shared identifiers, in contrast to "Statistical Matching" which matches similar but not necessarily identical units.

## Evolution from Predecessor

The methodology builds on the FDZ product **GKUPV** ("Integrierte Datengrundlage aus Gewerbe-, Körperschaft- und Umsatzsteuerstatistik...") available for years 2007, 2010, and 2016.

### Key Improvements Over GKUPV
| GKUPV (Previous) | Business-Tax-Panel (New) |
|------------------|--------------------------|
| Fixed matching sequence | Flexible multi-identifier matching |
| Cross-sectional only | Longitudinal panel structure |
| Limited identifiers | Additional identifiers (commercial register) |
| Basic variables | Extended variable set from EÜR |
| Limited business register | Enhanced business register integration |

## Three-Step Linkage Process

### Step 1: Tax Number-Based Linkage

**Within Tax Type Groups:**
1. VAT statistics (Voranmeldung + Veranlagung) linked via current and old tax numbers
2. Income taxes (Gewerbesteuer + Körperschaftsteuer) linked via current and old tax numbers
3. Partnership statistics linked

**Across Tax Type Groups:**
- Combined via all possible tax number combinations
- **Result**: ~50,000 additional annual matches between VAT advance returns and VAT assessments

**Business Register Integration:**
1. Current tax number used to link statistical business register to VAT advance returns
2. Then linked to VAT assessments
3. Duplicate tax numbers cleaned using: founding/closure dates, taxable turnover, fiscal unity status
4. Units only in business register (not in VAT statistics) are excluded

**Income-Expense Statement:**
- Linked via current tax number to merged statistics

```
Linkage Flow:
┌─────────────────────┐     ┌─────────────────────┐
│ Umsatzsteuer-       │────▶│ Umsatzsteuer-       │
│ Voranmeldung        │     │ Veranlagung         │
└─────────────────────┘     └─────────────────────┘
         │                           │
         ▼                           ▼
┌─────────────────────────────────────────────────┐
│            Statistisches Unternehmensregister   │
└─────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────┐
│  Körperschaftsteuer + Gewerbesteuer +           │
│  Personengesellschaften                         │
└─────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────┐
│         Einnahmenüberschussrechnung             │
└─────────────────────────────────────────────────┘
```

### Step 2: Commercial Register and Manual Verification

**Commercial Register (Handelsregistereintragungen):**
- Type, number, and postal code of company
- Not unique across all federal states
- Entries not validated
- Must combine with structural variables for reliable matching

**Matching Criteria:**
- Commercial register entries must match AND
- Structural variables (legal form, economic activity, municipality code) must match

**Manual Verification:**
- High-turnover entities manually checked and assigned
- **Result**: ~3,000 additional annual matches

**Quality Trend:**
- Commercial register data quality improves over time
- More matches possible in recent years
- Future improvements expected with additional identifiers

### Step 3: Cluster Tax Numbers and Longitudinal Linkage

**Problem:** Tax number changes are not recorded simultaneously across all statistics.

**Solution: Cluster Tax Number**
- Combines all tax numbers for an entity in a given year
- If changes occur earlier in one statistic than another, intermediate years are included

**Example:**
| Year | VAT Current | VAT Old | Trade Tax Current | Trade Tax Old | Cluster |
|------|-------------|---------|-------------------|---------------|---------|
| T1 | 995 | - | 110 | 995 | 110#995 |
| T2 | 995 | - | - | - | 995#_ |
| T3 | 110 | - | - | - | 110#_ |
| T4 | 110 | 995 | 110 | 995 | 110#995 |

**Result**: ~6,000 additional annual matches

**Longitudinal Linkage:**
- Cluster tax numbers enable tracking over time
- **Limitation**: Tax offices may reassign numbers after 3 years
- Current implementation limited to 3-year window

**Note on VAT Panel methodology:**
The VAT Panel (Umsatzsteuerpanel) additionally uses:
- VAT identification number (USt-IdNr)
- Company number (Unternehmensnummer)

These additional identifiers are **not yet implemented** in the Business-Tax-Panel.

### Final Step: Variable Selection

- Selected variables from underlying statistics based on:
  - Former publication series content
  - Previous research requests
- Structural variables concatenated (separate value per source statistic)
- Indicator variable shows which statistics contain each observation
- Combined structural variables created for VAT and income tax groups
- **Additional variables can be added on request**

## Quality Improvements Summary

| Step | Annual Additional Matches |
|------|---------------------------|
| Step 1: Improved tax number combinations | ~50,000 |
| Step 2: Commercial register + manual | ~3,000 |
| Step 3: Cluster tax numbers | ~6,000 |

## Key Points

- Record Linkage (exact matching) rather than Statistical Matching
- Three-step progressive matching with increasing complexity
- Cluster tax numbers solve asynchronous identifier changes
- Manual verification for high-value entities ensures quality
- Future improvements planned with additional identifiers
- Variable selection is not final - extensions possible on request

---

## Related Chunks
- Previous: [02_data_sources.md](./02_data_sources.md) - Data Sources
- Next: [04_panel_description.md](./04_panel_description.md) - Panel Description

---
*Index: [00_index.md](./00_index.md) | Paper: Business-Tax-Panel - Zusammenführung von Unternehmenssteuerstatistiken*
