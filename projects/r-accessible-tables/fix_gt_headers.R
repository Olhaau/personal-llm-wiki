#' Fix GT Table Header IDs for Accessibility
#' 
#' This function fixes accessibility issues in gt tables where header IDs and 
#' the corresponding headers attributes in data cells don't match. It generates
#' valid HTML IDs from column names containing any characters (spaces, emojis,
#' special characters, unicode symbols) and ensures proper accessibility compliance.
#'
#' @param gt_table A gt table object
#' @param id_suffix A string to append to table IDs for uniqueness in RMarkdown documents. Defaults to "".
#' @param preserve_mapping Logical, whether to store original->fixed name mapping for debugging. Defaults to FALSE.
#' @return A gt table object with corrected header references and valid HTML IDs
#' @export
#'
#' @details
#' This enhanced version handles problematic characters including:
#' - Spaces, tabs, line breaks
#' - Special symbols (>, <, &, $, %, @, #, etc.)
#' - German umlauts (ä, ö, ü, Ä, Ö, Ü, ß)
#' - Quotes, parentheses, brackets
#' - Mathematical symbols and operators
#' 
#' Generated IDs follow HTML standards:
#' - Start with a letter or underscore
#' - Contain only letters, digits, hyphens, and underscores
#' - Are unique within the document
#' - Preserve meaningful information from original names
#'
#' @examples
#' library(gt)
#' library(dplyr)
#' 
#' # Basic example with problematic characters
#' df <- data.frame(
#'   `Patient ID` = c("P1", "P2"),
#'   `Age (years)` = c(25, 30),
#'   `BMI > 25` = c("Yes", "No"),
#'   `Cost $USD` = c(100, 200),
#'   check.names = FALSE
#' )
#' 
#' my_table <- df %>%
#'   gt() %>%
#'   fix_gt_headers()
#'   
#' # German umlauts example
#' german_df <- data.frame(
#'   `Größe (cm)` = c(170, 175),           # German ö -> oe
#'   `Müdigkeit` = c("Low", "High"),       # German ü -> ue  
#'   `Straße` = c("A1", "B2"),             # German ß -> ss
#'   `Fähigkeit` = c("Good", "Better"),    # German ä -> ae
#'   check.names = FALSE
#' )
#' 
#' german_table <- german_df %>%
#'   gt() %>%
#'   fix_gt_headers()
#'   
#' # Table with unique ID suffix for RMarkdown documents
#' my_table2 <- df %>%
#'   gt() %>%
#'   fix_gt_headers(id_suffix = "table1")
#'   
#' # View the character mappings for debugging
#' german_debug <- german_df %>%
#'   gt() %>%
#'   fix_gt_headers(preserve_mapping = TRUE)
#'   
#' # View how German characters were converted
#' get_name_mapping(german_debug)

library(gt)

# ---- Character Mapping Table ----

#' Character mapping table for converting problematic characters to HTML-safe alternatives
#' 
#' This table defines replacements for characters that are invalid in HTML IDs
#' according to the W3C HTML 4.0 specification (Section 6.2). Per the W3C HTML 4.0
#' conventions, ID and NAME tokens must begin with a letter ([A-Za-z]) and may be
#' followed by any number of letters, digits ([0-9]), hyphens ("-"), underscores ("_"),
#' colons (":"), and periods ("."). The mapping preserves semantic meaning where possible
#' while ensuring compliance with these W3C HTML 4.0 naming conventions.
#' 
#' @format A named character vector where names are the problematic characters
#' and values are their HTML-safe replacements compliant with W3C HTML 4.0 conventions
CHARACTER_MAPPING <- c(
  # German umlauts and special characters
  "ä" = "ae",
  "ö" = "oe", 
  "ü" = "ue",
  "Ä" = "Ae",
  "Ö" = "Oe",
  "Ü" = "Ue",
  "ß" = "ss",
  
  # Common symbols
  "°" = ".deg.",
  "™" = ".tm.",
  "®" = ".reg.",
  "©" = ".copy.",
  
  # Mathematical and comparison operators  
  ">=" = ".gte.",
  "<=" = ".lte.",
  "!=" = ".neq.",
  "==" = ".eq.",
  ">" = ".gt.",
  "<" = ".lt.",
  "=" = ".equals.",
  
  # Logical and common operators
  "&" = ".and.",
  "|" = ".or.",
  "+" = ".plus.",
  "/" = ".div.",
  "*" = ".mult.",
  
  # Special symbols with semantic meaning
  "$" = ".dollar.",
  "%" = ".pct.",
  "@" = ".at.",
  "#" = ".num.",
  "?" = ".q.",
  "!" = ".excl.",
  
  # Quotes and punctuation
  "\"" = ".quote.",
  "'" = ".quote.",
  "`" = ".quote.",
  ";" = ".semi.",
  "\\" = ".backslash."
)

