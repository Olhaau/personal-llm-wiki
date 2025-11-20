#' Create Fully Formatted Excel Files Using openxlsx
#'
#' This script creates professionally formatted Excel files with:
#' - Properly merged cells for spanners
#' - Professional styling (fonts, colors, borders)
#' - GT table appearance with full formatting
#' - No manual formatting required

suppressPackageStartupMessages(library(dplyr))

# Check if openxlsx is available, fall back to writexl if not
if ("openxlsx" %in% installed.packages()[, "Package"]) {
  cat("Using openxlsx for full formatting capabilities\n")
  library(openxlsx)
  USE_OPENXLSX <- TRUE
} else {
  cat("openxlsx not available, using writexl with formatting instructions\n")
  library(writexl)
  USE_OPENXLSX <- FALSE
}

#' Create Fully Formatted Excel Table
#' @param data Data frame to export
#' @param filename Output Excel filename
#' @param title Table title
#' @param description Table description
#' @param spanner_delimiter Character used to split column names for spanners
#' @return Invisible path to created file
create_formatted_excel_table <- function(data,
                                        filename = "formatted_table.xlsx",
                                        title = "Professional GT Table",
                                        description = "Fully formatted GT-style table",
                                        spanner_delimiter = "_") {
  
  cat(sprintf("Creating professionally formatted Excel: %s\n", filename))
  
  # Analyze spanner structure
  structure_info <- analyze_spanner_structure(data, spanner_delimiter)
  
  if (USE_OPENXLSX) {
    create_openxlsx_formatted_table(data, structure_info, title, filename)
  } else {
    create_writexl_formatted_table(data, structure_info, title, filename)
  }
  
  cat(sprintf("✓ Professionally formatted Excel created: %s\n", filename))
  return(invisible(filename))
}

# ---- openxlsx Version (Full Formatting) ----

create_openxlsx_formatted_table <- function(data, structure, title, filename) {
  cat("Using openxlsx for full professional formatting...\n")
  
  # Create workbook
  wb <- createWorkbook()
  
  # Add worksheet
  addWorksheet(wb, "GT_Table")
  addWorksheet(wb, "Accessible_Data")
  
  # ---- GT_Table Worksheet (Fully Formatted) ----
  
  # Set up the GT table structure
  row_offset <- setup_gt_table_structure(wb, "GT_Table", data, structure, title)
  
  # Add data
  writeData(wb, "GT_Table", data, startRow = row_offset, startCol = 1, colNames = FALSE)
  
  # Apply professional formatting
  apply_professional_formatting(wb, "GT_Table", data, structure, row_offset)
  
  # ---- Accessible_Data Worksheet ----
  
  # Create accessible version
  accessible_data <- create_accessible_data(data, structure)
  writeData(wb, "Accessible_Data", accessible_data, startRow = 1, startCol = 1)
  
  # Format accessible data
  format_accessible_worksheet(wb, "Accessible_Data", accessible_data)
  
  # Save workbook
  saveWorkbook(wb, filename, overwrite = TRUE)
  
  cat("✓ Full professional formatting applied with openxlsx\n")
}

setup_gt_table_structure <- function(wb, sheet, data, structure, title) {
  num_cols <- ncol(data)
  current_row <- 1
  
  # Title row
  writeData(wb, sheet, title, startRow = current_row, startCol = 1)
  mergeCells(wb, sheet, cols = 1:num_cols, rows = current_row)
  current_row <- current_row + 2  # Title + spacer
  
  if (structure$has_spanners) {
    # Spanner row
    spanner_data <- create_spanner_row(structure, num_cols)
    writeData(wb, sheet, t(spanner_data), startRow = current_row, startCol = 1, colNames = FALSE)
    
    # Merge spanner cells
    apply_spanner_merges(wb, sheet, structure, current_row, num_cols)
    current_row <- current_row + 1
    
    # Sub-header row
    sub_headers <- sapply(structure$columns, function(x) x$sub_column)
    writeData(wb, sheet, t(sub_headers), startRow = current_row, startCol = 1, colNames = FALSE)
    current_row <- current_row + 2  # Headers + spacer
  } else {
    # Simple headers
    headers <- sapply(structure$columns, function(x) x$sub_column)
    writeData(wb, sheet, t(headers), startRow = current_row, startCol = 1, colNames = FALSE)
    current_row <- current_row + 2  # Headers + spacer
  }
  
  return(current_row)
}

create_spanner_row <- function(structure, num_cols) {
  spanner_row <- character(num_cols)
  current_group <- ""
  
  for (i in seq_along(structure$columns)) {
    col_info <- structure$columns[[i]]
    if (col_info$has_spanner) {
      if (col_info$group != current_group) {
        spanner_row[i] <- col_info$group
        current_group <- col_info$group
      } else {
        spanner_row[i] <- ""
      }
    } else {
      spanner_row[i] <- ""
      current_group <- ""
    }
  }
  
  return(spanner_row)
}

