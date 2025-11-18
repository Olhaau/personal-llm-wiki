# Original GT Demographic Table from Case Study
# Source: https://gt.rstudio.com/articles/case-study-clinical-tables.html

# Load required libraries
library(gt)
library(dplyr)
library(tidyr)
library(rlang)
library(purrr)

# Custom summary function from the case study
custom_summary <- function(df, group_var, sum_var) {
  group_var <- rlang::ensym(group_var)
  sum_var <- rlang::ensym(sum_var)

  is_categorical <-
    is.character(eval(expr(`$`(df, !!sum_var)))) |
      is.factor(eval(expr(`$`(df, !!sum_var))))

  if (is_categorical) {
    category_lbl <-
      sprintf("%s, n (%%)", attr(eval(expr(`$`(df, !!sum_var))), "label"))

    df_out <-
      df |>
      dplyr::group_by(!!group_var) |>
      dplyr::mutate(N = dplyr::n()) |>
      dplyr::ungroup() |>
      dplyr::group_by(!!group_var, !!sum_var) |>
      dplyr::summarize(
        val = dplyr::n(),
        pct = dplyr::n() / mean(N),
        .groups = "drop"
      ) |>
      tidyr::pivot_wider(
        id_cols = !!sum_var, names_from = !!group_var,
        values_from = c(val, pct)
      ) |>
      dplyr::rename(label = !!sum_var) |>
      dplyr::mutate(
        across(where(is.numeric), ~ ifelse(is.na(.), 0, .)),
        category = category_lbl
      )
  } else {
    category_lbl <-
      sprintf(
        "%s (%s)",
        attr(eval(expr(`$`(df, !!sum_var))), "label"),
        attr(eval(expr(`$`(df, !!sum_var))), "units")
      )

    df_out <-
      df |>
      dplyr::group_by(!!group_var) |>
      dplyr::summarize(
        n = sum(!is.na(!!sum_var)),
        mean = mean(!!sum_var, na.rm = TRUE),
        sd = sd(!!sum_var, na.rm = TRUE),
        median = median(!!sum_var, na.rm = TRUE),
        min = min(!!sum_var, na.rm = TRUE),
        max = max(!!sum_var, na.rm = TRUE),
        min_max = NA,
        .groups = "drop"
      ) |>
      tidyr::pivot_longer(
        cols = c(n, mean, median, min_max),
        names_to = "label",
        values_to = "val"
      ) |>
      dplyr::mutate(
        sd = ifelse(label == "mean", sd, NA),
        max = ifelse(label == "min_max", max, NA),
        min = ifelse(label == "min_max", min, NA),
        label = dplyr::recode(
          label,
          "mean" = "Mean (SD)",
          "min_max" = "Min - Max",
          "median" = "Median"
        )
      ) |>
      tidyr::pivot_wider(
        id_cols = label,
        names_from = !!group_var,
        values_from = c(val, sd, min, max)
      ) |>
      dplyr::mutate(category = category_lbl)
  }

  return(df_out)
}

# Create the demographic summary data
adsl_summary <-
  dplyr::filter(rx_adsl, ITTFL == "Y") |>
  (\(data) purrr::map_df(
    .x = dplyr::vars(AGE, AAGEGR1, SEX, ETHNIC, BLBMI),
    .f = \(x) custom_summary(df = data, group_var = TRTA, sum_var = !!x)
  ))()

# Count subjects per arm and create column labels
arm_n <-
  rx_adsl |>
  dplyr::filter(ITTFL == "Y") |>
  dplyr::group_by(TRTA) |>
  dplyr::summarize(
    lbl = sprintf("%s N=%i (100%%)", unique(TRTA), dplyr::n()),
    .groups = "drop"
  ) |>
  dplyr::arrange(TRTA)

collbl_list <- as.list(arm_n$lbl)
names(collbl_list) <- paste0("val_", arm_n$TRTA)

# Create the final GT table
rx_adsl_tbl <-
  adsl_summary |>
  gt(
    rowname_col = "label",
    groupname_col = "category"
  ) |>
  tab_header(
    title = "x.x: Demographic Characteristics",
    subtitle = "x.x.x: Demographic Characteristics - ITT Analysis Set"
  ) |>
  fmt_integer(
    columns = starts_with(c("val_", "min_", "max_")),
    rows = label %in% c("n", "Median", "Min - Max")
  ) |>
  fmt_percent(
    columns = starts_with("pct_"),
    decimals = 1
  ) |>
  fmt_number(
    columns = starts_with("val_"),
    rows = label == "Mean (SD)",
    decimals = 1
  ) |>
  fmt_number(
    columns = starts_with("sd_"),
    rows = label == "Mean (SD)",
    decimals = 2
  ) |>
  cols_merge(
    columns = c("val_Placebo", "pct_Placebo", "sd_Placebo", "min_Placebo", "max_Placebo"),
    pattern = "<<{1}>><< ({2})>><< ({3})>><<{4} - {5}>>"
  ) |>
  cols_merge(
    columns = c("val_Drug 1", "pct_Drug 1", "sd_Drug 1", "min_Drug 1", "max_Drug 1"),
    pattern = "<<{1}>><< ({2})>><< ({3})>><<{4} - {5}>>"
  ) |>
  tab_stub_indent(
    rows = everything(),
    indent = 5
  ) |>
  opt_align_table_header(align = "left") |>
  cols_width(
    starts_with("val_") ~ px(200),
    1 ~ px(250)
  ) |>
  cols_align(
    align = "center",
    columns = starts_with("val_")
  ) |>
  cols_label(.list = collbl_list)

# Display the table
rx_adsl_tbl

# Save the table as HTML for accessibility analysis
rx_adsl_tbl |> 
  gtsave("original_gt_table.html")

cat("Original GT table created successfully!\n")
cat("HTML file saved as: original_gt_table.html\n")