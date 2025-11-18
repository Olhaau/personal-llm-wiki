# Improved Accessible GT Demographic Table
# Enhanced version with better screen reader support and accessibility features

# Load required libraries
library(gt)
library(dplyr)
library(tidyr)
library(rlang)
library(purrr)

# Function to create accessible demographic summary
create_accessible_summary <- function(df, group_var, sum_var) {
  group_var <- rlang::ensym(group_var)
  sum_var <- rlang::ensym(sum_var)

  is_categorical <-
    is.character(eval(expr(`$`(df, !!sum_var)))) |
      is.factor(eval(expr(`$`(df, !!sum_var))))

  if (is_categorical) {
    # Get variable label
    var_label <- attr(eval(expr(`$`(df, !!sum_var))), "label")
    
    df_out <-
      df |>
      dplyr::group_by(!!group_var, !!sum_var) |>
      dplyr::summarize(
        n = dplyr::n(),
        .groups = "drop_last"
      ) |>
      dplyr::mutate(
        total = sum(n),
        pct = round(100 * n / total, 1)
      ) |>
      dplyr::ungroup() |>
      tidyr::pivot_wider(
        id_cols = !!sum_var,
        names_from = !!group_var,
        values_from = c(n, pct),
        names_sep = "_"
      ) |>
      dplyr::rename(Characteristic = !!sum_var) |>
      dplyr::mutate(
        Variable = var_label,
        .before = Characteristic
      )
  } else {
    # For continuous variables
    var_label <- attr(eval(expr(`$`(df, !!sum_var))), "label")
    var_units <- attr(eval(expr(`$`(df, !!sum_var))), "units")
    full_label <- if (!is.null(var_units)) paste0(var_label, " (", var_units, ")") else var_label
    
    df_summary <-
      df |>
      dplyr::group_by(!!group_var) |>
      dplyr::summarize(
        n = sum(!is.na(!!sum_var)),
        mean = round(mean(!!sum_var, na.rm = TRUE), 1),
        sd = round(sd(!!sum_var, na.rm = TRUE), 2),
        median = round(median(!!sum_var, na.rm = TRUE), 1),
        min_val = round(min(!!sum_var, na.rm = TRUE), 1),
        max_val = round(max(!!sum_var, na.rm = TRUE), 1),
        .groups = "drop"
      ) |>
      tidyr::pivot_longer(
        cols = c(n, mean, median, min_val, max_val),
        names_to = "statistic",
        values_to = "value"
      ) |>
      dplyr::mutate(
        sd_val = case_when(
          statistic == "mean" ~ sd,
          TRUE ~ NA_real_
        )
      ) |>
      dplyr::select(-sd) |>
      tidyr::pivot_wider(
        id_cols = statistic,
        names_from = !!group_var,
        values_from = c(value, sd_val)
      ) |>
      dplyr::mutate(
        Variable = full_label,
        Characteristic = case_when(
          statistic == "n" ~ "Number of subjects",
          statistic == "mean" ~ "Mean (Standard Deviation)",
          statistic == "median" ~ "Median",
          statistic == "min_val" ~ "Minimum value",
          statistic == "max_val" ~ "Maximum value"
        )
      ) |>
      dplyr::select(-statistic) |>
      dplyr::select(Variable, Characteristic, everything())
  }
  
  return(df_out)
}

# Create accessible demographic data
accessible_summary <- function() {
  # Filter ITT population
  ittData <- dplyr::filter(rx_adsl, ITTFL == "Y")
  
  # Create summaries for each variable
  age_summary <- create_accessible_summary(ittData, TRTA, AGE)
  agegrp_summary <- create_accessible_summary(ittData, TRTA, AAGEGR1)
  sex_summary <- create_accessible_summary(ittData, TRTA, SEX)
  ethnic_summary <- create_accessible_summary(ittData, TRTA, ETHNIC)
  bmi_summary <- create_accessible_summary(ittData, TRTA, BLBMI)
  
  # Combine all summaries
  combined_summary <- bind_rows(
    age_summary,
    agegrp_summary,
    sex_summary,
    ethnic_summary,
    bmi_summary
  )
  
  return(combined_summary)
}

# Create the data
summary_data <- accessible_summary()

