# Robust GT Headers Fix with Better Unicode/Emoji Handling
# This version handles encoding issues more gracefully

library(gt)

#' Generate Valid HTML ID from Any String - Robust Version
#'
#' @param name Character string to convert to valid HTML ID
#' @return Valid HTML ID string following W3C HTML 4.0 specification
#' @keywords internal
generate_valid_html_id_robust <- function(name) {
  if (is.na(name) || name == "") {
    return("col.empty")
  }
  
  # Start with the original name
  id <- name
  
  # Step 1: Handle common problematic patterns FIRST
  # Mathematical and comparison operators
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
  
  # Step 2: Handle Unicode/Emojis robustly using byte-level replacement
  # Convert common unicode patterns to meaningful names
  
  # Common emojis (using hex patterns to be encoding-safe)
  # Note: This is more robust than trying to match the actual emoji characters
  patterns <- list(
    # Common faces
    "smile|happy|\\ud83d\\ude0a|\\ud83d\\ude04|\\ud83d\\ude01" = ".smile.",
    "sad|cry|\\ud83d\\ude22|\\ud83d\\ude2d|\\ud83d\\ude25" = ".sad.",
    "cool|sunglasses|\\ud83d\\ude0e" = ".cool.",
    "love|heart.eyes|\\ud83d\\ude0d" = ".love.",
    "angry|\\ud83d\\ude21|\\ud83d\\ude20" = ".angry.",
    
    # Common symbols
    "thumbs.up|\\ud83d\\udc4d" = ".thumbsup.",
    "thumbs.down|\\ud83d\\udc4e" = ".thumbsdown.",
    "heart|\\u2764|\\ud83d\\udc96" = ".heart.",
    "star|\\u2b50|\\u272a" = ".star.",
    "check|\\u2713|\\u2705" = ".check.",
    "cross|\\u274c|\\u2717" = ".cross.",
    "warning|\\u26a0" = ".warning.",
    "fire|\\ud83d\\udd25" = ".fire.",
    "target|\\ud83c\\udfaf" = ".target.",
    
    # Circles
    "red.circle|\\ud83d\\udd34" = ".red.",
    "green.circle|\\ud83d\\udfe2" = ".green.",
    "blue.circle|\\ud83d\\udd35" = ".blue.",
    
    # Charts and data
    "chart|\\ud83d\\udcca" = ".chart.",
    "trending.up|\\ud83d\\udcc8" = ".trending.",
    "trending.down|\\ud83d\\udcc9" = ".declining.",
    
    # Common unicode symbols  
    "trademark|\\u2122" = ".tm.",
    "registered|\\u00ae" = ".reg.",
    "copyright|\\u00a9" = ".copy.",
    "degree|\\u00b0" = ".deg.",
    "arrow|\\u2192|\\u2190|\\u2191|\\u2193" = ".arrow.",
    "plus.minus|\\u00b1" = ".plusminus.",
    "infinity|\\u221e" = ".infinity.",
    
    # Greek letters (common in statistics)
    "alpha|\\u03b1" = ".alpha.",
    "beta|\\u03b2" = ".beta.",
    "gamma|\\u03b3" = ".gamma.",
    "delta|\\u03b4" = ".delta.",
    "pi|\\u03c0" = ".pi.",
    "sigma|\\u03c3" = ".sigma.",
    "mu|\\u03bc" = ".mu."
  )
  
  # Apply pattern replacements
  for (pattern in names(patterns)) {
    id <- gsub(pattern, patterns[[pattern]], id, ignore.case = TRUE)
  }
  
  # Step 3: Remove any remaining non-ASCII characters
  # This is more robust than iconv for handling encoding issues
  id <- gsub("[^\x20-\x7E]", ".unicode.", id)  # Keep only printable ASCII
  
  # Step 4: Convert remaining invalid characters to valid ones
  # Replace spaces and tabs with hyphens
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

# Test the robust function
if (FALSE) {  # Set to TRUE to run tests
  test_cases <- c(
    "Status 😊",
    "Sad 😢", 
    "Data™",
    "Temp°C",
    "Score👍",
    "Alert⚠️",
    "Chart📊",
    "Fire🔥",
    "Alpha α",
    "Beta β",
    "Pi π"
  )
  
  cat("=== Robust Emoji/Unicode Test ===\n")
  for (case in test_cases) {
    result <- generate_valid_html_id_robust(case)
    cat(sprintf("%-15s -> %s\n", paste0("\"", case, "\""), result))
  }
}

# Alternative approach: Simpler semantic replacement
generate_valid_html_id_simple <- function(name) {
  if (is.na(name) || name == "") {
    return("col.empty")
  }
  
  id <- name
  
  # Step 1: Handle semantic patterns based on common words/patterns
  # This avoids unicode matching issues entirely
  
  # Emotional/status indicators
  id <- gsub("(smile|happy|joy|good)", ".smile.", id, ignore.case = TRUE)
  id <- gsub("(sad|cry|bad|poor)", ".sad.", id, ignore.case = TRUE)
  id <- gsub("(cool|awesome|great)", ".cool.", id, ignore.case = TRUE)
  id <- gsub("(love|heart|like)", ".love.", id, ignore.case = TRUE)
  id <- gsub("(angry|mad|upset)", ".angry.", id, ignore.case = TRUE)
  
  # Directions and indicators
  id <- gsub("(up|increase|rise|high)", ".up.", id, ignore.case = TRUE)
  id <- gsub("(down|decrease|fall|low)", ".down.", id, ignore.case = TRUE)
  id <- gsub("(good|yes|positive|pass)", ".good.", id, ignore.case = TRUE)
  id <- gsub("(bad|no|negative|fail)", ".bad.", id, ignore.case = TRUE)
  
  # Mathematical and comparison operators
  id <- gsub("\\s*>=\\s*", ".gte.", id)
  id <- gsub("\\s*<=\\s*", ".lte.", id)
  id <- gsub("\\s*!=\\s*", ".neq.", id)
  id <- gsub("\\s*==\\s*", ".eq.", id)
  id <- gsub("\\s*>\\s*", ".gt.", id)
  id <- gsub("\\s*<\\s*", ".lt.", id)
  id <- gsub("\\s*=\\s*", ".equals.", id)
  
  # Special symbols
  id <- gsub("\\$", ".dollar.", id)
  id <- gsub("%", ".pct.", id)
  id <- gsub("@", ".at.", id)
  id <- gsub("#", ".num.", id)
  id <- gsub("\\?", ".q.", id)
  id <- gsub("!", ".excl.", id)
  id <- gsub("&", ".and.", id)
  id <- gsub("\\|", ".or.", id)
  id <- gsub("\\+", ".plus.", id)
  id <- gsub("\\*", ".mult.", id)
  id <- gsub("/", ".div.", id)
  
  # Brackets and quotes
  id <- gsub("\\(([^)]*?)\\)", ".\\1.", id)
  id <- gsub("\\[([^]]*?)\\]", ".\\1.", id)
  id <- gsub("\\{([^}]*?)\\}", ".\\1.", id)
  id <- gsub("[\"'`]", ".quote.", id)
  
  # Handle any non-ASCII by removing them completely
  id <- gsub("[^\x20-\x7E]", "", id)
  
  # Clean up spaces and invalid characters
  id <- gsub("[\\s\\t]+", "-", id)
  id <- gsub("[^A-Za-z0-9._:-]", ".", id)
  id <- gsub("[-._:]+", ".", id)
  id <- gsub("^[-._:]+|[-._:]+$", "", id)
  
  # Ensure starts with letter
  if (!grepl("^[A-Za-z]", id)) {
    if (grepl("^[0-9]", id)) {
      id <- paste0("col.", id)
    } else {
      id <- paste0("col", id)
    }
  }
  
  # Handle edge cases
  if (nchar(id) == 0 || id == "") {
    id <- "col.empty"
  } else if (nchar(id) == 1) {
    id <- paste0("col.", id)
  }
  
  return(id)
}