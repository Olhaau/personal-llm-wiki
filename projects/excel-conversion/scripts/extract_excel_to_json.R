#!/usr/bin/env Rscript

argv <- commandArgs(trailingOnly = TRUE)

usage <- function() {
  cat("Usage: Rscript scripts/extract_excel_to_json.R --input <file.xlsx> [--output <file.json>] [--sheet <name|index>]... [--compact] [--gzip]", "\n")
  invisible(NULL)
}

parse_args <- function(args) {
  out <- list(input = NULL, output = NULL, sheets = character(), compact = FALSE, gzip = FALSE)
  i <- 1L
  while (i <= length(args)) {
    flag <- args[[i]]
    if (flag == "--input") {
      i <- i + 1L
      if (i > length(args)) stop("Missing value for --input", call. = FALSE)
      out$input <- args[[i]]
    } else if (flag == "--output") {
      i <- i + 1L
      if (i > length(args)) stop("Missing value for --output", call. = FALSE)
      out$output <- args[[i]]
    } else if (flag == "--sheet") {
      i <- i + 1L
      if (i > length(args)) stop("Missing value for --sheet", call. = FALSE)
      out$sheets <- c(out$sheets, args[[i]])
    } else if (flag == "--compact") {
      out$compact <- TRUE
    } else if (flag == "--gzip") {
      out$gzip <- TRUE
    } else if (flag == "--help") {
      usage()
      quit(status = 0L, runLast = FALSE)
    } else {
      stop(sprintf("Unknown flag: %s", flag), call. = FALSE)
    }
    i <- i + 1L
  }
  if (is.null(out$input)) {
    usage()
    stop("--input is required", call. = FALSE)
  }
  out
}

load_excelex <- function() {
  if (requireNamespace("excelex", quietly = TRUE)) {
    return(invisible(NULL))
  }
  if (!requireNamespace("devtools", quietly = TRUE)) {
    stop("Package 'excelex' is not installed and devtools is unavailable to load it.", call. = FALSE)
  }
  devtools::load_all(".")
}

main <- function() {
  args <- parse_args(argv)
  load_excelex()
  out_path <- excelex::extract_excel_to_json(
    input = args$input,
    output = args$output,
    sheets = args$sheets,
    compact = args$compact,
    gzip = args$gzip
  )
  cli::cli_alert_success("JSON written to {out_path}")
}

if (!interactive()) {
  tryCatch(main(), error = function(e) {
    cli::cli_alert_danger(conditionMessage(e))
    quit(status = 1L, runLast = FALSE)
  })
}
