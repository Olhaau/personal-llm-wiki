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
#' @param obs Integer. Number of unique panel units (firms) to generate (default: 100).
#'   Note: Total rows will be greater than obs for unbalanced panels (default),
#'   as each unit may appear in multiple years. For balanced panels, 
#'   total rows = obs × length(years).
#' @param years Integer vector. Years to include (default: 2013:2019).
#' @param select Character. Statistics to include (default: "all").
#'   Options:
  #'   - "all": All statistics
  #'   - "g": Gewerbesteuer (Trade tax) - 328 variables
  #'   - "k": Körperschaftsteuer (Corporate tax) - 1088 variables
  #'   - "u": Umsatzsteuer-Voranmeldung (VAT advance) - 75 variables
  #'   - "p": Personengesellschaften (Partnerships) - 1078 variables
  #'   - "v": Umsatzsteuer-Veranlagung (VAT annual) - 120 variables
  #'   - "e": Einnahmenüberschussrechnung (EUR) - 349 variables
#'   - Combinations: "gk", "gkv", etc.
#' @param balanced Logical. If TRUE, all units appear in all years (default: FALSE).
#' @param seed Integer. Random seed for reproducibility (default: NULL).
#'
#' @return A data frame with synthetic BTP panel data containing:
#'   - Panel structure variables (id, jahr, verk, verk_qual, ags)
#'   - Enterprise register variables (urs_*)
#'   - Tax statistics variables (g_*, k_*, u_*, p_*, v_*, e_*)
#'   Total variables: 3038 (when select="all")
#'   Note: Excludes 645 variables with no values in any reporting year
#'
#' @details
#' The generator respects key BTP characteristics:
#' - Unbalanced panel (28.4% in all years by default)
#' - Realistic linkage patterns across statistics
#' - Proper German municipality codes (AGS)
#' - Variable naming conventions: [stat]_[type][area][number]
#' - Labeled variables with metadata
#' - Variables are NA for years where statistic not filled (filled==0)
#'
#' @examples
#' # Generate small balanced panel with all statistics
#' # 50 units × 7 years = 350 rows
#' df <- synth_btp(obs = 50, balanced = TRUE, seed = 42)
#'
#' # Generate larger unbalanced panel with selected statistics
#' # 1000 units, ~4700 rows (varies due to unbalanced structure)
#' df <- synth_btp(obs = 1000, select = "gkv", seed = 123)
#'
#' # Panel only for recent years
#' # 200 units × 3 years = 600 rows (if balanced)
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
  attr(df, "version") <- "2.0"
  attr(df, "obs") <- obs
  attr(df, "years") <- years
  attr(df, "statistics") <- stats_selected
  attr(df, "balanced") <- balanced
  
  # Print summary
  cat(sprintf("\nGenerated BTP dataset: %d units, %d rows, %d variables\n", 
              length(unique(df$id)), nrow(df), ncol(df)))
  
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


#' Load variable definitions from JSON
#' @keywords internal
load_variable_definitions <- function() {
  json_file <- system.file("extdata", "btp_variables.json", package = "synthbtp")
  
  # If package file not found, try local path
  if (json_file == "") {
    json_file <- "btp_variables.json"
  }
  
  if (!file.exists(json_file)) {
    # Return minimal definitions if file not found
    return(NULL)
  }
  
  jsonlite::fromJSON(json_file)
}


#' Generate variables from definitions
#' @keywords internal
generate_vars_from_defs <- function(dt, prefix, has_col, var_defs = NULL) {
  # Try to load definitions if not provided
  if (is.null(var_defs)) {
    var_defs <- load_variable_definitions()
  }
  
  # If definitions available, use them
  if (!is.null(var_defs) && prefix %in% names(var_defs)) {
    stat_def <- var_defs[[prefix]]
    variables <- stat_def$variables
    descriptions <- stat_def$descriptions
    formats <- stat_def$formats
    
    for (i in seq_along(variables)) {
      varname <- variables[i]
      description <- if (i <= length(descriptions)) descriptions[i] else varname
      format <- if (i <= length(formats)) formats[i] else "Num"
      
      # Generate variable based on format
      if (format == "Char") {
        # Character variable
        dt[get(has_col) == TRUE, (varname) := sample(c("A", "B", "C", "D", "E"), 
                                                      sum(get(has_col)), 
                                                      replace = TRUE)]
      } else {
        # Numeric variable
        dt[get(has_col) == TRUE, (varname) := rnorm(sum(get(has_col)), 
                                                     mean = 10000, 
                                                     sd = 50000)]
      }
      
      # Add label
      dt[, (varname) := labelled(get(varname), label = description)]
    }
  } else {
    # Fallback: generate generic variables
    warning(sprintf("Variable definitions not found for %s, generating generic variables", prefix))
  }
  
  return(dt)
}


