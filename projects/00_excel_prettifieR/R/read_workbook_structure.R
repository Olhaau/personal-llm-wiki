#' Read workbook and capture structure
#'
#' Reads an Excel workbook using openxlsx2 and returns a list containing the
#' workbook object and its structure captured via `str()`.
#'
#' @param path Character path to the .xlsx file.
#' @return A list with elements `workbook` and `structure`.
#' @export
read_workbook_structure <- function(path) {
  if (!is.character(path) || length(path) != 1 || !nzchar(path)) {
    stop("`path` must be a non-empty character string.")
  }

  if (!file.exists(path)) {
    stop("File not found: ", path)
  }

  wb <- tryCatch(
    openxlsx2::wb_load(path),
    error = function(e) {
      stop("Failed to load workbook: ", e$message)
    }
  )

  structure <- utils::capture.output(str(wb))

  list(
    workbook = wb,
    structure = structure
  )
}

#' Write workbook structure as JSON
#'
#' Reads an Excel workbook using openxlsx2 and writes its `str()` output to a
#' JSON file for downstream inspection.
#'
#' @param path Character path to the .xlsx file.
#' @param output_path Character path to the JSON output.
#' @return The JSON output path, invisibly.
#' @export
write_workbook_structure_json <- function(path, output_path) {
  if (!is.character(output_path) || length(output_path) != 1 || !nzchar(output_path)) {
    stop("`output_path` must be a non-empty character string.")
  }

  wb <- read_workbook_structure(path)$workbook

  decode_xml_text <- function(x) {
    x <- gsub("&amp;", "&", x, fixed = TRUE)
    x <- gsub("&lt;", "<", x, fixed = TRUE)
    x <- gsub("&gt;", ">", x, fixed = TRUE)
    x <- gsub("&quot;", "\"", x, fixed = TRUE)
    x <- gsub("&apos;", "'", x, fixed = TRUE)
    x
  }

  extract_shared_strings <- function(ss) {
    if (is.null(ss) || length(ss) == 0) {
      return(character())
    }

    values <- gsub("<[^>]+>", "", ss)
    values <- decode_xml_text(values)
    values
  }

  sanitize_for_json <- function(x) {
    if (is.null(x)) {
      return(NULL)
    }

    if (is.function(x) || is.environment(x) || inherits(x, "R6")) {
      return(NULL)
    }

    if (inherits(x, c("xml_document", "xml_node"))) {
      return(as.character(x))
    }

    if (typeof(x) == "externalptr") {
      return(NULL)
    }

    if (is.atomic(x)) {
      return(x)
    }

    if (is.data.frame(x)) {
      return(lapply(x, sanitize_for_json))
    }

    if (is.list(x)) {
      cleaned <- lapply(x, sanitize_for_json)
      keep <- !vapply(cleaned, is.null, logical(1))
      return(cleaned[keep])
    }

    as.character(x)
  }

  extract_sheet_content <- function(ws, sheet_name, shared_strings) {
    cc <- ws$sheet_data$cc
    if (is.null(cc) || !is.data.frame(cc) || nrow(cc) == 0) {
      return(list(sheet = sheet_name, cells = list()))
    }

    cells <- lapply(seq_len(nrow(cc)), function(i) {
      value_type <- cc$c_t[i]
      raw_value <- cc$v[i]
      resolved_value <- raw_value

      if (!is.na(value_type) && value_type == "s") {
        idx <- suppressWarnings(as.integer(raw_value))
        if (!is.na(idx) && (idx + 1) <= length(shared_strings)) {
          resolved_value <- shared_strings[[idx + 1]]
        }
      }

      list(
        sheet = sheet_name,
        coord = cc$r[i],
        row = cc$row_r[i],
        col = cc$c_r[i],
        value_type = value_type,
        value = resolved_value,
        formula = cc$f[i],
        formula_attr = cc$f_attr[i],
        inline = cc$is[i]
      )
    })

    list(sheet = sheet_name, cells = cells)
  }

  extract_sheet_formats <- function(ws, sheet_name) {
    cc <- ws$sheet_data$cc
    cell_formats <- list()

    if (!is.null(cc) && is.data.frame(cc) && nrow(cc) > 0) {
      cell_formats <- lapply(seq_len(nrow(cc)), function(i) {
        list(
          sheet = sheet_name,
          coord = cc$r[i],
          style_id = cc$c_s[i]
        )
      })
    }

    list(
      sheet = sheet_name,
      dimension = ws$dimension,
      merges = ws$mergeCells,
      columns = ws$cols_attr,
      rows = ws$sheet_data$row_attr,
      sheet_format_pr = ws$sheetFormatPr,
      sheet_views = ws$sheetViews,
      sheet_pr = ws$sheetPr,
      sheet_protection = ws$sheetProtection,
      freeze_pane = ws$freezePane,
      page_margins = ws$pageMargins,
      page_setup = ws$pageSetup,
      header_footer = ws$headerFooter,
      print_options = ws$printOptions,
      hyperlinks = ws$hyperlinks,
      data_validations = ws$dataValidations,
      conditional_formatting = ws$conditionalFormatting,
      auto_filter = ws$autoFilter,
      row_breaks = ws$rowBreaks,
      col_breaks = ws$colBreaks,
      table_parts = ws$tableParts,
      drawings = ws$drawing,
      drawings_hf = ws$drawingHF,
      relships = ws$relships,
      cell_formats = cell_formats
    )
  }

  styles <- NULL
  if (!is.null(wb$styles_mgr)) {
    styles <- list(
      styles = wb$styles_mgr$styles,
      fonts = wb$styles_mgr$font,
      fills = wb$styles_mgr$fill,
      borders = wb$styles_mgr$border,
      numfmt = wb$styles_mgr$numfmt,
      xf = wb$styles_mgr$xf,
      cell_style_xf = wb$styles_mgr$cellStyleXf,
      cell_style = wb$styles_mgr$cellStyle,
      dxf = wb$styles_mgr$dxf,
      table_style = wb$styles_mgr$tableStyle
    )
  }

  shared_strings <- extract_shared_strings(wb$sharedStrings)

  sheet_content <- list()
  sheet_formats <- list()

  if (!is.null(wb$worksheets) && length(wb$worksheets) > 0) {
    sheet_names <- wb$sheet_names
    sheet_content <- lapply(seq_along(wb$worksheets), function(i) {
      extract_sheet_content(wb$worksheets[[i]], sheet_names[[i]], shared_strings)
    })
    sheet_formats <- lapply(seq_along(wb$worksheets), function(i) {
      extract_sheet_formats(wb$worksheets[[i]], sheet_names[[i]])
    })
  }

  payload <- list(
    schema_version = "1.0",
    source_path = normalizePath(path, winslash = "/", mustWork = TRUE),
    workbook = list(
      sheet_names = wb$sheet_names,
      sheet_order = wb$sheetOrder,
      properties = wb$get_properties(),
      theme = wb$theme
    ),
    formats = list(
      styles = styles,
      sheets = sheet_formats
    ),
    content = list(
      shared_strings = shared_strings,
      sheets = sheet_content
    )
  )

  payload <- sanitize_for_json(payload)

  tryCatch(
    jsonlite::write_json(payload, output_path, pretty = TRUE, auto_unbox = TRUE),
    error = function(e) {
      stop("Failed to write JSON output: ", e$message)
    }
  )

  invisible(output_path)
}
