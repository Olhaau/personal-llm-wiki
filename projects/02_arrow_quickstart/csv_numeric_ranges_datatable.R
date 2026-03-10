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
