# example_simple_read.R
# Example operation definition showing how to add a simple read operation
# ----

# Define input files to benchmark with ----
input <- c(
  here("data", "btp_obs10", "data.csv")
)

# Define method to benchmark ----
method <- function(input_path) {
  # Simple operation: just read the file and return row count
  df <- read.csv(input_path)
  return(nrow(df))
}

# Operation name for benchmark results ----
operation_name <- "simple_read_rowcount"