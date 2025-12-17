# Linear Models with DuckDB Data
# ============================================================
# This script demonstrates using DuckDB to prepare data for linear regression

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create example dataset for regression analysis ----
set.seed(42)
dbExecute(con, "
  CREATE TABLE study_data AS
  SELECT
    RANGE as id,
    FLOOR(RANDOM() * 50 + 20) as age,
    CASE WHEN RANDOM() < 0.5 THEN 'Male' ELSE 'Female' END as gender,
    CASE 
      WHEN RANGE % 3 = 0 THEN 'Low'
      WHEN RANGE % 3 = 1 THEN 'Medium'
      ELSE 'High'
    END as education_level,
    RANDOM() * 15 + 5 as years_experience,
    RANDOM() * 40 + 10 as baseline_health_score,
    RANDOM() * 20 + 5 as stress_level,
    RANDOM() * 30 + 10 as exercise_hours_weekly,
    -- Outcome variable (with some relationship to predictors)
    50 + 
    (RANDOM() * 15 + 5) * 0.3 +  -- years_experience effect
    (RANDOM() * 30 + 10) * 0.4 +  -- exercise effect
    -(RANDOM() * 20 + 5) * 0.2 +  -- stress effect (negative)
    RANDOM() * 10 as health_outcome  -- random noise
  FROM RANGE(1, 5001)
")

print("Study data created:")
preview <- dbGetQuery(con, "SELECT * FROM study_data LIMIT 5")
print(preview)

# Example 1: Simple linear regression ----
# Prepare data in DuckDB, then fit model in R

model_data1 <- dbGetQuery(con, "
  SELECT 
    health_outcome,
    years_experience
  FROM study_data
  WHERE years_experience IS NOT NULL
    AND health_outcome IS NOT NULL
")

lm1 <- lm(health_outcome ~ years_experience, data = model_data1)
print("Example 1 - Simple linear regression:")
print(summary(lm1))

# Example 2: Multiple regression ----
model_data2 <- dbGetQuery(con, "
  SELECT 
    health_outcome,
    age,
    years_experience,
    baseline_health_score,
    stress_level,
    exercise_hours_weekly
  FROM study_data
  WHERE health_outcome IS NOT NULL
")

lm2 <- lm(health_outcome ~ age + years_experience + baseline_health_score + 
          stress_level + exercise_hours_weekly, 
          data = model_data2)

print("Example 2 - Multiple regression:")
print(summary(lm2))

# Example 3: Regression with categorical predictors ----
model_data3 <- dbGetQuery(con, "
  SELECT 
    health_outcome,
    gender,
    education_level,
    exercise_hours_weekly,
    stress_level
  FROM study_data
")

# Convert to factors
model_data3$gender <- factor(model_data3$gender)
model_data3$education_level <- factor(
  model_data3$education_level, 
  levels = c("Low", "Medium", "High"),
  ordered = TRUE
)

lm3 <- lm(health_outcome ~ gender + education_level + 
          exercise_hours_weekly + stress_level, 
          data = model_data3)

print("Example 3 - Regression with categorical variables:")
print(summary(lm3))

# Example 4: Data preprocessing in DuckDB ----
# Create derived variables, handle outliers, standardize
model_data4 <- dbGetQuery(con, "
  WITH preprocessed AS (
    SELECT 
      health_outcome,
      age,
      years_experience,
      exercise_hours_weekly,
      stress_level,
      -- Create interaction term
      exercise_hours_weekly * stress_level as exercise_stress_interaction,
      -- Standardize continuous variables
      (age - AVG(age) OVER ()) / STDDEV(age) OVER () as age_std,
      (years_experience - AVG(years_experience) OVER ()) / 
        STDDEV(years_experience) OVER () as experience_std,
      (exercise_hours_weekly - AVG(exercise_hours_weekly) OVER ()) / 
        STDDEV(exercise_hours_weekly) OVER () as exercise_std,
      (stress_level - AVG(stress_level) OVER ()) / 
        STDDEV(stress_level) OVER () as stress_std
    FROM study_data
    WHERE health_outcome IS NOT NULL
      -- Remove outliers (3 SD rule)
      AND ABS(health_outcome - AVG(health_outcome) OVER ()) / 
          STDDEV(health_outcome) OVER () < 3
  )
  SELECT * FROM preprocessed
")

lm4 <- lm(health_outcome ~ age_std + experience_std + exercise_std + 
          stress_std + exercise_stress_interaction, 
          data = model_data4)

print("Example 4 - Standardized regression with interaction:")
print(summary(lm4))

# Example 5: Train/test split in DuckDB ----
# Use random sampling for model validation
train_data <- dbGetQuery(con, "
  SELECT 
    health_outcome,
    age,
    years_experience,
    exercise_hours_weekly,
    stress_level
  FROM study_data
  WHERE RANDOM() < 0.7  -- 70% training data
    AND health_outcome IS NOT NULL
")

test_data <- dbGetQuery(con, "
  SELECT 
    id,
    health_outcome,
    age,
    years_experience,
    exercise_hours_weekly,
    stress_level
  FROM study_data
  WHERE id NOT IN (SELECT id FROM study_data USING SAMPLE 70%)
    AND health_outcome IS NOT NULL
  LIMIT 1500
")

# Fit model on training data
lm5 <- lm(health_outcome ~ age + years_experience + 
          exercise_hours_weekly + stress_level, 
          data = train_data)

# Predict on test data
test_data$predicted <- predict(lm5, newdata = test_data)
test_data$residual <- test_data$health_outcome - test_data$predicted

# Calculate test set metrics
test_rmse <- sqrt(mean(test_data$residual^2))
test_mae <- mean(abs(test_data$residual))
test_r2 <- cor(test_data$health_outcome, test_data$predicted)^2

print("Example 5 - Train/test split validation:")
print(paste("Training set size:", nrow(train_data)))
print(paste("Test set size:", nrow(test_data)))
print(paste("Test RMSE:", round(test_rmse, 3)))
print(paste("Test MAE:", round(test_mae, 3)))
print(paste("Test R²:", round(test_r2, 3)))

# Example 6: Grouped regression (by subgroups) ----
# Fit separate models for different groups
gender_models <- list()

for (gender_val in c("Male", "Female")) {
  subgroup_data <- dbGetQuery(con, sprintf("
    SELECT 
      health_outcome,
      age,
      years_experience,
      exercise_hours_weekly,
      stress_level
    FROM study_data
    WHERE gender = '%s'
      AND health_outcome IS NOT NULL
  ", gender_val))
  
  model <- lm(health_outcome ~ age + years_experience + 
              exercise_hours_weekly + stress_level, 
              data = subgroup_data)
  
  gender_models[[gender_val]] <- model
  
  print(sprintf("Example 6 - Model for %s:", gender_val))
  print(summary(model))
}

# Example 7: Diagnostics and residual analysis ----
# Use DuckDB to store predictions and residuals
full_data <- dbGetQuery(con, "
  SELECT * FROM study_data WHERE health_outcome IS NOT NULL
")

# Fit comprehensive model
lm_final <- lm(health_outcome ~ age + gender + education_level + 
               years_experience + baseline_health_score + 
               stress_level + exercise_hours_weekly, 
               data = full_data)

# Add predictions and residuals
full_data$fitted <- fitted(lm_final)
full_data$residuals <- residuals(lm_final)
full_data$standardized_residuals <- rstandard(lm_final)
full_data$cooks_distance <- cooks.distance(lm_final)

# Store results back in DuckDB for further analysis
dbWriteTable(con, "model_diagnostics", full_data, overwrite = TRUE)

# Analyze residuals in DuckDB
diagnostics <- dbGetQuery(con, "
  SELECT 
    education_level,
    COUNT(*) as n,
    ROUND(AVG(residuals), 3) as mean_residual,
    ROUND(STDDEV(residuals), 3) as sd_residual,
    ROUND(AVG(ABS(residuals)), 3) as mean_abs_residual,
    COUNT(CASE WHEN ABS(standardized_residuals) > 2 THEN 1 END) as outliers_2sd,
    COUNT(CASE WHEN ABS(standardized_residuals) > 3 THEN 1 END) as outliers_3sd,
    COUNT(CASE WHEN cooks_distance > 0.5 THEN 1 END) as influential_obs
  FROM model_diagnostics
  GROUP BY education_level
  ORDER BY education_level
")

print("Example 7 - Residual diagnostics by education level:")
print(diagnostics)

# Example 8: Export model results ----
# Create summary table for reporting
model_summary <- data.frame(
  term = names(coef(lm_final)),
  estimate = coef(lm_final),
  std_error = summary(lm_final)$coefficients[, "Std. Error"],
  t_value = summary(lm_final)$coefficients[, "t value"],
  p_value = summary(lm_final)$coefficients[, "Pr(>|t|)"]
)
rownames(model_summary) <- NULL

# Write to DuckDB
dbWriteTable(con, "model_coefficients", model_summary, overwrite = TRUE)

# Export to CSV
output_file <- "linear_model_results.csv"
dbExecute(con, sprintf("
  COPY model_coefficients TO '%s' (HEADER, DELIMITER ',')
", output_file))

print(paste("Model results exported to:", output_file))

# Read back and display
exported_results <- read.csv(output_file)
print("Exported model coefficients:")
print(exported_results)

# Example 9: Polynomial regression ----
poly_data <- dbGetQuery(con, "
  SELECT 
    health_outcome,
    exercise_hours_weekly,
    POWER(exercise_hours_weekly, 2) as exercise_squared,
    POWER(exercise_hours_weekly, 3) as exercise_cubed
  FROM study_data
  WHERE health_outcome IS NOT NULL
")

lm_poly <- lm(health_outcome ~ exercise_hours_weekly + 
              exercise_squared + exercise_cubed, 
              data = poly_data)

print("Example 9 - Polynomial regression:")
print(summary(lm_poly))

# Example 10: Large dataset efficiency ----
# Demonstrate DuckDB's efficiency with filtering and sampling
print("\n=== Performance Comparison ===")

# Method 1: Load all data, then filter in R
time_r <- system.time({
  all_data <- dbGetQuery(con, "SELECT * FROM study_data")
  filtered_r <- all_data[all_data$age > 30 & all_data$stress_level < 15, ]
  model_r <- lm(health_outcome ~ age + stress_level, data = filtered_r)
})

# Method 2: Filter in DuckDB, then load
time_duckdb <- system.time({
  filtered_duckdb <- dbGetQuery(con, "
    SELECT * FROM study_data 
    WHERE age > 30 AND stress_level < 15
  ")
  model_duckdb <- lm(health_outcome ~ age + stress_level, data = filtered_duckdb)
})

print(paste("Load all then filter (R):", round(time_r["elapsed"], 4), "seconds"))
print(paste("Filter in DuckDB:", round(time_duckdb["elapsed"], 4), "seconds"))
print(paste("Speedup:", round(time_r["elapsed"] / time_duckdb["elapsed"], 2), "x"))

# Model summary ----
print("\n=== Final Model Summary ===")
print(paste("Total observations:", nrow(full_data)))
print(paste("Predictors:", length(coef(lm_final)) - 1))
print(paste("R²:", round(summary(lm_final)$r.squared, 4)))
print(paste("Adjusted R²:", round(summary(lm_final)$adj.r.squared, 4)))
print(paste("RMSE:", round(sqrt(mean(residuals(lm_final)^2)), 3)))
print(paste("F-statistic:", round(summary(lm_final)$fstatistic[1], 2)))

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
file.remove(output_file)
print("\nConnection closed and files removed")
