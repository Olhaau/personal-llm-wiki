#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(cli)
  library(jsonlite)
  library(openxlsx2)
  library(xml2)
})

with_muffled_translation_warnings <- function(expr) {
  withCallingHandlers(expr, warning = function(w) {
    msg <- conditionMessage(w)
    if (grepl("unable to translate", msg, fixed = TRUE)) {
      invokeRestart("muffleWarning")
    }
  })
}

usage <- function() {
  cli_text("{col_blue('Usage:')} Rscript scripts/extract_excel_to_json.R --input <file.xlsx> [--output <file.json>] [--compact]")
  cli_text("\nFlags:")
  cli_text("  --input       Path to source .xlsx workbook (required)")
  cli_text("  --output      Destination JSON path (default: output/<basename>.json)")
  cli_text("  --compact     Emit minified JSON instead of pretty format")
  invisible(NULL)
}

parse_args <- function(argv) {
  if (length(argv) == 0) {
    usage()
    stop("No arguments supplied", call. = FALSE)
  }

  args <- list(input = NULL, output = NULL, compact = FALSE)
  i <- 1L
  while (i <= length(argv)) {
    flag <- argv[[i]]
    if (identical(flag, "--input")) {
      i <- i + 1L
      if (i > length(argv)) stop("Missing value for --input", call. = FALSE)
      args$input <- argv[[i]]
    } else if (identical(flag, "--output")) {
      i <- i + 1L
      if (i > length(argv)) stop("Missing value for --output", call. = FALSE)
      args$output <- argv[[i]]
    } else if (identical(flag, "--compact")) {
      args$compact <- TRUE
    } else if (identical(flag, "--help")) {
      usage()
      quit(status = 0L, runLast = FALSE)
    } else {
      stop(sprintf("Unknown argument: %s", flag), call. = FALSE)
    }
    i <- i + 1L
  }

  if (is.null(args$input)) {
    usage()
    stop("--input is required", call. = FALSE)
  }

  args
}

ensure_output_path <- function(path) {
  if (is.null(path) || identical(path, "")) return(path)
  dir <- dirname(path)
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  }
  path
}

normalize_input <- function(path) {
  if (!file.exists(path)) {
    stop(sprintf("Input file '%s' not found", path), call. = FALSE)
  }
  if (!grepl("\\.xlsx$", path, ignore.case = TRUE)) {
    stop("Input must be an .xlsx file", call. = FALSE)
  }
  normalizePath(path, winslash = "/", mustWork = TRUE)
}

col_letters_to_index <- function(ref) {
  if (is.na(ref) || !nzchar(ref)) return(NA_integer_)
  letters <- strsplit(toupper(ref), "")[[1]]
  Reduce(function(acc, chr) acc * 26L + (match(chr, LETTERS)), letters, init = 0L)
}

read_shared_strings <- function(wb) {
  if (length(wb$sharedStrings) == 0) return(list())
  lapply(seq_along(wb$sharedStrings), function(idx) {
    raw <- wb$sharedStrings[[idx]]
    node <- read_xml(raw)
    list(
      index = idx - 1L,
      text = xml_text(node, trim = FALSE),
      rich = as_list(node)
    )
  })
}

xml_nodes_to_list <- function(fragment, root = "root") {
  if (length(fragment) == 0) return(list())
  fragment <- fragment[!is.na(fragment)]
  if (length(fragment) == 0) return(list())
  if (all(!nzchar(fragment))) return(list())
  fragment <- enc2utf8(fragment)
  xml <- suppressWarnings(read_xml(paste0("<", root, ">", paste(fragment, collapse = ""), "</", root, ">")))
  lapply(xml_children(xml), xml2::as_list)
}

get_sheet_visibility <- function(wb) {
  if ("get_sheet_visibility" %in% names(wb)) {
    return(wb$get_sheet_visibility())
  }
  if (exists("wb_get_sheet_visibility", envir = asNamespace("openxlsx2"), inherits = FALSE)) {
    return(openxlsx2::wb_get_sheet_visibility(wb))
  }
  rep("visible", length(wb$worksheets))
}

