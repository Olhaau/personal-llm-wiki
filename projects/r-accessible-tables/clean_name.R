#!/usr/bin/env Rscript

# clean_name.R
# Functions to clean strings into valid HTML IDs and R variable names

# ---- Main Function ----

#' Clean String to Valid HTML ID and R Variable Name
#'
#' Converts a messy string into a valid identifier that works as both
#' an HTML ID attribute and an R variable name.
#'
#' @param x Character vector of strings to clean
#' @param case Character. Output case style: "snake" (default), "camel", or "dot"
#' @param prefix Character. Optional prefix to add (default: NULL)
#' @param unique Logical. Make names unique by appending numbers (default: FALSE)
#'
#' @return Character vector of cleaned names
#'
#' @details
#' The function ensures:
#' - Valid HTML ID: no whitespace, starts with letter/underscore
#' - Valid R name: syntactically valid, no reserved words
#' - No leading/trailing separators
#' - Handles Unicode characters by transliteration
#'
#' @examples
#' clean_name("My Variable!")              # "my_variable"
#' clean_name("123 starts with number")    # "x123_starts_with_number"
#' clean_name("Über-cool")                 # "uber_cool"
#' clean_name("special@#$chars")           # "special_chars"
#' clean_name(c("var", "var"), unique = TRUE)  # "var", "var_2"
#'
#' @export
clean_name <- function(x, case = "snake", prefix = NULL, unique = FALSE) {
  # Input validation
  if (!is.character(x)) {
    stop("Input must be a character vector")
  }
  
  if (!case %in% c("snake", "camel", "dot")) {
    stop("case must be one of: 'snake', 'camel', 'dot'")
  }
  
  # Handle empty strings
  if (length(x) == 0) {
    return(character(0))
  }
  
  # Process each string
  cleaned <- vapply(x, function(s) {
    if (is.na(s) || s == "") {
      return("empty")
    }
    
    # Step 1: Handle Unicode characters (transliterate)
    s <- iconv(s, to = "ASCII//TRANSLIT")
    if (is.na(s)) {
      s <- "invalid"
    }
    
    # Step 2: Convert to lowercase for processing
    s <- tolower(s)
    
    # Step 3: Replace invalid characters with separator
    separator <- switch(case,
                       snake = "_",
                       camel = "_",
                       dot = ".")
    
    # Keep only alphanumeric and some safe characters
    s <- gsub("[^a-z0-9_.-]", separator, s)
    
    # Step 4: Remove leading/trailing separators and collapse multiple separators
    s <- gsub(paste0(separator, "+"), separator, s)
    s <- gsub(paste0("^", separator, "+|", separator, "+$"), "", s)
    
    # Step 5: Ensure starts with letter or underscore (for HTML ID validity)
    if (grepl("^[0-9]", s)) {
      s <- paste0("x", s)
    }
    
    # Step 6: Handle empty result after cleaning
    if (s == "") {
      s <- "empty"
    }
    
    # Step 7: Convert to desired case
    if (case == "camel") {
      # Split by separator and capitalize first letter of each word (except first)
      parts <- strsplit(s, "_")[[1]]
      if (length(parts) > 1) {
        s <- paste0(parts[1], paste0(toupper(substring(parts[-1], 1, 1)),
                                      substring(parts[-1], 2), collapse = ""))
      }
    } else if (case == "dot") {
      s <- gsub("_", ".", s)
    }
    # snake case is already done
    
    # Step 8: Add prefix if provided
    if (!is.null(prefix) && prefix != "") {
      s <- paste0(prefix, "_", s)
    }
    
    # Step 9: Ensure it's a valid R name (handles reserved words)
    s <- make.names(s)
    
    # Step 10: Clean up artifacts from make.names() if needed
    # Remove trailing dots that make.names() might add
    s <- gsub("\\.$", "", s)
    
    return(s)
  }, character(1), USE.NAMES = FALSE)
  
  # Make unique if requested
  if (unique) {
    cleaned <- make.unique(cleaned, sep = "_")
  }
  
  return(cleaned)
}


# ---- Helper Functions ----

