# ---- Table Formatting Functions ----
# Centralized table formatting for consistent styling across the document

#' Format a knitr table with WISTA styling
#' 
#' @param data Data frame to format
#' @param align Character vector of column alignments (e.g., c("l", "r", "r"))
#' @param col_names Optional character vector of column names
#' @param label Label for cross-referencing (without "tbl-" prefix)
#' @param caption Table caption (required when using results: asis)
#' @param booktabs Use booktabs style (default: FALSE)
#' @param escape Escape special LaTeX characters (default: FALSE)
#' @param font_size Font size for table (default: 8)
#' @param full_width Use full column width (default: FALSE for two-column layout)
#' @param two_column Span both columns in two-column layout (default: TRUE)
#' @param collapse_rows Column numbers to collapse rows (default: NULL)
#' @param header_colors Use colored header styling (default: TRUE)
#' @param alternating_colors Use alternating row colors (default: TRUE)
#' 
#' @return Formatted kable object ready for LaTeX output
format_wista_table <- function(data,
                                align = NULL,
                                col_names = NULL,
                                label = NULL,
                                caption = NULL,
                                booktabs = FALSE,
                                escape = FALSE,
                                font_size = 8,
                                full_width = FALSE,
                                two_column = TRUE,
                                collapse_rows = NULL,
                                header_colors = TRUE,
                                alternating_colors = TRUE) {
  
  suppressPackageStartupMessages({
    library(kableExtra)
    library(dplyr)
  })
  
  # Auto-detect alignment if not provided
  if (is.null(align)) {
    align <- sapply(data, function(col) {
      if (is.numeric(col)) "r" else "l"
    })
  }
  
  n_cols <- ncol(data)
  
  # Detect output format
  is_latex <- knitr::is_latex_output()
  
  # For non-LaTeX (including DOCX), use flextable
  if (!is_latex) {
    suppressPackageStartupMessages({
      library(flextable)
      library(officer)
    })
    
    # Use data frame's column names if col_names not provided
    if (is.null(col_names)) {
      col_names <- names(data)
    }
    
    # Rename columns if custom names provided
    if (!is.null(col_names) && length(col_names) == ncol(data)) {
      names(data) <- col_names
    }
    
    # Create flextable
    ft <- flextable(data)
    
    # Apply basic, clean styling
    ft <- ft |>
      # Set font
      font(fontname = "Arial", part = "all") |>
      fontsize(size = font_size, part = "all") |>
      # Bold header
      bold(part = "header") |>
      # Remove all borders first
      border_remove() |>
      # Add only horizontal lines (top and bottom)
      hline_top(border = fp_border(color = "black", width = 1), part = "header") |>
      hline_bottom(border = fp_border(color = "black", width = 1), part = "header") |>
      hline_bottom(border = fp_border(color = "black", width = 1), part = "body") |>
      # Alignment
      align(align = "left", part = "header")
    
    # Apply column-specific alignment
    for (i in seq_along(align)) {
      if (i <= ncol(data)) {
        if (align[i] == "r") {
          ft <- align(ft, j = i, align = "right", part = "all")
        } else if (align[i] == "c") {
          ft <- align(ft, j = i, align = "center", part = "all")
        } else {
          ft <- align(ft, j = i, align = "left", part = "all")
        }
      }
    }
    
    # NOTE: For DOCX output, captions should be set using Quarto chunk options:
    #   #| tbl-cap: "Your caption here"
    #   #| label: tbl-your-label
    # This ensures proper numbering and cross-referencing in DOCX format.
    # The caption parameter is ignored for DOCX output.
    
    # Auto-fit to content
    ft <- autofit(ft)
    
    # Attach label as attribute for DOCX output
    attr(ft, "label") <- label
    
    # Return the flextable object
    return(ft)
  }
  
  # Use data frame's column names if col_names not provided
  if (is.null(col_names)) {
    col_names <- names(data)
  }
  
  # Create base kable for LaTeX
  tbl <- knitr::kable(
    data,
    col.names = col_names,
    booktabs = booktabs,
    format = "latex",
    escape = escape,
    linesep = "",
    align = align,
    caption = NULL  # Let Quarto handle captions for LaTeX
  )
  
  # Apply base styling (LaTeX only)
  # In two-column mode, remove hold_position to avoid float issues
  latex_opts <- if (two_column) c("HOLD_position") else c("hold_position")
  
  tbl <- tbl |>
    kable_styling(
      latex_options = latex_opts,
      font_size = font_size,
      full_width = full_width
    )
  
  # Apply header colors if requested
  if (header_colors) {
    tbl <- tbl |>
      row_spec(0, background = "#dce6f0", color = "#404040", bold = TRUE, hline_after = FALSE)
  }
  
  # Apply column styling with WISTA colors
  if (alternating_colors) {
    tbl <- tbl |>
      column_spec(1, border_left = TRUE, border_right = TRUE, 
                  color = "black", background = "white")
    
    if (n_cols > 1) {
      tbl <- tbl |>
        column_spec(2:n_cols, background = "#f0f8ff", 
                    border_left = TRUE, border_right = TRUE)
    }
  } else {
    tbl <- tbl |>
      column_spec(1:n_cols, border_left = TRUE, border_right = TRUE)
  }
  
  # Collapse rows if specified
  if (!is.null(collapse_rows)) {
    tbl <- tbl |>
      collapse_rows(columns = collapse_rows, valign = "top")
  }
  
  # Convert to raw LaTeX for post-processing
  tbl_out <- as.character(tbl)
  
  # Remove positioning directives that cause issues in two-column mode
  tbl_out <- gsub("\\[!h\\]", "", tbl_out)
  tbl_out <- gsub("\\[!ht\\]", "", tbl_out)
  tbl_out <- gsub("\\[H\\]", "", tbl_out)
  
  # Clean up midrule after colored rows
  tbl_out <- gsub("\\\\midrule\\n(\\\\rowcolor)", "\\1", tbl_out)
  
  # For two-column spanning tables, we need special handling
  if (two_column) {
    # First, remove the table environment completely and extract content
    # This regex captures everything including positioning like [H], [t], etc.
    tbl_out <- gsub("\\\\begin\\{table\\}[^\\n]*\\n", "", tbl_out)
    tbl_out <- gsub("\\\\end\\{table\\}", "", tbl_out)
    
    # Remove simple single-char positioning directives like [t], [h], [b]
    # but NOT multi-char ones like [!htb]
    tbl_out <- gsub("\\[t\\]\\s*\\n", "", tbl_out)
    tbl_out <- gsub("\\[h\\]\\s*\\n", "", tbl_out)
    tbl_out <- gsub("\\[b\\]\\s*\\n", "", tbl_out)
    
    # Remove outer \centering{ wrapper and its closing }
    # Pattern: \centering{ at start (possibly with whitespace)
    # followed by content, then } on its own line near the end
    if (grepl("^\\s*\\\\centering\\{", tbl_out)) {
      tbl_out <- sub("^\\s*\\\\centering\\{\\s*\\n", "", tbl_out)
      # Remove the matching } that's on its own line, followed by possible whitespace
      tbl_out <- sub("\\n\\s*\\}\\s*\\n\\s*$", "\n", tbl_out)
    }
    
    # Remove any remaining standalone [t], [h], [b] lines (but not [!htb])
    lines <- strsplit(tbl_out, "\\n")[[1]]
    lines <- lines[!grepl("^\\s*\\[[thb]\\]\\s*$", lines)]
    tbl_out <- paste(lines, collapse = "\n")
    
    # Build table* environment without positioning
    table_start <- "\\begin{table*}\n"
    if (!is.null(caption)) {
      table_start <- paste0(table_start, "\\caption{", caption, "}")
    }
    if (!is.null(label)) {
      table_start <- paste0(table_start, "\\label{tbl-", label, "}\n")
    } else if (!is.null(caption)) {
      table_start <- paste0(table_start, "\n")
    }
    table_end <- "\n\\end{table*}"
    
    # Assemble final table
    tbl_out <- paste0(table_start, tbl_out, table_end)
    
    # Clean up multiple consecutive newlines but preserve single newlines
    tbl_out <- gsub("\\n{3,}", "\\n\\n", tbl_out)
    # Fix any cases where newline was removed after \selectfont
    tbl_out <- gsub("\\\\selectfont([^\\n])", "\\\\selectfont\n\\1", tbl_out)
  }
  
  # FINAL cleanup: ALWAYS remove [t], [h], [b] positioning on their own lines
  # BUT keep [!htb] and similar multi-character positioning
  # Split into lines
  all_lines <- unlist(strsplit(tbl_out, "\n", fixed = TRUE))
  
  # Filter out lines that are ONLY single positioning characters like [t], [h], or [b]
  # but NOT [!htb] or other multi-char positioning
  clean_lines <- all_lines[!grepl("^\\s*\\[[thb]\\]\\s*$", all_lines)]
  
  # Also remove the closing } that pairs with \centering{ if it's on its own line
  clean_lines <- clean_lines[clean_lines != "}"]
  
  # Rejoin
  tbl_out <- paste(clean_lines, collapse = "\n")
  
  # Additional cleanup: remove [t] that appears after \begin{table*} or \begin{table}
  # BUT don't remove [!htb] or other multi-char positioning
  tbl_out <- gsub("\\\\begin\\{table\\*\\}\\[t\\]", "\\\\begin{table*}", tbl_out)
  tbl_out <- gsub("\\\\begin\\{table\\}\\[t\\]", "\\\\begin{table}", tbl_out)
  
  # Remove standalone [t] anywhere in the output (but not [!htb])
  tbl_out <- gsub("\\n\\s*\\[t\\]\\s*\\n", "\n", tbl_out)
  tbl_out <- gsub("^\\s*\\[t\\]\\s*\\n", "", tbl_out)
  
  return(tbl_out)
}

