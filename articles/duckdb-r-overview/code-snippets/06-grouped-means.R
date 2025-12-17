# Computing Grouped Means with DuckDB
# ============================================================
# This script demonstrates various aggregation functions and grouped statistics

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create example dataset with measurements ----
dbExecute(con, "
  CREATE TABLE measurements AS
  SELECT
    (RANGE % 100) + 1 as subject_id,
    CASE 
      WHEN RANGE % 3 = 0 THEN 'Control'
      WHEN RANGE % 3 = 1 THEN 'Treatment_A'
      ELSE 'Treatment_B'
    END as treatment_group,
    CASE
      WHEN RANGE % 2 = 0 THEN 'Male'
      ELSE 'Female'
    END as gender,
    FLOOR(RANDOM() * 40 + 20) as age,
    RANDOM() * 30 + 60 as baseline_score,
    RANDOM() * 35 + 65 as followup_score,
    RANDOM() * 10 + 5 as response_time,
    DATE '2024-01-01' + INTERVAL (RANGE % 180) DAY as measurement_date
  FROM RANGE(1, 5001)
")

print("Sample data created:")
preview <- dbGetQuery(con, "SELECT * FROM measurements LIMIT 5")
print(preview)

# Example 1: Basic mean by group ----
mean1 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    ROUND(AVG(baseline_score), 2) as mean_baseline,
    ROUND(AVG(followup_score), 2) as mean_followup,
    COUNT(*) as n
  FROM measurements
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 1 - Mean scores by treatment group:")
print(mean1)

# Example 2: Multiple summary statistics ----
summary2 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    COUNT(*) as n,
    ROUND(AVG(followup_score), 2) as mean,
    ROUND(STDDEV(followup_score), 2) as sd,
    ROUND(MIN(followup_score), 2) as min,
    ROUND(MAX(followup_score), 2) as max,
    ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY followup_score), 2) as q25,
    ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY followup_score), 2) as median,
    ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY followup_score), 2) as q75
  FROM measurements
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 2 - Comprehensive summary statistics:")
print(summary2)

# Example 3: Grouped by multiple variables ----
summary3 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    gender,
    COUNT(*) as n,
    ROUND(AVG(followup_score), 2) as mean_score,
    ROUND(STDDEV(followup_score), 2) as sd_score,
    ROUND(STDDEV(followup_score) / SQRT(COUNT(*)), 2) as se_score
  FROM measurements
  GROUP BY treatment_group, gender
  ORDER BY treatment_group, gender
")

print("Example 3 - Statistics by treatment and gender:")
print(summary3)

# Example 4: Computed columns and differences ----
summary4 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    COUNT(*) as n,
    ROUND(AVG(baseline_score), 2) as mean_baseline,
    ROUND(AVG(followup_score), 2) as mean_followup,
    ROUND(AVG(followup_score - baseline_score), 2) as mean_change,
    ROUND(STDDEV(followup_score - baseline_score), 2) as sd_change
  FROM measurements
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 4 - Change scores (followup - baseline):")
print(summary4)