#' Validate HTML ID
#'
#' Check if a string is a valid HTML ID attribute
#'
#' @param x Character vector to validate
#' @return Logical vector indicating validity
#'
#' @examples
#' is_valid_html_id("my_var")      # TRUE
#' is_valid_html_id("123_start")   # FALSE (starts with number)
#' is_valid_html_id("my var")      # FALSE (contains space)
#'
#' @export
is_valid_html_id <- function(x) {
  if (!is.character(x)) return(FALSE)
  
  vapply(x, function(s) {
    if (is.na(s) || s == "") return(FALSE)
    
    # Must not contain whitespace
    if (grepl("\\s", s)) return(FALSE)
    
    # Must start with letter or underscore (strict interpretation)
    if (!grepl("^[a-zA-Z_]", s)) return(FALSE)
    
    # Should only contain safe characters (letters, digits, -, _, .)
    if (!grepl("^[a-zA-Z_][a-zA-Z0-9_.-]*$", s)) return(FALSE)
    
    return(TRUE)
  }, logical(1), USE.NAMES = FALSE)
}


#' Validate R Variable Name
#'
#' Check if a string is a valid R variable name
#'
#' @param x Character vector to validate
#' @return Logical vector indicating validity
#'
#' @examples
#' is_valid_r_name("my_var")       # TRUE
#' is_valid_r_name("123_start")    # FALSE
#' is_valid_r_name("if")           # FALSE (reserved word)
#'
#' @export
is_valid_r_name <- function(x) {
  if (!is.character(x)) return(FALSE)
  
  vapply(x, function(s) {
    if (is.na(s) || s == "") return(FALSE)
    
    # Use make.names to check - if it changes the name, it wasn't valid
    identical(s, make.names(s))
  }, logical(1), USE.NAMES = FALSE)
}


#' Check if Valid for Both HTML and R
#'
#' Convenience function to check both HTML ID and R name validity
#'
#' @param x Character vector to validate
#' @return Logical vector indicating validity for both
#'
#' @examples
#' is_valid_name("my_var")         # TRUE
#' is_valid_name("my-var")         # FALSE (invalid for R)
#'
#' @export
is_valid_name <- function(x) {
  is_valid_html_id(x) & is_valid_r_name(x)
}


# ---- Testing ----

if (!interactive()) {
  cat("Running clean_name tests...\n\n")
  
  # Test cases
  test_cases <- c(
    "My Variable!",
    "123 starts with number",
    "Über-cool",
    "special@#$chars",
    "multiple   spaces",
    "UPPERCASE",
    "mixed_CASE-test",
    "trailing___",
    "___leading",
    "",
    "äöü",
    "日本語",
    "if",  # R reserved word
    "for"  # R reserved word
  )
  
  cat("Test inputs:\n")
  print(test_cases)
  cat("\n")
  
  # Test snake_case (default)
  cat("Snake case output:\n")
  snake_results <- clean_name(test_cases)
  print(data.frame(
    input = test_cases,
    output = snake_results,
    valid_html = is_valid_html_id(snake_results),
    valid_r = is_valid_r_name(snake_results),
    stringsAsFactors = FALSE
  ))
  cat("\n")
  
  # Test camelCase
  cat("Camel case output:\n")
  camel_results <- clean_name(test_cases, case = "camel")
  print(data.frame(
    input = test_cases,
    output = camel_results,
    stringsAsFactors = FALSE
  ))
  cat("\n")
  
  # Test dot.case
  cat("Dot case output:\n")
  dot_results <- clean_name(test_cases, case = "dot")
  print(data.frame(
    input = test_cases,
    output = dot_results,
    stringsAsFactors = FALSE
  ))
  cat("\n")
  
  # Test uniqueness
  cat("Uniqueness test:\n")
  duplicate_inputs <- c("var", "var", "var", "test", "test")
  unique_results <- clean_name(duplicate_inputs, unique = TRUE)
  print(data.frame(
    input = duplicate_inputs,
    output = unique_results,
    stringsAsFactors = FALSE
  ))
  cat("\n")
  
  # Test with prefix
  cat("Prefix test:\n")
  prefix_results <- clean_name(c("var1", "var2"), prefix = "col")
  print(data.frame(
    input = c("var1", "var2"),
    output = prefix_results,
    stringsAsFactors = FALSE
  ))
  cat("\n")
  
  cat("All tests completed!\n")
}
