# Skill Extension Guide - Building on excel-operations

## Overview

The `excel-operations` skill serves as the **core foundation** for all Excel-related operations. Other skills should build upon this foundation rather than recreate Excel functionality from scratch.

## Why Build on excel-operations?

### ✅ Benefits of Extension Pattern
- **Consistency**: All Excel operations use the same R + openxlsx2 approach
- **Maintainability**: Core functionality updates benefit all extending skills
- **Human Readability**: Consistent patterns for humans in the loop
- **Code Reuse**: Leverage tested helper functions and templates
- **Integration**: Seamless workflow with other Excel operations

### ❌ Avoid Duplicating Core Operations
- Don't reimplement basic read/write operations
- Don't create separate Excel styling approaches  
- Don't bypass the transparent R script requirement
- Don't use non-R tools for Excel manipulation

## Extension Patterns

### 1. Import Core Functionality

Start your skill by importing excel-operations capabilities:

```r
# At the beginning of your skill's R scripts
source("../.opencode/skills/excel-operations/code/excel_helpers.R")

# Use core functions
wb <- create_styled_workbook()  # From excel-operations
wb <- format_data_table(wb, "Sheet1", data)  # From excel-operations
```

### 2. Reference Core Skill in Documentation

In your skill's SKILL.md file:

```markdown
---
name: "your-excel-skill"
description: "Specialized Excel operations building on excel-operations foundation"
dependencies: ["excel-operations"]
---

# Your Excel Skill

## Foundation

This skill extends the **excel-operations** skill for specialized use cases.
See `.opencode/skills/excel-operations/` for core Excel functionality.

## When to Use This Skill

Use this skill for [specific use case] after ensuring excel-operations 
provides the foundation capabilities.
```

### 3. Extend Rather Than Replace

Build on top of core operations:

```r
# ✅ GOOD: Extend core functionality
specialized_excel_report <- function(data, template_type) {
  # Use core workbook creation
  wb <- create_styled_workbook()  # From excel-operations
  
  # Add your specialized functionality
  if (template_type == "financial") {
    wb <- add_financial_formatting(wb, data)  # Your extension
  }
  
  # Use core saving
  wb_save(wb, output_path)
}

# ❌ BAD: Reimplementing core functionality
bad_excel_function <- function() {
  library(openxlsx2)  # Don't recreate this foundation
  wb <- wb_workbook()  # Don't reimplement basic operations
  # ... duplicated code
}
```

## Skill Structure Template

### Directory Organization
```
your-excel-skill/
├── SKILL.md                    # References excel-operations as foundation
├── domain-operations.md        # Your specialized operations
├── examples/
│   └── domain_examples.R       # Uses excel-operations + your extensions
├── code/
│   └── domain_helpers.R        # Imports excel-operations helpers
└── templates/
    └── domain_templates.R      # Built on excel-operations foundation
```

### Skill Definition Template

```markdown
---
name: "your-excel-skill"
description: "Domain-specific Excel operations extending excel-operations core"
dependencies: ["excel-operations"]
---

# Your Domain Excel Operations

## Foundation Dependency

**Requires**: excel-operations skill for core Excel functionality
**Extends**: Basic operations with [domain-specific] capabilities

## When to Use This Skill

Use this skill for [specific domain] Excel operations:
- [Specific use case 1] building on excel-operations
- [Specific use case 2] extending core functionality
- [Specific use case 3] with domain expertise

## Core + Extension Pattern

```r
# Import foundation
source("excel-operations/code/excel_helpers.R")

# Create with core operations
wb <- create_styled_workbook()

# Extend with domain functionality  
wb <- add_domain_specific_features(wb, domain_data)

# Save using core operations
wb_save(wb, output_path)
```

## Extension Examples

### Financial Reporting Skill
```markdown
Dependencies: ["excel-operations"]

Extends core operations with:
- Financial statement templates
- Accounting number formats  
- Regulatory compliance formatting
- Financial chart types
```

### Scientific Data Skill  
```markdown
Dependencies: ["excel-operations"]

