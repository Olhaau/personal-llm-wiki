extract_numeric_ranges_csv <- function(csv_path,
                                       output_path = NULL,
                                       chunk_nrows = 1000000L,
                                       probe_nrows = 100000L,
                                       na_strings = c("", "NA", "NaN", "NULL"),
                                       show_progress = TRUE) {
  if (!requireNamespace("data.table", quietly = TRUE)) {
    stop("Package 'data.table' is required. Install it with install.packages('data.table').")
  }

  if (!file.exists(csv_path)) {
    stop(sprintf("CSV file not found: %s", csv_path))
  }

  chunk_nrows <- as.integer(chunk_nrows)
  probe_nrows <- as.integer(probe_nrows)

  if (is.na(chunk_nrows) || chunk_nrows <= 0L) {
    stop("'chunk_nrows' must be a positive integer.")
  }
  if (is.na(probe_nrows) || probe_nrows <= 0L) {
    stop("'probe_nrows' must be a positive integer.")
  }

  header_dt <- data.table::fread(
    csv_path,
    nrows = 0L,
    na.strings = na_strings,
    showProgress = FALSE
  )
  col_names <- names(header_dt)

  if (length(col_names) == 0L) {
    stop("CSV has no columns.")
  }

  probe_dt <- data.table::fread(
    csv_path,
    nrows = probe_nrows,
    select = col_names,
    na.strings = na_strings,
    showProgress = FALSE
  )

  probe_classes <- vapply(probe_dt, function(x) class(x)[1L], character(1))
  numeric_classes <- c("integer", "numeric", "integer64")
  numeric_cols <- names(probe_classes)[probe_classes %in% numeric_classes]
  numeric_idx <- match(numeric_cols, col_names)

  if (length(numeric_cols) == 0L) {
    empty_result <- data.table::data.table(
      variable = character(0),
      type = character(0),
      min_value = character(0),
      max_value = character(0)
    )

    if (!is.null(output_path)) {
      data.table::fwrite(empty_result, output_path)
    }

    return(empty_result)
  }

  ranges <- setNames(
    lapply(numeric_cols, function(...) list(min = NULL, max = NULL)),
    numeric_cols
  )

  rows_read <- 0L
  chunk_idx <- 0L

  repeat {
    chunk_idx <- chunk_idx + 1L

    chunk_dt <- tryCatch(
      {
        if (rows_read == 0L) {
          data.table::fread(
            csv_path,
            select = numeric_idx,
            nrows = chunk_nrows,
            na.strings = na_strings,
            showProgress = FALSE
          )
        } else {
          data.table::fread(
            csv_path,
            select = numeric_idx,
            skip = rows_read + 1L,
            nrows = chunk_nrows,
            header = FALSE,
            col.names = numeric_cols,
            na.strings = na_strings,
            showProgress = FALSE
          )
        }
      },
      error = function(e) {
        if (grepl("input only has", conditionMessage(e), fixed = TRUE)) {
          return(data.table::data.table())
        }
        stop(e)
      }
    )

    if (nrow(chunk_dt) == 0L) {
      break
    }

    for (col_name in numeric_cols) {
      x <- chunk_dt[[col_name]]
      x <- x[!is.na(x)]
      if (length(x) == 0L) {
        next
      }

      current_min <- min(x)
      current_max <- max(x)

      if (is.null(ranges[[col_name]]$min)) {
        ranges[[col_name]]$min <- current_min
        ranges[[col_name]]$max <- current_max
      } else {
        ranges[[col_name]]$min <- min(ranges[[col_name]]$min, current_min)
        ranges[[col_name]]$max <- max(ranges[[col_name]]$max, current_max)
      }
    }

    rows_read <- rows_read + nrow(chunk_dt)

    if (show_progress) {
      message(sprintf("Processed chunk %d (%d rows total)", chunk_idx, rows_read))
    }
  }

  result <- data.table::data.table(
    variable = numeric_cols,
    type = unname(probe_classes[numeric_cols]),
    min_value = vapply(
      numeric_cols,
      function(col_name) {
        value <- ranges[[col_name]]$min
        if (is.null(value)) {
          return(NA_character_)
        }
        as.character(value)
      },
      character(1)
    ),
    max_value = vapply(
      numeric_cols,
      function(col_name) {
        value <- ranges[[col_name]]$max
        if (is.null(value)) {
          return(NA_character_)
        }
        as.character(value)
      },
      character(1)
    )
  )

  if (!is.null(output_path)) {
    data.table::fwrite(result, output_path)
  }

  result
}

is_integer_string <- function(x) {
  !is.na(x) && grepl("^[+-]?[0-9]+$", x)
}

