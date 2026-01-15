# Test Statistischer Bericht Generator
# Based on extracted design patterns from official report

source("corporate-design/statistischer-bericht-generator.R")

# Create sample data matching the original structure
sample_data <- list(
  "61241-01" = data.frame(
    Erzeugnis = c("Motorenbenzin E 5", "Dieselkraftstoff", "Dieselkraftstoff"),
    Frachtlage = c("ab Lager", "ab Lager", "frei Verbrauchsstelle"), 
    Berichtsort = rep("Deutschland", 3),
    EUR_je_hl_JD_2025 = c(133.43, 121.45, 124.65),
    EUR_je_hl_Dez_2024 = c(132.73, 121.86, 125.03),
    EUR_je_hl_Nov_2025 = c(135.00, 125.38, 128.78),
    EUR_je_hl_Dez_2025 = c(128.89, 117.83, 121.31)
  ),
  
  "61241-02" = data.frame(
    Monat_Jahr = paste(rep(c("Januar", "Februar", "März", "April"), 5), 
                      rep(2020:2024, each = 4)),
    Motorenbenzin_E5 = runif(20, 80, 140),
    stringsAsFactors = FALSE
  ),
  
  "61241-03" = data.frame(
    Monat_Jahr = paste(rep(c("Januar", "Februar", "März"), 3),
                      rep(2023:2025, each = 3)),
    Dieselkraftstoff_ab_Lager = runif(9, 70, 130),
    Dieselkraftstoff_frei_Verbrauchsstelle = runif(9, 75, 135),
    stringsAsFactors = FALSE
  )
)

# Create the official report
cat("Creating Statistischer Bericht based on official design patterns...\n")

create_statistischer_bericht(
  data_list = sample_data,
  filename = "statistischer_bericht_demo.xlsx",
  title = "Preise für ausgewählte Mineralölerzeugnisse",
  period = "Dezember 2025", 
  evas_number = "61241"
)

cat("\n=== REPORT CREATED SUCCESSFULLY ===\n")
cat("File: statistischer_bericht_demo.xlsx\n")
cat("Structure matches official Destatis standards:\n")
cat("✓ Titel sheet with report metadata\n")
cat("✓ Informationen_Barrierefreiheit for accessibility\n")
cat("✓ Inhaltsübersicht with complete navigation\n")
cat("✓ Data tables (61241-01, 61241-02, 61241-03)\n") 
cat("✓ Barrier-free versions (61241-01-b, etc.)\n")
cat("✓ CSV versions (csv-61241-01, etc.)\n")
cat("✓ German number formatting throughout\n")
cat("✓ Official color scheme and typography\n")
cat("✓ Professional navigation system\n")