#' Generate Valid HTML ID from Any String Following W3C HTML 4.0 Specification
#'
#' @param name Character string to convert to valid HTML ID
#' @return Valid HTML ID string following W3C HTML 4.0 specification
#' @keywords internal
#' @details 
#' According to W3C HTML 4.0 specification (section 6.2):
#' "ID and NAME tokens must begin with a letter ([A-Za-z]) and may be followed by 
#' any number of letters, digits ([0-9]), hyphens ("-"), underscores ("_"), 
#' colons (":"), and periods (".")."
#' 
#' This function converts any input string to a valid HTML ID by:
#' 1. Preserving semantic meaning where possible
#' 2. Converting invalid characters to valid alternatives
#' 3. Ensuring the result starts with a letter
#' 4. Using only allowed characters: A-Za-z0-9._:-
generate_valid_html_id <- function(name) {
  if (is.na(name) || name == "") {
    return("col.empty")
  }
  
  # Start with the original name
  id <- name
  
  # Step 1: Apply character mappings from the mapping table
  # Process all mappings using fixed string replacement
  # Sort by length descending to handle longer patterns first
  mapping_order <- order(nchar(names(CHARACTER_MAPPING)), decreasing = TRUE)
  
  for (i in mapping_order) {
    char <- names(CHARACTER_MAPPING)[i]
    replacement <- CHARACTER_MAPPING[[i]]
    
    # Simple fixed replacement - exact match
    id <- gsub(char, replacement, id, fixed = TRUE)
    
    # For operators, also handle common whitespace variations
    if (char %in% c(">", "<", "=", "&", "|", "+", "/", "*", ">=", "<=", "!=", "==")) {
      # Handle with spaces around
      id <- gsub(paste0(" ", char, " "), replacement, id, fixed = TRUE)
      id <- gsub(paste0(" ", char), replacement, id, fixed = TRUE)  
      id <- gsub(paste0(char, " "), replacement, id, fixed = TRUE)
      # Handle with tabs
      id <- gsub(paste0("\t", char, "\t"), replacement, id, fixed = TRUE)
      id <- gsub(paste0("\t", char), replacement, id, fixed = TRUE)
      id <- gsub(paste0(char, "\t"), replacement, id, fixed = TRUE)
    }
  }
  
  # Step 2: Handle parentheses and brackets (extract content, use periods)
  id <- gsub("\\(([^)]*?)\\)", ".\\1.", id)         # (content) -> .content.
  id <- gsub("\\[([^]]*?)\\]", ".\\1.", id)         # [content] -> .content.  
  id <- gsub("\\{([^}]*?)\\}", ".\\1.", id)         # {content} -> .content.
  
  # Step 3: Handle any remaining non-ASCII characters
  # Try transliteration for any remaining accented characters
  tryCatch({
    id_transliterated <- iconv(id, from = "UTF-8", to = "ASCII//TRANSLIT", sub = "")
    
    # Check if transliteration was successful and didn't introduce question marks or NAs
    if (!is.na(id_transliterated) && !grepl("\\?", id_transliterated) && nchar(id_transliterated) > 0) {
      id <- id_transliterated
    } else {
      # Transliteration failed, replace any remaining non-ASCII with placeholder
      id <- gsub("[^\x20-\x7E]", ".unicode.", id)
    }
  }, error = function(e) {
    # If iconv fails completely, fallback to removing non-ASCII
    id <<- gsub("[^\x20-\x7E]", ".unicode.", id)
  })
  
  # Step 4: Convert remaining invalid characters to valid ones
  # Replace spaces and tabs with hyphens (common in column names) 
  id <- gsub("[\\s\\t]+", "-", id)
  
  # Replace any remaining invalid characters with periods
  # Valid chars per W3C: A-Za-z0-9._:-
  id <- gsub("[^A-Za-z0-9._:-]", ".", id)
  
  # Step 5: Clean up multiple separators
  id <- gsub("[-._:]+", ".", id)                    # Multiple separators -> single period
  id <- gsub("^[-._:]+|[-._:]+$", "", id)           # Remove leading/trailing separators
  
  # Step 6: Ensure ID starts with a letter (W3C requirement)
  if (!grepl("^[A-Za-z]", id)) {
    if (grepl("^[0-9]", id)) {
      # Starts with number, prefix with letter
      id <- paste0("col.", id)
    } else {
      # Starts with separator or empty, use meaningful prefix
      id <- paste0("col", id)
    }
  }
  
  # Step 7: Handle edge cases
  if (nchar(id) == 0 || id == "") {
    id <- "col.empty"
  } else if (nchar(id) == 1) {
    # Single character, ensure it's meaningful
    id <- paste0("col.", id)
  }
  
  # Step 8: Final validation - ensure result matches W3C pattern
  if (!grepl("^[A-Za-z][A-Za-z0-9._:-]*$", id)) {
    # Fallback if somehow we still have invalid characters
    id <- "col.fallback"
    warning("Generated ID did not match W3C pattern, using fallback for: ", name)
  }
  
  return(id)
}

