detect_csv_arrow_types <- function(csv_path, na = c("", "NA")) {
  if (!requireNamespace("arrow", quietly = TRUE)) {
    stop("Package 'arrow' is required. Install it with install.packages('arrow').")
  }

  if (!file.exists(csv_path)) {
    stop(sprintf("CSV file not found: %s", csv_path))
  }

  header <- utils::read.csv(csv_path, nrows = 0, check.names = FALSE)
  col_names <- names(header)

  if (length(col_names) == 0L) {
    stop("CSV has no columns.")
  }

  char_types <- stats::setNames(lapply(col_names, function(...) arrow::utf8()), col_names)
  char_schema <- do.call(arrow::schema, char_types)
  char_table <- arrow::read_csv_arrow(
    csv_path,
    schema = char_schema,
    as_data_frame = FALSE,
    na = na,
    col_names = FALSE,
    skip = 1
  )
  data <- as.data.frame(char_table, stringsAsFactors = FALSE)

  int_pattern <- "^[+-]?[0-9]+$"
  dbl_pattern <- "^[+-]?(?:\\d+\\.?\\d*|\\.\\d+)(?:[eE][+-]?\\d+)?$"
  int32_max <- 2147483647

  inferred_types <- list()
  overflow_cols <- character(0)

  for (name in col_names) {
    values <- trimws(data[[name]])
    keep <- !is.na(values) & !(values %in% na)
    values <- values[keep]

    if (length(values) == 0L) {
      inferred_types[[name]] <- arrow::utf8()
      next
    }

    if (all(grepl(int_pattern, values))) {
      max_abs <- max(abs(as.numeric(values)), na.rm = TRUE)
      if (is.finite(max_abs) && max_abs > int32_max) {
        inferred_types[[name]] <- arrow::int64()
        overflow_cols <- c(overflow_cols, name)
      } else {
        inferred_types[[name]] <- arrow::int32()
      }
      next
    }

    if (all(grepl(dbl_pattern, values))) {
      inferred_types[[name]] <- arrow::float64()
      next
    }

    inferred_types[[name]] <- arrow::utf8()
  }

  list(
    schema = do.call(arrow::schema, inferred_types),
    overflow_columns = overflow_cols
  )
}

convert_csv_to_parquet_int64_safe <- function(csv_path, parquet_path = NULL, compression = "snappy", na = c("", "NA")) {
  if (is.null(parquet_path)) {
    parquet_path <- sub("\\.csv$", ".parquet", csv_path, ignore.case = TRUE)
    if (identical(parquet_path, csv_path)) {
      parquet_path <- paste0(csv_path, ".parquet")
    }
  }

  type_info <- detect_csv_arrow_types(csv_path, na = na)
  typed_table <- arrow::read_csv_arrow(
    csv_path,
    schema = type_info$schema,
    as_data_frame = FALSE,
    na = na,
    col_names = FALSE,
    skip = 1
  )
  arrow::write_parquet(typed_table, parquet_path, compression = compression)

  invisible(list(
    parquet_path = parquet_path,
    overflow_columns = type_info$overflow_columns,
    schema = type_info$schema
  ))
}