extract_styles <- function(wb) {
  styles <- wb$styles_mgr
  if (is.null(styles) || length(styles$styles) == 0) {
    return(list())
  }
  style_parts <- styles$styles
  list(
    num_formats = xml_nodes_to_list(style_parts$numFmts, "numFmts"),
    fonts = xml_nodes_to_list(style_parts$fonts, "fonts"),
    fills = xml_nodes_to_list(style_parts$fills, "fills"),
    borders = xml_nodes_to_list(style_parts$borders, "borders"),
    cell_style_xfs = xml_nodes_to_list(style_parts$cellStyleXfs, "cellStyleXfs"),
    cell_xfs = xml_nodes_to_list(style_parts$cellXfs, "cellXfs"),
    cell_styles = xml_nodes_to_list(style_parts$cellStyles, "cellStyles"),
    dxfs = xml_nodes_to_list(style_parts$dxfs, "dxfs"),
    table_styles = enc2utf8(style_parts$tableStyles),
    colors = xml_nodes_to_list(style_parts$colors, "colors"),
    ext_lst = xml_nodes_to_list(style_parts$extLst, "extLst")
  )
}

extract_defined_names <- function(wb) {
  xml_nodes_to_list(wb$workbook$definedNames, "definedNames")
}

extract_sheet_structures <- function(sheet) {
  list(
    sheet_pr = xml_nodes_to_list(sheet$sheetPr, "sheetPr"),
    sheet_views = xml_nodes_to_list(sheet$sheetViews, "sheetViews"),
    sheet_format_pr = xml_nodes_to_list(sheet$sheetFormatPr, "sheetFormatPr"),
    cols = xml_nodes_to_list(sheet$cols_attr, "cols"),
    merge_cells = sheet$mergeCells,
    conditional_formatting = xml_nodes_to_list(sheet$conditionalFormatting, "conditionalFormatting"),
    data_validations = xml_nodes_to_list(sheet$dataValidations, "dataValidations"),
    auto_filter = xml_nodes_to_list(sheet$autoFilter, "autoFilter"),
    tables = xml_nodes_to_list(sheet$tableParts, "tableParts"),
    hyperlinks = xml_nodes_to_list(sheet$hyperlinks, "hyperlinks"),
    drawings = xml_nodes_to_list(sheet$drawing, "drawing"),
    page_setup = xml_nodes_to_list(sheet$pageSetup, "pageSetup"),
    page_margins = xml_nodes_to_list(sheet$pageMargins, "pageMargins"),
    header_footer = xml_nodes_to_list(sheet$headerFooter, "headerFooter"),
    sheet_protection = xml_nodes_to_list(sheet$sheetProtection, "sheetProtection"),
    ext_lst = xml_nodes_to_list(sheet$extLst, "extLst"),
    legacy_drawing = xml_nodes_to_list(sheet$legacyDrawing, "legacyDrawing")
  )
}

extract_row_heights <- function(sheet_data) {
  if (is.null(sheet_data$row_attr) || nrow(sheet_data$row_attr) == 0) return(list())
  df <- sheet_data$row_attr
  rows <- vector("list", nrow(df))
  for (i in seq_len(nrow(df))) {
    row <- df[i, , drop = FALSE]
    rows[[i]] <- as.list(row[!is.na(row)])
  }
  rows
}

extract_cells <- function(cell_cache, shared_strings) {
  if (is.null(cell_cache) || nrow(cell_cache) == 0) return(data.frame())
  cell_cache[] <- lapply(cell_cache, function(col) {
    if (is.factor(col)) as.character(col) else col
  })
  cell_cache$row_index <- as.integer(cell_cache$row_r)
  cell_cache$col_index <- vapply(cell_cache$c_r, col_letters_to_index, integer(1))
  cell_cache$shared_text <- NA_character_
  ss_lookup <- NULL
  if (length(shared_strings) > 0) {
    text_vec <- vapply(shared_strings, function(x) x$text, character(1))
    names(text_vec) <- vapply(shared_strings, function(x) as.character(x$index), character(1))
    ss_lookup <- text_vec
  }
  o <- order(cell_cache$row_index, cell_cache$col_index)
  cell_cache <- cell_cache[o, , drop = FALSE]
  n <- nrow(cell_cache)
  non_empty <- function(x) {
    if (is.null(x)) return(rep(NA_character_, n))
    val <- as.character(x)
    val[is.na(val) | !nzchar(val)] <- NA_character_
    val
  }

  type <- non_empty(cell_cache$c_t)
  raw_value <- non_empty(cell_cache$v)
  inline_string <- non_empty(cell_cache$is)
  formula <- non_empty(cell_cache$f)
  formula_attr <- non_empty(cell_cache$f_attr)
  style_id <- as.integer(non_empty(cell_cache$c_s))

  resolved_value <- raw_value
  if (!is.null(ss_lookup)) {
    ss_index <- raw_value
    mask_ss <- !is.na(type) & type == "s" & !is.na(ss_index)
    if (any(mask_ss)) {
      keys <- as.character(as.integer(ss_index[mask_ss]))
      resolved_value[mask_ss] <- ss_lookup[keys]
    }
  }
  mask_inline <- !is.na(inline_string)
  if (any(mask_inline)) {
    resolved_value[mask_inline] <- inline_string[mask_inline]
  }

  df <- data.frame(
    address = cell_cache$r,
    row = cell_cache$row_index,
    col = cell_cache$col_index,
    type = type,
    raw_value = raw_value,
    resolved_value = resolved_value,
    inline_string = inline_string,
    formula = formula,
    formula_attributes = formula_attr,
    style_id = style_id,
    stringsAsFactors = FALSE
  )
  df
}

