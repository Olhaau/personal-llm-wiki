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
  
  # Create base kable
  # Important: Don't use caption here as it will be added by Quarto
  tbl <- knitr::kable(
    data,
    col.names = col_names,
    booktabs = booktabs,
    format = "latex",
    escape = escape,
    linesep = "",
    align = align,
    caption = NULL  # Let Quarto handle captions
  )
  
  # Apply base styling
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
    tbl_out <- gsub("\\\\begin\\{table\\}[^\\n]*\\n", "", tbl_out)
    tbl_out <- gsub("\\\\end\\{table\\}", "", tbl_out)
    
    # Remove \centering{ opening and the [t] that follows
    # Structure: \centering{\n\n[t]\n\n\centering\begingroup... (lots of stuff) ...\endgroup{}\n}\n
    # Strategy: Remove just the "\centering{\n\n[t]\n\n" part, leave everything else
    tbl_out <- gsub("\\\\centering\\{[^\\\\]*\\[t\\][^\\\\]*(?=\\\\centering)", "", tbl_out, perl = TRUE)
    
    # Also remove the stray closing } that was part of the \centering{...} group
    # It appears after \endgroup{} near the end
    tbl_out <- gsub("\\\\endgroup\\{\\}\\s*\\n\\s*\\}", "\\\\endgroup{}", tbl_out)
    
    # Remove any remaining standalone [t] lines just in case
    lines <- strsplit(tbl_out, "\\n")[[1]]
    lines <- lines[!grepl("^\\s*\\[t\\]\\s*$", lines)]
    tbl_out <- paste(lines, collapse = "\n")
    
    # Build table* environment
    table_start <- "\\begin{table*}[t]\n"
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
  # Split into lines
  all_lines <- unlist(strsplit(tbl_out, "\n", fixed = TRUE))
  
  # Filter out lines that are ONLY [t], [h], or [b] (with optional whitespace)
  clean_lines <- all_lines[!grepl("^\\s*\\[[thb]\\]\\s*$", all_lines)]
  
  # Also remove the closing } that pairs with \centering{ if it's on its own line
  clean_lines <- clean_lines[clean_lines != "}"]
  
  # Rejoin
  tbl_out <- paste(clean_lines, collapse = "\n")
  
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
  
  format_wista_table(
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
  
  format_wista_table(
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
}

#' Simplified wrapper for small benchmark tables (appendix)
#' 
#' @param data Data frame to format
#' @param label Label for cross-referencing
#' @param caption Table caption
#' 
#' @return Formatted table output
format_small_benchmark_table <- function(data, label, caption = NULL) {
  format_wista_table(
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
}

#' Format descriptive/overview tables
#' 
#' @param data Data frame to format
#' @param label Label for cross-referencing
#' @param caption Table caption
#' @param col_names Column names (optional)
#' @param font_size Font size (default: 9)
#' 
#' @return Formatted table output
format_descriptive_table <- function(data, label, caption = NULL, col_names = NULL, font_size = 9) {
  format_wista_table(
    data = data,
    col_names = col_names,
    label = label,
    caption = caption,
    booktabs = FALSE,
    escape = FALSE,
    font_size = font_size,
    full_width = FALSE,
    two_column = TRUE,
    header_colors = TRUE,
    alternating_colors = TRUE
  )
}
