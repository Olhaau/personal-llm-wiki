# Initialize labelled function ----
# Use haven if available, otherwise use base R attributes
if (requireNamespace("haven", quietly = TRUE)) {
  labelled <- haven::labelled
} else {
  labelled <- function(x, label = NULL, labels = NULL) {
    if (!is.null(label)) attr(x, "label") <- label
    if (!is.null(labels)) attr(x, "labels") <- labels
    return(x)
  }
}

#' Synthetic Business-Tax-Panel (BTP) Data Generator
#'
#' @description
#' Generates synthetic panel data mimicking the structure and characteristics
#' of the German Business-Tax-Panel (BTP) 2013-2019. The BTP integrates 7 official
#' tax statistics with the enterprise register (Unternehmensregister).
#'
#' @param obs Integer. Number of unique panel units to generate (default: 100).
#' @param years Integer vector. Years to include (default: 2013:2019).
#' @param select Character. Statistics to include (default: "all").
#'   Options:
#'   - "all": All statistics
#'   - "g": Gewerbesteuer (Trade tax)
#'   - "k": Körperschaftsteuer (Corporate tax)
#'   - "u": Umsatzsteuer-Voranmeldung (VAT advance returns)
#'   - "p": Personengesellschaften (Partnerships)
#'   - "v": Umsatzsteuer-Veranlagung (VAT annual)
#'   - "e": Einnahmenüberschussrechnung (Income surplus calculation)
#'   - Combinations: "gk", "gkv", etc.
#' @param balanced Logical. If TRUE, all units appear in all years (default: FALSE).
#' @param seed Integer. Random seed for reproducibility (default: NULL).
#'
#' @return A data frame with synthetic BTP panel data containing:
#'   - Panel structure variables (id, jahr, verk, verk_qual, ags)
#'   - Enterprise register variables (urs_*)
#'   - Tax statistics variables (g_*, k_*, u_*, p_*, v_*, e_*)
#'
#' @details
#' The generator respects key BTP characteristics:
#' - Unbalanced panel (28.4% in all years by default)
#' - Realistic linkage patterns across statistics
#' - Proper German municipality codes (AGS)
#' - Variable naming conventions: [stat]_[type][area][number]
#' - Labeled variables with metadata
#'
#' @examples
#' # Generate small balanced panel with all statistics
#' df <- synth_btp(obs = 50, balanced = TRUE, seed = 42)
#'
#' # Generate larger unbalanced panel with selected statistics
#' df <- synth_btp(obs = 1000, select = "gkv", seed = 123)
#'
#' # Panel only for recent years
#' df <- synth_btp(obs = 200, years = 2017:2019, select = "k")
#'
#' @export
synth_btp <- function(obs = 100,
                      years = 2013:2019,
                      select = "all",
                      balanced = FALSE,
                      seed = NULL) {
  
  # Set seed for reproducibility ----
  if (!is.null(seed)) set.seed(seed)
  
  # Load required packages ----
  suppressPackageStartupMessages({
    library(data.table)
  })
  
  # Parse statistics selection ----
  all_stats <- c("g", "k", "u", "p", "v", "e")
  if (select == "all") {
    stats_selected <- all_stats
  } else {
    stats_selected <- unlist(strsplit(select, ""))
    invalid <- setdiff(stats_selected, all_stats)
    if (length(invalid) > 0) {
      stop("Invalid statistics code: ", paste(invalid, collapse = ", "),
           ". Valid codes: g, k, u, p, v, e")
    }
  }
  
  # Generate panel structure ----
  panel_structure <- generate_panel_structure(obs, years, balanced)
  
  # Generate core panel variables ----
  dt <- generate_core_variables(panel_structure, years)
  
  # Generate linkage variables ----
  dt <- generate_linkage_variables(dt, stats_selected)
  
  # Generate enterprise register variables ----
  dt <- generate_urs_variables(dt)
  
  # Generate statistic-specific variables ----
  if ("g" %in% stats_selected) dt <- generate_gewerbesteuer(dt)
  if ("k" %in% stats_selected) dt <- generate_koerperschaftsteuer(dt)
  if ("u" %in% stats_selected) dt <- generate_ust_voranmeldung(dt)
  if ("p" %in% stats_selected) dt <- generate_personengesellschaften(dt)
  if ("v" %in% stats_selected) dt <- generate_ust_veranlagung(dt)
  if ("e" %in% stats_selected) dt <- generate_eur(dt)
  
  # Convert to data.frame and return ----
  df <- as.data.frame(dt)
  
  # Add metadata attributes ----
  attr(df, "generated") <- Sys.time()
  attr(df, "generator") <- "synth_btp"
  attr(df, "version") <- "1.0"
  attr(df, "obs") <- obs
  attr(df, "years") <- years
  attr(df, "statistics") <- stats_selected
  attr(df, "balanced") <- balanced
  
  return(df)
}


