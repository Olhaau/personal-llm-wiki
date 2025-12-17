# Grouped Counts with DuckDB
# ============================================================
# This script demonstrates various counting and grouping operations

suppressPackageStartupMessages({
  library(DBI)
  library(duckdb)
})

# Setup ----
con <- dbConnect(duckdb::duckdb())

# Create example dataset ----
dbExecute(con, "
  CREATE TABLE sales AS
  SELECT
    (RANGE / 100) + 1 as customer_id,
    RANGE as transaction_id,
    CASE 
      WHEN RANGE % 5 = 0 THEN 'Electronics'
      WHEN RANGE % 5 = 1 THEN 'Clothing'
      WHEN RANGE % 5 = 2 THEN 'Food'
      WHEN RANGE % 5 = 3 THEN 'Books'
      ELSE 'Home & Garden'
    END as category,
    CASE
      WHEN RANGE % 4 = 0 THEN 'North'
      WHEN RANGE % 4 = 1 THEN 'South'
      WHEN RANGE % 4 = 2 THEN 'East'
      ELSE 'West'
    END as region,
    DATE '2024-01-01' + INTERVAL (RANGE % 365) DAY as sale_date,
    (RANDOM() * 100 + 10) as amount
  FROM RANGE(1, 10001)
")

print("Sample data created:")
preview <- dbGetQuery(con, "SELECT * FROM sales LIMIT 5")
print(preview)

# Example 1: Simple count by single column ----
count1 <- dbGetQuery(con, "
  SELECT 
    category,
    COUNT(*) as n
  FROM sales
  GROUP BY category
  ORDER BY n DESC
")

print("Example 1 - Count by category:")
print(count1)

# Example 2: Count by multiple columns ----
count2 <- dbGetQuery(con, "
  SELECT 
    category,
    region,
    COUNT(*) as n
  FROM sales
  GROUP BY category, region
  ORDER BY category, region
")

print("Example 2 - Count by category and region:")
print(head(count2, 10))

# Example 3: Count with percentage ----
count3 <- dbGetQuery(con, "
  SELECT 
    category,
    COUNT(*) as n,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as pct
  FROM sales
  GROUP BY category
  ORDER BY n DESC
")

print("Example 3 - Count with percentage:")
print(count3)

# Example 4: Count distinct values ----
count4 <- dbGetQuery(con, "
  SELECT 
    category,
    COUNT(*) as total_transactions,
    COUNT(DISTINCT customer_id) as unique_customers,
    COUNT(*) / COUNT(DISTINCT customer_id) as transactions_per_customer
  FROM sales
  GROUP BY category
  ORDER BY unique_customers DESC
")

print("Example 4 - Count with distinct:")
print(count4)

# Example 5: Conditional counting ----
count5 <- dbGetQuery(con, "
  SELECT 
    region,
    COUNT(*) as total_sales,
    COUNT(CASE WHEN amount > 50 THEN 1 END) as high_value_sales,
    COUNT(CASE WHEN amount <= 50 THEN 1 END) as low_value_sales,
    ROUND(
      COUNT(CASE WHEN amount > 50 THEN 1 END) * 100.0 / COUNT(*), 
      2
    ) as pct_high_value
  FROM sales
  GROUP BY region
  ORDER BY region
")

print("Example 5 - Conditional counting:")
print(count5)

# Example 6: Time-based counting ----
count6 <- dbGetQuery(con, "
  SELECT 
    DATE_TRUNC('month', sale_date) as month,
    category,
    COUNT(*) as transactions,
    COUNT(DISTINCT customer_id) as customers
  FROM sales
  WHERE sale_date >= '2024-01-01' 
    AND sale_date < '2024-04-01'
  GROUP BY month, category
  ORDER BY month, category
")

print("Example 6 - Monthly counts (first quarter):")
print(head(count6, 12))

# Example 7: Filtering groups with HAVING ----
count7 <- dbGetQuery(con, "
  SELECT 
    customer_id,
    COUNT(*) as purchase_count,
    COUNT(DISTINCT category) as categories_purchased
  FROM sales
  GROUP BY customer_id
  HAVING COUNT(*) > 50
  ORDER BY purchase_count DESC
  LIMIT 10
")

print("Example 7 - High-frequency customers (>50 purchases):")
print(count7)

# Example 8: Rolling counts (running totals) ----
count8 <- dbGetQuery(con, "
  WITH daily_counts AS (
    SELECT 
      DATE_TRUNC('day', sale_date) as date,
      COUNT(*) as daily_transactions
    FROM sales
    WHERE sale_date >= '2024-01-01' 
      AND sale_date < '2024-01-15'
    GROUP BY date
  )
  SELECT 
    date,
    daily_transactions,
    SUM(daily_transactions) OVER (
      ORDER BY date 
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as cumulative_transactions
  FROM daily_counts
  ORDER BY date
")

print("Example 8 - Daily and cumulative counts:")
print(count8)

# Example 9: Cross-tabulation (pivot) ----
count9 <- dbGetQuery(con, "
  SELECT 
    category,
    COUNT(CASE WHEN region = 'North' THEN 1 END) as North,
    COUNT(CASE WHEN region = 'South' THEN 1 END) as South,
    COUNT(CASE WHEN region = 'East' THEN 1 END) as East,
    COUNT(CASE WHEN region = 'West' THEN 1 END) as West,
    COUNT(*) as Total
  FROM sales
  GROUP BY category
  ORDER BY category
")

print("Example 9 - Cross-tabulation (category × region):")
print(count9)

# Example 10: Grouped counts with ranking ----
count10 <- dbGetQuery(con, "
  WITH category_counts AS (
    SELECT 
      region,
      category,
      COUNT(*) as n
    FROM sales
    GROUP BY region, category
  )
  SELECT 
    region,
    category,
    n,
    RANK() OVER (PARTITION BY region ORDER BY n DESC) as rank_in_region
  FROM category_counts
  WHERE n > 100
  ORDER BY region, rank_in_region
")

print("Example 10 - Category rankings within each region:")
print(head(count10, 15))

# Example 11: Count with binning ----
count11 <- dbGetQuery(con, "
  SELECT 
    CASE 
      WHEN amount < 30 THEN '0-30'
      WHEN amount < 60 THEN '30-60'
      WHEN amount < 90 THEN '60-90'
      ELSE '90+'
    END as amount_bin,
    COUNT(*) as transactions,
    ROUND(AVG(amount), 2) as avg_amount
  FROM sales
  GROUP BY amount_bin
  ORDER BY amount_bin
")

print("Example 11 - Counts by amount bins:")
print(count11)

# Example 12: GROUPING SETS for multiple aggregation levels ----
count12 <- dbGetQuery(con, "
  SELECT 
    category,
    region,
    COUNT(*) as n
  FROM sales
  GROUP BY GROUPING SETS (
    (category, region),
    (category),
    (region),
    ()
  )
  ORDER BY category, region
  LIMIT 15
")

print("Example 12 - Multiple aggregation levels with GROUPING SETS:")
print(count12)

# Performance comparison ----
print("\n=== Performance Comparison ===")

# Load all data into R
time_r <- system.time({
  all_data <- dbGetQuery(con, "SELECT * FROM sales")
  result_r <- table(all_data$category, all_data$region)
})

# Do counting in DuckDB
time_duckdb <- system.time({
  result_duckdb <- dbGetQuery(con, "
    SELECT category, region, COUNT(*) as n
    FROM sales
    GROUP BY category, region
  ")
})

print(paste("R (in-memory):", round(time_r["elapsed"], 4), "seconds"))
print(paste("DuckDB (SQL):", round(time_duckdb["elapsed"], 4), "seconds"))
print(paste("DuckDB is", round(time_r["elapsed"] / time_duckdb["elapsed"], 2), "x faster"))

# Cleanup ----
dbDisconnect(con, shutdown = TRUE)
print("\nConnection closed")