int64_outside_int32 <- function(min_value, max_value) {
  int32_max_str <- "2147483647"
  int32_min_str <- "-2147483648"

  abs_gt_int32 <- function(x) {
    x <- trimws(x)
    if (!is_integer_string(x)) {
      return(FALSE)
    }

    sign <- substr(x, 1L, 1L)
    unsigned <- if (sign %in% c("+", "-")) {
      substring(x, 2L)
    } else {
      x
    }
    unsigned <- sub("^0+", "", unsigned)
    if (identical(unsigned, "")) {
      unsigned <- "0"
    }

    limit <- if (identical(sign, "-")) int32_min_str else int32_max_str
    limit_unsigned <- gsub("-", "", limit, fixed = TRUE)

    if (nchar(unsigned) != nchar(limit_unsigned)) {
      return(nchar(unsigned) > nchar(limit_unsigned))
    }
    unsigned > limit_unsigned
  }

  abs_gt_int32(min_value) || abs_gt_int32(max_value)
}

build_arrow_schema_from_ranges <- function(csv_path,
                                           ranges_dt,
                                           probe_nrows = 100000L,
                                           na_strings = c("", "NA", "NaN", "NULL")) {
  if (!requireNamespace("data.table", quietly = TRUE)) {
    stop("Package 'data.table' is required. Install it with install.packages('data.table').")
  }
  if (!requireNamespace("arrow", quietly = TRUE)) {
    stop("Package 'arrow' is required. Install it with install.packages('arrow').")
  }

  header_dt <- data.table::fread(
    csv_path,
    nrows = 0L,
    na.strings = na_strings,
    showProgress = FALSE
  )
  col_names <- names(header_dt)

  probe_dt <- data.table::fread(
    csv_path,
    nrows = as.integer(probe_nrows),
    select = col_names,
    na.strings = na_strings,
    showProgress = FALSE
  )

  base_types <- vapply(probe_dt, function(x) class(x)[1L], character(1))
  range_map <- split(ranges_dt, by = "variable", keep.by = FALSE)

  schema_fields <- vector("list", length(col_names))
  names(schema_fields) <- col_names

  for (col_name in col_names) {
    range_info <- range_map[[col_name]]

    if (is.null(range_info)) {
      schema_fields[[col_name]] <- arrow::utf8()
      next
    }

    col_type <- as.character(range_info$type[[1L]])
    min_value <- as.character(range_info$min_value[[1L]])
    max_value <- as.character(range_info$max_value[[1L]])

    if (identical(col_type, "integer64")) {
      schema_fields[[col_name]] <- arrow::int64()
    } else if (identical(col_type, "integer")) {
      if (int64_outside_int32(min_value, max_value)) {
        schema_fields[[col_name]] <- arrow::int64()
      } else {
        schema_fields[[col_name]] <- arrow::int32()
      }
    } else if (identical(col_type, "numeric")) {
      schema_fields[[col_name]] <- arrow::float64()
    } else {
      inferred <- base_types[[col_name]]
      if (inferred %in% c("integer", "integer64")) {
        schema_fields[[col_name]] <- arrow::int64()
      } else if (identical(inferred, "numeric")) {
        schema_fields[[col_name]] <- arrow::float64()
      } else {
        schema_fields[[col_name]] <- arrow::utf8()
      }
    }
  }

  do.call(arrow::schema, schema_fields)
}

convert_csv_to_parquet_from_ranges <- function(csv_path,
                                               ranges_path,
                                               parquet_path = NULL,
                                               compression = "snappy",
                                               probe_nrows = 100000L,
                                               na_strings = c("", "NA", "NaN", "NULL")) {
  if (!requireNamespace("data.table", quietly = TRUE)) {
    stop("Package 'data.table' is required. Install it with install.packages('data.table').")
  }
  if (!requireNamespace("arrow", quietly = TRUE)) {
    stop("Package 'arrow' is required. Install it with install.packages('arrow').")
  }
  if (!file.exists(csv_path)) {
    stop(sprintf("CSV file not found: %s", csv_path))
  }
  if (!file.exists(ranges_path)) {
    stop(sprintf("Ranges file not found: %s", ranges_path))
  }

  if (is.null(parquet_path)) {
    parquet_path <- sub("\\.csv$", ".parquet", csv_path, ignore.case = TRUE)
    if (identical(parquet_path, csv_path)) {
      parquet_path <- paste0(csv_path, ".parquet")
    }
  }

  ranges_dt <- data.table::fread(ranges_path, showProgress = FALSE)
  required_cols <- c("variable", "type", "min_value", "max_value")
  if (!all(required_cols %in% names(ranges_dt))) {
    stop("Ranges dataset must contain: variable, type, min_value, max_value")
  }

  schema <- build_arrow_schema_from_ranges(
    csv_path = csv_path,
    ranges_dt = ranges_dt,
    probe_nrows = probe_nrows,
    na_strings = na_strings
  )

  tab <- arrow::read_csv_arrow(
    csv_path,
    schema = schema,
    as_data_frame = FALSE,
    na = na_strings,
    col_names = FALSE,
    skip = 1L
  )

  arrow::write_parquet(tab, parquet_path, compression = compression)

  invisible(list(parquet_path = parquet_path, schema = schema))
}