# Internal functions ----

#' Generate panel structure with realistic participation patterns
#' @keywords internal
generate_panel_structure <- function(obs, years, balanced) {
  n_years <- length(years)
  
  if (balanced) {
    # All units in all years
    id_year <- expand.grid(id = 1:obs, jahr = years)
  } else {
    # Realistic unbalanced panel structure
    # 28.4% in all years, varying participation otherwise
    n_all_years <- round(obs * 0.284)
    n_varying <- obs - n_all_years
    
    # Units in all years
    ids_all <- if (n_all_years > 0) {
      expand.grid(id = 1:n_all_years, jahr = years)
    } else {
      data.frame(id = integer(0), jahr = integer(0))
    }
    
    # Units with varying participation
    ids_varying <- if (n_varying > 0) {
      do.call(rbind, lapply((n_all_years + 1):obs, function(i) {
        # Random number of years (1 to n_years)
        n_participate <- sample(1:n_years, 1, 
                                prob = c(0.15, rep(0.12, n_years - 2), 0.15))
        years_participate <- sample(years, n_participate)
        data.frame(id = i, jahr = years_participate)
      }))
    } else {
      data.frame(id = integer(0), jahr = integer(0))
    }
    
    id_year <- rbind(ids_all, ids_varying)
  }
  
  return(id_year)
}


#' Generate core panel variables
#' @keywords internal
generate_core_variables <- function(panel_structure, years) {
  dt <- data.table(panel_structure)
  setkey(dt, id, jahr)
  
  # id: Already generated, just label it
  dt[, id := labelled(id, label = "Zeitkonsistenter Panelidentifikator")]
  
  # jahr: Already generated, just label it
  dt[, jahr := labelled(jahr, label = "Berichtsjahr")]
  
  # ags: Amtliche Gemeindeschlüssel (German municipality codes)
  # Format: 2-digit state + 3-digit district + 3-digit municipality
  # Generate realistic codes for major states
  state_codes <- c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
                   "11", "12", "13", "14", "15", "16")
  state_probs <- c(0.036, 0.023, 0.015, 0.184, 0.206, 0.021, 0.143, 0.089,
                   0.078, 0.029, 0.025, 0.032, 0.016, 0.051, 0.025, 0.027)
  
  dt[, ags := {
    state <- sample(state_codes, .N, replace = TRUE, prob = state_probs)
    district <- sprintf("%03d", sample(1:999, .N, replace = TRUE))
    municipality <- sprintf("%03d", sample(1:999, .N, replace = TRUE))
    paste0(state, district, municipality)
  }]
  dt[, ags := labelled(ags, label = "Amtlicher Gemeindeschlüssel")]
  
  return(dt)
}


