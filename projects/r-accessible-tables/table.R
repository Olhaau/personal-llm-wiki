# Micro census table with problematic characters and spanner structure
library(gt)
suppressPackageStartupMessages(library(dplyr))

df <- data.frame(
  `Verheiratet_Einkommen (%) > 3000€` = c(30, 2),
  `Verheiratet_Größe (cm)` = c(175, 165),
  `Single_Einkommen (%) > 3000€` = c(20, 1),
  `Single_Größe (cm)` = c(172, 168),
  Kategorie = c("Männer", "Frauen"),
  check.names = F
)

# Create GT table with spanner using underscore delimiter
create_test_table <- function() {
  df |>
    gt(rowname_col = "Kategorie") |>
    tab_spanner_delim(delim = "_") |>
    tab_header(
      title = "Mikrozensus Test mit Spanners",
      subtitle = "Problematic characters: %, €, (), ö with underscore delimiter"
    )
}

# Create version with fix_gt_headers applied
create_fixed_table <- function() {
  source("fix_gt_headers.R")
  
  df |>
    gt(rowname_col = "Kategorie") |>
    tab_spanner_delim(delim = "_") |>
    fix_gt_headers(preserve_mapping = TRUE) |>
    tab_header(
      title = "Mikrozensus Test - Accessibility Fixed",
      subtitle = "Fixed column IDs with proper spanner structure"
    )
}