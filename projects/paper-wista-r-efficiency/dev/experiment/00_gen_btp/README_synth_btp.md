# Synthetic Business-Tax-Panel (BTP) Generator

A comprehensive R function to generate realistic synthetic panel data that mimics the structure and characteristics of the German Business-Tax-Panel (BTP) 2013-2019.

## Overview

The Business-Tax-Panel (Unternehmenssteuer-Panel) integrates 7 official German tax statistics with the enterprise register (Unternehmensregister), creating a comprehensive longitudinal dataset for empirical tax research. This generator creates synthetic data that preserves the structural characteristics of the original BTP while containing no real data.

## Features

### Panel Structure
- **Unbalanced panel** (default): Realistic participation patterns with 28.4% of units appearing in all years
- **Balanced panel** (optional): All units present in all years for methodological testing
- **Time coverage**: 2013-2019 (configurable)
- **Panel consistency**: Time-consistent identifiers across years

### Tax Statistics Included

| Code | Statistic | Description |
|------|-----------|-------------|
| `g` | Gewerbesteuer | Trade tax (business tax at municipal level) |
| `k` | Körperschaftsteuer | Corporate income tax |
| `u` | Umsatzsteuer-Voranmeldung | VAT advance returns (monthly/quarterly) |
| `p` | Personengesellschaften | Partnerships (separate income determination) |
| `v` | Umsatzsteuer-Veranlagung | VAT annual assessment |
| `e` | Einnahmenüberschussrechnung | Income surplus calculation (simplified accounting) |
| `r` | Unternehmensregister | Enterprise register (always included) |

### Variable Structure

Variables follow the naming convention: `[stat]_[type][area][number]`

**Examples:**
- `g_c0101`: Gewerbesteuer - Profit from business operations
- `k_k0501`: Körperschaftsteuer - Assessed corporate tax
- `v_c0401`: Umsatzsteuer-Veranlagung - Annual VAT payment
- `urs_we_umsatz`: Unternehmensregister - Turnover

### Core Panel Variables

| Variable | Type | Description |
|----------|------|-------------|
| `id` | Numeric | Time-consistent random panel identifier |
| `jahr` | Numeric | Reference year (YYYY) |
| `verk` | Character(7) | Linkage indicator (e.g., "gkupvre" = all statistics) |
| `verk_qual` | Numeric(1) | Linkage quality (1=best, 3=manual/cluster) |
| `ags` | Character(8) | German municipality code (Amtlicher Gemeindeschlüssel) |

### Enterprise Register Variables

| Variable | Description |
|----------|-------------|
| `urs_we_umsatz` | Turnover in 1,000 EUR |
| `urs_we_umsatz_quelle` | Source of turnover data (1=Survey, 4=Tax admin, 5=Estimate) |
| `urs_we_tp_stichtag` | Active persons as of December 31 |
| `urs_we_svb_stichtag` | Employees subject to social insurance |
| `urs_rt_gruppen_kennz` | Enterprise group status |
| `urs_rechtsform` | Legal form (101=Sole proprietorship, 201=Partnership, 301=Corporation, 401=Other) |

### Statistic-Specific Variables

#### Gewerbesteuer (Trade Tax) - Prefix `g_`
- `g_fef17`: Business size class (1-9)
- `g_fef20`: Type of income determination (E=Surplus, B=Balance sheet, T=Tonnage)
- `g_fef21`: Fiscal unity indicator (0/1)
- `g_c0101`: Business profit
- `g_c0102`: Business loss
- `g_c0301`: Rounded trade income
- `g_c0401`: Assessed trade tax

#### Körperschaftsteuer (Corporate Tax) - Prefix `k_`
- `k_fef13`: Legal form (AG, GmbH, eG, VVaG)
- `k_k0101`: Taxable income
- `k_k0201`: Balance sheet profit
- `k_k0202`: Balance sheet loss
- `k_k0501`: Assessed corporate tax
- `k_k0502`: Solidarity surcharge (5.5% of corporate tax)

#### Umsatzsteuer-Voranmeldung (VAT Advance) - Prefix `u_`
- `u_c0101`: Taxable supplies at 19%
- `u_c0102`: VAT at 19%
- `u_c0201`: Taxable supplies at 7%
- `u_c0202`: VAT at 7%
- `u_c0301`: Input tax (deductible)
- `u_c0401`: VAT payment/refund

#### Personengesellschaften (Partnerships) - Prefix `p_`
- `p_fef14`: Type of determination (1-3)
- `p_c0101`: Total profit
- `p_c0201`: Business profit
- `p_c0301`: Number of partners

#### Umsatzsteuer-Veranlagung (VAT Annual) - Prefix `v_`
- `v_c0101`: Annual taxable supplies at 19%
- `v_c0102`: Annual VAT at 19%
- `v_c0201`: Annual taxable supplies at 7%
- `v_c0202`: Annual VAT at 7%
- `v_c0301`: Annual input tax
- `v_c0401`: Annual VAT payment/refund
- `v_c0501`: Total annual turnover

