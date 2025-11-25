# workflow.R
# Benchmark workflow for testing different read functions on BTP data
# ----

library(here)
suppressPackageStartupMessages(library(arrow))

# Source functions ----
source(here("source", "benchmark.R"))
source(here("source", "system_info.R"))

# Collect and save system information ----
save_system_info()

# Define input files ----
inputs <- c(
  here("data", "btp_obs10", "data.csv"),
  here("data", "btp_obs100", "data.csv")
)

# Define expressions to benchmark ----
exprs <- list(
  rbase_fallzahl = function(input) {
    df <- read.csv(input)
    stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
    total_rows <- nrow(df)
    
    # Calculate proportions for each jahr x stat combination
    proportions <- sapply(stat_cols, function(stat) {
      sapply(sort(unique(df$jahr)), function(year) {
        sum(df$jahr == year & !is.na(df[[stat]])) / total_rows
      })
    })
    
    rownames(proportions) <- sort(unique(df$jahr))
    return(proportions)
  },
  
  data_table_fallzahl = function(input) {
    suppressPackageStartupMessages(library(data.table))
    
    dt <- fread(input)
    stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
    total_rows <- nrow(dt)
    
    # Melt to long format
    dt_long <- melt(dt, id.vars = "jahr", measure.vars = stat_cols, 
                    variable.name = "stat", value.name = "value")
    
    # Calculate counts and proportions by jahr and stat
    result <- dt_long[!is.na(value), .(count = .N), by = .(jahr, stat)]
    result[, proportion := count / total_rows]
    
    # Convert to wide format (matrix)
    wide_table <- dcast(result, jahr ~ stat, value.var = "proportion", fill = 0)
    
    # Convert to matrix with proper dimnames
    jahr_values <- wide_table$jahr
    wide_matrix <- as.matrix(wide_table[, -1])
    rownames(wide_matrix) <- jahr_values
    
    return(wide_matrix)
  },
  
  arrow_fallzahl = function(input) {
    
    df <- read_csv_arrow(input)
    stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
    total_rows <- nrow(df)
    
    proportions <- sapply(stat_cols, function(stat) {
      sapply(sort(unique(df$jahr)), function(year) {
        sum(df$jahr == year & !is.na(df[[stat]])) / total_rows
      })
    })
    
    rownames(proportions) <- sort(unique(df$jahr))
    return(proportions)
  },
  
  vroom_fallzahl = function(input) {
    suppressPackageStartupMessages(library(vroom))
    
    df <- vroom(input, show_col_types = FALSE)
    stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
    total_rows <- nrow(df)
    
    proportions <- sapply(stat_cols, function(stat) {
      sapply(sort(unique(df$jahr)), function(year) {
        sum(df$jahr == year & !is.na(df[[stat]])) / total_rows
      })
    })
    
    rownames(proportions) <- sort(unique(df$jahr))
    return(proportions)
  },
  
  arrow_parquet_fallzahl = function(input) {
    # Replace .csv with .parquet
    parquet_input <- sub("\\.csv$", ".parquet", input)
    
    df <- read_parquet(parquet_input)
    stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
    total_rows <- nrow(df)
    
    proportions <- sapply(stat_cols, function(stat) {
      sapply(sort(unique(df$jahr)), function(year) {
        sum(df$jahr == year & !is.na(df[[stat]])) / total_rows
      })
    })
    
    rownames(proportions) <- sort(unique(df$jahr))
    return(proportions)
  },
  
  duckdb_fallzahl = function(input) {
    suppressPackageStartupMessages(library(duckdb))
    
    con <- dbConnect(duckdb())
    on.exit(dbDisconnect(con, shutdown = TRUE))
    
    # Read CSV into DuckDB
    query <- sprintf("SELECT * FROM read_csv_auto('%s')", input)
    df <- dbGetQuery(con, query)
    
    stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
    total_rows <- nrow(df)
    
    proportions <- sapply(stat_cols, function(stat) {
      sapply(sort(unique(df$jahr)), function(year) {
        sum(df$jahr == year & !is.na(df[[stat]])) / total_rows
      })
    })
    
    rownames(proportions) <- sort(unique(df$jahr))
    return(proportions)
  }
)

# Run benchmarks ----
# Loop through all input files and expressions
for (input in inputs) {
  for (expr_name in names(exprs)) {
    benchmark(input, exprs[[expr_name]], expr_name = expr_name)
  }
}

# Example: Single benchmark call ----
# benchmark(here("data", "btp_obs10", "data.csv"), read.csv, expr_name = "read.csv")