apply_spanner_merges <- function(wb, sheet, structure, row, num_cols) {
  # Track spanner groups for merging
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
  
  # Apply merges for each group
  for (group_name in names(groups)) {
    range <- groups[[group_name]]
    if (range[2] > range[1]) {  # Only merge if span > 1
      mergeCells(wb, sheet, cols = range[1]:range[2], rows = row)
    }
  }
}

apply_professional_formatting <- function(wb, sheet, data, structure, data_start_row) {
  num_cols <- ncol(data)
  num_rows <- nrow(data)
  
  # Define styles
  title_style <- createStyle(
    fontSize = 14, fontName = "Calibri", textDecoration = "bold",
    halign = "center", valign = "center",
    fgFill = "#366092", fontColour = "#FFFFFF"
  )
  
  spanner_style <- createStyle(
    fontSize = 12, fontName = "Calibri", textDecoration = "bold",
    halign = "center", valign = "center",
    fgFill = "#4F81BD", fontColour = "#FFFFFF",
    border = c("top", "bottom", "left", "right"),
    borderColour = "#4F81BD", borderStyle = "medium"
  )
  
  header_style <- createStyle(
    fontSize = 11, fontName = "Calibri", textDecoration = "bold",
    halign = "center", valign = "center",
    fgFill = "#B7D4F0", fontColour = "#000000",
    border = c("top", "bottom", "left", "right"),
    borderColour = "#4F81BD", borderStyle = "thin"
  )
  
  data_style <- createStyle(
    fontSize = 10, fontName = "Calibri",
    halign = "center", valign = "center",
    border = c("top", "bottom", "left", "right"),
    borderColour = "#D0D0D0", borderStyle = "thin"
  )
  
  # Apply styles
  
  # Title style (row 1)
  addStyle(wb, sheet, title_style, rows = 1, cols = 1:num_cols)
  
  if (structure$has_spanners) {
    # Spanner style (row 3)
    addStyle(wb, sheet, spanner_style, rows = 3, cols = 1:num_cols)
    
    # Header style (row 4)  
    addStyle(wb, sheet, header_style, rows = 4, cols = 1:num_cols)
    
    # Data style
    if (num_rows > 0) {
      addStyle(wb, sheet, data_style, rows = data_start_row:(data_start_row + num_rows - 1), cols = 1:num_cols, gridExpand = TRUE)
    }
  } else {
    # Header style (row 3)
    addStyle(wb, sheet, header_style, rows = 3, cols = 1:num_cols)
    
    # Data style
    if (num_rows > 0) {
      addStyle(wb, sheet, data_style, rows = data_start_row:(data_start_row + num_rows - 1), cols = 1:num_cols, gridExpand = TRUE)
    }
  }
  
  # Set column widths
  setColWidths(wb, sheet, cols = 1:num_cols, widths = "auto")
  
  # Freeze panes at data start
  freezePane(wb, sheet, firstActiveRow = data_start_row, firstActiveCol = 1)
}

