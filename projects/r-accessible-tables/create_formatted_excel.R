#' Create Clean Formatted Excel Files Matching GT Table Layout
#'
#' Creates Excel files with the correct GT table structure using empty cells
#' for proper visual spanner layout (no merge text visible)

library(writexl)
suppressPackageStartupMessages(library(dplyr))

#' Create Clean GT-Style Excel Table
create_formatted_excel_table <- function(data,
                                        filename = "formatted_table.xlsx",
                                        title = "GT-Style Table",
                                        description = "Clean GT table layout",
                                        spanner_delimiter = "_") {
  
  cat(sprintf("Creating clean GT-style Excel: %s\n", filename))
  
  # Analyze structure
  structure_info <- analyze_spanner_structure(data, spanner_delimiter)
  
  # Create worksheets
  worksheets <- list()
  
  # Main clean GT table
  worksheets[["GT_Table"]] <- create_clean_gt_layout(data, structure_info, title)
  
  # Accessible version
  worksheets[["Accessible_Data"]] <- create_accessible_version(data, structure_info)
  
  # Structure information
  worksheets[["Table_Info"]] <- create_table_info(structure_info, title)
  
  # Write file
  write_xlsx(worksheets, path = filename, col_names = FALSE)
  
  cat(sprintf("✓ Clean GT-style Excel created: %s\n", filename))
  show_clean_summary(structure_info, filename)
  
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

create_clean_gt_layout <- function(data, structure, title) {
  num_cols <- structure$num_cols
  
  # Create clean GT table structure
  table_rows <- list()
  
  # Row 1: Title (only in first cell, others empty for visual spanning)
  title_row <- character(num_cols)
  title_row[1] <- title
  # Leave other cells empty (they will appear as if title spans when formatted)
  for (i in 2:num_cols) {
    title_row[i] <- ""
  }
  table_rows[[1]] <- title_row
  
  # Row 2: Empty spacer
  table_rows[[2]] <- rep("", num_cols)
  
  if (structure$has_spanners) {
    # Row 3: Clean spanner headers (no merge text)
    spanner_row <- character(num_cols)
    current_group <- ""
    
    for (i in seq_along(structure$columns)) {
      col_info <- structure$columns[[i]]
      
      if (col_info$has_spanner) {
        if (col_info$group != current_group) {
          # First column of a new group - show group name
          spanner_row[i] <- col_info$group
          current_group <- col_info$group
        } else {
          # Subsequent columns of same group - leave empty for visual spanning
          spanner_row[i] <- ""
        }
      } else {
        # No spanner - leave empty
        spanner_row[i] <- ""
        current_group <- ""
      }
    }
    table_rows[[3]] <- spanner_row
    
    # Row 4: Sub-column headers
    sub_row <- character(num_cols)
    for (i in seq_along(structure$columns)) {
      sub_row[i] <- structure$columns[[i]]$sub_column
    }
    table_rows[[4]] <- sub_row
    
    # Row 5: Spacer
    table_rows[[5]] <- rep("", num_cols)
    
    # Data rows start from row 6
    data_start <- 6
  } else {
    # Row 3: Column headers (no spanners)
    header_row <- character(num_cols)
    for (i in seq_along(structure$columns)) {
      header_row[i] <- structure$columns[[i]]$sub_column
    }
    table_rows[[3]] <- header_row
    
    # Row 4: Spacer
    table_rows[[4]] <- rep("", num_cols)
    
    # Data rows start from row 5
    data_start <- 5
  }
  
  # Add data rows
  data_rows <- nrow(data)
  if (data_rows > 0) {
    for (i in 1:data_rows) {
      data_row <- as.character(unlist(data[i, ]))
      table_rows[[data_start + i - 1]] <- data_row
    }
  }
  
  # Convert to clean data frame
  max_rows <- length(table_rows)
  result_matrix <- matrix("", nrow = max_rows, ncol = num_cols)
  
  for (i in seq_along(table_rows)) {
    row_data <- table_rows[[i]]
    result_matrix[i, 1:length(row_data)] <- row_data
  }
  
  result_df <- as.data.frame(result_matrix, stringsAsFactors = FALSE)
  names(result_df) <- paste0("Col_", 1:num_cols)
  
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

create_table_info <- function(structure, title) {
  info_rows <- list()
  
  info_rows[[1]] <- data.frame(
    Aspect = "Title",
    Description = title,
    Location = "Row 1, spans all columns",
    stringsAsFactors = FALSE
  )
  
  info_rows[[2]] <- data.frame(
    Aspect = "Structure_Type",
    Description = if(structure$has_spanners) "Multi-level with spanners" else "Simple table",
    Location = if(structure$has_spanners) "Row 3: spanners, Row 4: headers" else "Row 3: headers",
    stringsAsFactors = FALSE
  )
  
  if (structure$has_spanners) {
    # Identify spanner groups and their ranges
    groups <- list()
    for (i in seq_along(structure$columns)) {
      col_info <- structure$columns[[i]]
      if (col_info$has_spanner) {
        group_name <- col_info$group
        if (!group_name %in% names(groups)) {
          groups[[group_name]] <- c(i, i)
        } else {
          groups[[group_name]][2] <- i
        }
      }
    }
    
    for (group_name in names(groups)) {
      range_info <- groups[[group_name]]
      info_rows[[length(info_rows) + 1]] <- data.frame(
        Aspect = paste("Spanner", group_name),
        Description = sprintf("Spans columns %d to %d", range_info[1], range_info[2]),
        Location = sprintf("Row 3, columns %d-%d", range_info[1], range_info[2]),
        stringsAsFactors = FALSE
      )
    }
  }
  
  info_rows[[length(info_rows) + 1]] <- data.frame(
    Aspect = "Data_Location",
    Description = sprintf("%d data rows", structure$num_rows),
    Location = if(structure$has_spanners) "Starting from row 6" else "Starting from row 5",
    stringsAsFactors = FALSE
  )
  
  info_rows[[length(info_rows) + 1]] <- data.frame(
    Aspect = "Manual_Formatting",
    Description = "To complete GT appearance, merge empty cells with spanner headers",
    Location = "Use Excel merge cells function on appropriate ranges",
    stringsAsFactors = FALSE
  )
  
  return(do.call(rbind, info_rows))
}

show_clean_summary <- function(structure, filename) {
  cat("\n=== Clean GT-Style Excel Created ===\n")
  cat(sprintf("File: %s\n", filename))
  cat("Layout: Clean GT table structure (no visible merge indicators)\n")
  
  if (structure$has_spanners) {
    cat("\nClean structure with spanners:\n")
    cat("  Row 1: Title (in first cell, others empty)\n")
    cat("  Row 2: [spacer]\n")
    cat("  Row 3: Spanner headers (group names in first cell of each group, others empty)\n")
    cat("  Row 4: Sub-column headers\n")
    cat("  Row 5: [spacer]\n")
    cat("  Rows 6+: Data\n")
    
    # Show spanner layout
    cat("\nSpanner layout:\n")
    groups <- list()
    for (i in seq_along(structure$columns)) {
      col_info <- structure$columns[[i]]
      if (col_info$has_spanner) {
        group_name <- col_info$group
        if (!group_name %in% names(groups)) {
          groups[[group_name]] <- c(i, i)
        } else {
          groups[[group_name]][2] <- i
        }
      }
    }
    
    for (group_name in names(groups)) {
      range_info <- groups[[group_name]]
      cat(sprintf("  - '%s': columns %d-%d (%d columns)\n", 
                  group_name, range_info[1], range_info[2], 
                  range_info[2] - range_info[1] + 1))
    }
  } else {
    cat("\nSimple structure:\n")
    cat("  Row 1: Title (in first cell, others empty)\n")
    cat("  Row 2: [spacer]\n") 
    cat("  Row 3: Column headers\n")
    cat("  Row 4: [spacer]\n")
    cat("  Rows 5+: Data\n")
  }
  
  cat("\nWorksheets:\n")
  cat("  • GT_Table - Clean layout ready for manual merging\n")
  cat("  • Accessible_Data - No merged cells for screen readers\n")
  cat("  • Table_Info - Structure and merging information\n")
  
  cat("\nVisual appearance:\n")
  cat("  ✓ Clean layout without visible merge indicators\n")
  cat("  ✓ Empty cells ready for merging to create spanner effect\n")
  cat("  ✓ Professional GT-style structure\n")
  cat("  ✓ Ready for manual formatting in Excel\n")
}

#' Create Sample Clean Excel
create_sample_formatted_excel <- function() {
  if (!exists("df")) {
    source("table.R")
  }
  
  create_formatted_excel_table(
    data = df,
    filename = "formatted_mikrozensus_sample.xlsx",
    title = "German Mikrozensus - Clean GT Layout",
    description = "Clean GT-style table without visible merge indicators",
    spanner_delimiter = "_"
  )
}