convert_csv_to_parquet <- function(csv_path, parquet_path = NULL, compression = "snappy") {
  if (!requireNamespace("arrow", quietly = TRUE)) {
    stop("Package 'arrow' is required. Install it with install.packages('arrow').")
  }

  if (!file.exists(csv_path)) {
    stop(sprintf("CSV file not found: %s", csv_path))
  }

  if (is.null(parquet_path)) {
    parquet_path <- sub("\\.csv$", ".parquet", csv_path, ignore.case = TRUE)
    if (identical(parquet_path, csv_path)) {
      parquet_path <- paste0(csv_path, ".parquet")
    }
  }

  table <- arrow::read_csv_arrow(csv_path)
  arrow::write_parquet(table, parquet_path, compression = compression)

  invisible(parquet_path)
}
