infer_column_type_streaming <- function(csv_path, column_name, na = c("", "NA"), block_size = 1048576L) {
  read_opts <- arrow::csv_read_options(block_size = block_size, skip_rows = 0L)

  table <- arrow::read_csv_arrow(
    csv_path,
    col_select = tidyselect::all_of(column_name),
    col_types = do.call(arrow::schema, stats::setNames(list(arrow::utf8()), column_name)),
    as_data_frame = FALSE,
    na = na,
    col_names = TRUE,
    read_options = read_opts
  )

  column <- table$GetColumnByName(column_name)
  if (is.null(column)) {
    stop(sprintf("Failed to read column '%s'", column_name))
  }

  int_pattern <- "^[+-]?[0-9]+$"
  dbl_pattern <- "^[+-]?(?:\\d+\\.?\\d*|\\.\\d+)(?:[eE][+-]?\\d+)?$"
  int32_max <- 2147483647

  saw_value <- FALSE
  all_integer_like <- TRUE
  all_double_like <- TRUE
  has_int32_overflow <- FALSE

  for (i in seq_len(column$num_chunks)) {
    chunk <- column$chunk(i - 1L)
    values <- trimws(chunk$as_vector())
    keep <- !is.na(values) & !(values %in% na)
    values <- values[keep]

    if (length(values) == 0L) {
      next
    }

    saw_value <- TRUE

    int_matches <- grepl(int_pattern, values)
    if (!all(int_matches)) {
      all_integer_like <- FALSE
    } else {
      numeric_values <- suppressWarnings(as.numeric(values))
      if (any(!is.na(numeric_values) & abs(numeric_values) > int32_max)) {
        has_int32_overflow <- TRUE
      }
      if (any(is.infinite(numeric_values))) {
        has_int32_overflow <- TRUE
      }
    }

    if (all_double_like) {
      if (!all(grepl(dbl_pattern, values))) {
        all_double_like <- FALSE
      }
    }
  }

  if (!saw_value) {
    return(list(type = arrow::utf8(), int32_overflow = FALSE))
  }

  if (all_integer_like) {
    if (has_int32_overflow) {
      return(list(type = arrow::int64(), int32_overflow = TRUE))
    }
    return(list(type = arrow::int32(), int32_overflow = FALSE))
  }

  if (all_double_like) {
    return(list(type = arrow::float64(), int32_overflow = FALSE))
  }

  list(type = arrow::utf8(), int32_overflow = FALSE)
}

detect_csv_arrow_types <- function(csv_path, na = c("", "NA"), block_size = 1048576L) {
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

  inferred_types <- list()
  overflow_cols <- character(0)

  for (name in col_names) {
    type_info <- infer_column_type_streaming(
      csv_path = csv_path,
      column_name = name,
      na = na,
      block_size = block_size
    )

    inferred_types[[name]] <- type_info$type
    if (isTRUE(type_info$int32_overflow)) {
      overflow_cols <- c(overflow_cols, name)
    }
  }

  list(
    schema = do.call(arrow::schema, inferred_types),
    overflow_columns = overflow_cols
  )
}

convert_csv_to_parquet_int64_safe <- function(csv_path,
                                              parquet_path = NULL,
                                              compression = "snappy",
                                              na = c("", "NA"),
                                              block_size = 1048576L) {
  if (is.null(parquet_path)) {
    parquet_path <- sub("\\.csv$", ".parquet", csv_path, ignore.case = TRUE)
    if (identical(parquet_path, csv_path)) {
      parquet_path <- paste0(csv_path, ".parquet")
    }
  }

  type_info <- detect_csv_arrow_types(csv_path, na = na, block_size = block_size)
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