create_accessible_data <- function(data, structure) {
  if (structure$has_spanners) {
    new_names <- character(ncol(data))
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

format_accessible_worksheet <- function(wb, sheet, data) {
  # Simple, clean formatting for accessibility
  header_style <- createStyle(
    fontSize = 11, fontName = "Calibri", textDecoration = "bold",
    fgFill = "#F2F2F2", fontColour = "#000000"
  )
  
  # Apply header style
  addStyle(wb, sheet, header_style, rows = 1, cols = 1:ncol(data))
  
  # Set column widths
  setColWidths(wb, sheet, cols = 1:ncol(data), widths = "auto")
}

# ---- writexl Version (With Instructions) ----

create_writexl_formatted_table <- function(data, structure, title, filename) {
  cat("openxlsx not available, creating writexl version with formatting instructions...\n")
  
  # Create clean structure
  worksheets <- list()
  
  # Clean GT table
  worksheets[["GT_Table"]] <- create_clean_gt_layout(data, structure, title)
  
  # Accessible data
  worksheets[["Accessible_Data"]] <- create_accessible_data(data, structure)
  
  # Formatting instructions
  worksheets[["Formatting_Instructions"]] <- create_detailed_formatting_guide(structure)
  
  # Write file
  write_xlsx(worksheets, path = filename, col_names = FALSE)
  
  cat("✓ writexl version created with detailed formatting instructions\n")
  print_formatting_instructions(structure, filename)
}

create_clean_gt_layout <- function(data, structure, title) {
  num_cols <- ncol(data)
  table_rows <- list()
  
  # Title row
  title_row <- character(num_cols)
  title_row[1] <- title
  for (i in 2:num_cols) title_row[i] <- ""
  table_rows[[1]] <- title_row
  
  # Spacer
  table_rows[[2]] <- rep("", num_cols)
  
  if (structure$has_spanners) {
    # Spanner row
    spanner_row <- create_spanner_row(structure, num_cols)
    table_rows[[3]] <- spanner_row
    
    # Sub-headers
    sub_headers <- sapply(structure$columns, function(x) x$sub_column)
    table_rows[[4]] <- sub_headers
    
    # Spacer
    table_rows[[5]] <- rep("", num_cols)
    
    # Data
    for (i in 1:nrow(data)) {
      table_rows[[5 + i]] <- as.character(unlist(data[i, ]))
    }
  } else {
    # Headers
    headers <- sapply(structure$columns, function(x) x$sub_column)
    table_rows[[3]] <- headers
    
    # Spacer
    table_rows[[4]] <- rep("", num_cols)
    
    # Data
    for (i in 1:nrow(data)) {
      table_rows[[4 + i]] <- as.character(unlist(data[i, ]))
    }
  }
  
  # Convert to data frame
  result_matrix <- matrix("", nrow = length(table_rows), ncol = num_cols)
  for (i in seq_along(table_rows)) {
    result_matrix[i, ] <- table_rows[[i]]
  }
  
  result_df <- as.data.frame(result_matrix, stringsAsFactors = FALSE)
  names(result_df) <- paste0("Col_", 1:num_cols)
  
  return(result_df)
}

create_detailed_formatting_guide <- function(structure) {
  instructions <- list()
  
  instructions[[1]] <- data.frame(
    Step = "OPENXLSX_RECOMMENDED",
    Instruction = "Install openxlsx package for automatic formatting",
    Details = "Run: install.packages('openxlsx') then use this script",
    stringsAsFactors = FALSE
  )
  
  instructions[[2]] <- data.frame(
    Step = "1_TITLE",
    Instruction = "Select A1:E1 and merge cells",
    Details = "Title should span all columns with blue background (#366092)",
    stringsAsFactors = FALSE
  )
  
  if (structure$has_spanners) {
    # Find spanner ranges
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
      range <- groups[[group_name]]
      if (range[2] > range[1]) {
        step_id <- paste0("2_SPANNER_", toupper(group_name))
        range_text <- paste0(LETTERS[range[1]], "3:", LETTERS[range[2]], "3")
        instructions[[length(instructions) + 1]] <- data.frame(
          Step = step_id,
          Instruction = paste("Select", range_text, "and merge cells"),
          Details = paste("Spanner", group_name, "with blue background (#4F81BD)"),
          stringsAsFactors = FALSE
        )
      }
    }
    
    instructions[[length(instructions) + 1]] <- data.frame(
      Step = "3_HEADERS",
      Instruction = "Format row 4 as headers",
      Details = "Light blue background (#B7D4F0), bold text, borders",
      stringsAsFactors = FALSE
    )
    
    instructions[[length(instructions) + 1]] <- data.frame(
      Step = "4_DATA",
      Instruction = "Format data rows (6 onwards)",
      Details = "Light borders, center alignment, auto-fit columns",
      stringsAsFactors = FALSE
    )
  } else {
    instructions[[length(instructions) + 1]] <- data.frame(
      Step = "2_HEADERS",
      Instruction = "Format row 3 as headers",
      Details = "Light blue background (#B7D4F0), bold text, borders",
      stringsAsFactors = FALSE
    )
    
    instructions[[length(instructions) + 1]] <- data.frame(
      Step = "3_DATA",
      Instruction = "Format data rows (5 onwards)",
      Details = "Light borders, center alignment, auto-fit columns",
      stringsAsFactors = FALSE
    )
  }
  
  return(do.call(rbind, instructions))
}

print_formatting_instructions <- function(structure, filename) {
  cat("\n=== FORMATTING INSTRUCTIONS ===\n")
  cat(sprintf("File: %s\n", filename))
  cat("\nFor automatic formatting, install openxlsx:\n")
  cat("  install.packages('openxlsx')\n")
  cat("  Then rerun this script\n")
  
  cat("\nManual formatting steps:\n")
  cat("1. Open GT_Table worksheet\n")
  cat("2. Merge title cells (A1:E1) with blue background\n")
  if (structure$has_spanners) {
    cat("3. Merge spanner cells as indicated in instructions\n")
    cat("4. Format headers (row 4) with light blue background\n") 
    cat("5. Format data (rows 6+) with borders and alignment\n")
  } else {
    cat("3. Format headers (row 3) with light blue background\n")
    cat("4. Format data (rows 5+) with borders and alignment\n")
  }
}

# ---- Helper Functions ----

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

#' Create Sample Formatted Excel
create_sample_formatted_excel <- function() {
  if (!exists("df")) {
    source("table.R")
  }
  
  create_formatted_excel_table(
    data = df,
    filename = "formatted_mikrozensus_sample.xlsx",
    title = "German Mikrozensus - Professional Format",
    description = "Fully formatted GT-style table with professional appearance",
    spanner_delimiter = "_"
  )
}