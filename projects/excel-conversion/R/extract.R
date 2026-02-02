#' Extract an Excel workbook to structured JSON
#'
#' @param input Path to the source `.xlsx` file.
#' @param output Optional destination path for the JSON (defaults to `output/`).
#' @param sheets Optional character or integer vector limiting extraction to specific sheets.
#' @param compact Logical, default `FALSE`. When `TRUE`, emit minified JSON.
#' @param gzip Logical, default `FALSE`. When `TRUE`, compress output using gzip.
#'
#' @return Invisibly returns the output path.
#' @examples
#' 
#' 
#' extract_excel_to_json("examples/mineraloelerzeugnisse.xlsx", sheets = "61241-b01", gzip = TRUE)
#' @export
extract_excel_to_json <- function(input,
                                  output = NULL,
                                  sheets = NULL,
                                  compact = FALSE,
                                  gzip = FALSE) {
  input <- normalize_input_path(input)
  wb <- with_muffled_translation_warnings(openxlsx2::wb_load(input))
  sheet_indices <- resolve_sheet_indices(wb, sheets)
  payload <- with_muffled_translation_warnings(
    extract_workbook_internal(wb, input, sheet_indices)
  )
  output_path <- ensure_output_path(output, input, suffix = "json", sheets = sheets, gzip = gzip)
  write_json_payload(payload, output_path, compact = compact, gzip = gzip)
  invisible(output_path)
}

extract_workbook_internal <- function(wb, source_path, sheet_indices) {
  shared_strings <- read_shared_strings(wb)
  styles <- extract_styles(wb)
  defined_names <- extract_defined_names(wb)
  wb_props <- suppressWarnings(wb$get_properties())
  visibility <- get_sheet_visibility(wb)
  sheet_names <- openxlsx2::wb_get_sheet_names(wb)
  sheet_payload <- lapply(seq_along(sheet_indices), function(pos) {
    idx <- sheet_indices[[pos]]
    cli::cli_alert_info("Extracting sheet {pos}/{length(sheet_indices)}: {sheet_names[[idx]]}")
    extract_sheet(wb, idx, shared_strings = shared_strings, visibility = visibility)
  })

  list(
    schema_version = "1.0.0",
    generator = list(name = "excelex", version = package_version_string("excelex")),
    generated_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
    source = list(
      path = source_path,
      sheet_total = length(wb$worksheets),
      sheets_processed = sheet_names[sheet_indices]
    ),
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

read_shared_strings <- function(wb) {
  if (length(wb$sharedStrings) == 0) return(list())
  lapply(seq_along(wb$sharedStrings), function(idx) {
    raw <- enc2utf8(wb$sharedStrings[[idx]])
    node <- xml2::read_xml(raw)
    list(
      index = idx - 1L,
      text = xml2::xml_text(node, trim = FALSE),
      rich = xml2::as_list(node)
    )
  })
}

xml_nodes_to_list <- function(fragment, root = "root") {
  if (length(fragment) == 0) return(list())
  fragment <- fragment[!is.na(fragment)]
  if (length(fragment) == 0 || all(!nzchar(fragment))) return(list())
  fragment <- enc2utf8(fragment)
  xml <- suppressWarnings(xml2::read_xml(paste0("<", root, ">", paste(fragment, collapse = ""), "</", root, ">")))
  lapply(xml2::xml_children(xml), xml2::as_list)
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

  data.frame(
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
}

extract_sheet <- function(wb, sheet_id, shared_strings, visibility) {
  sheet <- wb$worksheets[[sheet_id]]
  sheet_name <- openxlsx2::wb_get_sheet_names(wb)[[sheet_id]]
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

write_json_payload <- function(payload, path, compact = FALSE, gzip = FALSE) {
  cli::cli_alert_info("Writing JSON to {path}")
  json <- jsonlite::toJSON(
    payload,
    pretty = !compact,
    auto_unbox = TRUE,
    null = "null",
    na = "null",
    digits = NA,
    dataframe = "rows"
  )
  if (gzip) {
    con <- gzfile(path, open = "wb")
    on.exit(close(con), add = TRUE)
    writeBin(charToRaw(json), con)
  } else {
    writeLines(json, path, useBytes = TRUE)
  }
  invisible(path)
}
