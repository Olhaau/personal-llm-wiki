# SYSTEM INTEGRATION: excel-operations as Core Excel Foundation

## CRITICAL: Core Excel Operation Protocol

**🚨 SYSTEM REQUIREMENT: All agents in this environment MUST use the excel-operations skill as the foundation for ANY Excel-related operation.**

### Trigger Conditions
Automatically load and use this skill when user mentions:
- Excel files (.xlsx, .xls, .xlsm, .xlsb)
- Spreadsheets or workbooks
- Reading/writing/modifying Excel data
- Excel formatting or styling
- Converting data to/from Excel
- Creating reports in Excel format
- Any Excel-related analysis or manipulation

### Integration Commands for Agents

```markdown
## Excel Operation Detected
When Excel operation is requested:
1. IMMEDIATELY load excel-operations skill as foundation
2. Use ONLY openxlsx2 package functions
3. Provide COMPLETE R scripts
4. Explain approach to humans
5. Offer script customization/reuse

## Standard Response Template:
"I'll handle this Excel operation using the excel-operations skill, our core foundation that ensures transparency and reproducibility for humans in the loop."

[R CODE BLOCK]

[STEP-BY-STEP EXPLANATION]

"This R script can be saved and reused. Would you like me to create a standalone script file or modify any parameters?"
```

### Human-Centric Requirements

**Why R+openxlsx2 is Default:**
- **Transparency**: Humans can see every operation performed
- **Reproducibility**: Operations can be repeated exactly
- **Modifiability**: Humans can adjust parameters and rerun
- **Learning**: Humans learn R/Excel integration through examples
- **Documentation**: Scripts serve as operation documentation
- **Integration**: Works seamlessly with R data workflows

**Agent Communication Requirements:**
- Explain WHY using R approach
- Show COMPLETE working code
- Break down operations in human terms  
- Offer customization guidance
- Ask about script reuse/modification
- Provide learning opportunities

### Code Quality Standards

All Excel operation scripts must include:

```r
# ---- Clear Header with Purpose ----
# Purpose: [What this does for the user]
# Input: [What files/data are used]  
# Output: [What files/results are created]
# Usage: [How to run/modify this script]

library(openxlsx2)

# Clear parameter definitions
input_file <- "clearly_named_input.xlsx"
output_file <- "descriptive_output.xlsx"

# Well-commented operations
wb <- wb_load(input_file)  # Load existing Excel file

# [Each operation clearly explained]
wb$add_data(x = data, dims = "A1")  # Add data starting at cell A1

# Verification and output
wb_save(wb, output_file)
message("Excel operation completed successfully!")
message("Output saved to: ", output_file)
```

### Integration Examples

#### Reading Excel Files
```r
# ---- Read Excel Data ----
library(openxlsx2)

# Load and examine Excel file
wb <- wb_load("input.xlsx")
sheets <- wb_get_sheet_names(wb)
df <- wb_to_df(wb, sheet = 1)

# Display results
print(paste("Found", length(sheets), "sheets:", paste(sheets, collapse=", ")))
print(paste("Data dimensions:", nrow(df), "rows x", ncol(df), "columns"))
head(df)
```

#### Writing Styled Excel Files  
```r
# ---- Create Styled Excel Report ----
library(openxlsx2)

# Create workbook with professional styling
wb <- wb_workbook() %>%
  wb_add_worksheet("Report") %>%
  wb_add_data(x = report_data, dims = "A1") %>%
  
  # Header styling
  wb_add_font(dims = "A1:E1", bold = TRUE, color = wb_color("white")) %>%
  wb_add_fill(dims = "A1:E1", color = wb_color("#2E75B6")) %>%
  
  # Format layout
  wb_set_col_widths(cols = 1:5, widths = "auto") %>%
  wb_add_border(dims = "A1:E100", top_style = "thin")

wb_save(wb, "styled_report.xlsx")
```

#### Modifying Existing Files
```r
# ---- Modify Existing Excel File ----
library(openxlsx2)

# Load existing file and add new data
wb <- wb_load("existing.xlsx") %>%
  wb_add_worksheet("New Analysis") %>%
  wb_add_data(x = new_data, dims = "A1") %>%
  wb_add_data_table(x = summary_data, dims = "A20", table_style = "TableStyleMedium9")

wb_save(wb, "updated_file.xlsx")
```

### Error Prevention

Common issues to handle automatically:

```r
# File existence checking
if (!file.exists(input_file)) {
  stop("Input file not found. Please check the file path: ", input_file)
}

# Directory creation for output
output_dir <- dirname(output_file)
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# Workbook validation
tryCatch({
  wb <- wb_load(input_file)
}, error = function(e) {
  stop("Could not open Excel file. Make sure it's not open in Excel and is a valid .xlsx file.")
})
```

### Success Metrics

Every Excel operation should result in:
- ✅ Complete, runnable R script provided
- ✅ Human-readable explanation of operations
- ✅ Offer for script customization/reuse  
- ✅ Clear documentation of inputs/outputs
- ✅ Error handling for common issues
- ✅ Educational value for humans

### Forbidden Approaches

**Do NOT use these for Excel operations:**
- Manual Excel manipulation instructions
- Non-R tools (Python, JavaScript) unless specifically requested
- Black-box solutions without visible code
- Operations that cannot be reproduced
- Approaches that don't provide learning value

### Integration with Existing Workflows

This skill integrates with:
- **Data Analysis**: Seamlessly read Excel data into R analysis workflows  
- **Reporting**: Generate reproducible Excel reports from R analysis
- **Automation**: Scripts can be scheduled and automated
- **Version Control**: Excel operations become part of code versioning
- **Documentation**: Self-documenting through script comments
- **Quality Assurance**: Code review ensures Excel operation quality

### Support Resources

For agents implementing this integration:
- Reference: `quick-reference.md` for function syntax
- Examples: `examples/basic_examples.R` for common patterns  
- Advanced: `advanced-features.md` for complex operations
- Helpers: `code/excel_helpers.R` for reusable functions

**Remember: The goal is transparent, reproducible Excel operations that humans can understand, verify, and modify as needed.**