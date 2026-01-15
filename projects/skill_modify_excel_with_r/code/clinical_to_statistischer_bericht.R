# ============================================================================
# Create Statistischer Bericht from Clinical Case Study
# ============================================================================
# Convert clinical trial data to official German statistical report format

library(openxlsx2)
library(dplyr)
library(tidyr)

# Load our Statistischer Bericht generator
source("corporate-design/statistischer-bericht-generator.R")

# Simulate the rx_adsl dataset structure from the case study
set.seed(42)
create_clinical_data <- function() {
  n_subjects <- 182
  
  # Create demographic and clinical data similar to rx_adsl
  rx_adsl_sim <- data.frame(
    STUDYID = rep("GT01", n_subjects),
    USUBJID = paste0("GT", sprintf("%04d", 1:n_subjects)),
    TRTA = sample(c("Placebo", "Medikament 1"), n_subjects, replace = TRUE, prob = c(0.5, 0.5)),
    ITTFL = sample(c("Y", "N"), n_subjects, replace = TRUE, prob = c(0.9, 0.1)),
    AGE = sample(27:65, n_subjects, replace = TRUE),
    SEX = sample(c("Männlich", "Weiblich"), n_subjects, replace = TRUE, prob = c(0.6, 0.4)),
    ETHNIC = sample(c("Europäisch", "Asiatisch", "Andere"), n_subjects, replace = TRUE, prob = c(0.7, 0.2, 0.1)),
    BLBMI = round(rnorm(n_subjects, 26, 4), 1),
    EVNTFL = sample(c("Y", "N"), n_subjects, replace = TRUE, prob = c(0.6, 0.4))
  )
  
  # Add age groups
  rx_adsl_sim$AAGEGR1 <- ifelse(rx_adsl_sim$AGE < 40, "<40 Jahre", "≥40 Jahre")
  
  return(rx_adsl_sim)
}

# Create the simulated dataset
clinical_data <- create_clinical_data()

# Filter to ITT population for analysis
itt_population <- clinical_data |> filter(ITTFL == "Y")

cat("=== KLINISCHE STUDIE DATENANALYSE ===\n")
cat("Gesamtpopulation:", nrow(clinical_data), "Teilnehmer\n")
cat("ITT Population:", nrow(itt_population), "Teilnehmer\n")

# Create demographic summary table (61241-01)
demographic_summary <- itt_population |>
  group_by(TRTA) |>
  summarise(
    N_Total = n(),
    Alter_Mittelwert = round(mean(AGE, na.rm = TRUE), 1),
    Alter_Standardabweichung = round(sd(AGE, na.rm = TRUE), 1),
    Alter_Median = round(median(AGE, na.rm = TRUE), 1),
    Alter_Min = min(AGE, na.rm = TRUE),
    Alter_Max = max(AGE, na.rm = TRUE),
    BMI_Mittelwert = round(mean(BLBMI, na.rm = TRUE), 1),
    BMI_Standardabweichung = round(sd(BLBMI, na.rm = TRUE), 1),
    Anteil_Männlich_Prozent = round(100 * mean(SEX == "Männlich"), 1),
    Anteil_Weiblich_Prozent = round(100 * mean(SEX == "Weiblich"), 1),
    .groups = "drop"
  ) |>
  pivot_longer(-TRTA, names_to = "Parameter", values_to = "Wert") |>
  pivot_wider(names_from = TRTA, values_from = Wert) |>
  mutate(Parameter = case_when(
    Parameter == "N_Total" ~ "Anzahl Teilnehmer (n)",
    Parameter == "Alter_Mittelwert" ~ "Alter Mittelwert (Jahre)",
    Parameter == "Alter_Standardabweichung" ~ "Alter Standardabweichung (Jahre)",
    Parameter == "Alter_Median" ~ "Alter Median (Jahre)",
    Parameter == "Alter_Min" ~ "Alter Minimum (Jahre)",
    Parameter == "Alter_Max" ~ "Alter Maximum (Jahre)",
    Parameter == "BMI_Mittelwert" ~ "BMI Mittelwert (kg/m²)",
    Parameter == "BMI_Standardabweichung" ~ "BMI Standardabweichung (kg/m²)",
    Parameter == "Anteil_Männlich_Prozent" ~ "Anteil männlich (%)",
    Parameter == "Anteil_Weiblich_Prozent" ~ "Anteil weiblich (%)",
    TRUE ~ Parameter
  ))

# Create age group analysis table (61241-02)
age_group_analysis <- itt_population |>
  group_by(TRTA, AAGEGR1) |>
  summarise(
    Anzahl = n(),
    Event_Rate_n = sum(EVNTFL == "Y"),
    Event_Rate_Prozent = round(100 * sum(EVNTFL == "Y") / n(), 1),
    .groups = "drop"
  ) |>
  mutate(
    Event_Rate_Gesamt = paste0(Event_Rate_n, " (", Event_Rate_Prozent, "%)")
  ) |>
  select(-Event_Rate_n, -Event_Rate_Prozent) |>
  pivot_wider(names_from = TRTA, values_from = c(Anzahl, Event_Rate_Gesamt)) |>
  rename(Altersgruppe = AAGEGR1)