#' Simplified wrapper for benchmark tables
#' 
#' @param data Data frame to format
#' @param label Label for cross-referencing
#' @param caption Table caption
#' @param align Column alignments
#' 
#' @return Formatted table output
format_benchmark_table <- function(data, label, caption = NULL, align = NULL) {
  if (is.null(align)) {
    # Default alignment for benchmark tables
    align <- c("l", "l", "l", "r", "r", "r")
  }
  
  tbl <- format_wista_table(
    data = data,
    align = align,
    label = label,
    caption = caption,
    booktabs = FALSE,
    escape = TRUE,
    font_size = 8,
    full_width = FALSE,
    two_column = TRUE,
    header_colors = TRUE,
    alternating_colors = TRUE
  )
  
  # Attach label as attribute for DOCX output
  attr(tbl, "label") <- label
  return(tbl)
}

#' Simplified wrapper for baseline comparison tables
#' 
#' @param data Data frame to format
#' @param label Label for cross-referencing
#' @param caption Table caption
#' @param collapse_first_col Collapse first column rows (default: TRUE)
#' 
#' @return Formatted table output
format_baseline_table <- function(data, label, caption = NULL, collapse_first_col = TRUE) {
  collapse_cols <- if (collapse_first_col) 1 else NULL
  
  tbl <- format_wista_table(
    data = data,
    align = c("l", "l", "r", "r", "r"),
    label = label,
    caption = caption,
    booktabs = TRUE,
    escape = FALSE,
    font_size = 8,
    full_width = FALSE,
    two_column = TRUE,
    collapse_rows = collapse_cols,
    header_colors = FALSE,
    alternating_colors = TRUE
  )
  
  # Attach label as attribute for DOCX output
  attr(tbl, "label") <- label
  return(tbl)
}