#' Generate linkage variables (verk, verk_qual)
#' @keywords internal
generate_linkage_variables <- function(dt, stats_selected) {
  # verk: Indicates which statistics are linked for this observation
  # Format: 7-character string with stat letters or underscores
  # Example: "gkupvre" = all statistics, "g_u____" = only g and u
  
  dt[, verk := {
    # Probability of being in each statistic (simplified)
    probs <- list(
      g = 0.42,  # Trade tax
      k = 0.14,  # Corporate tax
      u = 0.34,  # VAT advance
      p = 0.13,  # Partnerships
      v = 0.71,  # VAT annual
      r = 0.38,  # Enterprise register (always included)
      e = 0.51   # Income surplus
    )
    
    verk_chars <- sapply(1:.N, function(i) {
      chars <- c(
        if ("g" %in% stats_selected && runif(1) < probs$g) "g" else "_",
        if ("k" %in% stats_selected && runif(1) < probs$k) "k" else "_",
        if ("u" %in% stats_selected && runif(1) < probs$u) "u" else "_",
        if ("p" %in% stats_selected && runif(1) < probs$p) "p" else "_",
        if ("v" %in% stats_selected && runif(1) < probs$v) "v" else "_",
        "r",  # Always include enterprise register
        if ("e" %in% stats_selected && runif(1) < probs$e) "e" else "_"
      )
      paste0(chars, collapse = "")
    })
    verk_chars
  }]
  dt[, verk := labelled(verk, 
                        label = "Verknüpfungsvariable (gkupvre = alle Statistiken)")]
  
  # verk_qual: Linkage quality (1 = best, 3 = manual/cluster)
  dt[, verk_qual := sample(1:3, .N, replace = TRUE, 
                           prob = c(0.70, 0.20, 0.10))]
  dt[, verk_qual := labelled(verk_qual,
                             label = "Verknüpfungsqualität",
                             labels = c("Aktuelle Steuernummer" = 1,
                                       "Aktuelle + alte Steuernummer" = 2,
                                       "Handelsregister/manuell/Cluster" = 3))]
  
  return(dt)
}


#' Generate enterprise register variables
#' @keywords internal
generate_urs_variables <- function(dt) {
  # urs_we_umsatz: Turnover in 1,000 EUR
  dt[, urs_we_umsatz := pmax(0, rlnorm(.N, meanlog = 5, sdlog = 2))]
  dt[, urs_we_umsatz := labelled(urs_we_umsatz, 
                                  label = "Umsatz in 1.000 EUR")]
  
  # urs_we_umsatz_quelle: Source of turnover data
  dt[, urs_we_umsatz_quelle := sample(c(1, 4, 5), .N, replace = TRUE,
                                       prob = c(0.4, 0.5, 0.1))]
  dt[, urs_we_umsatz_quelle := labelled(urs_we_umsatz_quelle,
                                         label = "Umsatzquelle",
                                         labels = c("Erhebung" = 1,
                                                   "Finanzverwaltung" = 4,
                                                   "Schätzung" = 5))]
  
  # urs_we_tp_stichtag: Active persons (estimated) as of Dec 31
  dt[, urs_we_tp_stichtag := pmax(1, rpois(.N, lambda = 15))]
  dt[, urs_we_tp_stichtag := labelled(urs_we_tp_stichtag,
                                       label = "Tätige Personen zum 31.12.")]
  
  # urs_we_svb_stichtag: Employees subject to social insurance
  dt[, urs_we_svb_stichtag := pmax(0, 
                                    rbinom(.N, size = urs_we_tp_stichtag, 
                                          prob = 0.75))]
  dt[, urs_we_svb_stichtag := labelled(urs_we_svb_stichtag,
                                        label = "Sozialversicherungspflichtig Beschäftigte")]
  
  # urs_rt_gruppen_kennz: Enterprise group status
  dt[, urs_rt_gruppen_kennz := sample(c(0, 1, 3, 6), .N, replace = TRUE,
                                       prob = c(0.85, 0.10, 0.03, 0.02))]
  dt[, urs_rt_gruppen_kennz := labelled(urs_rt_gruppen_kennz,
                                         label = "Unternehmensgruppen-Status",
                                         labels = c("Keine Gruppe" = 0,
                                                   "Inland kontrolliert" = 1,
                                                   "Ausland kontrolliert" = 3,
                                                   "Ausland kontrolliert (EU)" = 6))]
  
  # urs_rechtsform: Legal form
  dt[, urs_rechtsform := sample(c(101, 201, 301, 401), .N, replace = TRUE,
                                 prob = c(0.70, 0.15, 0.10, 0.05))]
  dt[, urs_rechtsform := labelled(urs_rechtsform,
                                   label = "Rechtsform",
                                   labels = c("Einzelunternehmen" = 101,
                                             "Personengesellschaft" = 201,
                                             "Kapitalgesellschaft" = 301,
                                             "Übrige juristische Personen" = 401))]
  
  return(dt)
}


