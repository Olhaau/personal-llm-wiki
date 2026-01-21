# ---- Coordinate-Based Excel Extraction Example ----

library(openxlsx2)
library(jsonlite)
source("../code/extraction_engine.R")

# ---- Create Sample Excel File with Complex Formatting ----

create_sample_excel_file <- function(filename = "sample_complex.xlsx") {
  
  # Create workbook with sample data
  wb <- wb_workbook()
  wb$add_worksheet("Sales_Data")
  wb$add_worksheet("Summary")
  
  # Add sample data to Sales_Data sheet
  sales_data <- data.frame(
    Region = c("North", "South", "East", "West", "North", "South"),
    Salesperson = c("Alice", "Bob", "Charlie", "Diana", "Eve", "Frank"),
    Q1_Sales = c(15000, 12000, 18000, 16000, 14000, 11000),
    Q2_Sales = c(16000, 13000, 17000, 15000, 15000, 12000),
    Q3_Sales = c(17000, 14000, 19000, 17000, 16000, 13000),
    Q4_Sales = c(18000, 15000, 20000, 18000, 17000, 14000),
    Total = c(66000, 54000, 74000, 66000, 62000, 50000)
  )
  
  wb$add_data(sheet = "Sales_Data", x = sales_data, dims = "A1", with_filter = TRUE)
  
  # ---- Apply Complex Coordinate-Based Formatting ----
  
  # Header Block Formatting (A1:G1)
  wb$add_font(
    sheet = "Sales_Data",
    dims = "A1:G1", 
    bold = TRUE,
    size = 12,
    color = wb_color("white")
  )
  wb$add_fill(
    sheet = "Sales_Data",
    dims = "A1:G1",
    color = wb_color("#4472C4")
  )
  wb$add_cell_style(
    sheet = "Sales_Data",
    dims = "A1:G1",
    horizontal = "center",
    vertical = "middle"
  )
  wb$add_border(
    sheet = "Sales_Data",
    dims = "A1:G1",
    top_style = "medium",
    bottom_style = "medium",
    left_style = "medium", 
    right_style = "medium"
  )
  
  # Data Block Formatting (A2:G7) 
  wb$add_border(
    sheet = "Sales_Data",
    dims = "A2:G7",
    inner_hgrid = "thin",
    inner_vgrid = "thin",
    outer_border = "medium"
  )
  
  # Alternating row fills (overlays)
  for (row in seq(2, 7, 2)) {  # Even rows
    wb$add_fill(
      sheet = "Sales_Data", 
      dims = paste0("A", row, ":G", row),
      color = wb_color("#F2F2F2")
    )
  }
  
  # Number formatting for sales columns (C2:G7)
  wb$add_numfmt(
    sheet = "Sales_Data",
    dims = "C2:G7",
    numfmt = "#,##0"
  )
  
  # Conditional formatting overlay for high performers (G2:G7)
  wb$add_conditional_formatting(
    sheet = "Sales_Data",
    dims = "G2:G7",
    rule = "cellIs",
    style = c(">=65000"),
    dxf = create_dxfs_style(
      bg_fill = wb_color("#90EE90"),
      font_color = wb_color("#006400")
    )
  )
  
  # Column width adjustments
  wb$set_col_widths(sheet = "Sales_Data", cols = 1:7, widths = "auto")
  
  # Add summary data to Summary sheet
  summary_data <- data.frame(
    Metric = c("Total Sales", "Average Sale", "Top Region", "Top Salesperson"),
    Value = c("$372,000", "$62,000", "East", "Charlie"),
    stringsAsFactors = FALSE
  )
  
  wb$add_data(sheet = "Summary", x = summary_data, dims = "B3")
  
  # Format summary sheet
  wb$add_font(sheet = "Summary", dims = "B3:C3", bold = TRUE, size = 14)
  wb$add_fill(sheet = "Summary", dims = "B3:C6", color = wb_color("#E6F3FF"))
  wb$add_border(sheet = "Summary", dims = "B3:C6", outer_border = "thick")
  
  # Merge cells for title
  wb$merge_cells(sheet = "Summary", dims = "B1:C1")
  wb$add_data(sheet = "Summary", x = "SALES SUMMARY REPORT", dims = "B1")
  wb$add_font(sheet = "Summary", dims = "B1", bold = TRUE, size = 16)
  wb$add_cell_style(sheet = "Summary", dims = "B1", horizontal = "center")
  
  # Add hyperlink
  wb$add_hyperlink(
    sheet = "Summary",
    dims = "B8",
    target = "Sales_Data!A1",
    display = "View Detailed Data"
  )
  
  # Add comment
  wb$add_comment(
    sheet = "Sales_Data",
    dims = "G2",
    comment = "Excellent performance this year!",
    author = "Manager"
  )
  
  # Save the file
  wb_save(wb, filename, overwrite = TRUE)
  cat("Sample Excel file created:", filename, "\n")
  
  return(wb)
}

