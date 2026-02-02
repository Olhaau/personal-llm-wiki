#' @keywords internal
normalize_input_path <- function(path) {
  if (is.null(path) || !nzchar(path)) {
    stop("Input path must be provided", call. = FALSE)
  }
  if (!file.exists(path)) {
    stop(sprintf("Input file '%s' not found", path), call. = FALSE)
  }
  if (!grepl("\\.xlsx$", path, ignore.case = TRUE)) {
    stop("Input must be an .xlsx file", call. = FALSE)
  }
  normalizePath(path, winslash = "/", mustWork = TRUE)
}

#' @keywords internal
ensure_output_path <- function(path, input_path, suffix = "json", sheets = NULL, gzip = FALSE) {
  if (is.null(path) || identical(path, "")) {
    base <- tools::file_path_sans_ext(basename(input_path))
    if (!is.null(sheets) && length(sheets) == 1L) {
      base <- sprintf("%s_%s", base, sheets[[1]])
    }
    ext <- if (gzip) sprintf("%s.gz", suffix) else suffix
    path <- file.path("output", sprintf("%s.%s", base, ext))
  }
  dir <- dirname(path)
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  }
  normalizePath(path, winslash = "/", mustWork = FALSE)
}

#' @keywords internal
with_muffled_translation_warnings <- function(expr) {
  withCallingHandlers(expr, warning = function(w) {
    if (grepl("unable to translate", conditionMessage(w), fixed = TRUE)) {
      invokeRestart("muffleWarning")
    }
  })
}

#' @keywords internal
col_letters_to_index <- function(ref) {
  if (is.na(ref) || !nzchar(ref)) return(NA_integer_)
  letters <- strsplit(toupper(ref), "")[[1]]
  Reduce(function(acc, chr) acc * 26L + (match(chr, LETTERS)), letters, init = 0L)
}

#' @keywords internal
resolve_sheet_indices <- function(wb, requested = NULL) {
  total <- seq_along(wb$worksheets)
  if (is.null(requested) || length(requested) == 0) return(total)
  sheet_names <- openxlsx2::wb_get_sheet_names(wb)
  idx <- integer()
  for (item in requested) {
    if (item %in% sheet_names) {
      idx <- c(idx, match(item, sheet_names))
    } else if (grepl("^[0-9]+$", item)) {
      numeric_index <- as.integer(item)
      if (!numeric_index %in% total) {
        stop(sprintf("Sheet index %s out of range", item), call. = FALSE)
      }
      idx <- c(idx, numeric_index)
    } else {
      stop(sprintf("Sheet '%s' not found", item), call. = FALSE)
    }
  }
  unique(idx)
}

#' @keywords internal
package_version_string <- function(pkg) {
  ver <- tryCatch(utils::packageVersion(pkg), error = function(...) NA)
  if (is.na(ver)) "0.0.0" else as.character(ver)
}

#' @keywords internal
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

#' @keywords internal
read_json_payload <- function(path) {
  if (grepl("\\.gz$", path, ignore.case = TRUE)) {
    con <- gzfile(path, open = "rb")
    on.exit(close(con), add = TRUE)
    jsonlite::fromJSON(con, simplifyVector = FALSE)
  } else {
    jsonlite::fromJSON(path, simplifyVector = FALSE)
  }
}