#' Generate Gewerbesteuer (Trade Tax) variables
#' @keywords internal
generate_gewerbesteuer <- function(dt) {
  # Only generate for observations where 'g' is in verk
  dt[, has_g := grepl("g", verk)]
  
  # g_fef17: Business size class
  dt[has_g == TRUE, g_fef17 := sample(1:9, sum(has_g), replace = TRUE,
                                       prob = c(0.45, 0.20, 0.15, 0.08, 
                                               0.05, 0.03, 0.02, 0.01, 0.01))]
  dt[, g_fef17 := labelled(g_fef17,
                           label = "Betriebsgrößenklasse",
                           labels = c("Kleinbetrieb" = 1, "Mittelbetrieb" = 5,
                                     "Großbetrieb" = 9))]
  
  # g_fef20: Type of income determination
  dt[has_g == TRUE, g_fef20 := sample(c("E", "B", "T"), sum(has_g), 
                                       replace = TRUE, prob = c(0.55, 0.40, 0.05))]
  dt[, g_fef20 := labelled(g_fef20,
                           label = "Art der Ertragsermittlung",
                           labels = c("Einnahmenüberschussrechnung" = "E",
                                     "Bilanzierung" = "B",
                                     "Tonnagebesteuerung" = "T"))]
  
  # g_fef21: Organschaft (fiscal unity)
  dt[has_g == TRUE, g_fef21 := sample(0:1, sum(has_g), replace = TRUE,
                                       prob = c(0.92, 0.08))]
  dt[, g_fef21 := labelled(g_fef21,
                           label = "Organschaft",
                           labels = c("Nein" = 0, "Ja" = 1))]
  
  # g_c0101: Profit from business operations
  dt[has_g == TRUE, g_c0101 := rnorm(sum(has_g), mean = 50000, sd = 100000)]
  dt[, g_c0101 := labelled(g_c0101, label = "Gewinn aus Gewerbebetrieb")]
  
  # g_c0102: Loss from business operations
  dt[has_g == TRUE & g_c0101 < 0, g_c0102 := abs(g_c0101)]
  dt[has_g == TRUE & g_c0101 >= 0, g_c0102 := 0]
  dt[, g_c0102 := labelled(g_c0102, label = "Verlust aus Gewerbebetrieb")]
  
  # g_c0301: Rounded trade income
  dt[has_g == TRUE, g_c0301 := pmax(0, g_c0101 * runif(sum(has_g), 0.8, 1.2))]
  dt[, g_c0301 := labelled(g_c0301, label = "Abgerundeter Gewerbeertrag")]
  
  # g_c0401: Trade tax assessment
  dt[has_g == TRUE, g_c0401 := pmax(0, g_c0301 * 0.035)]
  dt[, g_c0401 := labelled(g_c0401, label = "Festgesetzte Gewerbesteuer")]
  
  dt[, has_g := NULL]
  return(dt)
}


