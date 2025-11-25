# duckdb_fallzahl.R
# Operation definition for DuckDB fallzahl calculation
# ----

# Define input files to benchmark with ----
input <- c(
  here("data", "btp_obs10", "data.csv"),
  here("data", "btp_obs100", "data.csv")
)

# Define method to benchmark ----
method <- function(input_path) {
  suppressPackageStartupMessages(library(duckdb))
  
  con <- dbConnect(duckdb())
  on.exit(dbDisconnect(con, shutdown = TRUE))
  
  # Read CSV into DuckDB
  query <- sprintf("SELECT * FROM read_csv_auto('%s')", input_path)
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

# Operation name for benchmark results ----
operation_name <- "duckdb_fallzahl"