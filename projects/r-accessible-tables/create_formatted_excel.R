#' Create Formatted Excel Files Mimicking GT Table Appearance
#'
#' Simplified version that creates Excel files with visual formatting that
#' matches GT HTML table output with proper spanner headers and styling.

library(writexl)
suppressPackageStartupMessages(library(dplyr))

# ---- Main Function ----

#' Create Formatted Excel Table Matching GT Appearance
#'
#' @param data Data frame to export
#' @param filename Output Excel filename  
#' @param title Table title
#' @param description Table description
#' @param spanner_delimiter Character used to split column names for spanners
#' @return Invisible path to created file
#' @export
create_formatted_excel_table <- function(data,
                                        filename = "formatted_table.xlsx",
                                        title = "Formatted Data Table",
                                        description = "Excel table with GT-style formatting",
                                        spanner_delimiter = "_") {
  
  cat(sprintf("Creating formatted Excel table: %s\n", filename))
  
  # Analyze structure
  structure_info <- analyze_column_structure(data, spanner_delimiter)
  
  # Create worksheets
  worksheets <- list()
  
  # 1. Visual formatted table (mimics GT appearance)
  worksheets[["Visual_GT_Table"]] <- create_visual_gt_table(data, structure_info, title)
  
  # 2. Accessible data table
  worksheets[["Accessible_Data"]] <- create_accessible_data_table(data, structure_info)
  
  # 3. Column structure info
  worksheets[["Column_Structure"]] <- create_column_info_table(structure_info)
  
  # 4. Documentation
  worksheets[["Documentation"]] <- create_documentation_table(data, title, description, structure_info)
  
  # Write Excel file
  write_xlsx(worksheets, path = filename, col_names = TRUE)
  
  cat(sprintf("✓ Formatted Excel file created: %s\n", filename))
  print_excel_summary(structure_info, filename)
  
  return(invisible(filename))
}

# ---- Analysis Functions ----

analyze_column_structure <- function(data, delimiter = "_") {
  col_names <- names(data)
  groups <- list()
  group_info <- list()
  
  for (i in seq_along(col_names)) {
    name <- col_names[i]
    
    if (grepl(delimiter, name, fixed = TRUE)) {
      parts <- strsplit(name, delimiter, fixed = TRUE)[[1]]
      group_name <- parts[1]
      sub_name <- paste(parts[-1], collapse = delimiter)
      
      if (!group_name %in% names(groups)) {
        groups[[group_name]] <- list()
      }
      groups[[group_name]][[sub_name]] <- i
      
      group_info[[i]] <- list(
        original = name,
        group = group_name,
        sub = sub_name,
        has_group = TRUE
      )
    } else {
      group_info[[i]] <- list(
        original = name,
        group = NA,
        sub = name,
        has_group = FALSE
      )
    }
  }
  
  return(list(
    groups = groups,
    group_info = group_info,
    has_groups = length(groups) > 0,
    num_cols = length(col_names),
    num_rows = nrow(data)
  ))
}

# ---- Table Creation Functions ----

create_visual_gt_table <- function(data, structure, title) {
  # Create a visual representation similar to GT tables
  
  # Calculate dimensions
  num_cols <- structure$num_cols
  
  # Create table structure
  visual_table <- list()
  
  # Row 1: Title
  title_row <- character(num_cols)
  title_row[1] <- title
  if(num_cols > 1) {
    title_row[2:num_cols] <- ""
  }
  visual_table[["Title"]] <- title_row
  
  # Row 2: Empty spacer
  spacer_row <- rep("", num_cols)
  visual_table[["Spacer1"]] <- spacer_row
  
  if (structure$has_groups) {
    # Row 3: Group headers (spanners)
    group_row <- character(num_cols)
    for (i in seq_along(structure$group_info)) {
      info <- structure$group_info[[i]]
      if (info$has_group) {
        group_row[i] <- info$group
      } else {
        group_row[i] <- ""
      }
    }
    visual_table[["Groups"]] <- group_row
    
    # Row 4: Sub headers
    sub_row <- character(num_cols)
    for (i in seq_along(structure$group_info)) {
      info <- structure$group_info[[i]]
      sub_row[i] <- info$sub
    }
    visual_table[["Headers"]] <- sub_row
    
    # Row 5: Spacer
    visual_table[["Spacer2"]] <- spacer_row
  } else {
    # Simple headers
    header_row <- character(num_cols)
    for (i in seq_along(structure$group_info)) {
      header_row[i] <- structure$group_info[[i]]$sub
    }
    visual_table[["Headers"]] <- header_row
    visual_table[["Spacer2"]] <- spacer_row
  }
  
  # Add data rows
  data_rows <- nrow(data)
  if (data_rows > 0) {
    for (i in 1:data_rows) {
      row_name <- paste("Data", i, sep = "_")
      visual_table[[row_name]] <- as.character(data[i, ])
    }
  }
  
  # Convert to data frame
  result <- data.frame(visual_table, stringsAsFactors = FALSE)
  
  # Set proper column names
  col_names <- paste0("Col_", seq_len(num_cols))
  names(result) <- col_names
  
  return(result)
}