#' Generate Körperschaftsteuer (Corporate Tax) variables
#' @keywords internal
generate_koerperschaftsteuer <- function(dt) {
  dt[, has_k := grepl("k", verk)]
  
  # k_fef13: Legal form
  dt[has_k == TRUE, k_fef13 := sample(c("AG", "GmbH", "eG", "VVaG"), 
                                       sum(has_k), replace = TRUE,
                                       prob = c(0.02, 0.92, 0.04, 0.02))]
  dt[, k_fef13 := labelled(k_fef13,
                           label = "Rechtsform",
                           labels = c("Aktiengesellschaft" = "AG",
                                     "GmbH" = "GmbH",
                                     "Genossenschaft" = "eG",
                                     "Versicherungsverein" = "VVaG"))]
  
  # k_k0101: Taxable income
  dt[has_k == TRUE, k_k0101 := rnorm(sum(has_k), mean = 60000, sd = 120000)]
  dt[, k_k0101 := labelled(k_k0101, label = "Zu versteuerndes Einkommen")]
  
  # k_k0201: Balance sheet profit
  dt[has_k == TRUE, k_k0201 := pmax(0, k_k0101 * runif(sum(has_k), 0.9, 1.1))]
  dt[, k_k0201 := labelled(k_k0201, label = "Bilanzgewinn")]
  
  # k_k0202: Balance sheet loss
  dt[has_k == TRUE & k_k0101 < 0, k_k0202 := abs(k_k0101)]
  dt[has_k == TRUE & k_k0101 >= 0, k_k0202 := 0]
  dt[, k_k0202 := labelled(k_k0202, label = "Bilanzverlust")]
  
  # k_k0501: Assessed corporate tax
  dt[has_k == TRUE, k_k0501 := pmax(0, k_k0101 * 0.15)]
  dt[, k_k0501 := labelled(k_k0501, label = "Festgesetzte Körperschaftsteuer")]
  
  # k_k0502: Solidarity surcharge
  dt[has_k == TRUE, k_k0502 := pmax(0, k_k0501 * 0.055)]
  dt[, k_k0502 := labelled(k_k0502, label = "Solidaritätszuschlag")]
  
  dt[, has_k := NULL]
  return(dt)
}


#' Generate Umsatzsteuer-Voranmeldung (VAT Advance) variables
#' @keywords internal
generate_ust_voranmeldung <- function(dt) {
  dt[, has_u := grepl("u", verk)]
  
  # u_c0101: Taxable supplies at 19%
  dt[has_u == TRUE, u_c0101 := pmax(0, rlnorm(sum(has_u), meanlog = 11, sdlog = 1.5))]
  dt[, u_c0101 := labelled(u_c0101, label = "Steuerbare Umsätze 19%")]
  
  # u_c0102: VAT at 19%
  dt[has_u == TRUE, u_c0102 := u_c0101 * 0.19]
  dt[, u_c0102 := labelled(u_c0102, label = "Umsatzsteuer 19%")]
  
  # u_c0201: Taxable supplies at 7%
  dt[has_u == TRUE, u_c0201 := pmax(0, rlnorm(sum(has_u), meanlog = 10, sdlog = 1.8))]
  dt[, u_c0201 := labelled(u_c0201, label = "Steuerbare Umsätze 7%")]
  
  # u_c0202: VAT at 7%
  dt[has_u == TRUE, u_c0202 := u_c0201 * 0.07]
  dt[, u_c0202 := labelled(u_c0202, label = "Umsatzsteuer 7%")]
  
  # u_c0301: Input tax
  dt[has_u == TRUE, u_c0301 := pmax(0, (u_c0102 + u_c0202) * runif(sum(has_u), 0.6, 0.9))]
  dt[, u_c0301 := labelled(u_c0301, label = "Vorsteuer")]
  
  # u_c0401: VAT payment/refund
  dt[has_u == TRUE, u_c0401 := (u_c0102 + u_c0202) - u_c0301]
  dt[, u_c0401 := labelled(u_c0401, label = "Umsatzsteuer-Zahllast/-Erstattung")]
  
  dt[, has_u := NULL]
  return(dt)
}