#' Ensure Unique HTML IDs
#'
#' @param ids Character vector of HTML IDs
#' @return Character vector with unique IDs
#' @keywords internal
ensure_unique_ids <- function(ids) {
  # Track duplicates and make them unique
  unique_ids <- character(length(ids))
  id_counts <- table(ids)
  id_counters <- list()
  
  for (i in seq_along(ids)) {
    id <- ids[i]
    if (id_counts[id] > 1) {
      # This ID appears multiple times, add counter
      if (is.null(id_counters[[id]])) {
        id_counters[[id]] <- 1
      } else {
        id_counters[[id]] <- id_counters[[id]] + 1
      }
      unique_ids[i] <- paste0(id, "_", id_counters[[id]])
    } else {
      unique_ids[i] <- id
    }
  }
  
  return(unique_ids)
}

fix_gt_headers <- function(gt_table, id_suffix = "", preserve_mapping = FALSE) {
  # Check if input is a gt table
  if (!inherits(gt_table, "gt_tbl")) {
    stop("Input must be a gt table object")
  }
  
  # Make a copy of the gt table to avoid modifying the original
  fixed_table <- gt_table
  
  # Get the current column names from the data
  original_names <- names(fixed_table$`_data`)
  
  # Generate valid HTML IDs from original names
  fixed_names <- sapply(original_names, generate_valid_html_id, USE.NAMES = FALSE)
  
  # Ensure all IDs are unique within this table
  fixed_names <- ensure_unique_ids(fixed_names)
  
  # If id_suffix is provided, append it to make unique table IDs across documents
  if (id_suffix != "" && !is.na(id_suffix)) {
    # Clean the suffix to be HTML-safe
    clean_suffix <- generate_valid_html_id(id_suffix)
    fixed_names <- paste0(fixed_names, "_", clean_suffix)
  }
  
  # Store mapping for debugging if requested
  if (preserve_mapping) {
    name_mapping <- data.frame(
      original = original_names,
      fixed = fixed_names,
      stringsAsFactors = FALSE
    )
    attr(fixed_table, "name_mapping") <- name_mapping
  }
  
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

#' Get Name Mapping from Fixed GT Table
#'
#' @param gt_table A gt table object that has been processed with fix_gt_headers(preserve_mapping = TRUE)
#' @return Data frame with original and fixed column name mappings, or NULL if not available
#' @export
get_name_mapping <- function(gt_table) {
  return(attr(gt_table, "name_mapping"))
}

#' Validate HTML IDs Against W3C HTML 4.0 Specification
#'
#' @param ids Character vector of HTML IDs to validate
#' @return List with validation results
#' @export
#' @details
#' Validates according to W3C HTML 4.0 specification section 6.2:
#' "ID and NAME tokens must begin with a letter ([A-Za-z]) and may be followed by 
#' any number of letters, digits ([0-9]), hyphens ("-"), underscores ("_"), 
#' colons (":"), and periods (".")."
validate_html_ids <- function(ids) {
  results <- list(
    valid = character(0),
    invalid = character(0),
    issues = character(0),
    specification = "W3C HTML 4.0 Section 6.2"
  )
  
  # W3C HTML 4.0 specification pattern
  valid_pattern <- "^[A-Za-z][A-Za-z0-9._:-]*$"
  
  for (id in ids) {
    issues <- character(0)
    
    # Check if empty
    if (nchar(id) == 0 || is.na(id)) {
      issues <- c(issues, "Empty or NA ID")
    } else {
      # Check if starts with letter (A-Za-z) per W3C spec
      if (!grepl("^[A-Za-z]", id)) {
        issues <- c(issues, "Must start with letter (A-Za-z)")
      }
      
      # Check for invalid characters per W3C spec
      # Valid: A-Za-z0-9._:-
      if (grepl("[^A-Za-z0-9._:-]", id)) {
        invalid_chars <- regmatches(id, gregexpr("[^A-Za-z0-9._:-]", id))[[1]]
        invalid_chars <- unique(invalid_chars)
        issues <- c(issues, paste("Contains invalid characters:", paste(invalid_chars, collapse = ", ")))
      }
    }
    
    # Overall pattern check
    if (length(issues) == 0 && !grepl(valid_pattern, id)) {
      issues <- c(issues, "Does not match W3C HTML 4.0 ID pattern")
    }
    
    if (length(issues) == 0) {
      results$valid <- c(results$valid, id)
    } else {
      results$invalid <- c(results$invalid, id)
      results$issues <- c(results$issues, paste(id, ":", paste(issues, collapse = "; ")))
    }
  }
  
  # Add summary statistics
  results$summary <- list(
    total = length(ids),
    valid_count = length(results$valid),
    invalid_count = length(results$invalid),
    compliance_rate = round(length(results$valid) / length(ids) * 100, 2)
  )
  
  return(results)
}

#' Save gt table to HTML file
#' @param gt_table A gt table object
#' @param filename File path to save the HTML
#' @param ... Additional arguments passed to writeLines
save_html <- function(gt_table, filename, ...) {
  if (inherits(gt_table, "gt_tbl")) {
    # Convert gt table to HTML
    html_output <- as_raw_html(gt_table, inline_css = FALSE)
    writeLines(html_output, filename, ...)
  } else {
    stop("Input must be a gt table object")
  }
}

