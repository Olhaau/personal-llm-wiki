#' Create Properly Formatted Excel Files Matching GT Table Layout
#'
#' This creates Excel files with the CORRECT GT table structure:
#' - Proper orientation and layout
#' - Clear merge indicators for spanner headers
#' - Exact GT table structure that can be manually formatted in Excel

library(writexl)
suppressPackageStartupMessages(library(dplyr))

#' Create Correctly Formatted Excel Table
create_formatted_excel_table <- function(data,
                                        filename = "formatted_table.xlsx",
                                        title = "GT-Style Table",
                                        description = "Properly formatted GT table",
                                        spanner_delimiter = "_") {
  
  cat(sprintf("Creating properly formatted Excel: %s\n", filename))
  
  # Analyze structure
  structure_info <- analyze_spanner_structure(data, spanner_delimiter)
  
  # Create worksheets
  worksheets <- list()
  
  # Main formatted table
  worksheets[["GT_Table"]] <- create_gt_table_layout(data, structure_info, title)
  
  # Accessible version
  worksheets[["Accessible_Data"]] <- create_accessible_version(data, structure_info)
  
  # Instructions
  worksheets[["Formatting_Guide"]] <- create_formatting_guide(structure_info)
  
  # Write file
  write_xlsx(worksheets, path = filename, col_names = FALSE)  # No auto headers
  
  cat(sprintf("✓ GT-style Excel created: %s\n", filename))
  show_formatting_summary(structure_info, filename)
  
  return(invisible(filename))
}

analyze_spanner_structure <- function(data, delimiter = "_") {
  col_names <- names(data)
  spanner_info <- list()
  
  for (i in seq_along(col_names)) {
    name <- col_names[i]
    
    if (grepl(delimiter, name, fixed = TRUE)) {
      parts <- strsplit(name, delimiter, fixed = TRUE)[[1]]
      group <- parts[1]
      sub_col <- paste(parts[-1], collapse = delimiter)
      
      spanner_info[[i]] <- list(
        original = name,
        group = group,
        sub_column = sub_col,
        has_spanner = TRUE,
        position = i
      )
    } else {
      spanner_info[[i]] <- list(
        original = name,
        group = "",
        sub_column = name,
        has_spanner = FALSE,
        position = i
      )
    }
  }
  
  return(list(
    columns = spanner_info,
    has_spanners = any(sapply(spanner_info, function(x) x$has_spanner)),
    num_cols = length(col_names),
    num_rows = nrow(data)
  ))
}

create_gt_table_layout <- function(data, structure, title) {
  num_cols <- structure$num_cols
  
  # Create the proper GT table structure
  table_data <- list()
  
  # Row 1: Title (will be merged across all columns)
  title_row <- character(num_cols)
  title_row[1] <- title
  if (num_cols > 1) {
    title_row[2:num_cols] <- "[MERGE]"
  }
  table_data[[1]] <- title_row
  
  # Row 2: Empty spacer
  table_data[[2]] <- rep("", num_cols)
  
  if (structure$has_spanners) {
    # Row 3: Spanner headers
    spanner_row <- character(num_cols)
    current_group <- ""
    
    for (i in seq_along(structure$columns)) {
      col_info <- structure$columns[[i]]
      
      if (col_info$has_spanner) {
        if (col_info$group != current_group) {
          # First column of a new group
          spanner_row[i] <- col_info$group
          current_group <- col_info$group
        } else {
          # Continuation of the same group
          spanner_row[i] <- "[MERGE]"
        }
      } else {
        # No spanner
        spanner_row[i] <- ""
        current_group <- ""
      }
    }
    table_data[[3]] <- spanner_row
    
    # Row 4: Sub-column headers
    sub_row <- character(num_cols)
    for (i in seq_along(structure$columns)) {
      sub_row[i] <- structure$columns[[i]]$sub_column
    }
    table_data[[4]] <- sub_row
    
    # Row 5: Spacer
    table_data[[5]] <- rep("", num_cols)
    
    # Data rows start from row 6
    data_start <- 6
  } else {
    # Row 3: Column headers (no spanners)
    header_row <- character(num_cols)
    for (i in seq_along(structure$columns)) {
      header_row[i] <- structure$columns[[i]]$sub_column
    }
    table_data[[3]] <- header_row
    
    # Row 4: Spacer
    table_data[[4]] <- rep("", num_cols)
    
    # Data rows start from row 5
    data_start <- 5
  }
  
  # Add data rows
  for (i in 1:nrow(data)) {
    data_row <- as.character(unlist(data[i, ]))
    table_data[[data_start + i - 1]] <- data_row
  }
  
  # Convert to data frame
  max_rows <- length(table_data)
  result_df <- data.frame(
    matrix(unlist(lapply(table_data, function(x) c(x, rep("", num_cols - length(x))))),
           nrow = max_rows, ncol = num_cols, byrow = TRUE),
    stringsAsFactors = FALSE
  )
  
  # Set column names to match original data
  names(result_df) <- names(data)
  
  return(result_df)
}

