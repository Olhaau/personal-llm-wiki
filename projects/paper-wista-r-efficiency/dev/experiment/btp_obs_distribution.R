# BTP Observation Distribution by Statistic and Year
# Based on realistic patterns from the BTP structure

# Approximate distribution ratios (relative to total observations in year)
# These reflect that:
# - Umsatzsteuer-Veranlagung (v) is most common (~70%)
# - Gewerbesteuer (g) is second most common (~40%)
# - Einnahmenüberschussrechnung (e) is common for smaller businesses (~50%)
# - Umsatzsteuer-Voranmeldung (u) captures larger subset (~30%)
# - Personengesellschaften (p) partnerships (~10-15%)
# - Körperschaftsteuer (k) corporations only (~12-15%)

# Note: These are cumulative - units can appear in multiple statistics
# The percentages reflect the likelihood that a unit in the panel 
# has that specific statistic filled for that year

btp_stat_year_ratios <- data.frame(
  stat = c("g", "k", "u", "p", "v", "e"),
  stat_name = c(
    "Gewerbesteuer",
    "Körperschaftsteuer", 
    "Umsatzsteuer-Voranmeldung",
    "Personengesellschaften",
    "Umsatzsteuer-Veranlagung",
    "Einnahmenüberschussrechnung"
  ),
  # Average coverage across years 2013-2019
  # These represent probability that a unit has this statistic
  avg_coverage = c(0.42, 0.14, 0.34, 0.13, 0.71, 0.51),
  # Year-specific adjustments (multiplier relative to average)
  y2013 = c(1.00, 1.00, 1.00, 1.00, 1.00, 1.00),
  y2014 = c(0.98, 0.98, 0.99, 0.99, 0.99, 0.99),
  y2015 = c(1.02, 1.01, 1.01, 1.01, 1.01, 1.00),
  y2016 = c(1.03, 1.02, 1.02, 1.02, 1.01, 1.01),
  y2017 = c(1.04, 1.03, 1.02, 1.02, 1.02, 1.01),
  y2018 = c(1.05, 1.04, 1.03, 1.03, 1.02, 1.02),
  y2019 = c(1.06, 1.05, 1.04, 1.04, 1.03, 1.02)
)

# Calculate actual probabilities by year
for (year in 2013:2019) {
  year_col <- paste0("y", year)
  prob_col <- paste0("p", year)
  btp_stat_year_ratios[[prob_col]] <- 
    btp_stat_year_ratios$avg_coverage * btp_stat_year_ratios[[year_col]]
}

# Save for use in synth_btp
saveRDS(btp_stat_year_ratios, "btp_obs_distribution.rds")

# Print summary table
cat("\nBTP Statistic Coverage Probabilities by Year\n")
cat("=============================================\n\n")

summary_table <- btp_stat_year_ratios[, c("stat", "stat_name", 
                                            paste0("p", 2013:2019))]
names(summary_table) <- c("Stat", "Name", 2013:2019)

print(summary_table, row.names = FALSE)

cat("\n\nNote: Values represent probability that a unit in the panel\n")
cat("has that statistic filled for that year.\n")
cat("Multiple statistics per unit are common (not mutually exclusive).\n")
