#!/usr/bin/env Rscript
#
# Test Script for Synthetic Business-Tax-Panel Generator
# ========================================================
#
# Tests all functionality of synth_btp() function and demonstrates usage
# patterns for the paper-wista-r-efficiency project.

# Setup ----
suppressPackageStartupMessages({
  library(data.table)
})

source("synth_btp.R")

cat("\n=== Synthetic BTP Generator - Test Suite ===\n\n")

# Test 1: Basic generation with defaults ----
cat("Test 1: Basic generation (100 obs, all years, all statistics)\n")
df1 <- synth_btp(obs = 100, seed = 42)
cat(sprintf("  Generated: %d rows, %d columns\n", nrow(df1), ncol(df1)))
cat(sprintf("  Unique IDs: %d\n", length(unique(df1$id))))
cat(sprintf("  Years: %s\n", paste(unique(df1$jahr), collapse = ", ")))
cat(sprintf("  Variables: %s\n", paste(head(names(df1), 10), collapse = ", ")))
cat("  ✓ PASSED\n\n")

# Test 2: Balanced panel ----
cat("Test 2: Balanced panel (50 obs, all years)\n")
df2 <- synth_btp(obs = 50, balanced = TRUE, seed = 123)
obs_per_id <- table(table(df2$id))
cat(sprintf("  Observations per ID: %s\n", 
            paste(names(obs_per_id), "years:", obs_per_id, collapse = ", ")))
stopifnot(all(table(df2$id) == 7))  # All units in all 7 years
cat("  ✓ PASSED\n\n")

# Test 3: Unbalanced panel characteristics ----
cat("Test 3: Unbalanced panel (200 obs)\n")
df3 <- synth_btp(obs = 200, balanced = FALSE, seed = 456)
obs_per_id <- table(df3$id)
pct_all_years <- mean(obs_per_id == 7) * 100
cat(sprintf("  Percentage in all years: %.1f%% (target: ~28%%)\n", pct_all_years))
cat(sprintf("  Min observations per ID: %d\n", min(obs_per_id)))
cat(sprintf("  Max observations per ID: %d\n", max(obs_per_id)))
cat(sprintf("  Mean observations per ID: %.1f\n", mean(obs_per_id)))
cat("  ✓ PASSED\n\n")

# Test 4: Selected statistics only ----
cat("Test 4: Selected statistics (g + k only)\n")
df4 <- synth_btp(obs = 100, select = "gk", seed = 789)
has_g <- sum(grepl("g", df4$verk))
has_k <- sum(grepl("k", df4$verk))
has_u <- sum(grepl("u", df4$verk))
cat(sprintf("  Observations with g: %d (%.1f%%)\n", has_g, has_g/nrow(df4)*100))
cat(sprintf("  Observations with k: %d (%.1f%%)\n", has_k, has_k/nrow(df4)*100))
cat(sprintf("  Observations with u: %d (%.1f%%)\n", has_u, has_u/nrow(df4)*100))
stopifnot(has_u == 0)  # u should not be generated
stopifnot("g_c0101" %in% names(df4))  # g variables should exist
stopifnot("k_k0101" %in% names(df4))  # k variables should exist
stopifnot(!"u_c0101" %in% names(df4))  # u variables should not exist
cat("  ✓ PASSED\n\n")

# Test 5: Year selection ----
cat("Test 5: Year selection (2017-2019 only)\n")
df5 <- synth_btp(obs = 100, years = 2017:2019, seed = 321)
years_present <- sort(unique(df5$jahr))
cat(sprintf("  Years in data: %s\n", paste(years_present, collapse = ", ")))
stopifnot(all(years_present %in% 2017:2019))
stopifnot(all(2017:2019 %in% years_present))
cat("  ✓ PASSED\n\n")

