find_stata_executable <- function() {
  candidates <- c("stata-mp", "stata-se", "stata")
  paths <- Sys.which(candidates)
  available <- unname(paths[paths != ""])

  if (length(available) == 0L) {
    return(NA_character_)
  }

  available[[1]]
}

run_stata_compress <- function(stata_exe, dta_path) {
  do_path <- tempfile(fileext = ".do")
  do_lines <- c(
    sprintf('use "%s", clear', normalizePath(dta_path, winslash = "/", mustWork = TRUE)),
    "compress",
    sprintf('save "%s", replace', normalizePath(dta_path, winslash = "/", mustWork = TRUE)),
    "exit, clear"
  )
  writeLines(do_lines, do_path)

  args <- c("-b", "do", do_path)
  status <- system2(stata_exe, args = args, stdout = TRUE, stderr = TRUE)
  attr(status, "status") %||% 0L
}

`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

convert_parquet_to_dta <- function(parquet_path,
                                   dta_path = NULL,
                                   use_stata_compress = TRUE,
                                   stata_exe = NULL) {
  if (!requireNamespace("arrow", quietly = TRUE)) {
    stop("Package 'arrow' is required. Install it with install.packages('arrow').")
  }
  if (!requireNamespace("haven", quietly = TRUE)) {
    stop("Package 'haven' is required. Install it with install.packages('haven').")
  }

  if (!file.exists(parquet_path)) {
    stop(sprintf("Parquet file not found: %s", parquet_path))
  }

  if (is.null(dta_path)) {
    dta_path <- sub("\\.parquet$", ".dta", parquet_path, ignore.case = TRUE)
    if (identical(dta_path, parquet_path)) {
      dta_path <- paste0(parquet_path, ".dta")
    }
  }

  data <- arrow::read_parquet(parquet_path, as_data_frame = TRUE)

  for (name in names(data)) {
    if (inherits(data[[name]], "integer64")) {
      values_chr <- as.character(stats::na.omit(data[[name]]))
      values_num <- suppressWarnings(as.numeric(values_chr))
      precision_limit <- 9007199254740991
      if (any(abs(values_num) > precision_limit, na.rm = TRUE)) {
        warning(
          sprintf(
            "Column '%s' exceeds 2^53-1 and may lose integer precision in Stata.",
            name
          ),
          call. = FALSE
        )
      }
      data[[name]] <- as.double(data[[name]])
    }
  }

  # Stata 18 can read DTA version 15; haven currently writes up to version 15.
  haven::write_dta(data, path = dta_path, version = 15)

  stata_compress_applied <- FALSE
  if (isTRUE(use_stata_compress)) {
    if (is.null(stata_exe)) {
      stata_exe <- find_stata_executable()
    }

    if (is.na(stata_exe)) {
      warning(
        "Stata executable not found (looked for stata-mp, stata-se, stata). Saved uncompressed .dta.",
        call. = FALSE
      )
    } else {
      status <- run_stata_compress(stata_exe, dta_path)
      if (identical(status, 0L)) {
        stata_compress_applied <- TRUE
      } else {
        warning(
          sprintf("Stata compress step failed with status %s. Saved base .dta.", status),
          call. = FALSE
        )
      }
    }
  }

  invisible(list(
    dta_path = dta_path,
    stata_format_version = 15,
    stata_compress_applied = stata_compress_applied,
    stata_executable = if (isTRUE(use_stata_compress)) stata_exe else NA_character_
  ))
}