#' Simplified wrapper for small benchmark tables (appendix)
#' 
#' @param data Data frame to format
#' @param label Label for cross-referencing
#' @param caption Table caption
#' 
#' @return Formatted table output
format_small_benchmark_table <- function(data, label, caption = NULL) {
  tbl <- format_wista_table(
    data = data,
    align = c("r", "l", "l", "l", "r", "r", "r"),
    label = label,
    caption = caption,
    booktabs = TRUE,
    escape = TRUE,
    font_size = 8,
    full_width = FALSE,
    two_column = TRUE,
    header_colors = TRUE,
    alternating_colors = TRUE
  )
  
  # Attach label as attribute for DOCX output
  attr(tbl, "label") <- label
  return(tbl)
}

#' Format descriptive/overview tables
#' 
#' @param data Data frame to format
#' @param label Label for cross-referencing
#' @param caption Table caption
#' @param col_names Column names (optional)
#' @param font_size Font size (default: 9)
#' @param escape Escape special LaTeX characters (default: TRUE)
#' 
#' @return Formatted table output
format_descriptive_table <- function(data, label, caption = NULL, col_names = NULL, font_size = 9, escape = TRUE) {
  tbl <- format_wista_table(
    data = data,
    col_names = col_names,
    label = label,
    caption = caption,
    booktabs = FALSE,
    escape = escape,
    font_size = font_size,
    full_width = FALSE,
    two_column = TRUE,
    header_colors = TRUE,
    alternating_colors = TRUE
  )
  
  # Attach label as attribute for DOCX output
  attr(tbl, "label") <- label
  return(tbl)
}

#' Output table with format-aware handling
#' 
#' Helper function that outputs tables correctly based on format.
#' For LaTeX: uses cat() with the string output  
#' For DOCX: returns the flextable object for proper rendering
#' 
#' @param tbl_out Table output from format_*_table functions
#' 
#' @return For DOCX: flextable object; For LaTeX: NULL (after cat)
# Table numbering for DOCX output
.table_counter <- 0

# Helper to get table number from label
get_table_number <- function(label) {
  # Map labels to table numbers
  table_map <- c(
    "stba-rserver" = 1,
    "fdz-server" = 2,
    "dplyr-syntax" = 3,
    "baseline" = 4,
    "benchmark-small" = 5,
    "benchmark-regr-small" = 6,
    "benchmark" = 7,
    "benchmark-regr" = 8
  )
  
  if (label %in% names(table_map)) {
    return(table_map[[label]])
  } else {
    # Fallback to counter if label not found
    .table_counter <<- .table_counter + 1
    return(.table_counter)
  }
}

output_table <- function(tbl_out, label = NULL) {
  if (is.character(tbl_out)) {
    # LaTeX output - use cat() and return invisible
    cat(tbl_out)
    return(invisible(NULL))
  } else {
    # DOCX/other - skip tables, return placeholder with table number
    # Extract label from tbl_out attributes if not provided
    if (is.null(label)) {
      label <- attr(tbl_out, "label")
    }
    
    if (!is.null(label)) {
      table_num <- get_table_number(label)
      cat(sprintf("\n**→ Tabelle %d** (siehe Excel-Datei)\n\n", table_num))
    } else {
      cat("\n**→ Tabelle siehe Excel-Datei**\n\n")
    }
    return(invisible(NULL))
  }
}
