#' Fix GT Table Header IDs for Accessibility (HTML Output Version)
#' 
#' This function fixes accessibility issues in gt tables where header IDs and 
#' the corresponding headers attributes in data cells don't match due to 
#' spaces vs hyphens inconsistency. This version returns HTML directly.
#'
#' @param gt_table A gt table object
#' @return Character string containing fixed HTML
#' @export
#'
#' @examples
#' library(gt)
#' library(dplyr)
#' 
#' # Create a table with the issue
#' my_table <- mtcars %>%
#'   head() %>%
#'   gt() %>%
#'   fix_gt_headers_html()
#'   
#' # Save to file
#' writeLines(my_table, "fixed_table.html")

library(gt)

fix_gt_headers_html <- function(gt_table) {
  # Check if input is a gt table
  if (!inherits(gt_table, "gt_tbl")) {
    stop("Input must be a gt table object")
  }
  
  # Convert gt table to HTML using as_raw_html to get the actual HTML
  html_output <- as_raw_html(gt_table, inline_css = FALSE)
  
  # Fix the headers attribute values by replacing spaces with hyphens
  # Pattern to find headers attributes
  headers_pattern <- 'headers="([^"]*)"'
  
  # Function to fix individual headers attribute
  fix_headers_attr <- function(match) {
    # Extract content between quotes
    content <- gsub('headers="([^"]*)"', '\\1', match)
    
    # Split by spaces
    parts <- unlist(strsplit(content, "\\s+"))
    
    if (length(parts) > 1) {
      # First part is stub reference, rest are column headers that need fixing
      stub_ref <- parts[1]
      column_parts <- parts[-1]
      
      # Join column parts with hyphens instead of spaces
      fixed_column_ref <- paste(column_parts, collapse = "-")
      
      # Return the fixed headers attribute
      paste0('headers="', stub_ref, ' ', fixed_column_ref, '"')
    } else {
      # If only one part, return as is
      match
    }
  }
  
  # Find and replace all headers attributes
  matches <- gregexpr(headers_pattern, html_output, perl = TRUE)
  
  if (matches[[1]][1] != -1) {
    # Get all matches
    headers_attrs <- regmatches(html_output, matches)[[1]]
    
    # Fix each match
    fixed_attrs <- sapply(headers_attrs, fix_headers_attr, USE.NAMES = FALSE)
    
    # Replace in the HTML
    fixed_html <- html_output
    for (i in seq_along(headers_attrs)) {
      fixed_html <- gsub(headers_attrs[i], fixed_attrs[i], fixed_html, fixed = TRUE)
    }
  } else {
    fixed_html <- html_output
  }
  
  # Return as a simple character vector that can be written to file
  fixed_html
}

#' Save HTML string to file
#' @param html_string Character string containing HTML
#' @param filename File path to save the HTML
#' @param ... Additional arguments passed to writeLines
save_html_string <- function(html_string, filename, ...) {
  if (is.character(html_string)) {
    writeLines(html_string, filename, ...)
  } else {
    stop("Input must be a character string containing HTML")
  }
}

# Helper function for older R versions
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

# Define the pipe operator for older R versions compatibility
`%>%` <- function(lhs, rhs) {
  eval(substitute(rhs), envir = list(.=lhs), enclos = parent.frame())
}