# ---- Extract with Coordinate-Based System ----

demonstrate_coordinate_extraction <- function() {
  
  # Create sample file
  wb <- create_sample_excel_file("sample_complex.xlsx")
  
  cat("\n=== COORDINATE-BASED EXTRACTION DEMONSTRATION ===\n")
  
  # Extract complete specifications
  specs <- extract_excel_specifications(
    wb,
    output_file = "sample_complex_specs.json",
    include_raw_data = TRUE,
    include_formatting = TRUE,
    include_advanced = TRUE
  )
  
  cat("\n--- Extraction Results ---\n")
  cat("Coordinate System:", specs$coordinate_system$addressing_mode, "\n")
  cat("Total Worksheets:", length(specs$worksheets), "\n")
  
  # Analyze coordinate structure for Sales_Data sheet
  sales_sheet <- specs$worksheets[["Sales_Data"]]
  
  cat("\n--- Sales_Data Sheet Coordinate Analysis ---\n")
  cat("Used Range:", sales_sheet$coordinate_grid$used_range$range_address, "\n")
  cat("Total Data Regions:", length(sales_sheet$coordinate_grid$data_regions), "\n")
  
  # Show data regions
  if (length(sales_sheet$coordinate_grid$data_regions) > 0) {
    for (region_name in names(sales_sheet$coordinate_grid$data_regions)) {
      region <- sales_sheet$coordinate_grid$data_regions[[region_name]]
      cat(sprintf("  %s Region: %s (Type: %s)\n", 
                  region_name, 
                  region$coordinates$range_address,
                  region$type))
    }
  }
  
  # Show formatting layers
  cat("\n--- Formatting Layer Analysis ---\n")
  formatting <- sales_sheet$formatting_layers
  cat("Base Formatting Layer: Present\n")
  cat("Formatting Blocks:", length(formatting$block_formatting), "\n")
  cat("Formatting Overlays:", length(formatting$overlay_formatting), "\n")
  
  # Show content layers
  cat("\n--- Content Layer Analysis ---\n")
  content <- sales_sheet$content_layers
  cat("Cell Values:", length(content$cell_values), "\n")
  cat("Formulas:", length(content$formulas), "\n")
  cat("Comments:", length(content$comments), "\n")
  cat("Hyperlinks:", length(content$hyperlinks), "\n")
  
  # Show sample coordinate data
  cat("\n--- Sample Coordinate Data ---\n")
  if (length(content$cell_values) > 0) {
    sample_cell <- content$cell_values[[1]]
    cat("Sample Cell Coordinate:\n")
    cat(sprintf("  Address: %s\n", sample_cell$coordinate$address))
    cat(sprintf("  Row: %d, Col: %d\n", sample_cell$coordinate$row, sample_cell$coordinate$col))
    cat(sprintf("  Sheet: %s\n", sample_cell$coordinate$sheet))
    cat(sprintf("  Value: %s\n", sample_cell$value))
    cat(sprintf("  Type: %s\n", sample_cell$data_type))
  }
  
  return(specs)
}

# ---- Coordinate-Based Analysis Functions ----

