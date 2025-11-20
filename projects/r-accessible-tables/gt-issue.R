# GT Table Accessibility Demo - German Mikrozensus Data
# 
# This script demonstrates accessibility issues in GT tables using authentic German
# Mikrozensus (microcensus) variables with umlauts, special characters, and German
# statistical terminology. Shows how fix_gt_headers() resolves header ID mismatches
# for official German statistical data.

library(gt)
suppressPackageStartupMessages(library(dplyr))

# Source the fix function
source("fix_gt_headers.R")

# ---- German Mikrozensus Example Data ----

# Create comprehensive Mikrozensus-style data with spaces and special characters
df <- data.frame(
  `demographie_personen id` = c("HH001_P1", "HH001_P2", "HH002_P1", "HH003_P1", "HH004_P1", "HH005_P1"),
  `demographie_größe (in tsd.)` = c(45.2, 38.1, 52.7, 29.3, 67.8, 41.5),
  `demographie_haushaltsgröße ∅` = c(2.1, 2.8, 1.0, 3.4, 2.5, 1.7),        # Average with ∅ symbol
  `demographie_alter > 65 jahre` = c(18.5, 22.3, 31.2, 15.8, 28.7, 25.1),   # Age over 65 with >
  `erwerbstätigkeit_erwerbstätige (%)` = c(64.8, 58.2, 71.3, 55.9, 69.1, 62.4),
  `erwerbstätigkeit_arbeitslose rate` = c(5.8, 7.2, 4.1, 9.5, 6.3, 8.1),
  `erwerbstätigkeit_einkommen ≥ 3000€` = c(15.2, 12.8, 18.6, 8.4, 16.7, 11.9),
  `erwerbstätigkeit_netto & brutto` = c("2850€", "2345€", "3120€", "1980€", "2975€", "2190€"),
  `wohnen_wohnfläche (m²)` = c(85.4, 92.1, 78.3, 105.7, 89.6, 73.2),
  `wohnen_miete: warm` = c(850, 1200, 650, 950, 1100, 780),                 # Rent with colon
  `wohnen_eigenheim ja/nein` = c("Nein", "Ja", "Nein", "Ja", "Ja", "Nein"), # Home ownership with /
  `soziales_fähigkeiten & bildung` = c("Hoch", "Mittel", "Hoch", "Niedrig", "Hoch", "Mittel"),
  `soziales_migrationshintergrund?` = c("Ja", "Nein", "Ja", "Nein", "Nein", "Ja"),
  `soziales_sprachen (anzahl)` = c(2, 1, 3, 1, 2, 4),                      # Number of languages
  `gesundheit_betreuungsbedürftig` = c("Nein", "Ja", "Nein", "Nein", "Ja", "Nein"),
  `gesundheit_krankenversicherung typ` = c("GKV", "PKV", "GKV", "GKV", "PKV", "GKV"),
  `gesundheit_arztbesuche/jahr` = c(4, 12, 2, 8, 6, 15),                   # Doctor visits with /
  `familie_familienstand: verheiratet` = c("Ja", "Ja", "Nein", "Ja", "Nein", "Ja"),
  `familie_kinder < 18 jahre` = c(1, 2, 0, 3, 1, 0),                      # Children under 18 with <
  `familie_kinderbetreuung €` = c(450, 890, 0, 1200, 380, 0),             # Childcare costs
  col = c("Baden-Württemberg", "Bayern", "Berlin", "Brandenburg", "Bremen", "Hamburg"),
  check.names = FALSE
)

# ---- Create Original (Problematic) Table ----

cat("Erstelle ursprüngliche GT-Tabelle mit Accessibility-Problemen...\n")

original_table <- df |>
  gt(rowname_col = "col") |>
  tab_header(
    title = "Mikrozensus Deutschland 2023 - Original (Accessibility-Probleme)",
    subtitle = "Spalten-Header mit Leerzeichen und Zellreferenzen stimmen nicht überein"
  ) |>
  tab_spanner_delim(delim = "_") |>
  fmt_number(columns = `demographie_größe (in tsd.)`, decimals = 1, suffix = " Tsd.") |>
  fmt_number(columns = `demographie_haushaltsgröße ∅`, decimals = 1, suffix = " Pers.") |>
  fmt_percent(columns = c(`demographie_alter > 65 jahre`, `erwerbstätigkeit_erwerbstätige (%)`), 
              scale_values = FALSE, decimals = 1) |>
  fmt_percent(columns = `erwerbstätigkeit_arbeitslose rate`, scale_values = FALSE, decimals = 1) |>
  fmt_number(columns = `erwerbstätigkeit_einkommen ≥ 3000€`, decimals = 1, suffix = " Tsd.") |>
  fmt_number(columns = `wohnen_wohnfläche (m²)`, decimals = 1, suffix = " m²") |>
  fmt_currency(columns = `wohnen_miete: warm`, currency = "EUR", decimals = 0) |>
  fmt_number(columns = `soziales_sprachen (anzahl)`, decimals = 0, suffix = " Spr.") |>
  fmt_number(columns = `gesundheit_arztbesuche/jahr`, decimals = 0, suffix = "/Jahr") |>
  fmt_number(columns = `familie_kinder < 18 jahre`, decimals = 0, suffix = " Kind.") |>
  fmt_currency(columns = `familie_kinderbetreuung €`, currency = "EUR", decimals = 0)