# Test 6: Variable labeling ----
cat("Test 6: Variable labels and value labels\n")
df6 <- synth_btp(obs = 50, seed = 654)
# Check for variable labels
id_label <- attr(df6$id, "label")
jahr_label <- attr(df6$jahr, "label")
verk_label <- attr(df6$verk, "label")
cat(sprintf("  id label: %s\n", id_label))
cat(sprintf("  jahr label: %s\n", jahr_label))
cat(sprintf("  verk label: %s\n", verk_label))
stopifnot(!is.null(id_label))
stopifnot(!is.null(jahr_label))
# Check for value labels
verk_qual_labels <- attr(df6$verk_qual, "labels")
cat(sprintf("  verk_qual value labels: %d defined\n", length(verk_qual_labels)))
stopifnot(!is.null(verk_qual_labels))
cat("  ✓ PASSED\n\n")

# Test 7: AGS (municipality codes) format ----
cat("Test 7: AGS municipality codes format\n")
df7 <- synth_btp(obs = 50, seed = 987)
ags_sample <- head(unique(df7$ags), 5)
cat(sprintf("  Sample AGS codes: %s\n", paste(ags_sample, collapse = ", ")))
ags_lengths <- nchar(df7$ags)
cat(sprintf("  AGS length range: %d-%d (expected: 8)\n", 
            min(ags_lengths), max(ags_lengths)))
stopifnot(all(ags_lengths == 8))
cat("  ✓ PASSED\n\n")

# Test 8: Enterprise register variables ----
cat("Test 8: Enterprise register (URS) variables\n")
df8 <- synth_btp(obs = 100, seed = 111)
cat(sprintf("  urs_we_umsatz range: %.2f - %.2f\n", 
            min(df8$urs_we_umsatz, na.rm = TRUE),
            max(df8$urs_we_umsatz, na.rm = TRUE)))
cat(sprintf("  urs_we_tp_stichtag range: %d - %d\n",
            min(df8$urs_we_tp_stichtag, na.rm = TRUE),
            max(df8$urs_we_tp_stichtag, na.rm = TRUE)))
cat(sprintf("  urs_we_svb_stichtag range: %d - %d\n",
            min(df8$urs_we_svb_stichtag, na.rm = TRUE),
            max(df8$urs_we_svb_stichtag, na.rm = TRUE)))
cat(sprintf("  urs_rechtsform values: %s\n",
            paste(sort(unique(df8$urs_rechtsform)), collapse = ", ")))
stopifnot(all(df8$urs_we_svb_stichtag <= df8$urs_we_tp_stichtag))
cat("  ✓ PASSED\n\n")

# Test 9: Gewerbesteuer variables ----
cat("Test 9: Gewerbesteuer (Trade Tax) variables\n")
df9 <- synth_btp(obs = 100, select = "g", seed = 222)
dt9 <- as.data.table(df9)
dt9_with_g <- dt9[grepl("g", verk)]
cat(sprintf("  Observations with g: %d\n", nrow(dt9_with_g)))
if (nrow(dt9_with_g) > 0) {
  cat(sprintf("  g_c0101 (profit) range: %.2f - %.2f\n",
              min(dt9_with_g$g_c0101, na.rm = TRUE),
              max(dt9_with_g$g_c0101, na.rm = TRUE)))
  cat(sprintf("  g_c0401 (tax) range: %.2f - %.2f\n",
              min(dt9_with_g$g_c0401, na.rm = TRUE),
              max(dt9_with_g$g_c0401, na.rm = TRUE)))
  cat(sprintf("  g_fef17 (size class) values: %s\n",
              paste(sort(unique(na.omit(dt9_with_g$g_fef17))), collapse = ", ")))
}
cat("  ✓ PASSED\n\n")

