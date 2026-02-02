#!/usr/bin/env Rscript

argv <- commandArgs(trailingOnly = TRUE)

usage <- function() {
  cat("Usage: Rscript scripts/json_to_excel.R --input <file.json> [--output <file.xlsx>]", "\n")
  invisible(NULL)
}

parse_args <- function(args) {
  out <- list(input = NULL, output = NULL, apply_mods = NULL)
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
    } else if (flag == "--apply-mods") {
      i <- i + 1L
      if (i > length(args)) stop("Missing value for --apply-mods", call. = FALSE)
      out$apply_mods <- args[[i]]
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
  if (requireNamespace("excelex", quietly = TRUE)) return(invisible(NULL))
  if (!requireNamespace("devtools", quietly = TRUE)) {
    stop("Package 'excelex' is not installed and devtools is unavailable to load it.", call. = FALSE)
  }
  devtools::load_all(".")
}

main <- function() {
  args <- parse_args(argv)
  load_excelex()
  excelex::json_to_excel(
    input = args$input,
    output = args$output,
    apply_mods = args$apply_mods
  )
}

if (!interactive()) {
  tryCatch(main(), error = function(e) {
    cli::cli_alert_danger(conditionMessage(e))
    quit(status = 1L, runLast = FALSE)
  })
}
