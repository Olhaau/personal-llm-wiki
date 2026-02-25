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

  `%||%` <- function(x, y) {
    if (is.null(x)) {
      y
    } else {
      x
    }
  }

  wb <- read_workbook_structure(path)$workbook

  default_style_spec <- function() {
    list(
      num_fmt = "default",
      font = "default",
      fill = "default",
      border = "default",
      alignment = "default",
      protection = "default"
    )
  }

  excel_col_from_int <- function(x) {
    letters <- character()
    while (x > 0) {
      mod <- (x - 1) %% 26
      letters <- c(intToUtf8(mod + 65), letters)
      x <- (x - mod - 1) %/% 26
    }
    paste(letters, collapse = "")
  }

  excel_ref <- function(row, col) {
    paste0(excel_col_from_int(col), row)
  }

  parse_cell_ref <- function(ref) {
    if (is.na(ref) || !nzchar(ref)) {
      return(c(NA_integer_, NA_integer_))
    }
    m <- regexec("^([A-Z]+)([0-9]+)$", ref)
    parts <- regmatches(ref, m)[[1]]
    if (length(parts) != 3) {
      return(c(NA_integer_, NA_integer_))
    }
    letters <- unlist(strsplit(parts[2], ""))
    col <- 0
    for (ch in letters) {
      col <- col * 26 + (utf8ToInt(ch) - 64)
    }
    row <- suppressWarnings(as.integer(parts[3]))
    c(row, col)
  }

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
        inline = cc$is[i],
        style_id = cc$c_s[i]
      )
    })

    list(sheet = sheet_name, cells = cells)
  }

  extract_sheet_formats <- function(ws, sheet_name) {
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
      relships = ws$relships
    )
  }

  build_style_specs <- function(styles_mgr, style_ids) {
    if (is.null(styles_mgr)) {
      return(list(default = default_style_spec()))
    }

    xf <- styles_mgr$xf
    fonts <- styles_mgr$font
    fills <- styles_mgr$fill
    borders <- styles_mgr$border
    numfmt <- styles_mgr$numfmt

    style_specs <- list()
    style_specs$default <- default_style_spec()

    if (is.null(xf) || length(xf) == 0) {
      return(style_specs)
    }

    resolve_or_default <- function(x, default) {
      if (is.null(x)) {
        return(default)
      }
      x
    }

    style_ids <- unique(style_ids)
    style_ids <- style_ids[!is.na(style_ids)]
    style_ids <- style_ids[style_ids >= 0]
    if (length(style_ids) == 0) {
      return(style_specs)
    }

    for (style_id in style_ids) {
      idx <- style_id + 1
      if (idx < 1 || idx > length(xf)) {
        style_specs[[paste0("style_", style_id)]] <- default_style_spec()
        next
      }

      item <- xf[[idx]]
      if (!is.list(item)) {
        style_specs[[paste0("style_", style_id)]] <- default_style_spec()
        next
      }

      font_id <- resolve_or_default(item$fontId, NA_integer_)
      fill_id <- resolve_or_default(item$fillId, NA_integer_)
      border_id <- resolve_or_default(item$borderId, NA_integer_)
      num_fmt_id <- resolve_or_default(item$numFmtId, NA_integer_)

      spec <- list(
        num_fmt = "default",
        font = "default",
        fill = "default",
        border = "default",
        alignment = resolve_or_default(item$alignment, "default"),
        protection = resolve_or_default(item$protection, "default"),
        xf = item
      )

      if (!is.na(num_fmt_id) && length(numfmt) >= num_fmt_id) {
        spec$num_fmt <- numfmt[[num_fmt_id]]
      }
      if (!is.na(font_id) && length(fonts) >= (font_id + 1)) {
        spec$font <- fonts[[font_id + 1]]
      }
      if (!is.na(fill_id) && length(fills) >= (fill_id + 1)) {
        spec$fill <- fills[[fill_id + 1]]
      }
      if (!is.na(border_id) && length(borders) >= (border_id + 1)) {
        spec$border <- borders[[border_id + 1]]
      }

      style_specs[[paste0("style_", style_id)]] <- spec
    }

    style_specs
  }

  detect_table_regions <- function(cells) {
    if (nrow(cells) == 0) {
      return(list(
        header = NULL,
        index = NULL,
        body = NULL,
        footer = NULL
      ))
    }

    non_empty <- !(is.na(cells$value) | cells$value == "") | cells$formula != ""
    cells <- cells[non_empty, , drop = FALSE]
    if (nrow(cells) == 0) {
      return(list(
        header = NULL,
        index = NULL,
        body = NULL,
        footer = NULL
      ))
    }

    min_row <- min(cells$row)
    max_row <- max(cells$row)
    min_col <- min(cells$col)
    max_col <- max(cells$col)

    header_rows <- min_row:(min_row + 2)
    footer_rows <- max(max_row - 1, min_row):max_row

    body_rows <- setdiff(min_row:max_row, c(header_rows, footer_rows))
    body_rows <- body_rows[body_rows >= min_row & body_rows <= max_row]

    list(
      header = list(rows = header_rows, cols = min_col:max_col),
      index = list(rows = body_rows, cols = min_col),
      body = list(rows = body_rows, cols = (min_col + 1):max_col),
      footer = list(rows = footer_rows, cols = min_col:max_col)
    )
  }

  subset_cells_region <- function(cells, region) {
    if (is.null(region)) {
      return(cells[0, , drop = FALSE])
    }
    cells[cells$row %in% region$rows & cells$col %in% region$cols, , drop = FALSE]
  }

  compress_region_styles <- function(blocks) {
    if (length(blocks) == 0) {
      return(list(style = "default", blocks = blocks))
    }
    styles <- vapply(blocks, function(block) block$style %||% "default", "")
    styles <- unique(styles)
    if (length(styles) == 1) {
      blocks <- lapply(blocks, function(block) {
        block$style <- NULL
        block
      })
      return(list(style = styles[[1]], blocks = blocks))
    }
    list(style = NULL, blocks = blocks)
  }

  build_cells_df <- function(sheet_cells) {
    if (length(sheet_cells) == 0) {
      return(data.frame())
    }

    cells <- do.call(rbind, lapply(sheet_cells, function(cell) {
      row <- suppressWarnings(as.integer(cell$row))
      col <- suppressWarnings(as.integer(cell$col))
      if (is.na(row) || is.na(col)) {
        parsed <- parse_cell_ref(cell$coord)
        row <- parsed[1]
        col <- parsed[2]
      }
      data.frame(
        coord = cell$coord,
        row = row,
        col = col,
        value_type = ifelse(is.na(cell$value_type), "", cell$value_type),
        value = ifelse(is.null(cell$value), NA, cell$value),
        formula = ifelse(is.null(cell$formula), "", cell$formula),
        formula_attr = ifelse(is.null(cell$formula_attr), "", cell$formula_attr),
        inline = ifelse(is.null(cell$inline), NA, cell$inline),
        style_id = ifelse(is.null(cell$style_id) || is.na(cell$style_id), 0,
                          as.integer(cell$style_id)),
        stringsAsFactors = FALSE
      )
    }))

    cells <- cells[!is.na(cells$row) & !is.na(cells$col), , drop = FALSE]
    if (nrow(cells) == 0) {
      return(cells)
    }

    is_empty <- (is.na(cells$value) | cells$value == "") &
      cells$value_type == "" &
      cells$formula == "" &
      is.na(cells$inline)
    drop_default_empty <- cells$style_id == 0 & is_empty
    cells <- cells[!drop_default_empty, , drop = FALSE]
    cells
  }

  build_blocks_from_df <- function(cells, merges) {
    if (nrow(cells) == 0) {
      return(list())
    }
    if (nrow(cells) == 0) {
      return(list())
    }

    key <- paste(cells$row, cells$col, sep = ":")
    cell_index <- setNames(seq_len(nrow(cells)), key)

    visited <- rep(FALSE, nrow(cells))
    blocks <- list()

    neighbor_keys <- function(row, col) {
      c(
        paste(row - 1, col, sep = ":"),
        paste(row + 1, col, sep = ":"),
        paste(row, col - 1, sep = ":"),
        paste(row, col + 1, sep = ":")
      )
    }

    for (i in seq_len(nrow(cells))) {
      if (visited[i]) {
        next
      }

      target_style <- cells$style_id[i]
      target_type <- cells$value_type[i]
      queue <- i
      members <- integer()

      while (length(queue) > 0) {
        current <- queue[1]
        queue <- queue[-1]

        if (visited[current]) {
          next
        }
        if (cells$style_id[current] != target_style ||
            cells$value_type[current] != target_type) {
          next
        }

        visited[current] <- TRUE
        members <- c(members, current)

        n_keys <- neighbor_keys(cells$row[current], cells$col[current])
        n_idx <- cell_index[n_keys]
        n_idx <- n_idx[!is.na(n_idx)]
        queue <- c(queue, n_idx)
      }

      if (length(members) == 0) {
        next
      }

      block_rows <- cells$row[members]
      block_cols <- cells$col[members]
      min_row <- min(block_rows)
      max_row <- max(block_rows)
      min_col <- min(block_cols)
      max_col <- max(block_cols)

      values_matrix <- matrix("", nrow = max_row - min_row + 1,
                              ncol = max_col - min_col + 1)
      for (idx in members) {
        r <- cells$row[idx] - min_row + 1
        c <- cells$col[idx] - min_col + 1
        values_matrix[r, c] <- cells$value[idx]
      }

      loc <- if (min_row == max_row && min_col == max_col) {
        excel_ref(min_row, min_col)
      } else {
        paste0(excel_ref(min_row, min_col), ":", excel_ref(max_row, max_col))
      }

      connections <- list()
      merge_refs <- NULL
      if (!is.null(merges)) {
        if (is.list(merges) && !is.null(merges$ref)) {
          merge_refs <- merges$ref
        } else if (is.character(merges)) {
          merge_refs <- merges
        }
      }
      if (!is.null(merge_refs) && length(merge_refs) > 0) {
        for (ref in merge_refs) {
          parts <- unlist(strsplit(ref, ":"))
          if (length(parts) == 2) {
            start <- parse_cell_ref(parts[1])
            end <- parse_cell_ref(parts[2])
            if (all(!is.na(c(start, end)))) {
              if (start[1] >= min_row && end[1] <= max_row &&
                  start[2] >= min_col && end[2] <= max_col) {
                connections[[ref]] <- "merge"
              }
            }
          }
        }
      }

      if (target_style == 0 && all(values_matrix == "")) {
        next
      }

      block <- list(
        loc = loc,
        value_type = target_type,
        values = split(values_matrix, row(values_matrix)),
        style = if (target_style == 0) "default" else paste0("style_", target_style)
      )
      if (length(connections) > 0) {
        block$connections <- connections
      }
      blocks[[length(blocks) + 1]] <- block
    }

    blocks
  }

  build_blocks <- function(sheet_cells, merges) {
    cells <- build_cells_df(sheet_cells)
    build_blocks_from_df(cells, merges)
  }

  style_specs <- NULL

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

  content_blocks <- list()
  style_ids_used <- integer()
  if (length(sheet_content) > 0) {
    for (sheet_entry in sheet_content) {
      sheet_name <- sheet_entry$sheet
      ws_idx <- match(sheet_name, wb$sheet_names)
      merges <- NULL
      if (!is.na(ws_idx)) {
        merges <- wb$worksheets[[ws_idx]]$mergeCells
      }

      cells_df <- build_cells_df(sheet_entry$cells)
      regions <- detect_table_regions(cells_df)

      header_cells <- subset_cells_region(cells_df, regions$header)
      index_cells <- subset_cells_region(cells_df, regions$index)
      body_cells <- subset_cells_region(cells_df, regions$body)
      footer_cells <- subset_cells_region(cells_df, regions$footer)

      header_blocks <- build_blocks_from_df(header_cells, merges)
      index_blocks <- build_blocks_from_df(index_cells, merges)
      body_blocks <- build_blocks_from_df(body_cells, merges)
      footer_blocks <- build_blocks_from_df(footer_cells, merges)

      header_compact <- compress_region_styles(header_blocks)
      index_compact <- compress_region_styles(index_blocks)
      body_compact <- compress_region_styles(body_blocks)
      footer_compact <- compress_region_styles(footer_blocks)

      content_blocks[[sheet_name]] <- list(
        table_header = header_compact,
        table_index = index_compact,
        table_body = body_compact,
        table_footer = footer_compact
      )

      style_ids_used <- c(style_ids_used,
                          header_cells$style_id,
                          index_cells$style_id,
                          body_cells$style_id,
                          footer_cells$style_id)
    }
  }

  style_specs <- build_style_specs(wb$styles_mgr, style_ids_used)

  payload <- list(
    formats = list(
      styles = style_specs,
      sheets = sheet_formats,
      workbook = list(
        sheet_names = wb$sheet_names,
        sheet_order = wb$sheetOrder,
        properties = wb$get_properties(),
        theme = wb$theme
      )
    ),
    content = content_blocks
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