extract_sheet <- function(wb, sheet_id, shared_strings, visibility) {
  sheet <- wb$worksheets[[sheet_id]]
  sheet_name <- wb_get_sheet_names(wb)[[sheet_id]]
  structures <- extract_sheet_structures(sheet)
  sheet_data <- sheet$sheet_data
  row_info <- extract_row_heights(sheet_data)
  list(
    name = sheet_name,
    position = sheet_id,
    state = visibility[[sheet_id]],
    dimension = sheet$dimension,
    structures = structures,
    rows = row_info,
    cells = extract_cells(sheet_data$cc, shared_strings)
  )
}

extract_workbook <- function(wb, source_path) {
  cli_alert_info("Loading workbook")
  sheets <- seq_along(wb$worksheets)
  shared_strings <- read_shared_strings(wb)
  styles <- extract_styles(wb)
  defined_names <- extract_defined_names(wb)
  wb_props <- suppressWarnings(wb$get_properties())
  visibility <- get_sheet_visibility(wb)
  sheet_names <- wb_get_sheet_names(wb)
  sheet_payload <- lapply(sheets, function(idx) {
    cli_alert_info("Extracting sheet {idx}/{length(sheets)}: {sheet_names[[idx]]}")
    extract_sheet(wb = wb, sheet_id = idx, shared_strings = shared_strings, visibility = visibility)
  })

  list(
    schema_version = "1.0.0",
    generator = list(name = "excel-conversion", version = "0.1.0"),
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    source = list(path = source_path, sheet_count = length(sheets)),
    workbook = list(
      properties = wb_props,
      defined_names = defined_names,
      calc_properties = xml_nodes_to_list(wb$workbook$calcPr, "calcPr"),
      custom_properties = xml_nodes_to_list(wb$workbook$customWorkbookViews, "customWorkbookViews"),
      book_views = xml_nodes_to_list(wb$workbook$bookViews, "bookViews"),
      pivot_caches = xml_nodes_to_list(wb$workbook$pivotCaches, "pivotCaches"),
      themes = if (length(wb$theme) > 0) xml_nodes_to_list(wb$theme, "theme") else list()
    ),
    shared_strings = shared_strings,
    styles = styles,
    sheets = sheet_payload
  )
}

write_output <- function(payload, path, compact) {
  cli_alert_info("Writing JSON to {path}")
  json <- jsonlite::toJSON(
    payload,
    pretty = !compact,
    auto_unbox = TRUE,
    null = "null",
    na = "null",
    digits = NA,
    dataframe = "rows"
  )
  writeLines(json, path, useBytes = TRUE)
  invisible(path)
}

main <- function() {
  args <- parse_args(commandArgs(trailingOnly = TRUE))
  input <- normalize_input(args$input)
  output <- if (!is.null(args$output)) args$output else file.path("output", sprintf("%s.json", tools::file_path_sans_ext(basename(input))))
  output <- ensure_output_path(output)

  cli_alert_info("Loading workbook from {input}")
  wb <- tryCatch(
    with_muffled_translation_warnings(wb_load(input)),
    error = function(e) {
      stop(sprintf("Failed to load workbook: %s", e$message), call. = FALSE)
    }
  )

  payload <- with_muffled_translation_warnings(extract_workbook(wb, input))
  write_output(payload, output, args$compact)
  cli_alert_success("Extraction complete: {output}")
  quit(status = 0L, runLast = FALSE)
}

if (identical(environment(), globalenv()) && !interactive()) {
  main()
}