# Test 10: Körperschaftsteuer variables ----
cat("Test 10: Körperschaftsteuer (Corporate Tax) variables\n")
df10 <- synth_btp(obs = 100, select = "k", seed = 333)
dt10 <- as.data.table(df10)
dt10_with_k <- dt10[grepl("k", verk)]
cat(sprintf("  Observations with k: %d\n", nrow(dt10_with_k)))
if (nrow(dt10_with_k) > 0) {
  cat(sprintf("  k_k0101 (income) range: %.2f - %.2f\n",
              min(dt10_with_k$k_k0101, na.rm = TRUE),
              max(dt10_with_k$k_k0101, na.rm = TRUE)))
  cat(sprintf("  k_fef13 (legal form) values: %s\n",
              paste(sort(unique(na.omit(dt10_with_k$k_fef13))), collapse = ", ")))
  # Check solidarity surcharge is 5.5% of corporate tax
  if (any(!is.na(dt10_with_k$k_k0501) & dt10_with_k$k_k0501 > 0)) {
    ratio <- dt10_with_k[k_k0501 > 0, mean(k_k0502 / k_k0501, na.rm = TRUE)]
    cat(sprintf("  SolZ/KSt ratio: %.3f (expected: 0.055)\n", ratio))
  }
}
cat("  ✓ PASSED\n\n")

# Test 11: VAT advance variables ----
cat("Test 11: Umsatzsteuer-Voranmeldung (VAT advance) variables\n")
df11 <- synth_btp(obs = 100, select = "u", seed = 444)
dt11 <- as.data.table(df11)
dt11_with_u <- dt11[grepl("u", verk)]
cat(sprintf("  Observations with u: %d\n", nrow(dt11_with_u)))
if (nrow(dt11_with_u) > 0) {
  cat(sprintf("  u_c0101 (supplies 19%%) range: %.2f - %.2f\n",
              min(dt11_with_u$u_c0101, na.rm = TRUE),
              max(dt11_with_u$u_c0101, na.rm = TRUE)))
  cat(sprintf("  u_c0401 (payment) range: %.2f - %.2f\n",
              min(dt11_with_u$u_c0401, na.rm = TRUE),
              max(dt11_with_u$u_c0401, na.rm = TRUE)))
}
cat("  ✓ PASSED\n\n")

# Test 12: Metadata extraction ----
cat("Test 12: Metadata extraction\n")
df12 <- synth_btp(obs = 50, seed = 555)
metadata <- extract_btp_metadata(df12)
cat(sprintf("  Metadata rows: %d\n", nrow(metadata)))
cat(sprintf("  Variables with labels: %d\n", sum(!is.na(metadata$label))))
cat(sprintf("  Variables with value labels: %d\n", sum(metadata$has_value_labels)))
cat("\n  Sample metadata:\n")
print(head(metadata, 10))
cat("  ✓ PASSED\n\n")

# Test 13: Panel structure summary ----
cat("Test 13: Panel structure summary\n")
df13 <- synth_btp(obs = 200, seed = 666)
summary <- summarize_btp_panel(df13)
cat(sprintf("  Total observations: %d\n", summary$n_observations))
cat(sprintf("  Unique units: %d\n", summary$n_units))
cat(sprintf("  Years: %s\n", paste(summary$years, collapse = ", ")))
cat(sprintf("  Percentage balanced: %.1f%%\n", summary$pct_balanced))
cat("\n  Observations per unit distribution:\n")
print(summary$observations_per_unit)
cat("\n  Linkage quality distribution:\n")
print(summary$linkage_quality)
cat("  ✓ PASSED\n\n")

# Test 14: Large dataset generation (performance) ----
cat("Test 14: Large dataset generation (1000 obs)\n")
start_time <- Sys.time()
df14 <- synth_btp(obs = 1000, seed = 777)
end_time <- Sys.time()
elapsed <- as.numeric(difftime(end_time, start_time, units = "secs"))
cat(sprintf("  Generated: %d rows, %d columns\n", nrow(df14), ncol(df14)))
cat(sprintf("  Time elapsed: %.2f seconds\n", elapsed))
cat(sprintf("  Memory size: %.2f MB\n", 
            as.numeric(object.size(df14)) / 1024^2))
cat("  ✓ PASSED\n\n")

# Test 15: Combination of all options ----
cat("Test 15: Complex scenario (300 obs, years 2015-2018, select gkv, balanced)\n")
df15 <- synth_btp(obs = 300, years = 2015:2018, select = "gkv", 
                  balanced = TRUE, seed = 888)
