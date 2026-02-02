# ---- Sample Datasets for Excel Skill Testing ----

# Load required libraries
suppressPackageStartupMessages(library(datasets))

# ---- Financial Data ----
create_financial_data <- function() {
  data.frame(
    Quarter = c("Q1 2023", "Q2 2023", "Q3 2023", "Q4 2023", "Q1 2024", "Q2 2024"),
    Revenue = c(1250000, 1400000, 1600000, 1800000, 1950000, 2100000),
    Costs = c(750000, 850000, 950000, 1100000, 1200000, 1300000),
    Profit = c(500000, 550000, 650000, 700000, 750000, 800000),
    Margin = c(0.40, 0.39, 0.41, 0.39, 0.38, 0.38),
    Employees = c(45, 48, 52, 55, 58, 62)
  )
}

# ---- Sales Performance Data ----
create_sales_data <- function() {
  set.seed(123)  # For reproducible random data
  
  salespeople <- c("Alice Johnson", "Bob Smith", "Charlie Brown", "Diana Prince", 
                   "Eva Garcia", "Frank Miller", "Grace Lee", "Henry Wilson")
  
  data.frame(
    Salesperson = salespeople,
    Region = rep(c("North", "South", "East", "West"), 2),
    Q1_Sales = round(runif(8, 80000, 150000)),
    Q2_Sales = round(runif(8, 85000, 160000)),
    Q3_Sales = round(runif(8, 90000, 170000)),
    Q4_Sales = round(runif(8, 95000, 180000)),
    Target = rep(c(120000, 130000, 125000, 135000), 2),
    Commission_Rate = rep(c(0.05, 0.06, 0.055, 0.065), 2),
    Hire_Date = seq(as.Date("2020-01-15"), by = "3 months", length.out = 8)
  )
}

# ---- Product Inventory Data ----
create_inventory_data <- function() {
  data.frame(
    Product_ID = paste0("P", sprintf("%03d", 1:20)),
    Product_Name = c(
      "Wireless Headphones", "Smartphone Case", "USB Cable", "Bluetooth Speaker",
      "Laptop Stand", "Wireless Mouse", "Keyboard", "Monitor", "Webcam", 
      "Tablet", "Power Bank", "Desk Lamp", "Chair", "Notebook", "Pen Set",
      "Calculator", "Paper Shredder", "Printer", "Scanner", "External Drive"
    ),
    Category = rep(c("Electronics", "Accessories", "Office", "Furniture"), 5),
    Unit_Price = c(79.99, 24.99, 12.99, 149.99, 89.99, 34.99, 89.99, 299.99, 69.99, 399.99,
                   49.99, 59.99, 299.99, 4.99, 19.99, 29.99, 199.99, 249.99, 179.99, 99.99),
    Stock_Quantity = c(45, 120, 200, 25, 30, 75, 40, 15, 35, 20, 85, 50, 12, 300, 150,
                       80, 8, 18, 22, 60),
    Reorder_Level = c(10, 50, 75, 5, 8, 25, 15, 5, 10, 5, 20, 15, 3, 100, 50,
                      20, 2, 5, 5, 15),
    Supplier = rep(c("TechCorp", "OfficeSupply Inc", "ElectroWorld", "FurniturePlus"), 5),
    Last_Ordered = seq(Sys.Date() - 60, Sys.Date() - 1, length.out = 20)
  )
}

# ---- Customer Satisfaction Data ----
create_satisfaction_data <- function() {
  set.seed(456)
  
  data.frame(
    Survey_ID = paste0("S", sprintf("%04d", 1:50)),
    Customer_Type = sample(c("Premium", "Standard", "Basic"), 50, replace = TRUE, prob = c(0.2, 0.6, 0.2)),
    Service_Rating = sample(1:5, 50, replace = TRUE, prob = c(0.02, 0.08, 0.15, 0.35, 0.4)),
    Product_Quality = sample(1:5, 50, replace = TRUE, prob = c(0.01, 0.04, 0.15, 0.4, 0.4)),
    Support_Rating = sample(1:5, 50, replace = TRUE, prob = c(0.03, 0.07, 0.2, 0.35, 0.35)),
    Overall_Satisfaction = sample(1:5, 50, replace = TRUE, prob = c(0.02, 0.06, 0.12, 0.4, 0.4)),
    Likelihood_Recommend = sample(0:10, 50, replace = TRUE, prob = c(0.01, 0.01, 0.02, 0.03, 0.04, 0.05, 0.1, 0.15, 0.2, 0.25, 0.14)),
    Survey_Date = sample(seq(Sys.Date() - 90, Sys.Date(), by = "day"), 50),
    Age_Group = sample(c("18-25", "26-35", "36-45", "46-55", "56+"), 50, replace = TRUE),
    Purchase_Frequency = sample(c("Weekly", "Monthly", "Quarterly", "Annually"), 50, replace = TRUE, prob = c(0.1, 0.4, 0.35, 0.15))
  )
}

