# rbase_fallzahl.R
# Operation definition for R base fallzahl calculation
# ----

# Define input files to benchmark with ----
input <- c(
  here("data", "btp_obs10", "data.csv"),
  here("data", "btp_obs100", "data.csv")
)

# Define method to benchmark ----
method <- function(input_path) {
  df <- read.csv(input_path)
  stat_cols <- c("g_k2110", "k_c13110", "v_ef48", "e_c25100")
  
  # Only use columns that exist in the data
  stat_cols <- stat_cols[stat_cols %in% names(df)]
  
  if (length(stat_cols) == 0) {
    warning("None of the stat columns found in data")
    return(matrix(0, nrow = 0, ncol = 0))
  }
  
  total_rows <- nrow(df)
  
  # Calculate proportions for each jahr x stat combination
  proportions <- sapply(stat_cols, function(stat) {
    sapply(sort(unique(df$jahr)), function(year) {
      sum(df$jahr == year & !is.na(df[[stat]])) / total_rows
    })
  })
  
  rownames(proportions) <- sort(unique(df$jahr))
  return(proportions)
}

# Operation name for benchmark results ----
operation_name <- "rbase_fallzahl"