#' Generate Personengesellschaften (Partnerships) variables
#' @keywords internal
generate_personengesellschaften <- function(dt) {
  dt[, has_p := grepl("p", verk)]
  
  # p_fef14: Type of determination
  dt[has_p == TRUE, p_fef14 := sample(1:3, sum(has_p), replace = TRUE,
                                       prob = c(0.85, 0.10, 0.05))]
  dt[, p_fef14 := labelled(p_fef14,
                           label = "Art der Feststellung",
                           labels = c("Gesonderte Feststellung" = 1,
                                     "Einheitliche Feststellung" = 2,
                                     "Gesonderte und einheitliche" = 3))]
  
  # p_c0101: Total profit
  dt[has_p == TRUE, p_c0101 := rnorm(sum(has_p), mean = 40000, sd = 80000)]
  dt[, p_c0101 := labelled(p_c0101, label = "Summe der Einkünfte")]
  
  # p_c0201: Business profit
  dt[has_p == TRUE, p_c0201 := p_c0101 * runif(sum(has_p), 0.7, 1.0)]
  dt[, p_c0201 := labelled(p_c0201, label = "Gewinn aus Gewerbebetrieb")]
  
  # p_c0301: Number of partners
  dt[has_p == TRUE, p_c0301 := sample(2:10, sum(has_p), replace = TRUE,
                                       prob = c(0.50, 0.25, 0.12, 0.06, 
                                               0.03, 0.02, 0.01, 0.005, 0.005))]
  dt[, p_c0301 := labelled(p_c0301, label = "Anzahl der Beteiligten")]
  
  dt[, has_p := NULL]
  return(dt)
}


#' Generate Umsatzsteuer-Veranlagung (VAT Annual) variables
#' @keywords internal
generate_ust_veranlagung <- function(dt) {
  dt[, has_v := grepl("v", verk)]
  
  # v_c0101: Annual taxable supplies at 19%
  dt[has_v == TRUE, v_c0101 := pmax(0, rlnorm(sum(has_v), meanlog = 12, sdlog = 1.5))]
  dt[, v_c0101 := labelled(v_c0101, label = "Steuerbare Umsätze 19% (Jahr)")]
  
  # v_c0102: Annual VAT at 19%
  dt[has_v == TRUE, v_c0102 := v_c0101 * 0.19]
  dt[, v_c0102 := labelled(v_c0102, label = "Umsatzsteuer 19% (Jahr)")]
  
  # v_c0201: Annual taxable supplies at 7%
  dt[has_v == TRUE, v_c0201 := pmax(0, rlnorm(sum(has_v), meanlog = 11, sdlog = 1.8))]
  dt[, v_c0201 := labelled(v_c0201, label = "Steuerbare Umsätze 7% (Jahr)")]
  
  # v_c0202: Annual VAT at 7%
  dt[has_v == TRUE, v_c0202 := v_c0201 * 0.07]
  dt[, v_c0202 := labelled(v_c0202, label = "Umsatzsteuer 7% (Jahr)")]
  
  # v_c0301: Annual input tax
  dt[has_v == TRUE, v_c0301 := pmax(0, (v_c0102 + v_c0202) * runif(sum(has_v), 0.6, 0.9))]
  dt[, v_c0301 := labelled(v_c0301, label = "Vorsteuer (Jahr)")]
  
  # v_c0401: Annual VAT payment/refund
  dt[has_v == TRUE, v_c0401 := (v_c0102 + v_c0202) - v_c0301]
  dt[, v_c0401 := labelled(v_c0401, label = "Umsatzsteuer-Zahllast/-Erstattung (Jahr)")]
  
  # v_c0501: Total turnover
  dt[has_v == TRUE, v_c0501 := v_c0101 + v_c0201]
  dt[, v_c0501 := labelled(v_c0501, label = "Gesamtumsatz")]
  
  dt[, has_v := NULL]
  return(dt)
}


