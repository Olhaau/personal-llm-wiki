# ---- Export All Tables to Excel ----
# This script extracts all tables from the document and exports them to Excel

suppressPackageStartupMessages({
  library(openxlsx)
  library(dplyr)
  library(tibble)
  library(readr)
})

# Source table formatting functions
source("R/table_formatting.R")

# Create workbook
wb <- createWorkbook()

# ---- Table 1: R-Server Ausbau (StBA) ----
server_ausbau <- data.frame(
  Komponente = c(
    "Anzahl Server",
    "Arbeitsspeicher",
    "Kernanzahl",
    "Kerntakt",
    "Grafikkarte"
  ),
  Vorher = c(
    "1",
    "700 GB",
    "72",
    "tba",
    "keine"
  ),
  Nachher = c(
    "10",
    "je 1 TB",
    "je 96",
    "je tba",
    "je 2x A6000 (je 48 GB VRAM)"
  )
)

addWorksheet(wb, "Tabelle 1")
writeData(wb, "Tabelle 1", "Ausbau des R-Server des Statistischen Bundesamtes (Januar 2025)", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 1", cols = 1:3, rows = 1)
addStyle(wb, "Tabelle 1", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:3)
writeData(wb, "Tabelle 1", server_ausbau, startRow = 3)
addStyle(wb, "Tabelle 1", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:3)

# ---- Table 2: FDZ OnSite-Server ----
fdz_specs <- data.frame(
  Komponente = c(
    "Stata-Server",
    "R-Server",
    "Arbeitsspeicher",
    "Kernanzahl",
    "Kerntaktfrequenz"
  ),
  Umfang = c(
    "3",
    "6",
    "je 512 GB",
    "je 16",
    "je 3.1 GHz"
  )
)

addWorksheet(wb, "Tabelle 2")
writeData(wb, "Tabelle 2", "OnSite-Server des FDZ Bund: Spezifikationen (November 2025)", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 2", cols = 1:2, rows = 1)
addStyle(wb, "Tabelle 2", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:2)
writeData(wb, "Tabelle 2", fdz_specs, startRow = 3)
addStyle(wb, "Tabelle 2", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:2)

# ---- Table 3: dplyr-Syntax Example ----
dplyr_syntax <- tribble(
  ~Nr, ~Befehl, ~Beschreibung,
  1, "ergebnis <-", "Speichert die Fallzahl pro Jahr und Statistik des BTP",
  2, "    read_csv('daten/btp/daten.csv') |>", "Einlesen des BTP im CSV-Format",
  3, "    group_by(jahr) |>", "Gruppiert die Daten nach Jahren",
  4, "    summarize(", "Aggregiere die Daten auf eine Beobachtung pro Gruppe:",
  5, "        g = sum(str_detect('g', verk)),", "Zählt in jeder Gruppe die Fälle mit 'g' in verk,",
  6, "        k = sum(str_detect('k', verk))", "Zählt in jeder Gruppe die Fälle mit 'k' in verk",
  7, "        #, ...", "usw.",
  8, "    )", ""
)

addWorksheet(wb, "Tabelle 3")
writeData(wb, "Tabelle 3", "Exemplarische Auswertung des BTP in dplyr-Syntax", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 3", cols = 1:3, rows = 1)
addStyle(wb, "Tabelle 3", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:3)
writeData(wb, "Tabelle 3", dplyr_syntax, startRow = 3)
addStyle(wb, "Tabelle 3", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:3)
setColWidths(wb, "Tabelle 3", cols = 1:3, widths = c(5, 40, 50))

# ---- Table 4: Baseline SAS and Stata ----
realtimes_sas_cnt <- c(2.25, 2.43, 2.32, 2.5, 2.59, 2.43, 2.51)
realtime_sas_cnt <- sprintf("%.1f Min.", median(realtimes_sas_cnt))
memorys_sas_cnt <- c(65301.48, 65134.98, 65119.78) / 1000
memory_sas_cnt <- sprintf("%.0f MB", median(memorys_sas_cnt))
realtimes_sas_reg <- c(2.4, 2.35, 2.49, 3.45, 3.15, 3.29)
realtime_sas_reg <- sprintf("%.1f Min.", median(realtimes_sas_reg))
memorys_sas_reg<- c(7242.09, 6926.34, 6937.09) / 1000
memory_sas_reg <- sprintf("%.0f MB", median(memorys_sas_reg))

baseline_data <- tribble(
  ~Software, ~Anwendung, ~Arbeitsspeicher, ~Laufzeit, ~Festplattenspeicher,
  "SAS",   "Fallzahl",   memory_sas_cnt, realtime_sas_cnt, "33 GB",
  "SAS",   "Regression", memory_sas_reg, realtime_sas_reg,"33 GB",
  "Stata", "Fallzahl",   "33 GB",        "55,2 Sek.",      "32 GB",
  "Stata", "Regression", "33 GB",        "55,8 Sek.",      "32 GB"
)

addWorksheet(wb, "Tabelle 4")
writeData(wb, "Tabelle 4", "Baselines in SAS und Stata (anhand 1% des simuliertes BTP)", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 4", cols = 1:5, rows = 1)
addStyle(wb, "Tabelle 4", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:5)
writeData(wb, "Tabelle 4", baseline_data, startRow = 3)
addStyle(wb, "Tabelle 4", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:5)

# ---- Tables 5-8: Benchmark Results ----
# Read benchmark data
dat_bm <- read_csv2("~/newwork/dev/projects/paper-wista-r-efficiency/output/leaderboard.csv",
                    show_col_types = FALSE) |>
  filter(!is.na(real_time) & !grepl("_chu", fns_name)) |>
  mutate(
    Anwendung = ifelse(app == "count", "Fallzahl", "Regression"),
    Package = sprintf("{%s}", pkg),
    Dateiformat = ifelse(grepl("parquet", input), "Parquet", "CSV"),
    Dateiformat = ifelse(grepl("gz", input), "CSV.GZ", Dateiformat),
    Optimierung = ifelse(grepl("_sel", fns_name), 'Variablenauswahl',''),
    Optimierung = ifelse(grepl("_nach_jahr", input), 'Datenaufteilung (Berichtsjahr)', Optimierung),
    Optimierung = ifelse(grepl("_aufgeteilt", input), 'Datenaufteilung (gleichmäßig)', Optimierung),
    Optimierung = ifelse(Optimierung == "", "-", Optimierung),
    obs = trimws(format(obs, scientific = FALSE, big.mark = ".", decimal.mark = ","))
  ) |>
  rename(Beobachtungen = obs) |>
  select(Beobachtungen, Anwendung, Package, Dateiformat, Optimierung, 
         memory, real_time, datsize)

# Helper functions for formatting
format_size <- function(size_bytes) {
  if (is.na(size_bytes) || size_bytes == "") return("-")
  size_bytes <- as.numeric(size_bytes)
  if (is.na(size_bytes)) return("-")
  if (size_bytes >= 1e9) {
    sprintf("%.1f GB", size_bytes / 1e9)
  } else {
    sprintf("%.1f MB", size_bytes / 1e6)
  }
}

format_time <- function(time_str) {
  if (is.na(time_str) || time_str == "" || time_str == "NA") return("-")
  time_str <- trimws(as.character(time_str))
  if (grepl("ms$", time_str)) {
    value <- as.numeric(sub("ms$", "", time_str))
    sprintf("%.1f Sek", value / 1000)
  } else if (grepl("m$", time_str)) {
    value <- as.numeric(sub("m$", "", time_str))
    sprintf("%.1f Min", value)
  } else if (grepl("s$", time_str)) {
    value <- as.numeric(sub("s$", "", time_str))
    sprintf("%.1f Sek", value)
  } else if (grepl("h$", time_str)) {
    value <- as.numeric(sub("h$", "", time_str))
    sprintf("%.1f Std", value)
  } else {
    time_str
  }
}

dat_bm <- dat_bm |>
  mutate(
    Arbeitsspeicher = sapply(memory, format_size),
    Festplattenspeicher = sapply(datsize, format_size),
    Laufzeit = sapply(real_time, format_time)
  ) |>
  select(-memory, -real_time, -datsize)

# Table 5: Benchmark small - count
dat_bm_small_cnt <- dat_bm |>
  filter(Beobachtungen == "100.000", Anwendung == "Fallzahl") |>
  select(-Beobachtungen, -Anwendung)

addWorksheet(wb, "Tabelle 5")
writeData(wb, "Tabelle 5", 
          "Performanz Messungen für die Fallzahlberechnung anhand 1% des BTP", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 5", cols = 1:6, rows = 1)
addStyle(wb, "Tabelle 5", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:6)
writeData(wb, "Tabelle 5", dat_bm_small_cnt, startRow = 3)
addStyle(wb, "Tabelle 5", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:6)

# Table 6: Benchmark small - regression
dat_bm_small_reg <- dat_bm |>
  filter(Beobachtungen == "100.000", Anwendung == "Regression") |>
  select(-Beobachtungen, -Anwendung)

addWorksheet(wb, "Tabelle 6")
writeData(wb, "Tabelle 6", 
          "Performanz Messungen für die Regressionsberechnung anhand 1% des BTP", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 6", cols = 1:6, rows = 1)
addStyle(wb, "Tabelle 6", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:6)
writeData(wb, "Tabelle 6", dat_bm_small_reg, startRow = 3)
addStyle(wb, "Tabelle 6", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:6)

# Table 7: Benchmark large - count
dat_bm_large_cnt <- dat_bm |>
  filter(Beobachtungen == "1.000.000", Anwendung == "Fallzahl") |>
  select(-Beobachtungen, -Anwendung)

addWorksheet(wb, "Tabelle 7")
writeData(wb, "Tabelle 7", 
          "Performanz Messungen für die Fallzahlberechnung anhand 10% des BTP", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 7", cols = 1:6, rows = 1)
addStyle(wb, "Tabelle 7", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:6)
writeData(wb, "Tabelle 7", dat_bm_large_cnt, startRow = 3)
addStyle(wb, "Tabelle 7", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:6)

# Table 8: Benchmark large - regression
dat_bm_large_reg <- dat_bm |>
  filter(Beobachtungen == "1.000.000", Anwendung == "Regression") |>
  select(-Beobachtungen, -Anwendung)

addWorksheet(wb, "Tabelle 8")
writeData(wb, "Tabelle 8", 
          "Performanz Messungen für die Regressionsberechnung anhand 10% des BTP", 
          startRow = 1, startCol = 1)
mergeCells(wb, "Tabelle 8", cols = 1:6, rows = 1)
addStyle(wb, "Tabelle 8", 
         style = createStyle(textDecoration = "bold", fontSize = 12), 
         rows = 1, cols = 1:6)
writeData(wb, "Tabelle 8", dat_bm_large_reg, startRow = 3)
addStyle(wb, "Tabelle 8", 
         style = createStyle(textDecoration = "bold"), 
         rows = 3, cols = 1:6)

# ---- Save Workbook ----
output_file <- "_book/Tabellen-Effiziente-Analyse-Forschungsdaten-R.xlsx"
saveWorkbook(wb, output_file, overwrite = TRUE)

cat("\n✓ Excel file created successfully:", output_file, "\n")
cat("\nWorksheets created:\n")
cat("  Tabelle 1: R-Server Ausbau (StBA)\n")
cat("  Tabelle 2: OnSite-Server des FDZ Bund\n")
cat("  Tabelle 3: dplyr-Syntax Example\n")
cat("  Tabelle 4: SAS and Stata Baselines\n")
cat("  Tabelle 5: Benchmark 1% - Fallzahl\n")
cat("  Tabelle 6: Benchmark 1% - Regression\n")
cat("  Tabelle 7: Benchmark 10% - Fallzahl\n")
cat("  Tabelle 8: Benchmark 10% - Regression\n")
