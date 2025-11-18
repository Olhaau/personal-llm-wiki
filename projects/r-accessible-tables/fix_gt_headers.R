#' Fix GT Table Header IDs for Accessibility
#' 
#' This function fixes accessibility issues in gt tables where header IDs and 
#' the corresponding headers attributes in data cells don't match due to 
#' spaces vs hyphens inconsistency.
#'
#' @param gt_table A gt table object
#' @return A gt table object with corrected header references
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
#'   fix_gt_headers()

library(gt)

fix_gt_headers <- function(gt_table) {
  # Check if input is a gt table
  if (!inherits(gt_table, "gt_tbl")) {
    stop("Input must be a gt table object")
  }
  
  # Make a copy of the gt table to avoid modifying the original
  fixed_table <- gt_table
  
  # Get the current column names from the data
  original_names <- names(fixed_table$`_data`)
  
  # Create a mapping of original names to fixed names (spaces -> hyphens)
  fixed_names <- gsub("\\s+", "-", original_names)
  
  # If any names need fixing, update them
  if (any(original_names != fixed_names)) {
    # Rename columns in the data
    names(fixed_table$`_data`) <- fixed_names
    
    # Update the boxhead (column metadata)
    if (!is.null(fixed_table$`_boxhead`)) {
      # Update var column which contains the column identifiers
      var_indices <- match(fixed_table$`_boxhead`$var, original_names)
      valid_indices <- !is.na(var_indices)
      fixed_table$`_boxhead`$var[valid_indices] <- fixed_names[var_indices[valid_indices]]
    }
    
    # Update any spanner information if present
    if (!is.null(fixed_table$`_spanners`) && nrow(fixed_table$`_spanners`) > 0) {
      for (i in seq_len(nrow(fixed_table$`_spanners`))) {
        if (!is.null(fixed_table$`_spanners`$vars[[i]])) {
          # Update variable names in spanners
          spanner_vars <- fixed_table$`_spanners`$vars[[i]]
          var_indices <- match(spanner_vars, original_names)
          valid_indices <- !is.na(var_indices)
          fixed_table$`_spanners`$vars[[i]][valid_indices] <- fixed_names[var_indices[valid_indices]]
        }
      }
    }
    
    # Update any formatting rules that reference column names
    if (!is.null(fixed_table$`_formats`) && length(fixed_table$`_formats`) > 0) {
      for (i in seq_along(fixed_table$`_formats`)) {
        if (!is.null(fixed_table$`_formats`[[i]]$colname)) {
          colname <- fixed_table$`_formats`[[i]]$colname
          var_index <- match(colname, original_names)
          if (!is.na(var_index)) {
            fixed_table$`_formats`[[i]]$colname <- fixed_names[var_index]
          }
        }
      }
    }
    
    # Update any styles that reference column names
    if (!is.null(fixed_table$`_styles`) && nrow(fixed_table$`_styles`) > 0) {
      for (i in seq_len(nrow(fixed_table$`_styles`))) {
        if (!is.na(fixed_table$`_styles`$colname[i])) {
          colname <- fixed_table$`_styles`$colname[i]
          var_index <- match(colname, original_names)
          if (!is.na(var_index)) {
            fixed_table$`_styles`$colname[i] <- fixed_names[var_index]
          }
        }
      }
    }
    
    # Update any footnotes that reference column names
    if (!is.null(fixed_table$`_footnotes`) && nrow(fixed_table$`_footnotes`) > 0) {
      for (i in seq_len(nrow(fixed_table$`_footnotes`))) {
        if (!is.na(fixed_table$`_footnotes`$colname[i])) {
          colname <- fixed_table$`_footnotes`$colname[i]
          var_index <- match(colname, original_names)
          if (!is.na(var_index)) {
            fixed_table$`_footnotes`$colname[i] <- fixed_names[var_index]
          }
        }
      }
    }
  }
  
  # Return the modified gt table object
  fixed_table
}

#' Save gt table to HTML file
#' @param gt_table A gt table object
#' @param filename File path to save the HTML
#' @param ... Additional arguments passed to writeLines
# save_html <- function(gt_table, filename, ...) {
#   if (inherits(gt_table, "gt_tbl")) {
#     # Convert gt table to HTML
#     html_output <- as_raw_html(gt_table, inline_css = FALSE)
#     writeLines(html_output, filename, ...)
#   } else {
#     stop("Input must be a gt table object")
#   }
# }

