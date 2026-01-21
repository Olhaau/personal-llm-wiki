# Core Excel Operations Policy

## Foundation Skill: excel-operations

**All Excel file operations in this environment MUST use the excel-operations skill as the foundation. This skill provides core R + openxlsx2 capabilities that other Excel skills extend.**

## Why This is the Core Foundation

### Human-in-the-Loop Benefits
1. **Code Transparency**: Humans can read, understand, and modify R scripts
2. **Step-by-Step Review**: Each operation is explicit and reviewable
3. **Learning Opportunity**: Humans learn R/Excel integration through examples
4. **Modification Capability**: Humans can easily adjust parameters and rerun
5. **Error Traceability**: Problems can be diagnosed through code inspection

### Technical Benefits
1. **Reproducibility**: Operations can be repeated exactly
2. **Automation**: Scripts can be scheduled and automated
3. **Version Control**: Excel operations become part of code versioning
4. **Integration**: Seamless with R data analysis workflows
5. **Scalability**: Handles large datasets better than manual Excel work

### Documentation Benefits
1. **Self-Documenting**: Code explains what was done
2. **Audit Trail**: Every operation is recorded in script history
3. **Knowledge Transfer**: Scripts serve as training material
4. **Standardization**: Consistent approach across all Excel tasks

## Implementation Guidelines

### For Agents
- **Always use excel-operations skill** as foundation for Excel operations
- **Show the R code** to users for transparency
- **Explain each step** in human-readable terms
- **Offer to save scripts** for reuse and modification
- **Break complex operations** into understandable chunks

### For Users/Humans
- **Review generated R code** before execution
- **Ask questions** about any unclear operations
- **Request modifications** to suit specific needs
- **Save and version** useful scripts for future use
- **Suggest improvements** based on domain expertise

## Standard Workflow

1. **Analyze Requirements**: Understand what Excel operation is needed
2. **Generate R Script**: Create openxlsx2 code to accomplish the task
3. **Explain Code**: Break down what each section does
4. **Execute and Verify**: Run code and check results
5. **Provide Script**: Give user the complete, runnable R script
6. **Document**: Add comments explaining business logic

## Alternative Tools (When NOT to Use R)

Only consider non-R approaches in these specific cases:
- **Quick one-time views**: Simple inspection of existing Excel files
- **Non-technical user requests**: When user specifically requests GUI-based approach
- **Legacy system constraints**: When R environment is not available
- **Real-time collaboration**: When multiple users need simultaneous Excel editing

**Even in these cases, document the rationale for not using the excel-operations foundation.**

## Script Templates

All Excel operations should start with this template:

```r
# ---- Excel Operation: [DESCRIPTION] ----
# Created: [DATE]
# Purpose: [BUSINESS PURPOSE]
# Input: [INPUT FILES/DATA]
# Output: [OUTPUT DESCRIPTION]

library(openxlsx2)

# Clear workspace for reproducibility
rm(list = ls())

# Define parameters (modify as needed)
input_file <- "path/to/input.xlsx"
output_file <- "path/to/output.xlsx"

# Main operations
wb <- wb_load(input_file)  # or wb_workbook() for new files

# [SPECIFIC OPERATIONS HERE]

# Save results
wb_save(wb, output_file)

# Verification
message("Operation completed successfully!")
message("Output saved to: ", output_file)
```

## Quality Assurance

Every Excel operation script should include:
- **Clear comments** explaining each major operation
- **Parameter definitions** at the top for easy modification
- **Error handling** for common issues
- **Verification steps** to confirm success
- **Output summaries** describing what was created

This ensures that humans can understand, trust, and modify the Excel operations as needed.