# Create overall efficacy summary (61241-03)
efficacy_summary_temp <- itt_population |>
  group_by(TRTA) |>
  summarise(
    Anzahl_Total = n(),
    Anzahl_Event = sum(EVNTFL == "Y"),
    Event_Rate_Prozent = round(100 * sum(EVNTFL == "Y") / n(), 1),
    Anzahl_Kein_Event = sum(EVNTFL == "N"),
    .groups = "drop"
  ) |>
  mutate(
    Event_Rate_Darstellung = paste0(Anzahl_Event, "/", Anzahl_Total, " (", Event_Rate_Prozent, "%)")
  )

# Create two rows - one for each parameter type (convert all to character for consistency)
efficacy_summary <- bind_rows(
  # Row 1: Event rates with n/N format
  efficacy_summary_temp |>
    select(TRTA, Event_Rate_Darstellung) |>
    pivot_wider(names_from = TRTA, values_from = Event_Rate_Darstellung) |>
    mutate(Parameter = "Ereignisrate (n/N, %)", .before = 1),
  
  # Row 2: Event rates as percentages only (convert to character)
  efficacy_summary_temp |>
    select(TRTA, Event_Rate_Prozent) |>
    mutate(Event_Rate_Prozent = paste0(Event_Rate_Prozent, "%")) |>
    pivot_wider(names_from = TRTA, values_from = Event_Rate_Prozent) |>
    mutate(Parameter = "Ereignisrate (%)", .before = 1)
)

# Create gender distribution table (61241-04)
gender_distribution <- itt_population |>
  group_by(TRTA, SEX) |>
  summarise(Anzahl = n(), .groups = "drop") |>
  group_by(TRTA) |>
  mutate(
    Total = sum(Anzahl),
    Prozent = round(100 * Anzahl / Total, 1),
    Darstellung = paste0(Anzahl, " (", Prozent, "%)")
  ) |>
  select(TRTA, SEX, Darstellung) |>
  pivot_wider(names_from = TRTA, values_from = Darstellung) |>
  rename(Geschlecht = SEX)

# Create ethnicity breakdown table (61241-05)
ethnicity_breakdown <- itt_population |>
  group_by(TRTA, ETHNIC) |>
  summarise(Anzahl = n(), .groups = "drop") |>
  group_by(TRTA) |>
  mutate(
    Total = sum(Anzahl),
    Prozent = round(100 * Anzahl / Total, 1),
    Darstellung = paste0(Anzahl, " (", Prozent, "%)")
  ) |>
  select(TRTA, ETHNIC, Darstellung) |>
  pivot_wider(names_from = TRTA, values_from = Darstellung) |>
  rename(Ethnische_Zugehörigkeit = ETHNIC)

# Compile all tables for the Statistischer Bericht
clinical_tables <- list(
  "61241-01" = demographic_summary,
  "61241-02" = age_group_analysis, 
  "61241-03" = efficacy_summary,
  "61241-04" = gender_distribution,
  "61241-05" = ethnicity_breakdown
)

cat("\n=== ERSTELLE STATISTISCHEN BERICHT ===\n")

# Create the official Statistischer Bericht
create_statistischer_bericht(
  data_list = clinical_tables,
  filename = "statistischer_bericht_klinische_studie.xlsx",
  title = "Klinische Studie - Demografische und Wirksamkeitsdaten",
  period = "Auswertung Dezember 2025",
  evas_number = "61241"
)

cat("\n=== ZUSÄTZLICHE INFORMATIONEN ===\n")
cat("Datentabellen erstellt:\n")
cat("✓ 61241-01: Demografische Zusammenfassung\n")
cat("✓ 61241-02: Altersgruppen-Analyse\n") 
cat("✓ 61241-03: Wirksamkeitsübersicht\n")
cat("✓ 61241-04: Geschlechterverteilung\n")
cat("✓ 61241-05: Ethnische Zusammensetzung\n")

cat("\nBerichtmerkmale:\n")
cat("✓ Offizielle Destatis-Designstandards\n")
cat("✓ Deutsche Zahlenformatierung (Komma als Dezimalzeichen)\n")
cat("✓ Vollständiges Navigationssystem\n")
cat("✓ Barrierefreie Versionen (-b Suffix)\n")
cat("✓ CSV-Datenversionen\n")
cat("✓ Professionelle Typografie (Arial, 10pt)\n")
cat("✓ Offizielle Farbgebung (#004B76 Blau)\n")

# Display summary statistics
cat("\nStatistische Zusammenfassung:\n")
summary_stats <- itt_population |>
  group_by(TRTA) |>
  summarise(
    N = n(),
    Alter_MW = round(mean(AGE), 1),
    BMI_MW = round(mean(BLBMI), 1),
    Event_Rate = round(100 * mean(EVNTFL == "Y"), 1),
    .groups = "drop"
  )

for (i in 1:nrow(summary_stats)) {
  cat(sprintf("  %s: N=%d, Alter=%.1f Jahre, BMI=%.1f kg/m², Ereignisrate=%.1f%%\n",
              summary_stats$TRTA[i], summary_stats$N[i], 
              summary_stats$Alter_MW[i], summary_stats$BMI_MW[i], 
              summary_stats$Event_Rate[i]))
}