#' Generate Gewerbesteuer (Trade Tax) variables - 328 variables
#' @keywords internal
generate_gewerbesteuer <- function(dt) {
  # Load JSON definitions
  json_file <- "btp_variables.json"
  if (!file.exists(json_file)) {
    stop("btp_variables.json not found. Please ensure it's in the working directory.")
  }
  
  var_defs <- jsonlite::fromJSON(json_file)$g
  
  # Only generate for observations where 'g' is in verk
  dt[, has_g := grepl("g", verk)]
  n_has_g <- sum(dt$has_g)
  
  if (n_has_g == 0) {
    dt[, has_g := NULL]
    return(dt)
  }
  
  # Generate all variables at once for efficiency
  cat(sprintf("Generating %d variables for %d observations with Gewerbesteuer...\n", 
              length(var_defs$variables), n_has_g))
  
  for (i in seq_along(var_defs$variables)) {
    varname <- var_defs$variables[i]
    description <- var_defs$descriptions[i]
    format <- var_defs$formats[i]
    
    if (format == "Char") {
      vals <- sample(c("0", "1", "2", "A", "B", "E"), n_has_g, replace = TRUE)
      dt[has_g == TRUE, (varname) := vals]
    } else {
      vals <- rnorm(n_has_g, mean = 50000, sd = 100000)
      dt[has_g == TRUE, (varname) := vals]
    }
    
    # Apply label without calling labelled on entire column
    setattr(dt[[varname]], "label", description)
    
    # Progress indicator every 50 variables
    if (i %% 50 == 0) {
      cat(sprintf("  ...generated %d/%d variables\n", i, length(var_defs$variables)))
    }
  }
  
  dt[, has_g := NULL]
  return(dt)
}


#' Generate Körperschaftsteuer (Corporate Tax) variables - 1088 variables
#' @keywords internal
generate_koerperschaftsteuer <- function(dt) {
  json_file <- "btp_variables.json"
  if (!file.exists(json_file)) {
    stop("btp_variables.json not found. Please ensure it's in the working directory.")
  }
  
  var_defs <- jsonlite::fromJSON(json_file)$k
  
  dt[, has_k := grepl("k", verk)]
  n_has_k <- sum(dt$has_k)
  
  if (n_has_k == 0) {
    dt[, has_k := NULL]
    return(dt)
  }
  
  cat(sprintf("Generating %d variables for %d observations with Körperschaftsteuer...\n", 
              length(var_defs$variables), n_has_k))
  
  for (i in seq_along(var_defs$variables)) {
    varname <- var_defs$variables[i]
    description <- var_defs$descriptions[i]
    format <- var_defs$formats[i]
    
    if (format == "Char") {
      vals <- sample(c("0", "1", "2", "AG", "GmbH", "eG"), n_has_k, replace = TRUE)
      dt[has_k == TRUE, (varname) := vals]
    } else {
      vals <- rnorm(n_has_k, mean = 60000, sd = 120000)
      dt[has_k == TRUE, (varname) := vals]
    }
    
    setattr(dt[[varname]], "label", description)
    
    if (i %% 100 == 0) {
      cat(sprintf("  ...generated %d/%d variables\n", i, length(var_defs$variables)))
    }
  }
  
  dt[, has_k := NULL]
  return(dt)
}


#' Generate Umsatzsteuer-Voranmeldung (VAT Advance) variables - 75 variables
#' @keywords internal
generate_ust_voranmeldung <- function(dt) {
  json_file <- "btp_variables.json"
  if (!file.exists(json_file)) {
    stop("btp_variables.json not found. Please ensure it's in the working directory.")
  }
  
  var_defs <- jsonlite::fromJSON(json_file)$u
  
  dt[, has_u := grepl("u", verk)]
  n_has_u <- sum(dt$has_u)
  
  if (n_has_u == 0) {
    dt[, has_u := NULL]
    return(dt)
  }
  
  cat(sprintf("Generating %d variables for %d observations with Umsatzsteuer-Voranmeldung...\n", 
              length(var_defs$variables), n_has_u))
  
  for (i in seq_along(var_defs$variables)) {
    varname <- var_defs$variables[i]
    description <- var_defs$descriptions[i]
    format <- var_defs$formats[i]
    
    if (format == "Char") {
      vals <- sample(c("0", "1", "2", "3"), n_has_u, replace = TRUE)
      dt[has_u == TRUE, (varname) := vals]
    } else {
      vals <- pmax(0, rlnorm(n_has_u, meanlog = 11, sdlog = 1.5))
      dt[has_u == TRUE, (varname) := vals]
    }
    
    setattr(dt[[varname]], "label", description)
  }
  
  dt[, has_u := NULL]
  return(dt)
}