#### Einnahmenüberschussrechnung (Income Surplus) - Prefix `e_`
- `e_c0101`: Operating revenues
- `e_c0201`: Operating expenses
- `e_c0301`: Income surplus (profit)
- `e_c0401`: Goods and materials expenses
- `e_c0501`: Personnel expenses
- `e_c0601`: Depreciation

## Installation

No installation required. Simply source the R script:

```r
source("synth_btp.R")
```

**Required packages:**
- `data.table` (mandatory)
- `haven` (optional, for enhanced variable labeling)

## Usage

### Basic Usage

```r
# Generate default dataset (100 units, all years, all statistics)
df <- synth_btp()
```

### Balanced Panel

```r
# All units appear in all years
df <- synth_btp(obs = 500, balanced = TRUE, seed = 42)
```

### Select Specific Statistics

```r
# Only trade tax and corporate tax
df <- synth_btp(obs = 1000, select = "gk", seed = 123)

# All VAT-related statistics
df <- synth_btp(obs = 800, select = "uv")

# Complex combination
df <- synth_btp(obs = 1500, select = "gkve", years = 2015:2019)
```

### Year Selection

```r
# Focus on recent years only
df <- synth_btp(obs = 200, years = 2017:2019)

# Single year cross-section
df <- synth_btp(obs = 5000, years = 2018)
```

### Large-Scale Simulations

```r
# Generate 10,000 units (unbalanced panel)
df <- synth_btp(obs = 10000, seed = 999)

# This creates ~47,000 observations with realistic panel structure
nrow(df)  # Approximately 47,830 rows
```

## Helper Functions

### Extract Metadata

```r
df <- synth_btp(obs = 100)
metadata <- extract_btp_metadata(df)

# View variables with value labels
subset(metadata, has_value_labels == TRUE)
```

### Summarize Panel Structure

```r
df <- synth_btp(obs = 500)
summary <- summarize_btp_panel(df)

# Access summary components
summary$n_observations      # Total rows
summary$n_units            # Unique panel units
summary$pct_balanced       # Percentage in all years
summary$linkage_quality    # Distribution of linkage quality
```

## Function Signature

```r
synth_btp(obs = 100,
          years = 2013:2019,
          select = "all",
          balanced = FALSE,
          seed = NULL)
```

**Parameters:**
- `obs`: Number of unique panel units (default: 100)
- `years`: Vector of years to include (default: 2013:2019)
- `select`: Statistics to include - "all" or combination of "g", "k", "u", "p", "v", "e" (default: "all")
- `balanced`: Logical, if TRUE all units appear in all years (default: FALSE)
- `seed`: Random seed for reproducibility (default: NULL)

**Returns:**
- Data frame with synthetic BTP panel data
- All variables include descriptive labels
- Categorical variables include value labels
- Dataset attributes include generation metadata

## Realistic Characteristics

The generator produces data with realistic properties based on actual BTP metadata:

### Panel Balance
- **28.4%** of units appear in all years (in unbalanced mode)
- Variable participation patterns reflecting business entry/exit
- Realistic linkage patterns across statistics

### Statistics Coverage (approximate)
- Trade tax (g): ~42% of observations
- Corporate tax (k): ~14% of observations
- VAT advance (u): ~34% of observations
- Partnerships (p): ~13% of observations
- VAT annual (v): ~71% of observations
- Income surplus (e): ~51% of observations

### Linkage Quality
- Quality 1 (current tax number): ~70%
- Quality 2 (current + old tax number): ~20%
- Quality 3 (manual/register/cluster): ~10%

### German Municipality Codes (AGS)
- Realistic 8-digit codes
- State distribution reflects actual German population
- Format: 2-digit state + 3-digit district + 3-digit municipality

### Economic Variables
- Log-normal distributions for turnover and revenue
- Realistic tax rates (19% and 7% VAT, 15% corporate tax, 5.5% solidarity surcharge)
- Plausible relationships between variables (e.g., input tax < output tax)

## Data Structure Example

```r
df <- synth_btp(obs = 3, years = 2018:2019, balanced = TRUE, seed = 42)
head(df)

   id jahr      ags    verk verk_qual urs_we_umsatz ...
1   1 2018 09247893 g_upvre         1     450.23    ...
2   1 2019 09247893 g_upvre         1     478.91    ...
3   2 2018 06112456 _k__vre         2     125.67    ...
4   2 2019 06112456 _k__vre         1     134.82    ...
5   3 2018 01003789 gku_vre         1    1250.45    ...
6   3 2019 01003789 gku_vre         1    1389.33    ...
```

## Testing

A comprehensive test suite is provided in `test_synth_btp.R`:

```r
source("test_synth_btp.R")
```