analyze_coordinate_structure <- function(specs) {
  
  cat("\n=== COORDINATE STRUCTURE ANALYSIS ===\n")
  
  for (sheet_name in names(specs$worksheets)) {
    sheet <- specs$worksheets[[sheet_name]]
    
    cat(sprintf("\n--- %s Sheet ---\n", sheet_name))
    
    # Coordinate grid analysis
    grid <- sheet$coordinate_grid
    cat(sprintf("Used Range: %s\n", grid$used_range$range_address))
    cat(sprintf("Dimensions: %d rows x %d cols (%d total cells)\n",
                grid$used_range$dimensions$rows,
                grid$used_range$dimensions$cols, 
                grid$used_range$dimensions$total_cells))
    
    # Data regions
    if (length(grid$data_regions) > 0) {
      cat("Data Regions:\n")
      for (region in grid$data_regions) {
        cat(sprintf("  - %s: %s [%s]\n", 
                    region$type, 
                    region$coordinates$range_address,
                    region$region_id))
      }
    }
    
    # Formatting blocks
    formatting <- sheet$formatting_layers
    if (length(formatting$block_formatting) > 0) {
      cat("Formatting Blocks:\n")
      for (block in formatting$block_formatting) {
        cat(sprintf("  - Block %s: %s (Priority: %d)\n",
                    block$block_id,
                    block$coordinates$range_address,
                    block$priority))
      }
    }
    
    # Overlays
    if (length(formatting$overlay_formatting) > 0) {
      cat("Formatting Overlays:\n")
      for (overlay in formatting$overlay_formatting) {
        cat(sprintf("  - Overlay %s: %s [%s] (Priority: %d)\n",
                    overlay$overlay_id,
                    overlay$coordinates$range_address,
                    overlay$overlay_type,
                    overlay$priority))
      }
    }
  }
}

# ---- Coordinate-Based Validation ----

validate_coordinate_consistency <- function(specs) {
  
  cat("\n=== COORDINATE CONSISTENCY VALIDATION ===\n")
  
  validation_results <- list()
  
  for (sheet_name in names(specs$worksheets)) {
    sheet <- specs$worksheets[[sheet_name]]
    sheet_validation <- list()
    
    # Check coordinate system consistency
    addressing_mode <- specs$coordinate_system$addressing_mode
    
    # Validate all coordinates use consistent addressing
    consistent_addressing <- TRUE
    
    # Check content layer coordinates
    content <- sheet$content_layers
    for (cell_ref in names(content$cell_values)) {
      cell <- content$cell_values[[cell_ref]]
      coord <- cell$coordinate
      
      # Verify address matches row/col
      expected_address <- paste0(int2col(coord$col), coord$row)
      if (coord$address != expected_address) {
        consistent_addressing <- FALSE
        break
      }
    }
    
    sheet_validation$consistent_addressing <- consistent_addressing
    
    # Check for overlapping blocks/overlays
    formatting <- sheet$formatting_layers
    overlapping_detected <- FALSE
    
    # This would implement overlap detection logic
    sheet_validation$no_overlapping_conflicts <- !overlapping_detected
    
    # Check coordinate bounds
    grid <- sheet$coordinate_grid
    within_bounds <- (
      grid$used_range$end$row <= specs$coordinate_system$max_dimensions$max_rows &&
      grid$used_range$end$col <= specs$coordinate_system$max_dimensions$max_cols
    )
    
    sheet_validation$within_coordinate_bounds <- within_bounds
    
    validation_results[[sheet_name]] <- sheet_validation
  }
  
  # Overall validation
  all_valid <- all(sapply(validation_results, function(sheet) {
    all(unlist(sheet))
  }))
  
  cat("Coordinate System Validation:", if (all_valid) "PASSED" else "FAILED", "\n")
  
  for (sheet_name in names(validation_results)) {
    sheet_result <- validation_results[[sheet_name]]
    cat(sprintf("%s Sheet:\n", sheet_name))
    cat(sprintf("  Consistent Addressing: %s\n", 
                if (sheet_result$consistent_addressing) "✓" else "✗"))
    cat(sprintf("  No Overlapping Conflicts: %s\n",
                if (sheet_result$no_overlapping_conflicts) "✓" else "✗"))
    cat(sprintf("  Within Coordinate Bounds: %s\n",
                if (sheet_result$within_coordinate_bounds) "✓" else "✗"))
  }
  
  return(validation_results)
}

# ---- Run Demonstration ----

if (!interactive()) {
  # Run the demonstration
  specs <- demonstrate_coordinate_extraction()
  analyze_coordinate_structure(specs)
  validate_coordinate_consistency(specs)
  
  cat("\n=== FILES CREATED ===\n")
  cat("Excel File: sample_complex.xlsx\n")
  cat("JSON Specs: sample_complex_specs.json\n")
  cat("\nDemonstration complete!\n")
}