# Quick Start Guide - Synthetic BTP Generator

## Installation

```r
# Install required packages
install.packages("data.table")
# Optional: install.packages("haven")

# Load the generator
source("synth_btp.R")
```

## 5-Minute Tutorial

### 1. Generate Your First Dataset (10 seconds)

```r
# Simple generation with defaults
df <- synth_btp(obs = 100, seed = 42)

# What did we get?
dim(df)                    # 471 rows × 47 columns
head(df[, 1:8])           # Preview first 8 columns
names(df)                  # All variable names
```

### 2. Understand the Panel Structure (1 minute)

```r
# Summarize the panel
summary <- summarize_btp_panel(df)
summary$n_units           # 100 unique units
summary$pct_balanced      # % appearing in all years
summary$observations_per_unit  # Distribution

# Check years covered
table(df$jahr)

# Check linkage patterns
table(df$verk_qual)
```

### 3. Explore the Statistics (2 minutes)

```r
# How many observations have each statistic?
c(
  Gewerbesteuer = sum(grepl("g", df$verk)),
  Koerperschaftsteuer = sum(grepl("k", df$verk)),
  USt_Voranmeldung = sum(grepl("u", df$verk)),
  Personengesellschaften = sum(grepl("p", df$verk)),
  USt_Veranlagung = sum(grepl("v", df$verk)),
  EUR = sum(grepl("e", df$verk))
)

# Focus on one statistic
trade_tax <- df[grepl("g", df$verk), ]
summary(trade_tax$g_c0401)  # Trade tax amounts
```

### 4. Variable Labels (1 minute)

```r
# Extract metadata for all variables
metadata <- extract_btp_metadata(df)
metadata[1:10, ]  # View first 10 variables

# Find variables with value labels
subset(metadata, has_value_labels == TRUE)
```

### 5. Generate Custom Datasets (1 minute)

```r
# Balanced panel for econometric methods
balanced <- synth_btp(obs = 500, balanced = TRUE, seed = 123)
all(table(balanced$id) == 7)  # TRUE - all units in all 7 years

# Focus on corporations (Gewerbesteuer + Körperschaftsteuer)
corps <- synth_btp(obs = 1000, select = "gk", years = 2015:2019)

# Only VAT statistics
vat_only <- synth_btp(obs = 800, select = "uv", seed = 456)

# Large dataset for performance testing
large <- synth_btp(obs = 10000)
nrow(large)  # ~47,000 observations
```

## Common Tasks

### Export to Different Formats

```r
df <- synth_btp(obs = 100, seed = 42)

# CSV
write.csv(df, "btp_synthetic.csv", row.names = FALSE)

# RDS (preserves labels)
saveRDS(df, "btp_synthetic.rds")

# Parquet (if arrow installed)
# library(arrow)
# write_parquet(df, "btp_synthetic.parquet")
```

### Analyze Panel Data

```r
df <- synth_btp(obs = 200, balanced = TRUE, seed = 42)

# Time trends
library(dplyr)
df %>%
  group_by(jahr) %>%
  summarise(
    mean_turnover = mean(urs_we_umsatz, na.rm = TRUE),
    mean_employees = mean(urs_we_tp_stichtag, na.rm = TRUE),
    n = n()
  )

# By legal form
df %>%
  group_by(urs_rechtsform) %>%
  summarise(
    mean_turnover = mean(urs_we_umsatz, na.rm = TRUE),
    n = n()
  )
```

### Fixed Effects Model Example

```r
df <- synth_btp(obs = 500, balanced = TRUE, select = "g", seed = 42)

# Only units with trade tax data
df_g <- df[grepl("g", df$verk) & !is.na(df$g_c0401), ]

# Fixed effects regression (requires plm package)
# library(plm)
# pdata <- pdata.frame(df_g, index = c("id", "jahr"))
# model <- plm(g_c0401 ~ urs_we_tp_stichtag + urs_we_umsatz,
#              data = pdata, model = "within")
# summary(model)
```

### Benchmark Data Processing

```r
df <- synth_btp(obs = 5000)

# Compare data.table vs dplyr
library(data.table)
library(dplyr)
library(microbenchmark)

dt <- as.data.table(df)

microbenchmark(
  data.table = dt[, mean(urs_we_umsatz), by = jahr],
  dplyr = df %>% group_by(jahr) %>% summarise(m = mean(urs_we_umsatz)),
  times = 10
)
```

## Parameter Reference

```r
synth_btp(
  obs = 100,           # Number of unique units
  years = 2013:2019,   # Years to include
  select = "all",      # Statistics: "all", "g", "k", "u", "p", "v", "e", or combinations
  balanced = FALSE,    # TRUE = all units in all years
  seed = NULL         # Random seed for reproducibility
)
```

## Statistics Codes

| Code | Statistic |
|------|-----------|
| `g` | Gewerbesteuer (Trade tax) |
| `k` | Körperschaftsteuer (Corporate tax) |
| `u` | Umsatzsteuer-Voranmeldung (VAT advance) |
| `p` | Personengesellschaften (Partnerships) |
| `v` | Umsatzsteuer-Veranlagung (VAT annual) |
| `e` | Einnahmenüberschussrechnung (Income surplus) |

**Combinations:** `select = "gk"` (trade + corporate), `select = "uv"` (VAT advance + annual), etc.

## Key Variables Quick Reference

| Variable | Description |
|----------|-------------|
| `id` | Panel identifier |
| `jahr` | Year |
| `verk` | Which statistics are linked (e.g., "gkupvre") |
| `verk_qual` | Linkage quality (1-3) |
| `ags` | Municipality code |
| `urs_we_umsatz` | Turnover (1,000 EUR) |
| `urs_we_tp_stichtag` | Employees |
| `urs_rechtsform` | Legal form |
| `g_c0401` | Trade tax |
| `k_k0501` | Corporate tax |
| `v_c0501` | Total turnover |

## Troubleshooting

### Missing Package Error

```r
# Error: there is no package called 'data.table'
install.packages("data.table")
```

### Labels Not Showing

```r
# Install haven for better label support
install.packages("haven")

# Or check labels manually
attr(df$verk_qual, "label")
attr(df$verk_qual, "labels")
```

### Too Many Variables

```r
# Focus on specific statistics
df <- synth_btp(select = "g")  # Only trade tax + core + URS
ncol(df)  # Fewer columns
```

### Need More Variables

The generator includes ~50 key variables. To add more variables from specific statistics, extend the generator functions in `synth_btp.R`:
- `generate_gewerbesteuer()`
- `generate_koerperschaftsteuer()`
- etc.

Refer to Excel files in `/resources/raw/BTP_*.xlsx` for complete variable lists.

## Next Steps

1. **Read full documentation**: `README_synth_btp.md`
2. **Run tests**: `source("test_synth_btp.R")`
3. **Explore examples**: See README for 6 detailed use cases
4. **Customize**: Modify generator functions to add more variables

## Getting Real BTP Data

This generator creates **synthetic data only**. For actual research:

**FDZ des Statistischen Bundesamtes**
- Website: https://www.forschungsdatenzentrum.de/de/steuern/btp
- Email: forschungsdatenzentrum@destatis.de
- Access: KDFV (remote) or GWAP (on-site)
- DOI: 10.21242/73511.2019.00.05.1.1.0

---

**Generated:** November 2024 | **Version:** 1.0
