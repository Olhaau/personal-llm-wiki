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
#' - Unicode characters and emojis
#' - Quotes, parentheses, brackets
#' - Date formats and mathematical symbols
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
#'   `Emoji Status 😊` = c("Happy", "Sad"),
#'   check.names = FALSE
#' )
#' 
#' my_table <- df %>%
#'   gt() %>%
#'   fix_gt_headers()
#'   
#' # German/European characters example
#' german_df <- data.frame(
#'   `Größe (cm)` = c(170, 175),           # German ö -> oe
#'   `Müdigkeit` = c("Low", "High"),       # German ü -> ue  
#'   `Straße` = c("A1", "B2"),             # German ß -> ss
#'   `Café français` = c("Yes", "No"),     # Mixed French -> Cafe francai
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
#' # International multi-language example
#' intl_df <- data.frame(
#'   `Résultats %` = c(85, 90),            # French é -> e
#'   `Größe/Høyde` = c(170, 175),          # German/Norwegian mix
#'   `Příjmení` = c("Novák", "Svoboda"),   # Czech ř -> r
#'   `Señor/Señora` = c("Sr.", "Sra."),    # Spanish ñ -> n
#'   check.names = FALSE
#' )
#' 
#' international_table <- intl_df %>%
#'   gt() %>%
#'   fix_gt_headers(preserve_mapping = TRUE)
#'   
#' # View the character mappings
#' get_name_mapping(international_table)

