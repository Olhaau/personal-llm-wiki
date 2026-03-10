#!/usr/bin/env bash
set -euo pipefail

N_ROWS="${1:-10000000}"
DATA_DIR="data"
CSV_PATH="${DATA_DIR}/benchmark_${N_ROWS}.csv"
PARQUET_PATH="${DATA_DIR}/benchmark_${N_ROWS}.parquet"

mkdir -p "${DATA_DIR}"

echo "Preparing CSV with ${N_ROWS} rows (if needed)..."
N_ROWS="${N_ROWS}" CSV_PATH="${CSV_PATH}" Rscript -e '
if (!requireNamespace("arrow", quietly = TRUE)) stop("arrow package required")
n <- as.numeric(Sys.getenv("N_ROWS"))
csv_path <- Sys.getenv("CSV_PATH")
if (!file.exists(csv_path)) {
  set.seed(42)
  df <- data.frame(
    id = seq_len(n),
    grp = sprintf("g%02d", (seq_len(n) - 1L) %% 100L),
    value = runif(n),
    flag = (seq_len(n) %% 2L) == 0L
  )
  arrow::write_csv_arrow(df, csv_path)
  cat("created", csv_path, "\n")
} else {
  cat("exists", csv_path, "\n")
}
print(file.info(csv_path)[, "size", drop = FALSE])
'

echo "Benchmarking conversion RAM/time..."
rm -f "${PARQUET_PATH}"
CSV_PATH="${CSV_PATH}" PARQUET_PATH="${PARQUET_PATH}" /usr/bin/time -v Rscript -e '
source("csv_to_parquet.R")
out <- convert_csv_to_parquet(Sys.getenv("CSV_PATH"), Sys.getenv("PARQUET_PATH"))
cat("output=", out, "\n", sep = "")
'

echo "Reporting file size ratio..."
CSV_PATH="${CSV_PATH}" PARQUET_PATH="${PARQUET_PATH}" Rscript -e '
csv_size <- file.info(Sys.getenv("CSV_PATH"))$size
parquet_size <- file.info(Sys.getenv("PARQUET_PATH"))$size
cat(sprintf("csv_bytes=%d\nparquet_bytes=%d\nratio=%.3f\n", csv_size, parquet_size, parquet_size / csv_size))
'