**Tests include:**
1. Basic generation with defaults
2. Balanced panel structure
3. Unbalanced panel characteristics
4. Selected statistics filtering
5. Year selection
6. Variable labeling
7. AGS format validation
8. Enterprise register variables
9. Trade tax variables
10. Corporate tax variables
11. VAT variables
12. Metadata extraction
13. Panel structure summary
14. Large dataset performance
15. Complex parameter combinations
16. Reproducibility with seeds

All tests include validation of data properties and expected values.

## Performance

**Typical generation times (on standard hardware):**
- 100 units: < 0.1 seconds
- 1,000 units: ~0.3 seconds
- 10,000 units: ~3 seconds

**Memory usage:**
- ~2 MB per 1,000 observations
- 10,000 units (~47,000 obs): ~90 MB

## Use Cases

### 1. Methodological Testing
```r
# Test panel data methods on balanced dataset
df <- synth_btp(obs = 1000, balanced = TRUE, seed = 42)

# Estimate fixed effects model
library(plm)
pdata <- pdata.frame(df, index = c("id", "jahr"))
model <- plm(urs_we_umsatz ~ factor(jahr), data = pdata, model = "within")
```

### 2. Code Development
```r
# Develop data processing pipelines without real data access
df <- synth_btp(obs = 5000)

# Test analysis workflow
library(dplyr)
df %>%
  filter(grepl("g", verk)) %>%
  group_by(jahr) %>%
  summarise(mean_tax = mean(g_c0401, na.rm = TRUE))
```

### 3. Teaching and Training
```r
# Generate small dataset for teaching
df <- synth_btp(obs = 50, years = 2017:2019, balanced = TRUE)

# Students can practice panel data analysis
# without dealing with confidentiality restrictions
```

### 4. Performance Benchmarking
```r
# Generate large dataset for performance testing
df_large <- synth_btp(obs = 50000)  # ~235,000 observations

# Benchmark different data processing approaches
library(microbenchmark)
microbenchmark(
  base_r = aggregate(urs_we_umsatz ~ jahr, df_large, mean),
  dplyr = df_large %>% group_by(jahr) %>% summarise(mean_umsatz = mean(urs_we_umsatz)),
  data.table = df_large[, mean(urs_we_umsatz), by = jahr],
  times = 10
)
```

### 5. Documentation and Examples
```r
# Create example datasets for documentation
# Export to various formats for demonstration

df <- synth_btp(obs = 100, seed = 42)

# Save in different formats
saveRDS(df, "example_btp.rds")
write.csv(df, "example_btp.csv", row.names = FALSE)

# Arrow/Parquet format (for large data examples)
library(arrow)
write_parquet(df, "example_btp.parquet")
```

## Limitations and Disclaimers

1. **Synthetic Data**: This is NOT real BTP data. All values are randomly generated.
2. **Simplified Structure**: The generator includes ~50 key variables out of 2,700+ in the full BTP.
3. **Statistical Independence**: Cross-sectional relationships between variables are simplified.
4. **No Economic Consistency**: Values don't reflect real economic relationships or time trends.
5. **Research Use**: NOT suitable for actual empirical research - use real BTP data from FDZ.

## Data Sources and References

The generator is based on official BTP metadata and documentation:

- **Kristiansen, A. (2023)**: "Business-Tax-Panel – Zusammenführung von Unternehmenssteuerstatistiken", WISTA Wirtschaft und Statistik, 3/2023
- **FDZ Documentation**: Metadatenreports Teil I & II, Business-Tax-Panel 2013-2019
- **Variable definitions**: Excel files from `/resources/raw/BTP_*.xlsx`

## Real Data Access

To access the actual Business-Tax-Panel:

**Forschungsdatenzentren der Statistischen Ämter des Bundes und der Länder**
- Website: https://www.forschungsdatenzentrum.de/de/steuern/btp
- Email: forschungsdatenzentrum@destatis.de
- DOI (KDFV): 10.21242/73511.2019.00.05.1.1.0
- DOI (GWAP): 10.21242/73511.2019.00.05.2.1.0

**Access methods:**
- KDFV (Kontrollierte Datenfernverarbeitung): Remote access
- GWAP (Gastwissenschaftlerarbeitsplatz): On-site access

## Citation

If using this generator in publications, please cite:

```
Synthetic Business-Tax-Panel Generator (2024)
Based on: Kristiansen, A. (2023). Business-Tax-Panel – Zusammenführung 
von Unternehmenssteuerstatistiken. WISTA Wirtschaft und Statistik, 3/2023.
Code: https://github.com/[your-repo]
```

## License

This generator is provided for educational and methodological purposes. The structure is based on publicly available metadata from the German Federal Statistical Office (Destatis).

## Contact

For questions or issues:
- Project: paper-wista-r-efficiency
- Location: `/projects/paper-wista-r-efficiency/dev/experiment/`

---

**Version**: 1.0  
**Last Updated**: November 2024  
**Generated Dataset Attributes**: Contains generation timestamp, version, and parameter metadata