Extends core operations with:
- Laboratory data templates
- Scientific notation handling
- Measurement unit formatting
- Research chart types
```

### Project Management Skill
```markdown  
Dependencies: ["excel-operations"]

Extends core operations with:
- Gantt chart creation
- Project timeline formatting
- Resource allocation tables
- Status tracking templates
```

## Integration Requirements

### Code Standards
- **Always import excel-operations helpers**: Don't reimplement core functions
- **Use consistent R patterns**: Follow excel-operations code style
- **Maintain transparency**: All operations visible in R scripts
- **Provide human explanations**: Same educational approach as core skill

### Documentation Standards
- **Reference foundation**: Clearly state dependency on excel-operations  
- **Show integration**: Demonstrate how core + extension work together
- **Avoid duplication**: Don't redocument core Excel operations
- **Focus on value-add**: Document what your skill adds beyond core

### User Experience Standards
- **Seamless workflow**: Users shouldn't need to switch between skills manually
- **Consistent patterns**: Same R script transparency and modification approach
- **Clear boundaries**: Obvious what's core vs. specialized functionality
- **Learning progression**: Skills build naturally on core knowledge

## Testing Integration

Your skill tests should verify integration with excel-operations:

```r
# Test that core functionality is available
test_core_integration <- function() {
  # Should be able to use excel-operations functions
  wb <- create_styled_workbook()  # From core skill
  
  # Add your specialized functionality
  wb <- add_your_extension(wb, test_data)
  
  # Verify combination works
  output_path <- "test_integration.xlsx"
  wb_save(wb, output_path)
  
  # Verify file is readable by core skill
  wb_loaded <- wb_load(output_path)  # Core function should work
  
  expect_true(file.exists(output_path))
  expect_true(length(wb_get_sheet_names(wb_loaded)) > 0)
}
```

## Communication Pattern

When your skill is used, communicate the foundation dependency:

```
"I'll handle this [domain-specific] Excel operation using the excel-operations 
skill as the foundation, then add specialized [domain] functionality on top."

[Show R code that clearly uses both core + extension]

"This approach ensures you get the reliable Excel operations foundation 
plus the specialized features needed for [domain]."
```

## Anti-Patterns to Avoid

### ❌ Skill Isolation
```r
# DON'T create independent Excel operations
my_skill_excel_function <- function() {
  library(openxlsx2)
  wb <- wb_workbook()  # Duplicating core functionality
  # ...
}
```

### ❌ Hidden Dependencies  
```markdown
# DON'T hide that you use excel-operations
# DO clearly state dependency
dependencies: ["excel-operations"]
```

### ❌ Non-R Excel Operations
```python
# DON'T use other tools for Excel in extending skills  
import openpyxl  # Breaks the R + openxlsx2 foundation
```

### ❌ Inconsistent Patterns
```r
# DON'T use different variable naming or patterns
workbook <- openxlsx2::wb_workbook()  # Inconsistent with wb naming
```

## Success Criteria

Your skill successfully extends excel-operations when:

- ✅ Uses excel-operations helper functions without modification
- ✅ Produces Excel files readable by excel-operations functions  
- ✅ Follows same R script transparency patterns
- ✅ Provides clear human explanations of extensions
- ✅ Can be combined with other excel-operations extensions
- ✅ Maintains consistent code style and variable naming
- ✅ Adds clear value beyond core functionality

## Getting Help

When building extensions:
1. **Review excel-operations examples**: See `excel-operations/examples/`
2. **Use helper functions**: Import `excel-operations/code/excel_helpers.R`
3. **Follow integration guide**: This document and `agent-integration.md`
4. **Test integration**: Verify your skill works with excel-operations foundation
5. **Maintain consistency**: Keep the same human-readable R approach

The goal is a cohesive ecosystem of Excel skills that all build on the solid, transparent foundation provided by excel-operations.