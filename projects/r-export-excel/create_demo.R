# Create demo Excel file with multiple sheets and multi-level headers
source('R/excelize.R')

# Create output directory if needed
if (!dir.exists('output')) dir.create('output')

# Sheet 1: Bundesländer Bevölkerung mit Kategorien ----
bevoelkerung <- data.frame(
  Bundesland = c('Baden-Württemberg', 'Bayern', 'Berlin', 'Brandenburg', 
                 'Bremen', 'Hamburg', 'Hessen', 'Niedersachsen'),
  Einwohner_Gesamt = c(11280257, 13369393, 3769495, 2573138, 
                       676463, 1906411, 6391360, 8140242),
  Einwohner_Maennlich = c(5589321, 6631044, 1864218, 1283629,
                          333912, 950287, 3168234, 4042628),
  Einwohner_Weiblich = c(5690936, 6738349, 1905277, 1289509,
                         342551, 956124, 3223126, 4097614),
  Flaeche_km2 = c(35748, 70541, 892, 29654, 
                  420, 755, 21116, 47710),
  Dichte_pro_km2 = c(315.5, 189.5, 4227.1, 86.8, 
                     1610.6, 2525.3, 302.6, 170.6)
)

# Define multi-level header for population sheet
bevoelkerung_header <- list(
  list(label = "Verwaltung", cols = 1),
  list(label = "Bevölkerung", cols = 2:4),
  list(label = "Geographie", cols = 5:6)
)

# Sheet 2: Wirtschaftsdaten mit Kategorien ----
wirtschaft <- data.frame(
  Jahr = c(2020, 2021, 2022, 2023),
  BIP_Nominal = c(3332.0, 3617.5, 3876.8, 4121.2),
  BIP_Real = c(3280.5, 3385.1, 3445.8, 3435.5),
  BIP_Wachstum = c(-3.8, 3.2, 1.8, -0.3),
  Arbeitslose = c(2695000, 2613000, 2418000, 2607000),
  Arbeitslosenquote = c(5.9, 5.7, 5.3, 5.7),
  Inflation = c(0.5, 3.1, 6.9, 5.9),
  Inflation_Energie = c(-5.2, 4.5, 34.7, -2.7)
)

# Define multi-level header for economy sheet
wirtschaft_header <- list(
  list(label = "Zeitraum", cols = 1),
  list(label = "Bruttoinlandsprodukt (Mrd. €)", cols = 2:4),
  list(label = "Arbeitsmarkt", cols = 5:6),
  list(label = "Inflation (%)", cols = 7:8)
)

# Sheet 3: Bildungsausgaben mit Kategorien ----
bildung <- data.frame(
  Bildungsbereich = c('Kindergärten', 'Grundschulen', 'Weiterführende Schulen',
                      'Berufsschulen', 'Hochschulen', 'Erwachsenenbildung'),
  Personal_Mio = c(4521.3, 8234.5, 12456.8, 
                   3124.6, 18234.2, 1245.8),
  Sachmittel_Mio = c(2134.7, 4123.8, 6234.1, 
                     1678.9, 9123.4, 678.3),
  Investitionen_Mio = c(1794.5, 2872.5, 3876.4, 
                        1088.6, 4793.3, 416.6),
  Schueler = c(745200, 2834500, 8456300, 
               2567800, 2948600, 156700),
  Lehrer = c(52340, 198230, 534200,
             89450, 412300, 12450)
)

# Define multi-level header for education sheet
bildung_header <- list(
  list(label = "Bereich", cols = 1),
  list(label = "Ausgaben (Mio. €)", cols = 2:4),
  list(label = "Personen", cols = 5:6)
)

# Create workbook ----
wb <- wb_workbook()

# STEP 1: Create empty index sheet first (so it appears as first sheet)
wb <- init_index_sheet(wb, index_sheet_name = "Index")

# STEP 2: Add data sheets with multi-level headers
wb <- add_sheet(
  wb, 
  bevoelkerung, 
  sheet_name = "Bevölkerung",
  heading = "Bevölkerungsstatistik nach Bundesländern",
  multi_header = bevoelkerung_header,
  freeze_rows = 1,
  add_index_link = TRUE
)

wb <- add_sheet(
  wb, 
  wirtschaft, 
  sheet_name = "Wirtschaft",
  heading = "Wirtschaftsindikatoren Deutschland",
  multi_header = wirtschaft_header,
  freeze_rows = 1,
  add_index_link = TRUE
)

wb <- add_sheet(
  wb, 
  bildung, 
  sheet_name = "Bildung",
  heading = "Bildungsausgaben nach Bereichen",
  multi_header = bildung_header,
  freeze_rows = 1,
  add_index_link = TRUE
)

# STEP 3: Update index sheet with links to all data sheets
wb <- update_index_sheet(
  wb,
  index_title = "Inhaltsverzeichnis",
  index_sheet_name = "Index"
)

# Save workbook
wb$save("output/demo_statistik_mehrere_sheets.xlsx")

cat('\n✓ Multi-sheet Excel file created successfully!\n')
cat('  File: output/demo_statistik_mehrere_sheets.xlsx\n')

# Get sheet info
all_sheets <- wb$get_sheet_names()
cat('  Sheets:', length(all_sheets), '\n')
for (i in seq_along(all_sheets)) {
  cat('  ', i, '.', all_sheets[i], '\n')
}

cat('\n  Features:\n')
cat('  - Index sheet as FIRST sheet with clickable links\n')
cat('  - Multi-level headers with merged cells\n')
cat('  - German number formatting (space for hundreds separator, comma for decimals)\n')
cat('  - Light grey column headers with blue hyperlinks\n')
cat('  - Borders only around tables\n')
cat('  - Back to Index links on each data sheet\n')
