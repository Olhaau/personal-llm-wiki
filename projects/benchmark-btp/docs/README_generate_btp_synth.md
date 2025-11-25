# generate_btp_synth.R - Quick Reference

## Overview

Generates synthetic Business-Tax-Panel (BTP) data for testing and benchmarking purposes.

## Basic Usage

```r
# Source the function
source("source/generate_btp_synth.R")

# Generate data with default settings (100 units, unbalanced panel, all statistics)
df <- generate_btp_synth()

# Generate smaller dataset for testing
df <- generate_btp_synth(obs = 10, seed = 42)
```

## Parameters

- **obs**: Number of units/firms (default: 100)
- **years**: Years to include (default: 2013:2019)
- **select**: Statistics to include (default: "all")
  - "all": All 6 statistics
  - Single: "g", "k", "u", "p", "v", "e"
  - Combinations: "gk", "gkv", etc.
- **balanced**: TRUE for balanced panel, FALSE for unbalanced (default: FALSE)
- **seed**: Random seed for reproducibility (default: NULL)

## Statistics Available

- **g**: Gewerbesteuer (Trade Tax) - 328 variables
- **k**: Körperschaftsteuer (Corporate Tax) - 1,088 variables
- **u**: Umsatzsteuer-Voranmeldung (VAT Advance) - 75 variables
- **p**: Personengesellschaften (Partnerships) - 1,078 variables
- **v**: Umsatzsteuer-Veranlagung (VAT Annual) - 120 variables
- **e**: Einnahmenüberschussrechnung (Income Surplus) - 349 variables

## Examples

### Small Test Dataset
```r
# 50 units × 7 years = 350 rows (balanced)
df <- generate_btp_synth(obs = 50, balanced = TRUE, seed = 42)
```

### Selected Statistics
```r
# Only trade tax and corporate tax
df <- generate_btp_synth(obs = 100, select = "gk", seed = 123)
```

### Recent Years Only
```r
# 2017-2019 only
df <- generate_btp_synth(obs = 200, years = 2017:2019, select = "k")
```

### Large Unbalanced Panel
```r
# 1000 units, ~4700 rows (varies due to unbalanced structure)
df <- generate_btp_synth(obs = 1000, select = "gkv", seed = 123)
```

## Output Structure

The function returns a data frame with:

### Core Variables (always present)
- **id**: Panel identifier (1, 2, 3, ...)
- **jahr**: Year (2013-2019)
- **ags**: Municipality code (8-digit)
- **verk**: Linkage variable (7-character string)
- **verk_qual**: Linkage quality (1-3)

### Enterprise Register Variables (always present)
- **urs_we_umsatz**: Turnover in 1,000 EUR
- **urs_we_umsatz_quelle**: Turnover data source (1, 4, 5)
- **urs_we_tp_stichtag**: Active persons on Dec 31
- **urs_we_svb_stichtag**: Employees subject to social insurance
- **urs_rt_gruppen_kennz**: Enterprise group status (0, 1, 3, 6)
- **urs_rechtsform**: Legal form (101, 201, 301, 401)

### Tax Statistic Variables (conditional on selection)
- **g_***: Trade tax variables (if "g" selected)
- **k_***: Corporate tax variables (if "k" selected)
- **u_***: VAT advance variables (if "u" selected)
- **p_***: Partnership variables (if "p" selected)
- **v_***: VAT annual variables (if "v" selected)
- **e_***: Income surplus variables (if "e" selected)

## Panel Structure

### Unbalanced (default)
- 28.4% of units appear in all 7 years
- Remaining units have varying participation (1-7 years)
- More realistic for testing panel data methods

### Balanced
- All units appear in all years
- Total rows = obs × number of years
- Easier for some types of analysis

## Data Files

The function requires these files in the `data/` folder:

### Required
- **btp_variables_format.csv**: Variable names and formats
  - Created from BTP documentation
  - Contains: prefix, variable, format

### Optional
- **btp_obs_distribution.csv**: Year-specific coverage probabilities
  - If missing, uses average probabilities
  - Contains: stat, p2013-p2019

## Documentation

For detailed information on data sources and methodology, see:
- **docs/btp_synth_data_sources.md**

## Dependencies

- **data.table**: Required for efficient data generation
- **here** (optional): For path resolution

## Metadata

Each generated dataset includes metadata attributes:
```r
attr(df, "generated")    # Timestamp
attr(df, "generator")    # "generate_btp_synth"
attr(df, "version")      # "2.0"
attr(df, "obs")          # Number of units
attr(df, "years")        # Years included
attr(df, "statistics")   # Statistics selected
attr(df, "balanced")     # Panel balance type
```

Access with:
```r
attributes(df)
```

## Important Notes

1. **All data is synthetic** - no real taxpayer information
2. **Variables have no labels** - simplified structure for performance
3. **Reproducible** - use seed parameter for consistent results
4. **Realistic structure** - mimics real BTP panel characteristics
5. **NOT for economic analysis** - for testing and benchmarking only

## Quick Performance Guide

Approximate generation times depend on:
- Number of observations
- Number of statistics selected
- Balanced vs. unbalanced

Examples (on typical laptop):
- 10 obs, select="g": <1 second
- 100 obs, select="all": ~5-10 seconds
- 1000 obs, select="all": ~60-120 seconds

## Troubleshooting

### Error: "Variable definitions not found"
- Check that `data/btp_variables_format.csv` exists
- Ensure working directory is project root

### Slow performance
- Reduce number of observations
- Select fewer statistics
- Use balanced panel (faster than unbalanced)

### Inconsistent results
- Set a seed for reproducibility
- Same seed always produces same data

## Version History

- **v2.0** (Nov 2025): Removed labelling, reorganized file structure
- **v1.0**: Initial version with labelling

## License & Attribution

This synthetic data generator is based on publicly available information about the German Business-Tax-Panel (BTP) structure. It does not contain or reproduce any confidential data.
