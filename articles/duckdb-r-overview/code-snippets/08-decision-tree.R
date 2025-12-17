# Decision Tree Models with DuckDB Data
# ============================================================
# This script demonstrates using DuckDB to prepare data for decision tree models

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
  library(rpart)
  library(rpart.plot)
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create example classification dataset ----
set.seed(123)
dbExecute(con, "
  CREATE TABLE customer_data AS
  SELECT
    RANGE as customer_id,
    FLOOR(RANDOM() * 60 + 18) as age,
    CASE WHEN RANDOM() < 0.5 THEN 'Male' ELSE 'Female' END as gender,
    CASE 
      WHEN RANGE % 4 = 0 THEN 'Single'
      WHEN RANGE % 4 = 1 THEN 'Married'
      WHEN RANGE % 4 = 2 THEN 'Divorced'
      ELSE 'Widowed'
    END as marital_status,
    FLOOR(RANDOM() * 150000 + 20000) as annual_income,
    FLOOR(RANDOM() * 800) + 300 as credit_score,
    FLOOR(RANDOM() * 20) as years_with_bank,
    FLOOR(RANDOM() * 10) as num_products,
    RANDOM() * 50000 as account_balance,
    FLOOR(RANDOM() * 50) as monthly_transactions,
    -- Target variable: Customer churn (influenced by other variables)
    CASE 
      WHEN (
        (credit_score < 500) OR 
        (account_balance < 5000 AND monthly_transactions < 10) OR
        (num_products < 2 AND years_with_bank < 2)
      ) THEN 'Yes'
      ELSE 'No'
    END as churned
  FROM RANGE(1, 10001)
")

print("Customer data created:")
preview <- dbGetQuery(con, "SELECT * FROM customer_data LIMIT 5")
print(preview)

# Check class distribution
distribution <- dbGetQuery(con, "
  SELECT 
    churned,
    COUNT(*) as n,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as pct
  FROM customer_data
  GROUP BY churned
")
print("Class distribution:")
print(distribution)

# Example 1: Simple decision tree ----
tree_data1 <- dbGetQuery(con, "
  SELECT 
    churned,
    age,
    annual_income,
    credit_score,
    account_balance
  FROM customer_data
")

# Convert target to factor
tree_data1$churned <- factor(tree_data1$churned)

# Fit decision tree
tree1 <- rpart(churned ~ ., 
               data = tree_data1, 
               method = "class",
               control = rpart.control(cp = 0.01))

print("Example 1 - Simple decision tree:")
print(tree1)
print("\nVariable importance:")
print(tree1$variable.importance)

# Example 2: Train/test split in DuckDB ----
# Create deterministic split using modulo
train_data <- dbGetQuery(con, "
  SELECT 
    churned,
    age,
    gender,
    marital_status,
    annual_income,
    credit_score,
    years_with_bank,
    num_products,
    account_balance,
    monthly_transactions
  FROM customer_data
  WHERE customer_id % 10 < 7  -- 70% for training
")

test_data <- dbGetQuery(con, "
  SELECT 
    customer_id,
    churned,
    age,
    gender,
    marital_status,
    annual_income,
    credit_score,
    years_with_bank,
    num_products,
    account_balance,
    monthly_transactions
  FROM customer_data
  WHERE customer_id % 10 >= 7  -- 30% for testing
")

# Convert factors
train_data$churned <- factor(train_data$churned)
train_data$gender <- factor(train_data$gender)
train_data$marital_status <- factor(train_data$marital_status)

test_data$churned <- factor(test_data$churned)
test_data$gender <- factor(test_data$gender)
test_data$marital_status <- factor(test_data$marital_status)

print(paste("Training set size:", nrow(train_data)))
print(paste("Test set size:", nrow(test_data)))

# Fit tree on training data
tree2 <- rpart(churned ~ ., 
               data = train_data, 
               method = "class",
               control = rpart.control(
                 minsplit = 20,
                 minbucket = 7,
                 cp = 0.001,
                 maxdepth = 10
               ))

# Predict on test data
test_data$predicted <- predict(tree2, newdata = test_data, type = "class")
test_data$prob_yes <- predict(tree2, newdata = test_data, type = "prob")[, "Yes"]

# Calculate accuracy metrics
confusion <- table(Actual = test_data$churned, Predicted = test_data$predicted)
accuracy <- sum(diag(confusion)) / sum(confusion)
precision <- confusion["Yes", "Yes"] / sum(confusion[, "Yes"])
recall <- confusion["Yes", "Yes"] / sum(confusion["Yes", ])
f1_score <- 2 * (precision * recall) / (precision + recall)

print("Example 2 - Model performance:")
print("Confusion Matrix:")
print(confusion)
print(paste("Accuracy:", round(accuracy, 4)))
print(paste("Precision:", round(precision, 4)))
print(paste("Recall:", round(recall, 4)))
print(paste("F1 Score:", round(f1_score, 4)))

# Example 3: Feature engineering in DuckDB ----
engineered_data <- dbGetQuery(con, "
  SELECT 
    churned,
    age,
    -- Age groups
    CASE 
      WHEN age < 25 THEN 'Young'
      WHEN age < 40 THEN 'Middle'
      WHEN age < 60 THEN 'Senior'
      ELSE 'Elderly'
    END as age_group,
    -- Income groups
    CASE 
      WHEN annual_income < 40000 THEN 'Low'
      WHEN annual_income < 80000 THEN 'Medium'
      ELSE 'High'
    END as income_level,
    credit_score,
    -- Credit score categories
    CASE 
      WHEN credit_score < 500 THEN 'Poor'
      WHEN credit_score < 650 THEN 'Fair'
      WHEN credit_score < 750 THEN 'Good'
      ELSE 'Excellent'
    END as credit_category,
    years_with_bank,
    num_products,
    -- Engagement metric
    account_balance / NULLIF(annual_income, 0) as balance_to_income_ratio,
    monthly_transactions / NULLIF(num_products, 0) as transactions_per_product,
    -- Customer value score
    (account_balance * 0.3 + annual_income * 0.4 + credit_score * 0.3) as value_score
  FROM customer_data
  WHERE customer_id % 10 < 7
")

# Convert factors
engineered_data$churned <- factor(engineered_data$churned)
engineered_data$age_group <- factor(engineered_data$age_group)
engineered_data$income_level <- factor(engineered_data$income_level)
engineered_data$credit_category <- factor(engineered_data$credit_category)

tree3 <- rpart(churned ~ ., 
               data = engineered_data, 
               method = "class",
               control = rpart.control(cp = 0.001))

print("Example 3 - Tree with engineered features:")
print("Variable importance:")
print(sort(tree3$variable.importance, decreasing = TRUE))

# Example 4: Pruning with cross-validation ----
# Full tree
tree_full <- rpart(churned ~ ., 
                   data = train_data, 
                   method = "class",
                   control = rpart.control(
                     minsplit = 10,
                     cp = 0.0001,
                     maxdepth = 30
                   ))

# Find optimal CP using cross-validation
cp_table <- tree_full$cptable
optimal_cp <- cp_table[which.min(cp_table[, "xerror"]), "CP"]

print("Example 4 - Cross-validation results:")
print(cp_table)
print(paste("Optimal CP:", round(optimal_cp, 5)))

# Prune tree
tree_pruned <- prune(tree_full, cp = optimal_cp)

print("Tree sizes:")
print(paste("Full tree nodes:", sum(tree_full$frame$var == "<leaf>") * 2 - 1))
print(paste("Pruned tree nodes:", sum(tree_pruned$frame$var == "<leaf>") * 2 - 1))

# Compare performance
pred_full <- predict(tree_full, newdata = test_data, type = "class")
pred_pruned <- predict(tree_pruned, newdata = test_data, type = "class")

acc_full <- mean(pred_full == test_data$churned)
acc_pruned <- mean(pred_pruned == test_data$churned)

print("Test accuracy:")
print(paste("Full tree:", round(acc_full, 4)))
print(paste("Pruned tree:", round(acc_pruned, 4)))

# Example 5: Stratified sampling in DuckDB ----
# Ensure balanced class representation in training
stratified_train <- dbGetQuery(con, "
  WITH class_sizes AS (
    SELECT 
      churned,
      COUNT(*) as total,
      FLOOR(COUNT(*) * 0.7) as sample_size
    FROM customer_data
    GROUP BY churned
  ),
  sampled AS (
    SELECT 
      c.*,
      ROW_NUMBER() OVER (PARTITION BY c.churned ORDER BY RANDOM()) as rn
    FROM customer_data c
    JOIN class_sizes cs ON c.churned = cs.churned
  )
  SELECT 
    churned, age, gender, marital_status, annual_income,
    credit_score, years_with_bank, num_products,
    account_balance, monthly_transactions
  FROM sampled s
  JOIN class_sizes cs ON s.churned = cs.churned
  WHERE s.rn <= cs.sample_size
")

print("Example 5 - Stratified sample class distribution:")
print(table(stratified_train$churned))

# Example 6: Store predictions back in DuckDB ----
# Create predictions table
test_data$correct <- test_data$predicted == test_data$churned

# Write back to DuckDB
dbWriteTable(con, "predictions", test_data, overwrite = TRUE)

# Analyze predictions in DuckDB
prediction_analysis <- dbGetQuery(con, "
  SELECT 
    churned as actual,
    predicted,
    COUNT(*) as n,
    AVG(prob_yes) as avg_probability,
    AVG(CASE WHEN correct THEN 1 ELSE 0 END) as accuracy
  FROM predictions
  GROUP BY churned, predicted
  ORDER BY churned, predicted
")

print("Example 6 - Prediction analysis:")
print(prediction_analysis)

# Example 7: Feature importance analysis ----
importance_df <- data.frame(
  variable = names(tree2$variable.importance),
  importance = tree2$variable.importance
)
rownames(importance_df) <- NULL
importance_df <- importance_df[order(-importance_df$importance), ]

print("Example 7 - Feature importance ranking:")
print(importance_df)

# Store in DuckDB
dbWriteTable(con, "feature_importance", importance_df, overwrite = TRUE)

# Export to CSV
importance_file <- "feature_importance.csv"
dbExecute(con, sprintf("
  COPY feature_importance TO '%s' (HEADER, DELIMITER ',')
", importance_file))

print(paste("Feature importance exported to:", importance_file))

# Example 8: Regression tree (continuous outcome) ----
regression_data <- dbGetQuery(con, "
  SELECT 
    account_balance as target,
    age,
    annual_income,
    credit_score,
    years_with_bank,
    num_products,
    monthly_transactions
  FROM customer_data
  WHERE customer_id % 10 < 7
    AND account_balance IS NOT NULL
")

tree_reg <- rpart(target ~ ., 
                  data = regression_data, 
                  method = "anova",
                  control = rpart.control(cp = 0.001))

print("Example 8 - Regression tree:")
print(tree_reg)
print(paste("R²:", round(1 - tree_reg$cptable[nrow(tree_reg$cptable), "rel error"], 4)))

# Example 9: Export tree rules ----
# Extract rules from tree
rules <- rpart.rules(tree_pruned, cover = TRUE)
print("Example 9 - Tree rules (first 10):")
print(head(rules, 10))

# Example 10: Performance comparison ----
print("\n=== Performance Comparison ===")

# Method 1: Load all data, then filter in R
time_r <- system.time({
  all_data <- dbGetQuery(con, "SELECT * FROM customer_data")
  filtered_r <- all_data[all_data$age > 30 & all_data$credit_score > 500, ]
  filtered_r$churned <- factor(filtered_r$churned)
  tree_r <- rpart(churned ~ age + credit_score + account_balance, 
                  data = filtered_r, method = "class")
})

# Method 2: Filter in DuckDB
time_duckdb <- system.time({
  filtered_duckdb <- dbGetQuery(con, "
    SELECT * FROM customer_data 
    WHERE age > 30 AND credit_score > 500
  ")
  filtered_duckdb$churned <- factor(filtered_duckdb$churned)
  tree_duckdb <- rpart(churned ~ age + credit_score + account_balance, 
                       data = filtered_duckdb, method = "class")
})

print(paste("Load all then filter (R):", round(time_r["elapsed"], 4), "seconds"))
print(paste("Filter in DuckDB:", round(time_duckdb["elapsed"], 4), "seconds"))
print(paste("Speedup:", round(time_r["elapsed"] / time_duckdb["elapsed"], 2), "x"))

# Model summary ----
print("\n=== Final Model Summary ===")
print(paste("Training observations:", nrow(train_data)))
print(paste("Test observations:", nrow(test_data)))
print(paste("Number of predictors:", ncol(train_data) - 1))
print(paste("Tree depth:", max(tree_pruned$frame$var == "<leaf>") * 2 - 1))
print(paste("Final accuracy:", round(acc_pruned, 4)))

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
file.remove(importance_file)
print("\nConnection closed and files removed")