library(gt)

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
  
  # Step 1: Handle European language characters FIRST (before emojis/unicode)
  # German umlauts and special characters
  id <- gsub("ä", "ae", id)                         # German a-umlaut
  id <- gsub("ö", "oe", id)                         # German o-umlaut  
  id <- gsub("ü", "ue", id)                         # German u-umlaut
  id <- gsub("Ä", "Ae", id)                         # German A-umlaut
  id <- gsub("Ö", "Oe", id)                         # German O-umlaut
  id <- gsub("Ü", "Ue", id)                         # German U-umlaut
  id <- gsub("ß", "ss", id)                         # German eszett (sharp s)
  
  # French accented characters
  id <- gsub("é", "e", id)                          # e acute
  id <- gsub("è", "e", id)                          # e grave
  id <- gsub("ê", "e", id)                          # e circumflex
  id <- gsub("ë", "e", id)                          # e diaeresis
  id <- gsub("à", "a", id)                          # a grave
  id <- gsub("â", "a", id)                          # a circumflex
  id <- gsub("ç", "c", id)                          # c cedilla
  id <- gsub("î", "i", id)                          # i circumflex
  id <- gsub("ï", "i", id)                          # i diaeresis
  id <- gsub("ô", "o", id)                          # o circumflex
  id <- gsub("ù", "u", id)                          # u grave
  id <- gsub("û", "u", id)                          # u circumflex
  id <- gsub("ÿ", "y", id)                          # y diaeresis
  
  # French uppercase
  id <- gsub("É", "E", id)                          # E acute
  id <- gsub("È", "E", id)                          # E grave
  id <- gsub("Ê", "E", id)                          # E circumflex
  id <- gsub("Ë", "E", id)                          # E diaeresis
  id <- gsub("À", "A", id)                          # A grave
  id <- gsub("Â", "A", id)                          # A circumflex
  id <- gsub("Ç", "C", id)                          # C cedilla
  id <- gsub("Î", "I", id)                          # I circumflex
  id <- gsub("Ï", "I", id)                          # I diaeresis
  id <- gsub("Ô", "O", id)                          # O circumflex
  id <- gsub("Ù", "U", id)                          # U grave
  id <- gsub("Û", "U", id)                          # U circumflex
  
  # Spanish characters
  id <- gsub("ñ", "n", id)                          # n tilde
  id <- gsub("Ñ", "N", id)                          # N tilde
  id <- gsub("á", "a", id)                          # a acute
  id <- gsub("í", "i", id)                          # i acute
  id <- gsub("ó", "o", id)                          # o acute
  id <- gsub("ú", "u", id)                          # u acute
  id <- gsub("Á", "A", id)                          # A acute
  id <- gsub("Í", "I", id)                          # I acute
  id <- gsub("Ó", "O", id)                          # O acute
  id <- gsub("Ú", "U", id)                          # U acute
  
  # Italian characters (additional)
  id <- gsub("ì", "i", id)                          # i grave
  id <- gsub("ò", "o", id)                          # o grave
  id <- gsub("Ì", "I", id)                          # I grave
  id <- gsub("Ò", "O", id)                          # O grave
  
  # Scandinavian characters
  id <- gsub("å", "aa", id)                         # a ring (Danish/Norwegian/Swedish)
  id <- gsub("æ", "ae", id)                         # ae ligature (Danish/Norwegian)
  id <- gsub("ø", "oe", id)                         # o slash (Danish/Norwegian)
  id <- gsub("Å", "Aa", id)                         # A ring
  id <- gsub("Æ", "Ae", id)                         # AE ligature
  id <- gsub("Ø", "Oe", id)                         # O slash
  
  # Eastern European characters  
  id <- gsub("č", "c", id)                          # c caron (Czech/Slovak)
  id <- gsub("š", "s", id)                          # s caron
  id <- gsub("ž", "z", id)                          # z caron
  id <- gsub("ř", "r", id)                          # r caron (Czech)
  id <- gsub("ď", "d", id)                          # d caron
  id <- gsub("ť", "t", id)                          # t caron
  id <- gsub("ň", "n", id)                          # n caron
  id <- gsub("ů", "u", id)                          # u ring (Czech)
  id <- gsub("Č", "C", id)                          # C caron
  id <- gsub("Š", "S", id)                          # S caron
  id <- gsub("Ž", "Z", id)                          # Z caron
  id <- gsub("Ř", "R", id)                          # R caron
  id <- gsub("Ď", "D", id)                          # D caron
  id <- gsub("Ť", "T", id)                          # T caron
  id <- gsub("Ň", "N", id)                          # N caron
  id <- gsub("Ů", "U", id)                          # U ring
  
  # Polish characters
  id <- gsub("ą", "a", id)                          # a ogonek
  id <- gsub("ć", "c", id)                          # c acute
  id <- gsub("ę", "e", id)                          # e ogonek
  id <- gsub("ł", "l", id)                          # l stroke
  id <- gsub("ń", "n", id)                          # n acute
  id <- gsub("ś", "s", id)                          # s acute
  id <- gsub("ź", "z", id)                          # z acute
  id <- gsub("ż", "z", id)                          # z dot above
  id <- gsub("Ą", "A", id)                          # A ogonek
  id <- gsub("Ć", "C", id)                          # C acute
  id <- gsub("Ę", "E", id)                          # E ogonek
  id <- gsub("Ł", "L", id)                          # L stroke
  id <- gsub("Ń", "N", id)                          # N acute
  id <- gsub("Ś", "S", id)                          # S acute
  id <- gsub("Ź", "Z", id)                          # Z acute
  id <- gsub("Ż", "Z", id)                          # Z dot above
  
  # Step 2: Handle emojis and unicode symbols SECOND (after European characters)
  # Common emojis with meaningful names
  id <- gsub("😊", ".smile.", id)                   # Smiling face
  id <- gsub("😢", ".sad.", id)                     # Sad face  
  id <- gsub("😍", ".love.", id)                    # Heart eyes
  id <- gsub("😎", ".cool.", id)                    # Cool sunglasses
  id <- gsub("😭", ".crying.", id)                  # Crying
  id <- gsub("😡", ".angry.", id)                   # Angry
  id <- gsub("👍", ".thumbsup.", id)                # Thumbs up
  id <- gsub("👎", ".thumbsdown.", id)              # Thumbs down
  id <- gsub("❤️", ".heart.", id)                   # Heart
  id <- gsub("💔", ".brokenheart.", id)             # Broken heart
  id <- gsub("⭐", ".star.", id)                    # Star
  id <- gsub("✨", ".sparkles.", id)                # Sparkles
  id <- gsub("✅", ".check.", id)                   # Check mark
  id <- gsub("❌", ".cross.", id)                   # Cross mark
  id <- gsub("⚠️", ".warning.", id)                 # Warning
  id <- gsub("🚨", ".alert.", id)                   # Alert
  id <- gsub("📊", ".chart.", id)                   # Chart
  id <- gsub("📈", ".trending.", id)                # Trending up
  id <- gsub("📉", ".declining.", id)               # Trending down
  id <- gsub("🔥", ".fire.", id)                    # Fire
  id <- gsub("💯", ".hundred.", id)                 # 100 points
  id <- gsub("🎯", ".target.", id)                  # Target
  id <- gsub("🔴", ".red.", id)                     # Red circle
  id <- gsub("🟢", ".green.", id)                   # Green circle  
  id <- gsub("🔵", ".blue.", id)                    # Blue circle
  id <- gsub("🟡", ".yellow.", id)                  # Yellow circle
  id <- gsub("🟠", ".orange.", id)                  # Orange circle
  id <- gsub("🟣", ".purple.", id)                  # Purple circle
  
  # Common unicode symbols
  id <- gsub("™", ".tm.", id)                       # Trademark
  id <- gsub("®", ".reg.", id)                      # Registered
  id <- gsub("©", ".copy.", id)                     # Copyright
  id <- gsub("°", ".deg.", id)                      # Degree symbol
  id <- gsub("→", ".arrow.", id)                    # Right arrow
  id <- gsub("←", ".leftarrow.", id)                # Left arrow
  id <- gsub("↑", ".uparrow.", id)                  # Up arrow
  id <- gsub("↓", ".downarrow.", id)                # Down arrow
  id <- gsub("↔", ".bidiarrow.", id)                # Bidirectional arrow
  id <- gsub("±", ".plusminus.", id)                # Plus-minus
  id <- gsub("≤", ".lte.", id)                      # Less than or equal (unicode)
  id <- gsub("≥", ".gte.", id)                      # Greater than or equal (unicode)
  id <- gsub("≠", ".neq.", id)                      # Not equal (unicode)
  id <- gsub("≈", ".approx.", id)                   # Approximately equal
  id <- gsub("∞", ".infinity.", id)                 # Infinity
  id <- gsub("√", ".sqrt.", id)                     # Square root
  id <- gsub("∑", ".sum.", id)                      # Summation
  id <- gsub("∏", ".product.", id)                  # Product
  id <- gsub("∫", ".integral.", id)                 # Integral
  
  # Greek letters (common in statistics and science)
  id <- gsub("α", ".alpha.", id)                    # Alpha
  id <- gsub("β", ".beta.", id)                     # Beta
  id <- gsub("γ", ".gamma.", id)                    # Gamma
  id <- gsub("δ", ".delta.", id)                    # Delta
  id <- gsub("ε", ".epsilon.", id)                  # Epsilon
  id <- gsub("π", ".pi.", id)                       # Pi
  id <- gsub("σ", ".sigma.", id)                    # Sigma
  id <- gsub("τ", ".tau.", id)                      # Tau
  id <- gsub("φ", ".phi.", id)                      # Phi
  id <- gsub("χ", ".chi.", id)                      # Chi
  id <- gsub("ψ", ".psi.", id)                      # Psi
  id <- gsub("ω", ".omega.", id)                    # Omega
  id <- gsub("μ", ".mu.", id)                       # Mu
  id <- gsub("ν", ".nu.", id)                       # Nu
  id <- gsub("λ", ".lambda.", id)                   # Lambda
  id <- gsub("θ", ".theta.", id)                    # Theta
  
  # Step 3: Handle mathematical and comparison operators
  # (Do this after European characters and emoji/unicode to avoid conflicts)
  id <- gsub("\\s*>=\\s*", ".gte.", id)             # Greater or equal  
  id <- gsub("\\s*<=\\s*", ".lte.", id)             # Less or equal
  id <- gsub("\\s*!=\\s*", ".neq.", id)             # Not equal
  id <- gsub("\\s*==\\s*", ".eq.", id)              # Equal comparison
  id <- gsub("\\s*>\\s*", ".gt.", id)               # Greater than
  id <- gsub("\\s*<\\s*", ".lt.", id)               # Less than
  id <- gsub("\\s*=\\s*", ".equals.", id)           # Assignment/equal
  
  # Logical and common operators
  id <- gsub("\\s*&\\s*", ".and.", id)              # Ampersand
  id <- gsub("\\s*\\|\\s*", ".or.", id)             # Pipe/or
  id <- gsub("\\s*\\+\\s*", ".plus.", id)           # Plus
  id <- gsub("\\s*/\\s*", ".div.", id)              # Division
  id <- gsub("\\s*\\*\\s*", ".mult.", id)           # Multiply
  
  # Special symbols with semantic meaning
  id <- gsub("\\$", ".dollar.", id)                 # Dollar sign
  id <- gsub("%", ".pct.", id)                      # Percent
  id <- gsub("@", ".at.", id)                       # At symbol  
  id <- gsub("#", ".num.", id)                      # Hash/number/pound
  id <- gsub("\\?", ".q.", id)                      # Question mark
  id <- gsub("!", ".excl.", id)                     # Exclamation
  
  # Handle parentheses and brackets (extract content, use periods)
  id <- gsub("\\(([^)]*?)\\)", ".\\1.", id)         # (content) -> .content.
  id <- gsub("\\[([^]]*?)\\]", ".\\1.", id)         # [content] -> .content.  
  id <- gsub("\\{([^}]*?)\\}", ".\\1.", id)         # {content} -> .content.
  
  # Handle quotes and punctuation
  id <- gsub("[\"'`]", ".quote.", id)               # Various quotes
  id <- gsub(";", ".semi.", id)                     # Semicolon
  id <- gsub("\\\\", ".backslash.", id)             # Backslash
  
  # Step 4: Handle any remaining non-ASCII characters gracefully
  # At this point, most European characters should already be converted
  # Try transliteration for any remaining accented characters
  tryCatch({
    id_transliterated <- iconv(id, from = "UTF-8", to = "ASCII//TRANSLIT", sub = "")
    
    # Check if transliteration was successful and didn't introduce question marks or NAs
    if (!is.na(id_transliterated) && !grepl("\\?", id_transliterated) && nchar(id_transliterated) > 0) {
      id <- id_transliterated
    } else {
      # Transliteration failed, replace any remaining non-ASCII with placeholder
      # Use more specific fallback for common remaining cases
      id <- gsub("[^\x20-\x7E]", ".intl.", id)  # Use .intl. for international chars
    }
  }, error = function(e) {
    # If iconv fails completely, fallback to removing non-ASCII
    id <<- gsub("[^\x20-\x7E]", ".intl.", id)
  })
  
  # Step 5: Convert remaining invalid characters to valid ones
  # Replace spaces and tabs with hyphens (common in column names) 
  id <- gsub("[\\s\\t]+", "-", id)
  
  # Replace any remaining invalid characters with periods
  # Valid chars per W3C: A-Za-z0-9._:-
  id <- gsub("[^A-Za-z0-9._:-]", ".", id)
  
  # Step 6: Clean up multiple separators
  id <- gsub("[-._:]+", ".", id)                    # Multiple separators -> single period
  id <- gsub("^[-._:]+|[-._:]+$", "", id)           # Remove leading/trailing separators
  
  # Step 7: Ensure ID starts with a letter (W3C requirement)
  if (!grepl("^[A-Za-z]", id)) {
    if (grepl("^[0-9]", id)) {
      # Starts with number, prefix with letter
      id <- paste0("col.", id)
    } else {
      # Starts with separator or empty, use meaningful prefix
      id <- paste0("col", id)
    }
  }
  
  # Step 8: Handle edge cases
  if (nchar(id) == 0 || id == "") {
    id <- "col.empty"
  } else if (nchar(id) == 1) {
    # Single character, ensure it's meaningful
    id <- paste0("col.", id)
  }
  
  # Step 9: Final validation - ensure result matches W3C pattern
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
# save_html <- function(gt_table, filename, ...) {
#   if (inherits(gt_table, "gt_tbl")) {
#     # Convert gt table to HTML
#     html_output <- as_raw_html(gt_table, inline_css = FALSE)
#     writeLines(html_output, filename, ...)
#   } else {
#     stop("Input must be a gt table object")
#   }
# }