# Get treatment arm sample sizes for headers
arm_counts <-
  rx_adsl |>
  dplyr::filter(ITTFL == "Y") |>
  dplyr::count(TRTA, name = "n_subjects") |>
  dplyr::arrange(TRTA)

# Create accessible GT table
create_accessible_gt_table <- function(data, arm_counts) {
  
  # Create the base table
  tbl <- data |>
    gt(groupname_col = "Variable") |>
    
    # Add comprehensive table caption and summary
    tab_header(
      title = "Demographic and Baseline Characteristics",
      subtitle = "Intent-to-Treat Analysis Population"
    ) |>
    
    # Add table summary for screen readers
    tab_source_note(
      source_note = md("**Table Summary:** This table presents demographic and baseline characteristics 
                       for the intent-to-treat population comparing Placebo (N=90) and Drug 1 (N=90) groups. 
                       For categorical variables, data are shown as number of subjects (percentage). 
                       For continuous variables, data include count, mean with standard deviation, 
                       median, minimum and maximum values.")
    ) |>
    
    # Format the data columns
    fmt_number(
      columns = starts_with(c("n_", "pct_")),
      decimals = 1,
      drop_trailing_zeros = TRUE
    ) |>
    
    # Create readable column headers
    cols_label(
      Characteristic = "Characteristic",
      `n_Placebo` = "Count",
      `pct_Placebo` = "Percent (%)",
      `n_Drug 1` = "Count", 
      `pct_Drug 1` = "Percent (%)",
      `value_Placebo` = "Value",
      `sd_val_Placebo` = "SD",
      `value_Drug 1` = "Value",
      `sd_val_Drug 1` = "SD"
    ) |>
    
    # Add treatment group spanners with clear labels
    tab_spanner(
      label = paste0("Placebo Group (N=", arm_counts$n_subjects[1], ")"),
      columns = contains("Placebo")
    ) |>
    tab_spanner(
      label = paste0("Drug 1 Group (N=", arm_counts$n_subjects[2], ")"),
      columns = contains("Drug 1")
    ) |>
    
    # Style for better readability
    tab_style(
      style = cell_text(weight = "bold"),
      locations = cells_column_spanners()
    ) |>
    
    # Add footnotes for clarity
    tab_footnote(
      footnote = "For categorical variables: n (%). For continuous variables: individual statistics as labeled.",
      locations = cells_column_labels(columns = "Characteristic")
    ) |>
    
    # Align content appropriately
    cols_align(
      align = "left",
      columns = "Characteristic"
    ) |>
    cols_align(
      align = "center", 
      columns = -"Characteristic"
    ) |>
    
    # Set reasonable column widths
    cols_width(
      "Characteristic" ~ px(200),
      everything() ~ px(120)
    ) |>
    
    # Left-align headers
    opt_align_table_header(align = "left") |>
    
    # Add accessibility-focused options
    tab_options(
      # Ensure adequate contrast and spacing
      table.font.size = 12,
      data_row.padding = px(8),
      
      # Use letters for footnote marks (more accessible)
      footnotes.marks = letters,
      
      # Ensure table is not too wide
      table.width = pct(95),
      
      # Add some padding for readability
      heading.padding = px(10)
    )
  
  return(tbl)
}

# Create a simplified, more accessible version of the data
simplified_data <- summary_data |>
  # Handle categorical variables (merge n and pct)
  mutate(
    `Placebo_summary` = case_when(
      !is.na(`pct_Placebo`) ~ paste0(`n_Placebo`, " (", `pct_Placebo`, "%)"),
      !is.na(`value_Placebo`) & !is.na(`sd_val_Placebo`) ~ paste0(`value_Placebo`, " (", `sd_val_Placebo`, ")"),
      !is.na(`value_Placebo`) ~ as.character(`value_Placebo`),
      TRUE ~ ""
    ),
    `Drug1_summary` = case_when(
      !is.na(`pct_Drug 1`) ~ paste0(`n_Drug 1`, " (", `pct_Drug 1`, "%)"),
      !is.na(`value_Drug 1`) & !is.na(`sd_val_Drug 1`) ~ paste0(`value_Drug 1`, " (", `sd_val_Drug 1`, ")"),
      !is.na(`value_Drug 1`) ~ as.character(`value_Drug 1`),
      TRUE ~ ""
    )
  ) |>
  select(Variable, Characteristic, Placebo_summary, Drug1_summary)

# Create the simplified accessible table
accessible_table <- simplified_data |>
  gt(groupname_col = "Variable") |>
  
  # Comprehensive table identification
  tab_header(
    title = "Table 1: Demographic and Baseline Characteristics",
    subtitle = "Intent-to-Treat Analysis Population - Accessible Version"
  ) |>
  
  # Detailed table summary for screen readers
  tab_source_note(
    source_note = md("**Accessible Table Summary:** This table compares demographic and baseline characteristics between treatment groups. 
                     Placebo group: 90 subjects. Drug 1 group: 90 subjects. 
                     Categorical data presented as: number of subjects (percentage). 
                     Continuous data for count shows number of subjects. 
                     Continuous data for mean shows: value (standard deviation). 
                     Median, minimum, and maximum values shown as single numbers.
                     
                     **Navigation tip:** Use table navigation commands in your screen reader to move between data cells. 
                     Row headers identify the characteristic type, column headers identify the treatment group.")
  ) |>
  
  # Clear, descriptive column labels
  cols_label(
    Characteristic = "Demographic Characteristic",
    Placebo_summary = paste0("Placebo Group (N=", arm_counts$n_subjects[1], ")"),
    Drug1_summary = paste0("Drug 1 Group (N=", arm_counts$n_subjects[2], ")")
  ) |>
  
  # Styling for accessibility
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_row_groups()
  ) |>
  
  # Appropriate alignment
  cols_align(
    align = "left",
    columns = "Characteristic"
  ) |>
  cols_align(
    align = "center",
    columns = c("Placebo_summary", "Drug1_summary")
  ) |>
  
  # Reasonable column widths
  cols_width(
    "Characteristic" ~ px(250),
    "Placebo_summary" ~ px(180),
    "Drug1_summary" ~ px(180)
  ) |>
  
  # Left-align headers
  opt_align_table_header(align = "left") |>
  
  # Accessibility-focused styling
  tab_options(
    # Clear, readable font size
    table.font.size = 14,
    heading.title.font.size = 16,
    heading.subtitle.font.size = 14,
    
    # Adequate padding for readability
    data_row.padding = px(10),
    heading.padding = px(12),
    
    # Use semantic footnote marks
    footnotes.marks = letters,
    
    # Responsive width
    table.width = pct(100),
    
    # Clear borders for structure
    table.border.top.style = "solid",
    table.border.bottom.style = "solid",
    column_labels.border.bottom.style = "solid"
  ) |>
  
  # Add explanatory footnote
  tab_footnote(
    footnote = "Data presentation: For categorical variables, values shown as count (percentage). For continuous variables: count shows number of subjects with data; mean shows value (standard deviation); median, minimum, and maximum show individual values.",
    locations = cells_column_labels(columns = "Characteristic")
  )

# Display the improved table
print(accessible_table)

# Save both versions
accessible_table |> 
  gtsave("improved_accessible_table.html")

# Also create a CSV version for ultimate accessibility
csv_data <- simplified_data |>
  rename(
    `Variable Category` = Variable,
    `Specific Characteristic` = Characteristic,
    `Placebo Group N=90` = Placebo_summary,
    `Drug 1 Group N=90` = Drug1_summary
  )

write.csv(csv_data, "demographic_table_accessible.csv", row.names = FALSE)

cat("Improved accessible GT table created successfully!\n")
cat("Files created:\n")
cat("- improved_accessible_table.html (Enhanced HTML table)\n")
cat("- demographic_table_accessible.csv (CSV for screen readers)\n")

# Print accessibility improvements made
cat("\n=== ACCESSIBILITY IMPROVEMENTS IMPLEMENTED ===\n")
cat("1. ✅ Added comprehensive table caption and summary\n")
cat("2. ✅ Simplified column structure (no complex merging)\n") 
cat("3. ✅ Clear, descriptive column headers\n")
cat("4. ✅ Proper row grouping with semantic meaning\n")
cat("5. ✅ Alternative CSV format provided\n")
cat("6. ✅ Detailed source notes for screen reader users\n")
cat("7. ✅ Larger font size and adequate padding\n")
cat("8. ✅ Clear data presentation patterns\n")
cat("9. ✅ Explanatory footnotes\n")
cat("10. ✅ Responsive table width\n")