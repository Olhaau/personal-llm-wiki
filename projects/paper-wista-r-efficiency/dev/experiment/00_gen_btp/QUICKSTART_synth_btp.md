# Synthetic BTP - Quick Start Guide

## Installation

```r
# Required packages
install.packages(c("data.table", "jsonlite", "haven"))

# Load the generator
source("synth_btp.R")
```

## Basic Usage

### Example 1: Small Balanced Panel with All Statistics

```r
# Generate 50 units across all years (2013-2019), all statistics
df <- synth_btp(obs = 50, balanced = TRUE, seed = 42)

# Check dimensions
dim(df)  
# [1]  350 3694  (50 units × 7 years = 350 obs, 3694 variables)

# View structure
str(df, list.len = 20)

# Summarize
summary_stats <- summarize_btp_panel(df)
print(summary_stats$variable_counts)
```

### Example 2: Unbalanced Panel (Realistic)

```r
# Generate realistic unbalanced panel
df <- synth_btp(obs = 1000, balanced = FALSE, seed = 123)

# Check balance
summary_stats <- summarize_btp_panel(df)
cat("Observations:", summary_stats$n_observations, "\n")
cat("Units:", summary_stats$n_units, "\n")
cat("% in all years:", round(summary_stats$pct_balanced, 1), "%\n")
# Expected: ~28.4%
```

### Example 3: Selected Statistics Only

```r
# Only Gewerbesteuer and Körperschaftsteuer
df_gk <- synth_btp(obs = 200, select = "gk", seed = 456)
ncol(df_gk)  # 11 core + 428 g + 1239 k = 1678 variables

# Only VAT statistics
df_vat <- synth_btp(obs = 300, select = "uv", seed = 789)
ncol(df_vat)  # 11 core + 75 u + 120 v = 206 variables

# Single statistic
df_k <- synth_btp(obs = 100, select = "k", years = 2015:2019)
ncol(df_k)  # 11 core + 1239 k = 1250 variables
```

### Example 4: Recent Years Only

```r
# Focus on recent years
df_recent <- synth_btp(obs = 500, years = 2017:2019, select = "all", seed = 999)
unique(df_recent$jahr)  # [1] 2017 2018 2019
```

## Exploring the Data

### Check Linkage Pattern

```r
# View first observation
obs1 <- df[1, ]
cat("verk:", obs1$verk, "\n")
cat("has Gewerbesteuer:", grepl("g", obs1$verk), "\n")
cat("has Körperschaftsteuer:", grepl("k", obs1$verk), "\n")

# Check if variables are NA when not in verk
cat("g_ef4 (Gewerbe):", !is.na(obs1$g_ef4), "\n")
cat("k_ef4 (Körperschaft):", !is.na(obs1$k_ef4), "\n")
```

### Statistics Coverage

```r
# How many units participate in each statistic?
summary_stats <- summarize_btp_panel(df)
print(summary_stats$statistics_coverage)

# Example output:
#   stat    n    pct
# 1    _   27   5.4    # No statistics
# 2    g  210  42.0    # Gewerbesteuer
# 3    k   70  14.0    # Körperschaftsteuer
# etc.
```

### Variable Metadata

```r
# Extract all variable labels
metadata <- extract_btp_metadata(df)
head(metadata, 20)

# Find specific variables
g_vars <- metadata[grepl("^g_", metadata$variable), ]
cat("Gewerbesteuer variables:", nrow(g_vars), "\n")

k_vars <- metadata[grepl("^k_", metadata$variable), ]
cat("Körperschaftsteuer variables:", nrow(k_vars), "\n")

# Check label for a specific variable
cat("g_ef4:", attr(df$g_ef4, "label"), "\n")
# Output: "Lieferart"
```

## Working with Specific Statistics

### Gewerbesteuer (Trade Tax)

```r
df_g <- synth_btp(obs = 100, select = "g", seed = 42)

# Key Gewerbesteuer variables
g_cols <- grep("^g_", names(df_g), value = TRUE)
length(g_cols)  # 428 variables

# Example analysis: Gewerbeertrag by year
library(data.table)
dt <- as.data.table(df_g)
dt[!is.na(g_c0301), .(mean_ertrag = mean(g_c0301)), by = jahr]
```

### Körperschaftsteuer (Corporate Tax)

```r
df_k <- synth_btp(obs = 100, select = "k", seed = 42)

# Key Körperschaftsteuer variables
k_cols <- grep("^k_", names(df_k), value = TRUE)
length(k_cols)  # 1239 variables

# Example: Corporate income distribution
library(ggplot2)
ggplot(df_k[!is.na(df_k$k_k0101), ], aes(x = k_k0101)) +
  geom_histogram(bins = 30) +
  labs(title = "Zu versteuerndes Einkommen",
       x = "Amount", y = "Frequency")
```

## Advanced Usage

### Generate Multiple Datasets

```r
# Generate datasets for different scenarios
scenarios <- list(
  small_balanced = synth_btp(obs = 50, balanced = TRUE, seed = 1),
  medium_unbalanced = synth_btp(obs = 500, balanced = FALSE, seed = 2),
  large_recent = synth_btp(obs = 2000, years = 2016:2019, seed = 3)
)

# Compare structures
lapply(scenarios, function(x) {
  list(
    n_obs = nrow(x),
    n_vars = ncol(x),
    years = unique(x$jahr)
  )
})
```

### Export Data

```r
# Save as RDS (preserves labels)
saveRDS(df, "synth_btp.rds")

# Save as CSV (loses labels)
write.csv(df, "synth_btp.csv", row.names = FALSE)

# Save with haven (preserves labels for SPSS/Stata)
library(haven)
write_sav(df, "synth_btp.sav")
write_dta(df, "synth_btp.dta")
```

## Performance Tips

1. **Start small**: Test with `obs = 50` before scaling up
2. **Select statistics**: Use `select = "g"` instead of `"all"` when possible
3. **Limit years**: Use `years = 2017:2019` instead of full range
4. **Use seeds**: Always set `seed` for reproducibility

## Troubleshooting

### Error: "btp_variables.json not found"

```r
# Make sure you're in the correct directory
getwd()
# Should be: .../dev/experiment/

# Check if file exists
file.exists("btp_variables.json")
# Should be TRUE

# If FALSE, ensure the JSON file is in the working directory
```

### Memory Issues

```r
# For very large datasets, monitor memory
cat("Estimated memory:", format(object.size(df), units = "MB"), "\n")

# Consider generating in batches or using fewer statistics
df <- synth_btp(obs = 10000, select = "g", seed = 42)  # Instead of "all"
```

## Next Steps

- See `INDEX_synth_btp.md` for complete variable list
- See `README_synth_btp.md` for detailed documentation
- See `test_synth_btp.R` for testing examples
- Explore `btp_variables.json` for variable definitions