# Example 5: Age group analysis ----
summary5 <- dbGetQuery(con, "
  SELECT 
    CASE 
      WHEN age < 30 THEN '20-29'
      WHEN age < 40 THEN '30-39'
      WHEN age < 50 THEN '40-49'
      ELSE '50+'
    END as age_group,
    treatment_group,
    COUNT(*) as n,
    ROUND(AVG(followup_score), 2) as mean_score,
    ROUND(STDDEV(followup_score), 2) as sd_score
  FROM measurements
  GROUP BY age_group, treatment_group
  ORDER BY age_group, treatment_group
")

print("Example 5 - Statistics by age group and treatment:")
print(head(summary5, 10))

# Example 6: Time-based aggregation ----
summary6 <- dbGetQuery(con, "
  SELECT 
    DATE_TRUNC('month', measurement_date) as month,
    treatment_group,
    COUNT(*) as measurements,
    ROUND(AVG(followup_score), 2) as mean_score
  FROM measurements
  WHERE measurement_date >= '2024-01-01'
    AND measurement_date < '2024-04-01'
  GROUP BY month, treatment_group
  ORDER BY month, treatment_group
")

print("Example 6 - Monthly mean scores by treatment:")
print(summary6)

# Example 7: Weighted means ----
summary7 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    ROUND(
      SUM(followup_score * response_time) / SUM(response_time), 
      2
    ) as weighted_mean_score,
    ROUND(AVG(followup_score), 2) as unweighted_mean_score
  FROM measurements
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 7 - Weighted vs unweighted means:")
print(summary7)

# Example 8: Filtering before aggregation ----
summary8 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    COUNT(*) as n,
    ROUND(AVG(followup_score), 2) as mean_score
  FROM measurements
  WHERE age >= 30 
    AND age < 50
    AND baseline_score > 65
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 8 - Filtered sample (age 30-49, baseline > 65):")
print(summary8)

# Example 9: Filtering after aggregation (HAVING) ----
summary9 <- dbGetQuery(con, "
  SELECT 
    subject_id,
    COUNT(*) as measurements,
    ROUND(AVG(followup_score), 2) as mean_score,
    ROUND(STDDEV(followup_score), 2) as sd_score
  FROM measurements
  GROUP BY subject_id
  HAVING COUNT(*) >= 40 AND AVG(followup_score) > 75
  ORDER BY mean_score DESC
  LIMIT 10
")

print("Example 9 - Subjects with ≥40 measurements and mean score >75:")
print(summary9)

# Example 10: Window functions for group comparisons ----
summary10 <- dbGetQuery(con, "
  WITH group_means AS (
    SELECT 
      treatment_group,
      AVG(followup_score) as mean_score
    FROM measurements
    GROUP BY treatment_group
  )
  SELECT 
    treatment_group,
    ROUND(mean_score, 2) as mean_score,
    ROUND(mean_score - AVG(mean_score) OVER (), 2) as diff_from_overall
  FROM group_means
  ORDER BY treatment_group
")

print("Example 10 - Group means relative to overall mean:")
print(summary10)

# Example 11: Multiple variables summary ----
summary11 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    COUNT(*) as n,
    ROUND(AVG(baseline_score), 2) as mean_baseline,
    ROUND(AVG(followup_score), 2) as mean_followup,
    ROUND(AVG(response_time), 2) as mean_response_time,
    ROUND(STDDEV(baseline_score), 2) as sd_baseline,
    ROUND(STDDEV(followup_score), 2) as sd_followup,
    ROUND(STDDEV(response_time), 2) as sd_response_time
  FROM measurements
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 11 - Multi-variable summary:")
print(summary11)

# Example 12: Correlation within groups ----
summary12 <- dbGetQuery(con, "
  SELECT 
    treatment_group,
    COUNT(*) as n,
    ROUND(CORR(baseline_score, followup_score), 3) as correlation
  FROM measurements
  GROUP BY treatment_group
  ORDER BY treatment_group
")

print("Example 12 - Correlation between baseline and followup:")
print(summary12)

# Example 13: Grand summary with subtotals ----
summary13 <- dbGetQuery(con, "
  SELECT 
    COALESCE(treatment_group, 'TOTAL') as treatment_group,
    COALESCE(gender, 'TOTAL') as gender,
    COUNT(*) as n,
    ROUND(AVG(followup_score), 2) as mean_score
  FROM measurements
  GROUP BY ROLLUP(treatment_group, gender)
  ORDER BY treatment_group, gender
")

print("Example 13 - Summary with subtotals (ROLLUP):")
print(head(summary13, 15))

# Example 14: Export summary table ----
output_file <- "summary_statistics.csv"
dbExecute(con, sprintf("
  COPY (
    SELECT 
      treatment_group,
      gender,
      COUNT(*) as n,
      ROUND(AVG(age), 1) as mean_age,
      ROUND(AVG(baseline_score), 2) as mean_baseline,
      ROUND(AVG(followup_score), 2) as mean_followup,
      ROUND(AVG(followup_score - baseline_score), 2) as mean_change,
      ROUND(STDDEV(followup_score - baseline_score), 2) as sd_change
    FROM measurements
    GROUP BY treatment_group, gender
    ORDER BY treatment_group, gender
  ) TO '%s' (HEADER, DELIMITER ',')
", output_file))

print(paste("Summary exported to:", output_file))

# Read back and verify
exported <- read.csv(output_file)
print("Exported summary (first rows):")
print(head(exported))

# Performance comparison ----
print("\n=== Performance Comparison ===")

# Method 1: Load data into R, then aggregate
time_r <- system.time({
  data_r <- dbGetQuery(con, "SELECT * FROM measurements")
  result_r <- aggregate(
    followup_score ~ treatment_group + gender, 
    data = data_r, 
    FUN = mean
  )
})

# Method 2: Aggregate in DuckDB
time_duckdb <- system.time({
  result_duckdb <- dbGetQuery(con, "
    SELECT 
      treatment_group,
      gender,
      AVG(followup_score) as mean_score
    FROM measurements
    GROUP BY treatment_group, gender
  ")
})

print(paste("R aggregate:", round(time_r["elapsed"], 4), "seconds"))
print(paste("DuckDB:", round(time_duckdb["elapsed"], 4), "seconds"))
print(paste("Speedup:", round(time_r["elapsed"] / time_duckdb["elapsed"], 2), "x"))

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
file.remove(output_file)
print("\nConnection closed and files removed")