# Save original problematic table
original_html <- original_table |> as_raw_html(inline_css = FALSE)
writeLines(original_html, "gt-issue-original.html")
cat("✓ Original-Tabelle gespeichert unter: gt-issue-original.html\n")

# ---- Create Fixed (Accessible) Table ----

cat("Erstelle korrigierte GT-Tabelle mit ordnungsgemäßer Accessibility...\n")

fixed_table <- df |>
  gt(rowname_col = "col") |>
  tab_header(
    title = "Mikrozensus Deutschland 2023 - Korrigiert (Accessibility-konform)",
    subtitle = "Alle Header-IDs mit Leerzeichen korrekt zu HTML-IDs konvertiert"
  ) |>
  tab_spanner_delim(delim = "_") |>
  fmt_number(columns = `demographie_größe (in tsd.)`, decimals = 1, suffix = " Tsd.") |>
  fmt_number(columns = `demographie_haushaltsgröße ∅`, decimals = 1, suffix = " Pers.") |>
  fmt_percent(columns = c(`demographie_alter > 65 jahre`, `erwerbstätigkeit_erwerbstätige (%)`), 
              scale_values = FALSE, decimals = 1) |>
  fmt_percent(columns = `erwerbstätigkeit_arbeitslose rate`, scale_values = FALSE, decimals = 1) |>
  fmt_number(columns = `erwerbstätigkeit_einkommen ≥ 3000€`, decimals = 1, suffix = " Tsd.") |>
  fmt_number(columns = `wohnen_wohnfläche (m²)`, decimals = 1, suffix = " m²") |>
  fmt_currency(columns = `wohnen_miete: warm`, currency = "EUR", decimals = 0) |>
  fmt_number(columns = `soziales_sprachen (anzahl)`, decimals = 0, suffix = " Spr.") |>
  fmt_number(columns = `gesundheit_arztbesuche/jahr`, decimals = 0, suffix = "/Jahr") |>
  fmt_number(columns = `familie_kinder < 18 jahre`, decimals = 0, suffix = " Kind.") |>
  fmt_currency(columns = `familie_kinderbetreuung €`, currency = "EUR", decimals = 0) |>
  fix_gt_headers(preserve_mapping = TRUE)

# Save fixed accessible table
fixed_html <- fixed_table |> as_raw_html(inline_css = FALSE)
writeLines(fixed_html, "gt-issue-fixed.html")
cat("✓ Korrigierte Tabelle gespeichert unter: gt-issue-fixed.html\n")

# ---- Show Column Name Mappings ----

cat("\nAngewandte Spaltennamen-Zuordnungen:\n")
mappings <- get_name_mapping(fixed_table)
if (!is.null(mappings)) {
  for (i in 1:nrow(mappings)) {
    cat(sprintf("  '%s' → '%s'\n", mappings$original[i], mappings$fixed[i]))
  }
} else {
  cat("  Keine Zuordnungen verfügbar (preserve_mapping wurde nicht gesetzt)\n")
}

# ---- Validate HTML IDs ----

cat("\nValidierung der generierten HTML-IDs:\n")
validation_results <- validate_html_ids(mappings$fixed)
cat(sprintf("  ✓ Gültige IDs: %d/%d (%.1f%% W3C-Konformität)\n", 
            validation_results$summary$valid_count,
            validation_results$summary$total,
            validation_results$summary$compliance_rate))

if (length(validation_results$invalid) > 0) {
  cat("  ⚠ Probleme gefunden:\n")
  for (issue in validation_results$issues) {
    cat(sprintf("    %s\n", issue))
  }
} else {
  cat("  ✓ Alle IDs entsprechen der W3C HTML 4.0 Spezifikation\n")
}

cat("\nDemo abgeschlossen! Vergleichen Sie die HTML-Dateien, um die Accessibility-Verbesserungen zu sehen.\n")
cat("Original:   gt-issue-original.html\n")
cat("Korrigiert: gt-issue-fixed.html\n")

# ---- Show Character Mapping Examples ----

cat("\nBeispiele für deutsche Zeichen-Zuordnungen:\n")
cat("  'ä' → 'ae' (Fähigkeiten → Faehigkeiten)\n")
cat("  'ö' → 'oe' (Größe → Groesse)\n") 
cat("  'ü' → 'ue' (Betreuungsbedürftig → Betreuungsbeduerftig)\n")
cat("  ' ' → '-' (Leerzeichen → Bindestrich)\n")
cat("  '≥' → '.gte.' (Einkommen ≥ 3000€ → Einkommen.gte.3000€)\n")
cat("  '²' → '.2.' (Wohnfläche (m²) → Wohnflaeche.m.2.)\n")
cat("  '∅' → '.avg.' (Haushaltsgröße ∅ → Haushaltsgroesse.avg.)\n")
cat("  '&' → '.and.' (Fähigkeiten & Bildung → Faehigkeiten.and.Bildung)\n")
cat("  ':' → '.' (miete: warm → miete.warm)\n")
cat("  '>' → '.gt.' (alter > 65 → alter.gt.65)\n")
cat("  '<' → '.lt.' (kinder < 18 → kinder.lt.18)\n")
cat("  '/' → '.div.' (ja/nein → ja.div.nein, besuche/jahr → besuche.div.jahr)\n")
cat("  '(%)' → '.pct.' (Erwerbstätige (%) → Erwerbstaetige.pct.)\n")
