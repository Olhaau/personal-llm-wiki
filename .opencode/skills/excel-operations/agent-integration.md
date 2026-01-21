# Agent Integration Guide for excel-operations

## Core Skill Usage for Excel Operations

**ALL AGENTS must use the excel-operations skill as the foundation for ANY Excel-related task.** This includes:

- Reading Excel files
- Writing Excel files  
- Modifying existing Excel files
- Creating reports in Excel format
- Data analysis involving Excel files
- Excel formatting and styling
- Converting between Excel and other formats

## Integration Patterns

### 1. Automatic Skill Loading
When any Excel-related request is detected, immediately load this skill:

```
User mentions: "Excel", ".xlsx", ".xls", "spreadsheet", "workbook", "worksheet"
Agent action: Load excel-operations skill and use as foundation for ALL operations
```

### 2. Standard Response Pattern

**Step 1: Acknowledge and Load Skill**
```
"I'll handle this Excel operation using R with the openxlsx2 package, which is our standard approach for Excel manipulation. This ensures the operations are transparent, reproducible, and can be reviewed by humans."
```

**Step 2: Show the R Code**
```r
# Always provide the complete R script
library(openxlsx2)

# [Complete working code here]
```

**Step 3: Explain the Approach**
```
"Here's what this code does:
1. [Step 1 explanation]
2. [Step 2 explanation]
3. [Step 3 explanation]"
```

**Step 4: Offer Script for Reuse**
```
"I can save this script for you to reuse and modify as needed. Would you like me to create a standalone R script file?"
```

### 3. Human-Centric Communication

**Always explain WHY R is being used:**
- "Using R ensures you can see exactly what operations are performed"
- "This approach allows you to modify the parameters and rerun if needed"  
- "The script serves as documentation of what was done to your Excel files"
- "You can automate this process in the future using this same code"

**Make code understandable:**
- Add extensive comments explaining each operation
- Use descriptive variable names
- Break complex operations into clear steps
- Explain any Excel-specific terminology

**Offer learning opportunities:**
- "Would you like me to explain any part of the R code?"
- "I can walk you through how the openxlsx2 functions work"
- "This is a great example of how R can handle Excel tasks programmatically"

## Required Elements in Every Excel Response

### 1. Complete Working Script
```r
# ---- [Task Description] ----
library(openxlsx2)

# Clear and commented code that accomplishes the task
# [Full implementation]

# Save results
wb_save(wb, "output.xlsx")
message("Task completed successfully!")
```

### 2. Step-by-Step Explanation
```
The script performs these operations:
1. [First major operation with explanation]
2. [Second major operation with explanation]  
3. [Final steps and output]
```

### 3. Human Modification Guidance
```
To modify this for your specific needs:
- Change 'input_file' to your Excel file path
- Adjust the data range in 'dims = "A1:E10"' 
- Modify styling parameters like colors and fonts
- Add additional worksheets by repeating the add_worksheet() pattern
```

### 4. Script Availability
```
Would you like me to:
- Save this as a reusable R script file?
- Create a parameterized version for different inputs?
- Add additional error handling for production use?
- Explain any specific part in more detail?
```

## Error Handling Patterns

### When Excel Files Don't Exist
```r
# Always include file existence checks
if (!file.exists(input_file)) {
  stop("Input file not found: ", input_file)
}
```

### When Operations Fail
```r
# Wrap operations in try-catch for better error messages
tryCatch({
  wb <- wb_load(input_file)
}, error = function(e) {
  stop("Could not load Excel file. Please check if the file is valid and not open in Excel.")
})
```

### When Paths Are Invalid
```r
# Validate output paths
output_dir <- dirname(output_file)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  message("Created output directory: ", output_dir)
}
```

## Examples of Required Responses

### User Request: "Can you read this Excel file?"

**Agent Response:**
```
I'll read your Excel file using R with openxlsx2, our standard approach for Excel operations. This ensures transparency and reproducibility.

```r
# ---- Read Excel File ----
library(openxlsx2)

# Load the Excel file
wb <- wb_load("your_file.xlsx")

# Convert to data frame for analysis
df <- wb_to_df(wb)

# Display basic information
cat("File loaded successfully!\n")
cat("Sheets:", wb_get_sheet_names(wb), "\n")
cat("Dimensions:", nrow(df), "rows,", ncol(df), "columns\n")

# Show first few rows
head(df)
```

This approach allows you to:
- See exactly what data was read
- Modify the code to read specific sheets or ranges
- Add this to your own R analysis workflow
- Reproduce the exact same results later

Would you like me to save this as a reusable script or modify it to read specific parts of your Excel file?
```

### User Request: "Format this data in Excel"

**Agent Response:**
```
I'll create a formatted Excel file using R with openxlsx2. This ensures professional formatting that you can reproduce and modify.

```r
# ---- Format Data in Excel ----
library(openxlsx2)

# Create formatted workbook
wb <- wb_workbook() %>%
  wb_add_worksheet("Formatted Data") %>%
  wb_add_data(x = your_data, dims = "A1")

# Apply professional formatting
wb %>%
  # Header formatting
  wb_add_font(dims = "A1:E1", bold = TRUE, size = 12) %>%
  wb_add_fill(dims = "A1:E1", color = wb_color("#4472C4")) %>%
  wb_add_font(dims = "A1:E1", color = wb_color("white")) %>%
  
  # Data formatting
  wb_set_col_widths(cols = 1:5, widths = "auto") %>%
  wb_add_border(dims = "A1:E10", top_style = "thin", 
                bottom_style = "thin", left_style = "thin", right_style = "thin")

# Save the formatted file
wb_save(wb, "formatted_data.xlsx")
```

This creates a professionally formatted Excel file with:
1. Bold blue headers with white text
2. Auto-sized columns for readability  
3. Clean borders around the data
4. Proper spacing and alignment

The script can be easily modified to:
- Change colors by adjusting wb_color() values
- Add different formatting to specific columns
- Include additional worksheets or styling
- Automate the process for multiple datasets

Would you like me to customize the formatting further or create a reusable template?
```

## Skill Integration Checklist

For every Excel-related response, agents must:

- [ ] Load R-Excel-openxlsx2 skill
- [ ] Provide complete, runnable R code
- [ ] Explain why R approach is used
- [ ] Break down the code steps clearly
- [ ] Include error handling where appropriate
- [ ] Offer script customization guidance
- [ ] Ask about saving script for reuse
- [ ] Use human-friendly variable names and comments
- [ ] Verify the solution addresses the user's need
- [ ] Mention advantages of programmatic approach

This ensures consistent, transparent, and educational Excel handling across all agent interactions.