create_accessible_version <- function(data, structure) {
  if (structure$has_spanners) {
    # Create clear headers for accessibility
    new_names <- character(structure$num_cols)
    for (i in seq_along(structure$columns)) {
      col_info <- structure$columns[[i]]
      if (col_info$has_spanner) {
        new_names[i] <- paste(col_info$group, col_info$sub_column, sep = " - ")
      } else {
        new_names[i] <- col_info$sub_column
      }
    }
    
    result <- data
    names(result) <- new_names
    return(result)
  }
  
  return(data)
}

create_formatting_guide <- function(structure) {
  guide_steps <- list()
  
  guide_steps[[1]] <- data.frame(
    Step = "1",
    Action = "Open GT_Table worksheet",
    Details = "This contains the properly structured table layout",
    stringsAsFactors = FALSE
  )
  
  guide_steps[[2]] <- data.frame(
    Step = "2",
    Action = "Select cells marked with [MERGE]",
    Details = "These indicate cells that should be merged with the cell to their left",
    stringsAsFactors = FALSE
  )
  
  guide_steps[[3]] <- data.frame(
    Step = "3", 
    Action = "Merge cells for title (Row 1)",
    Details = "Merge all cells in row 1 to create the title spanning all columns",
    stringsAsFactors = FALSE
  )
  
  if (structure$has_spanners) {
    guide_steps[[4]] <- data.frame(
      Step = "4",
      Action = "Merge cells for spanner headers (Row 3)",
      Details = "Merge cells marked [MERGE] with the group name to their left",
      stringsAsFactors = FALSE
    )
    
    guide_steps[[5]] <- data.frame(
      Step = "5",
      Action = "Format spanner headers",
      Details = "Make spanner headers bold and centered",
      stringsAsFactors = FALSE
    )
    
    guide_steps[[6]] <- data.frame(
      Step = "6",
      Action = "Add borders",
      Details = "Add borders around column groups and headers",
      stringsAsFactors = FALSE
    )
  } else {
    guide_steps[[4]] <- data.frame(
      Step = "4",
      Action = "Format headers",
      Details = "Make column headers bold",
      stringsAsFactors = FALSE
    )
  }
  
  return(do.call(rbind, guide_steps))
}

show_formatting_summary <- function(structure, filename) {
  cat("\n=== Properly Formatted Excel Created ===\n")
  cat(sprintf("File: %s\n", filename))
  cat("Layout: CORRECT GT table structure\n")
  
  if (structure$has_spanners) {
    cat("Structure with spanners:\n")
    cat("  Row 1: Title [MERGE] [MERGE] [MERGE] [MERGE]\n")
    cat("  Row 2: [spacer]\n")
    cat("  Row 3: Verheiratet [MERGE] Single [MERGE] \n")
    cat("  Row 4: Sub-headers for each column\n")
    cat("  Row 5: [spacer]\n")
    cat("  Rows 6+: Data\n")
  } else {
    cat("Simple structure:\n")
    cat("  Row 1: Title [MERGE] [MERGE] [MERGE] [MERGE]\n")
    cat("  Row 2: [spacer]\n") 
    cat("  Row 3: Column headers\n")
    cat("  Row 4: [spacer]\n")
    cat("  Rows 5+: Data\n")
  }
  
  cat("\nTo complete formatting:\n")
  cat("  1. Open GT_Table worksheet\n")
  cat("  2. Merge cells marked with [MERGE]\n")
  cat("  3. Apply formatting (bold, borders, colors)\n")
  cat("  4. Use Accessible_Data for screen readers\n")
}

#' Create Sample Formatted Excel
create_sample_formatted_excel <- function() {
  if (!exists("df")) {
    source("table.R")
  }
  
  create_formatted_excel_table(
    data = df,
    filename = "formatted_mikrozensus_sample.xlsx",
    title = "German Mikrozensus - Proper GT Layout",
    description = "Correctly formatted GT-style table with merge indicators",
    spanner_delimiter = "_"
  )
}