# ---- Time Series Data ----
create_timeseries_data <- function() {
  dates <- seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "month")
  
  data.frame(
    Month = dates,
    Website_Visits = round(runif(12, 50000, 100000)),
    New_Customers = round(runif(12, 500, 1200)),
    Conversion_Rate = round(runif(12, 0.02, 0.08), 4),
    Average_Order_Value = round(runif(12, 75, 150), 2),
    Customer_Retention = round(runif(12, 0.65, 0.85), 3),
    Marketing_Spend = round(runif(12, 15000, 35000)),
    Social_Media_Engagement = round(runif(12, 2000, 8000))
  )
}

# ---- Product Performance Matrix ----
create_performance_matrix <- function() {
  products <- c("Product A", "Product B", "Product C", "Product D", "Product E")
  months <- month.abb
  
  # Create a matrix of sales data
  sales_matrix <- matrix(
    round(runif(60, 1000, 5000)), 
    nrow = 5, 
    ncol = 12,
    dimnames = list(products, months)
  )
  
  # Convert to data frame with product names as first column
  performance_df <- data.frame(
    Product = products,
    sales_matrix,
    stringsAsFactors = FALSE
  )
  
  return(performance_df)
}

# ---- Employee Data ----
create_employee_data <- function() {
  set.seed(789)
  
  departments <- c("Sales", "Marketing", "Engineering", "Support", "Finance", "HR")
  
  data.frame(
    Employee_ID = paste0("E", sprintf("%03d", 1:30)),
    Name = paste(
      sample(c("John", "Jane", "Michael", "Sarah", "David", "Lisa", "Robert", "Emma", "James", "Maria"), 30, replace = TRUE),
      sample(c("Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez"), 30, replace = TRUE)
    ),
    Department = sample(departments, 30, replace = TRUE),
    Position = sample(c("Manager", "Senior", "Associate", "Junior", "Intern"), 30, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.25, 0.05)),
    Salary = round(runif(30, 45000, 120000), -3),  # Round to nearest thousand
    Performance_Score = sample(1:5, 30, replace = TRUE, prob = c(0.05, 0.1, 0.25, 0.4, 0.2)),
    Years_Experience = sample(1:15, 30, replace = TRUE),
    Start_Date = sample(seq(as.Date("2018-01-01"), as.Date("2023-12-31"), by = "day"), 30),
    Remote_Work = sample(c("Full Remote", "Hybrid", "On-site"), 30, replace = TRUE, prob = c(0.3, 0.4, 0.3)),
    Training_Hours = round(runif(30, 10, 80))
  )
}

# ---- Data Loading Function ----
load_all_sample_data <- function() {
  list(
    financial = create_financial_data(),
    sales = create_sales_data(),
    inventory = create_inventory_data(),
    satisfaction = create_satisfaction_data(),
    timeseries = create_timeseries_data(),
    performance_matrix = create_performance_matrix(),
    employees = create_employee_data()
  )
}

# ---- Data Descriptions ----
data_descriptions <- list(
  financial = "Quarterly financial performance data including revenue, costs, profit, and key metrics",
  sales = "Sales team performance data with individual targets, regional assignments, and quarterly results",
  inventory = "Product inventory management data with stock levels, pricing, and supplier information",
  satisfaction = "Customer satisfaction survey results with ratings across multiple service dimensions",
  timeseries = "Monthly business metrics time series data for trend analysis and visualization",
  performance_matrix = "Product performance matrix suitable for heat maps and comparative analysis",
  employees = "Employee directory with salary, performance, and demographic information for HR analysis"
)

# Function to get data with description
get_sample_data <- function(dataset_name) {
  all_data <- load_all_sample_data()
  
  if (dataset_name %in% names(all_data)) {
    cat("Dataset:", dataset_name, "\n")
    cat("Description:", data_descriptions[[dataset_name]], "\n")
    cat("Dimensions:", nrow(all_data[[dataset_name]]), "rows x", ncol(all_data[[dataset_name]]), "columns\n\n")
    return(all_data[[dataset_name]])
  } else {
    cat("Available datasets:", paste(names(all_data), collapse = ", "), "\n")
    return(NULL)
  }
}