#' Generate Einnahmenüberschussrechnung (Income Surplus) variables
#' @keywords internal
generate_eur <- function(dt) {
  dt[, has_e := grepl("e", verk)]
  
  # e_c0101: Operating revenues
  dt[has_e == TRUE, e_c0101 := pmax(0, rlnorm(sum(has_e), meanlog = 11, sdlog = 1.5))]
  dt[, e_c0101 := labelled(e_c0101, label = "Betriebseinnahmen")]
  
  # e_c0201: Operating expenses
  dt[has_e == TRUE, e_c0201 := pmax(0, e_c0101 * runif(sum(has_e), 0.6, 0.95))]
  dt[, e_c0201 := labelled(e_c0201, label = "Betriebsausgaben")]
  
  # e_c0301: Income surplus (profit)
  dt[has_e == TRUE, e_c0301 := e_c0101 - e_c0201]
  dt[, e_c0301 := labelled(e_c0301, label = "Gewinn (Einnahmenüberschuss)")]
  
  # e_c0401: Goods and materials expenses
  dt[has_e == TRUE, e_c0401 := pmax(0, e_c0201 * runif(sum(has_e), 0.3, 0.6))]
  dt[, e_c0401 := labelled(e_c0401, label = "Waren und Rohstoffe")]
  
  # e_c0501: Personnel expenses
  dt[has_e == TRUE, e_c0501 := pmax(0, e_c0201 * runif(sum(has_e), 0.2, 0.4))]
  dt[, e_c0501 := labelled(e_c0501, label = "Personalkosten")]
  
  # e_c0601: Depreciation
  dt[has_e == TRUE, e_c0601 := pmax(0, e_c0201 * runif(sum(has_e), 0.05, 0.15))]
  dt[, e_c0601 := labelled(e_c0601, label = "Abschreibungen")]
  
  dt[, has_e := NULL]
  return(dt)
}


# Helper function to extract metadata ----

#' Extract variable metadata from generated BTP data
#'
#' @param btp_data Data frame generated by synth_btp()
#' @return Data frame with variable metadata (name, label, type)
#' @export
extract_btp_metadata <- function(btp_data) {
  metadata <- data.frame(
    variable = names(btp_data),
    label = sapply(btp_data, function(x) {
      lbl <- attr(x, "label")
      if (is.null(lbl)) NA_character_ else lbl
    }),
    type = sapply(btp_data, function(x) {
      if (is.numeric(x)) "numeric"
      else if (is.character(x)) "character"
      else if (is.factor(x)) "factor"
      else "other"
    }),
    has_value_labels = sapply(btp_data, function(x) {
      !is.null(attr(x, "labels"))
    }),
    stringsAsFactors = FALSE
  )
  
  return(metadata)
}


# Helper function to summarize panel structure ----

#' Summarize panel structure of BTP data
#'
#' @param btp_data Data frame generated by synth_btp()
#' @return List with panel summary statistics
#' @export
summarize_btp_panel <- function(btp_data) {
  dt <- data.table::as.data.table(btp_data)
  
  # Basic counts
  n_obs <- nrow(dt)
  n_units <- length(unique(dt$id))
  years <- sort(unique(dt$jahr))
  n_years <- length(years)
  
  # Panel balance
  obs_per_unit <- dt[, .N, by = id]
  balance_dist <- table(obs_per_unit$N)
  pct_all_years <- mean(obs_per_unit$N == n_years) * 100
  
  # Statistics coverage
  stats_coverage <- dt[, .(
    n = .N,
    pct = .N / nrow(dt) * 100
  ), by = .(stat = substr(verk, 1, 1))]
  
  # Linkage quality
  linkage_qual <- dt[, .(
    n = .N,
    pct = .N / nrow(dt) * 100
  ), by = verk_qual]
  
  return(list(
    n_observations = n_obs,
    n_units = n_units,
    years = years,
    n_years = n_years,
    pct_balanced = pct_all_years,
    observations_per_unit = balance_dist,
    statistics_coverage = stats_coverage,
    linkage_quality = linkage_qual
  ))
}
