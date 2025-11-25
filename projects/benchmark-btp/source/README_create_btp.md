# create_btp.R

Generate synthetic BTP (Business-Tax-Panel) data with configurable number of observations in multiple file formats.

## Requirements

- R packages: `here`, `data.table`, `arrow`
- R project file: `benchmark-btp.Rproj` (included)

Install required packages:
```r
install.packages(c("here", "data.table", "arrow"))
```

## Usage

1. Edit the `obs` parameter at the top of `source/create_btp.R`:
   ```r
   obs <- 10  # Change to desired number of observations
   ```

2. Run the script from anywhere within the project:
   ```bash
   # From project root
   Rscript source/create_btp.R
   
   # From source directory
   cd source && Rscript create_btp.R
   ```

The script uses the `here` package to automatically find the project root (where `benchmark-btp.Rproj` is located).

## Output

Creates a directory `data/btp_obs{N}/` where N is the number of observations, containing:

- **`data.csv`** - Standard CSV format
- **`data.csv.gz`** - Compressed CSV
- **`data.parquet`** - Single Parquet file
- **`parquet_nach_jahr/`** - Parquet partitioned by year (2013-2019)
- **`parquet_gleich_aufgeteilt/`** - Parquet with equal partitions

## Variables

The script keeps 10 key variables from the full BTP dataset:

1. `id` - Panel identifier
2. `jahr` - Year
3. `ags` - Municipality code
4. `verk` - Linkage variable
5. `urs_we_umsatz` - Turnover
6. `urs_we_tp_stichtag` - Active persons
7. `g_k2110` - Trade tax variable
8. `k_c13110` - Corporate tax variable
9. `v_ef48` - VAT variable
10. `e_c25100` - Income surplus variable

## Examples

Generate dataset with 10 observations:
```r
# In source/create_btp.R
obs <- 10
```

Generate dataset with 1000 observations:
```r
# In source/create_btp.R
obs <- 1000
```

Each run creates a separate directory (e.g., `btp_obs10/`, `btp_obs1000/`).