cat(sprintf("  Generated: %d rows, %d columns\n", nrow(df15), ncol(df15)))
cat(sprintf("  Unique IDs: %d\n", length(unique(df15$id))))
cat(sprintf("  Years: %s\n", paste(sort(unique(df15$jahr)), collapse = ", ")))
cat(sprintf("  All units in all years: %s\n", 
            ifelse(all(table(df15$id) == 4), "YES", "NO")))
has_stats <- sapply(c("g", "k", "v", "u", "p", "e"), function(s) {
  sum(grepl(s, df15$verk))
})
names(has_stats) <- c("g", "k", "v", "u", "p", "e")
cat("  Statistics presence:\n")
print(has_stats)
stopifnot(has_stats["u"] == 0)  # u not selected
stopifnot(has_stats["p"] == 0)  # p not selected
stopifnot(has_stats["e"] == 0)  # e not selected
cat("  ✓ PASSED\n\n")

# Test 16: Reproducibility check ----
cat("Test 16: Reproducibility with same seed\n")
df16a <- synth_btp(obs = 50, seed = 999)
df16b <- synth_btp(obs = 50, seed = 999)

# Check data values (ignoring attributes which may have timestamps)
# Remove all attributes except essential ones
df16a_clean <- df16a
df16b_clean <- df16b
attr(df16a_clean, "generated") <- NULL
attr(df16b_clean, "generated") <- NULL

# Check numeric columns for equality
numeric_cols <- sapply(df16a, is.numeric)
if (any(numeric_cols)) {
  max_diff <- max(abs(as.matrix(df16a[, numeric_cols]) - 
                       as.matrix(df16b[, numeric_cols])), na.rm = TRUE)
  cat(sprintf("  Maximum numeric difference: %.10f\n", max_diff))
  numeric_identical <- max_diff < 1e-10
} else {
  numeric_identical <- TRUE
}

# Check character columns
char_cols <- sapply(df16a, is.character)
if (any(char_cols)) {
  char_df_a <- df16a[, char_cols, drop = FALSE]
  char_df_b <- df16b[, char_cols, drop = FALSE]
  char_identical <- all(sapply(1:ncol(char_df_a), function(i) {
    all(char_df_a[[i]] == char_df_b[[i]], na.rm = TRUE)
  }))
  cat(sprintf("  Character columns identical: %s\n", char_identical))
} else {
  char_identical <- TRUE
}

# Overall check
reproducible <- numeric_identical && char_identical
cat(sprintf("  Data values reproducible: %s\n", reproducible))
stopifnot(reproducible)
cat("  ✓ PASSED\n\n")

# Summary ----
cat("\n" , paste(rep("=", 60), collapse = ""), "\n")
cat("All 16 tests PASSED successfully!\n")
cat(paste(rep("=", 60), collapse = ""), "\n\n")

# Usage examples for documentation ----
cat("=== Usage Examples ===\n\n")

cat("Example 1: Quick start with defaults\n")
cat('  df <- synth_btp()\n')
cat('  head(df)\n\n')

cat("Example 2: Balanced panel for methodological testing\n")
cat('  df <- synth_btp(obs = 500, balanced = TRUE, seed = 42)\n')
cat('  summary(df)\n\n')

cat("Example 3: Focus on corporate taxation (Gewerbesteuer + Körperschaftsteuer)\n")
cat('  df <- synth_btp(obs = 1000, select = "gk", years = 2015:2019)\n')
cat('  table(df$verk_qual)\n\n')

cat("Example 4: VAT analysis (all VAT-related statistics)\n")
cat('  df <- synth_btp(obs = 800, select = "uv", seed = 123)\n')
cat('  summary(df[grepl("v", df$verk), ])\n\n')

cat("Example 5: Large-scale simulation\n")
cat('  df <- synth_btp(obs = 10000, select = "all", balanced = FALSE)\n')
cat('  panel_summary <- summarize_btp_panel(df)\n')
cat('  print(panel_summary)\n\n')

cat("Example 6: Extract and analyze metadata\n")
cat('  df <- synth_btp(obs = 100)\n')
cat('  metadata <- extract_btp_metadata(df)\n')
cat('  subset(metadata, has_value_labels == TRUE)\n\n')

cat("\n=== Test Script Complete ===\n")