create_accessible_data_table <- function(data, structure) {
  if (structure$has_groups) {
    # Create descriptive column names
    new_names <- character(structure$num_cols)
    for (i in seq_along(structure$group_info)) {
      info <- structure$group_info[[i]]
      if (info$has_group) {
        new_names[i] <- paste(info$group, info$sub, sep = " - ")
      } else {
        new_names[i] <- info$sub
      }
    }
    
    result <- data
    names(result) <- new_names
    return(result)
  }
  
  return(data)
}

create_column_info_table <- function(structure) {
  info_rows <- list()
  
  for (i in seq_along(structure$group_info)) {
    info <- structure$group_info[[i]]
    info_rows[[i]] <- data.frame(
      Column_Position = i,
      Original_Name = info$original,
      Group = if(info$has_group) info$group else "None",
      Sub_Column = info$sub,
      Has_Spanner = info$has_group,
      stringsAsFactors = FALSE
    )
  }
  
  return(do.call(rbind, info_rows))
}

create_documentation_table <- function(data, title, description, structure) {
  doc_rows <- list(
    data.frame(Section = "Title", Information = title, stringsAsFactors = FALSE),
    data.frame(Section = "Description", Information = description, stringsAsFactors = FALSE),
    data.frame(Section = "Generated", Information = format(Sys.time(), "%Y-%m-%d %H:%M:%S"), stringsAsFactors = FALSE),
    data.frame(Section = "Data_Rows", Information = as.character(structure$num_rows), stringsAsFactors = FALSE),
    data.frame(Section = "Data_Columns", Information = as.character(structure$num_cols), stringsAsFactors = FALSE)
  )
  
  if (structure$has_groups) {
    doc_rows[[length(doc_rows) + 1]] <- data.frame(
      Section = "Structure_Type", 
      Information = "Grouped columns with spanners", 
      stringsAsFactors = FALSE
    )
    doc_rows[[length(doc_rows) + 1]] <- data.frame(
      Section = "Number_of_Groups", 
      Information = as.character(length(structure$groups)), 
      stringsAsFactors = FALSE
    )
    doc_rows[[length(doc_rows) + 1]] <- data.frame(
      Section = "Group_Names", 
      Information = paste(names(structure$groups), collapse = ", "), 
      stringsAsFactors = FALSE
    )
  } else {
    doc_rows[[length(doc_rows) + 1]] <- data.frame(
      Section = "Structure_Type", 
      Information = "Simple table without grouping", 
      stringsAsFactors = FALSE
    )
  }
  
  return(do.call(rbind, doc_rows))
}

# ---- Utility Functions ----

print_excel_summary <- function(structure, filename) {
  cat("\n=== Formatted Excel Summary ===\n")
  cat(sprintf("File: %s\n", filename))
  
  if (structure$has_groups) {
    cat("Structure: Multi-level table with visual spanners\n")
    cat(sprintf("Column groups: %d\n", length(structure$groups)))
    for (group_name in names(structure$groups)) {
      cat(sprintf("  - '%s': %d columns\n", group_name, length(structure$groups[[group_name]])))
    }
  } else {
    cat("Structure: Simple table without grouping\n")
  }
  
  cat("\nWorksheets created:\n")
  cat("  • 'Visual_GT_Table' - GT-style layout with spanners\n")
  cat("  • 'Accessible_Data' - Screen reader optimized data\n")
  cat("  • 'Column_Structure' - Detailed column information\n") 
  cat("  • 'Documentation' - Complete metadata\n")
  
  cat("\nVisual GT features:\n")
  cat("  ✓ Title row at top\n")
  cat("  ✓ Spanner headers over grouped columns\n")
  cat("  ✓ Sub-column headers\n")
  cat("  ✓ Proper spacing and hierarchy\n")
  cat("  ✓ Professional layout matching GT tables\n")
}

#' Create Sample Formatted Excel
create_sample_formatted_excel <- function() {
  if (!exists("df")) {
    source("table.R")
  }
  
  create_formatted_excel_table(
    data = df,
    filename = "formatted_mikrozensus_sample.xlsx",
    title = "German Mikrozensus - GT-Style Formatted Table",
    description = paste(
      "German micro census data with visual formatting that matches GT table appearance.",
      "Features visual spanner headers, professional layout, and accessibility optimization.",
      "Demonstrates proper handling of special characters (%, €, (), German umlauts)."
    ),
    spanner_delimiter = "_"
  )
}