mz <- arrow::read_parquet("~/mz_data/endvoe_2022jj_20231110_v2_26rev.parquet")
data.table::setnames(mz, tolower)

############################################################################## #
# Aufbereitung -----------------------------------------------------------------
############################################################################## #

mz[, kreis := paste0(stringr::str_pad(as.numeric(land), 2, "left", 0),
                     stringr::str_pad(as.numeric(gbtregierungsbezirk), 1, "left", 0),
                     stringr::str_pad(as.numeric(gbtkreis), 2, "left", 0))]
mz[land == 2, kreis := "02000"]
mz[land == 11, kreis := "11000"]
kreis_codes_1 <- c("05315", # Köln
                   "02000", # Hamburg
                   "08111", # Stuttgart
                   "09162", # München
                   "06412", # Frankfurt am Main
                   "05111", # Düsseldorf
                   "11000") # Berlin
mz[kreistyp == "01" & kreis %in% kreis_codes_1, kreistyp_metr := 1]
mz[kreistyp == "01" & !(kreis %in% kreis_codes_1), kreistyp_metr := 2]
mz[is.na(kreistyp_metr), kreistyp_metr := as.numeric(kreistyp) + 1]

mz[, verflechtungsbereich_zentrn := as.numeric(verflechtungsbereich_zentr)]

############################################################################## #
# Formate ----------------------------------------------------------------------
############################################################################## #

kreistyp_f <- new_format(var = kreistyp_metr, name = "Kreistyp",
                         1 ~ 'TOP-7-Metropole',
                         2 ~ 'Kreisfreie Großstädte',
                         3 ~ 'Städtische Kreise',
                         4 ~ 'Ländliche Kreise mit Verdichtungsansätzen',
                         5 ~ 'Dünn besiedelte ländliche Kreise')

degurba_f <- new_format(var = degurba, name = "Grad der Verstädterung",
                        1 ~ 'dicht besiedelt',
                        2 ~ 'mittlere Besiedlungsdichte',
                        3 ~ 'gering besiedelt')

zentralitaet_f <- new_format(var = verflechtungsbereich_zentrn, name = "Zentralität",
                             10:11 ~ 'Oberzentrum',
                             20:21 ~ 'Mittelzentrum mit Teilfunktion eines Oberzentrums',
                             30:31 ~ 'Mittelzentrum',
                             40:41 ~ 'Unterzentrum mit Teilfunktion eines Mittelzentrums',
                             50:51 ~ 'Unterzentrum',
                             60:71 ~ 'Kleinzentrum',
                             90 ~ 'Gemeinde ohne zentralörtliche Funktion')

tw0401h_f <- new_format(var = tw0401h, name = "Mietbelastung",
                        . >= 0 | is.na(.) ~ "Insgesamt",
                        darunter(. %in[)% c(0, 10) ~ "unter 10",
                                 . %in[)% c(10, 20) ~ "10 - 20",
                                 . %in[)% c(20, 30) ~ "20 - 30",
                                 . %in[)% c(30, 40) ~ "30 - 40",
                                 . %in[)% c(40, 50) ~ "40 - 50",
                                 . >= 50 ~ "50 und mehr",
                                 label = "Davon mit einer monatlichen Mietbelastung\nvon ... bis unter ... % des\nHaushaltsnettoeinkommens"))

hhtyp_f <- new_format(var = tw0022w, name = "Haushaltstyp",
                      1 ~ "Hauptmieterhaushalte")

total_f <- tf(label = "Insgesamt", name = "Gesamtwert")

############################################################################## #
# Tabelle ----------------------------------------------------------------------
############################################################################## #

tab <- create_table_count(df = mz, formula = hhtyp_f * (total_f + kreistyp_f + degurba_f + zentralitaet_f) ~ tw0401h_f,
                          where = ba0100h %in% 1:3 & th0201h == 1 & th0501p == 1 & tw0022w == 1 & ba1901h == 3,
                          w = hr000wz, check = TRUE) |>
  add_metadata(title = "Tabelle 7",
               subtitle = "Hauptmieterhaushalte in Gebäuden mit Wohnraum (ohne Wohnheime) 2022 nach Mietbelastung und Regionsmerkmalen",
               stubhead = "Regionsmerkmal")
               footer = c("Endergebnisse des Mikrozensus - Hauptwohnsitzhaushalte",
                          'Falls keine Angaben vorliegen, wurden die Fälle der "Insgesamt"-Kategorie zugewiesen.',
                          "Es werden nur Haushalte dargestellt, die alleine in einer Wohnung leben."))

saveRDS(tab, file = "dev/beispiel_wohnen/wohnen_tab_v2_neu.rds")
