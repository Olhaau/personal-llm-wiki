# Create Demo Excel File
# Simple working version using openxlsx2

library(openxlsx2)

# Function to create formatted Excel with navigation
create_demo_excel <- function(data_list, filename) {
  wb <- wb_workbook()
  
  # Create index sheet
  wb$add_worksheet("Inhaltsübersicht")
  
  # Add title
  wb$add_data(x = "Inhaltsübersicht", dims = "A1")
  wb$add_style(dims = "A1:B1", style = wb_style(font_bold = TRUE, font_size = 16))
  wb$merge_cells(dims = "A1:B1")
  
  # Add headers for navigation table
  wb$add_data(x = "Blatt", dims = "A3")
  wb$add_data(x = "Beschreibung", dims = "B3")
  wb$add_style(dims = "A3:B3", style = wb_style(font_bold = TRUE))
  
  # Add navigation links
  row <- 4
  for (sheet_name in names(data_list)) {
    wb$add_data(x = sheet_name, dims = paste0("A", row))
    wb$add_hyperlink(dims = paste0("A", row), target = paste0("#", sheet_name, "!A1"))
    
    n_rows <- nrow(data_list[[sheet_name]])
    n_cols <- ncol(data_list[[sheet_name]])
    description <- paste0("Tabelle mit ", n_rows, " Zeilen und ", n_cols, " Spalten")
    wb$add_data(x = description, dims = paste0("B", row))
    row <- row + 1
  }
  
  # Set column widths
  wb$set_col_widths(cols = 1, widths = 20)
  wb$set_col_widths(cols = 2, widths = 40)
  
  # Create data sheets
  for (sheet_name in names(data_list)) {
    wb$add_worksheet(sheet_name)
    
    # Add title
    title <- paste("Daten:", sheet_name)
    wb$add_data(x = title, dims = "A1")
    wb$add_style(dims = "A1", style = wb_style(font_bold = TRUE, font_size = 14))
    
    # Add back link
    wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")
    wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
    
    # Add data starting from A4
    wb$add_data(x = data_list[[sheet_name]], dims = "A4")
    
    # Format headers
    header_range <- paste0("A4:", int2col(ncol(data_list[[sheet_name]])), "4")
    wb$add_style(dims = header_range, style = wb_style(font_bold = TRUE))
    
    # Auto-size columns
    wb$set_col_widths(cols = 1:ncol(data_list[[sheet_name]]), widths = "auto")
  }
  
  # Set active sheet to index
  wb$set_active_sheet("Inhaltsübersicht")
  
  # Save
  wb_save(wb, filename, overwrite = TRUE)
  cat("✓ Created Excel file:", filename, "\n")
}

# Create the demo
datasets <- list(
  "Iris" = iris,
  "Cars" = mtcars
)

create_demo_excel(datasets, "demo_excel_file.xlsx")

cat("Demo Excel file created successfully with:\n")
cat("- Inhaltsübersicht (navigation sheet)\n")
cat("- Iris data sheet\n") 
cat("- Cars data sheet\n")
cat("- Hyperlinks between sheets\n")
cat("- Formatted headers\n")