#' Generate Personengesellschaften (Partnerships) variables - 1078 variables
#' @keywords internal
generate_personengesellschaften <- function(dt) {
  json_file <- "btp_variables.json"
  if (!file.exists(json_file)) {
    stop("btp_variables.json not found. Please ensure it's in the working directory.")
  }
  
  var_defs <- jsonlite::fromJSON(json_file)$p
  
  dt[, has_p := grepl("p", verk)]
  n_has_p <- sum(dt$has_p)
  
  if (n_has_p == 0) {
    dt[, has_p := NULL]
    return(dt)
  }
  
  cat(sprintf("Generating %d variables for %d observations with Personengesellschaften...\n", 
              length(var_defs$variables), n_has_p))
  
  for (i in seq_along(var_defs$variables)) {
    varname <- var_defs$variables[i]
    description <- var_defs$descriptions[i]
    format <- var_defs$formats[i]
    
    if (format == "Char") {
      vals <- sample(c("0", "1", "2", "3", "20", "21"), n_has_p, replace = TRUE)
      dt[has_p == TRUE, (varname) := vals]
    } else {
      vals <- rnorm(n_has_p, mean = 40000, sd = 80000)
      dt[has_p == TRUE, (varname) := vals]
    }
    
    setattr(dt[[varname]], "label", description)
    
    if (i %% 100 == 0) {
      cat(sprintf("  ...generated %d/%d variables\n", i, length(var_defs$variables)))
    }
  }
  
  dt[, has_p := NULL]
  return(dt)
}


#' Generate Umsatzsteuer-Veranlagung (VAT Annual) variables - 120 variables
#' @keywords internal
generate_ust_veranlagung <- function(dt) {
  json_file <- "btp_variables.json"
  if (!file.exists(json_file)) {
    stop("btp_variables.json not found. Please ensure it's in the working directory.")
  }
  
  var_defs <- jsonlite::fromJSON(json_file)$v
  
  dt[, has_v := grepl("v", verk)]
  n_has_v <- sum(dt$has_v)
  
  if (n_has_v == 0) {
    dt[, has_v := NULL]
    return(dt)
  }
  
  cat(sprintf("Generating %d variables for %d observations with Umsatzsteuer-Veranlagung...\n", 
              length(var_defs$variables), n_has_v))
  
  for (i in seq_along(var_defs$variables)) {
    varname <- var_defs$variables[i]
    description <- var_defs$descriptions[i]
    format <- var_defs$formats[i]
    
    if (format == "Char") {
      vals <- sample(c("0", "1", "2", "3"), n_has_v, replace = TRUE)
      dt[has_v == TRUE, (varname) := vals]
    } else {
      vals <- pmax(0, rlnorm(n_has_v, meanlog = 12, sdlog = 1.5))
      dt[has_v == TRUE, (varname) := vals]
    }
    
    setattr(dt[[varname]], "label", description)
  }
  
  dt[, has_v := NULL]
  return(dt)
}


#' Generate Einnahmenüberschussrechnung (Income Surplus) variables - 349 variables
#' @keywords internal
generate_eur <- function(dt) {
  json_file <- "btp_variables.json"
  if (!file.exists(json_file)) {
    stop("btp_variables.json not found. Please ensure it's in the working directory.")
  }
  
  var_defs <- jsonlite::fromJSON(json_file)$e
  
  dt[, has_e := grepl("e", verk)]
  n_has_e <- sum(dt$has_e)
  
  if (n_has_e == 0) {
    dt[, has_e := NULL]
    return(dt)
  }
  
  cat(sprintf("Generating %d variables for %d observations with Einnahmenüberschussrechnung...\n", 
              length(var_defs$variables), n_has_e))
  
  for (i in seq_along(var_defs$variables)) {
    varname <- var_defs$variables[i]
    description <- var_defs$descriptions[i]
    format <- var_defs$formats[i]
    
    if (format == "Char") {
      vals <- sample(c("0", "1", "2", "A", "B"), n_has_e, replace = TRUE)
      dt[has_e == TRUE, (varname) := vals]
    } else {
      vals <- pmax(0, rlnorm(n_has_e, meanlog = 11, sdlog = 1.5))
      dt[has_e == TRUE, (varname) := vals]
    }
    
    setattr(dt[[varname]], "label", description)
    
    if (i %% 100 == 0) {
      cat(sprintf("  ...generated %d/%d variables\n", i, length(var_defs$variables)))
    }
  }
  
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
  
  # Count variables by statistic
  var_counts <- list(
    total_vars = ncol(btp_data),
    g_vars = sum(grepl("^g_", names(btp_data))),
    k_vars = sum(grepl("^k_", names(btp_data))),
    u_vars = sum(grepl("^u_", names(btp_data))),
    p_vars = sum(grepl("^p_", names(btp_data))),
    v_vars = sum(grepl("^v_", names(btp_data))),
    e_vars = sum(grepl("^e_", names(btp_data))),
    urs_vars = sum(grepl("^urs_", names(btp_data)))
  )
  
  return(list(
    n_observations = n_obs,
    n_units = n_units,
    years = years,
    n_years = n_years,
    pct_balanced = pct_all_years,
    observations_per_unit = balance_dist,
    statistics_coverage = stats_coverage,
    linkage_quality = linkage_qual,
    variable_counts = var_counts
  ))
}
