# Simple Demo Excel File Creation
library(openxlsx2)

# Create workbook
wb <- wb_workbook()

# Create index sheet
wb$add_worksheet("Inhaltsübersicht")

# Add title and content to index
wb$add_data(x = "Inhaltsübersicht", dims = "A1")
wb$add_data(x = "Blatt", dims = "A3") 
wb$add_data(x = "Beschreibung", dims = "B3")

# Add navigation links
wb$add_data(x = "Iris", dims = "A4")
wb$add_hyperlink(dims = "A4", target = "#Iris!A1")
wb$add_data(x = "Iris Blumendaten mit 150 Zeilen und 5 Spalten", dims = "B4")

wb$add_data(x = "Cars", dims = "A5")
wb$add_hyperlink(dims = "A5", target = "#Cars!A1") 
wb$add_data(x = "Autodaten mit 32 Zeilen und 11 Spalten", dims = "B5")

# Create Iris sheet
wb$add_worksheet("Iris")
wb$add_data(x = "Daten: Iris", dims = "A1")
wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2")
wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
wb$add_data(x = iris, dims = "A4")

# Create Cars sheet  
wb$add_worksheet("Cars")
wb$add_data(x = "Daten: Cars", dims = "A1")
wb$add_data(x = "← Zur Inhaltsübersicht", dims = "A2") 
wb$add_hyperlink(dims = "A2", target = "#Inhaltsübersicht!A1")
wb$add_data(x = mtcars, dims = "A4")

# Set active sheet to index
wb$set_active_sheet("Inhaltsübersicht")

# Save file
wb_save(wb, "demo_excel_file.xlsx", overwrite = TRUE)

cat("✓ Demo Excel file created: demo_excel_file.xlsx\n")
cat("  Contains:\n")
cat("  - Inhaltsübersicht (navigation sheet)\n")  
cat("  - Iris sheet (150 rows of flower data)\n")
cat("  - Cars sheet (32 rows of car data)\n")
cat("  - Hyperlinks for navigation between sheets\n")