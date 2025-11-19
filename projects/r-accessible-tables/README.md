# Accessible R Tables with GT Package

This project demonstrates accessibility challenges in the GT package's table generation and provides practical solutions, including a fix for header ID mismatches that prevent screen readers from properly associating data cells with column headers.

## Project Overview

This project addresses critical accessibility issues in GT-generated tables, particularly focusing on the header ID mismatch problem that breaks screen reader functionality. The project includes:

1. **GT Header ID Fix** - Core solution for header/cell association issues
2. **Comprehensive analysis** of GT accessibility barriers (based on [GT clinical tables case study](https://gt.rstudio.com/articles/case-study-clinical-tables.html))
3. **Practical solutions** that integrate seamlessly into existing GT workflows
4. **Testing and validation** framework for accessibility compliance

## Related GT Package Issues

Our work addresses several known accessibility issues in the GT package:

- **[#1577 - GT does not generate unique column ids when knit as HTML](https://github.com/rstudio/gt/issues/1577)** ⚠️ **Open**
  - *Same problem we solve*: Column IDs contain spaces/special characters, breaking screen reader associations
  - *Our solution*: `fix_gt_headers()` function fixes this automatically

- **[#1247 - Column header IDs duplicated across tables](https://github.com/rstudio/gt/issues/1247)** ⚠️ **Open**  
  - *Related issue*: Non-unique IDs across multiple tables in same document
  - *Broader scope than our fix, but related to ID generation problems*

- **[#2080 - Table header formatting in .docx export](https://github.com/rstudio/gt/issues/2080)** ⚠️ **Open**
  - *Accessibility focus*: Headers not properly formatted in Word export

**Fixed in GT package:**
- **[#678 - Row names (stub) have to use `<th>` tag](https://github.com/rstudio/gt/issues/678)** ✅ **Fixed in v0.7.0**
- **[#679 - Replace `<th>` with `<td>` for title/subtitle elements](https://github.com/rstudio/gt/issues/679)** ✅ **Fixed in v0.7.0**  
- **[#680 - Add scope="col" attribute to column headers](https://github.com/rstudio/gt/issues/680)** ✅ **Fixed in v0.7.0**
- **[#635 - Use table `<caption>` element](https://github.com/rstudio/gt/issues/635)** ✅ **Fixed in v0.8.0**

Our solution provides an **immediate workaround** for the open issues while maintaining full GT functionality.

## Files in This Project

### Core Accessibility Fixes
- **`fix_gt_headers.R`** - 🔧 **Main solution**: Function to fix header ID mismatches (returns gt object)
- **`fix_gt_headers_alternative.R`** - Alternative version that returns HTML directly  
- **`test_fix_gt_headers.R`** - Test script demonstrating the fix
- **`compare_fix_methods.R`** - Comparison of both fix approaches

### Problem Demonstration
- **`gt-issue.R`** - Reproduces the header ID mismatch problem
- **`gt-issue.html`** - Generated HTML showing the accessibility issue
- **`gt-issue-fixed.html`** - Same table after applying the fix

### Comprehensive Analysis (in `exploration/` folder)
- `original_gt_table.R` - Recreates the original GT demographic table from the case study
- `improved_accessible_table.R` - Enhanced version with accessibility improvements
- `accessibility_testing.R` - Comprehensive testing and validation script
- `accessibility_assessment.md` - Detailed accessibility analysis and scoring
- `accessibility_testing_guide.md` - Step-by-step testing instructions

### Generated Outputs
- Various HTML files showing before/after accessibility fixes
- CSV alternatives for screen reader compatibility

## Quick Start

### Fix GT Header Issues (Main Solution)

```r
# Install required packages
install.packages("gt")

# Load the fix
source("fix_gt_headers.R")

# Use with any GT table
library(gt)
library(dplyr)

# Example: Table with problematic column names
df <- data.frame(
  `married_low income` = c(30, 2),
  `married_high income` = c(30, 4), 
  `single_low income` = c(20, 1),
  `single_high income` = c(20, 2),
  row_names = c("age", "hsize"),
  check.names = FALSE
)

# Create accessible table (can continue using GT functions)
accessible_table <- df |>
  gt(rowname_col = "row_names") |>
  tab_spanner_delim(delim = "_") |>
  fix_gt_headers() |>                    # 🔧 Fixes header ID issues
  tab_header(title = "Demographic Data") |>
  fmt_number(decimals = 0)

# Save to file
save_html(accessible_table, "accessible_table.html")
```

### Alternative: Direct HTML Output
```r
source("fix_gt_headers_alternative.R")

# Returns HTML string directly
fixed_html <- my_gt_table |> fix_gt_headers_html()
writeLines(fixed_html, "fixed_table.html")
```

### Test the Fix
```r
# Run the test to see before/after comparison
source("test_fix_gt_headers.R")

# Compare both fix approaches
source("compare_fix_methods.R")
```

## The Header ID Mismatch Problem

### What's Wrong?

GT generates column header IDs using hyphens (e.g., `id="married_low-income"`) but cell `headers` attributes use spaces (e.g., `headers="stub_1_1 married_low income"`). This mismatch breaks the semantic relationship between headers and data cells.

**Example of the Problem:**
```html
<!-- Column header has hyphens -->
<th scope="col" id="married_low-income">Married Low Income</th>

<!-- But cell references it with spaces --> 
<td headers="stub_1_1 married_low income">30</td>
```

**Impact:** Screen readers cannot properly associate data cells with their headers, making tables incomprehensible to users who rely on assistive technology.

### Our Solution

The `fix_gt_headers()` function:
1. ✅ **Preserves GT workflow** - Returns a proper gt table object
2. ✅ **Fixes ID mismatches** - Ensures header IDs and `headers` attributes match exactly  
3. ✅ **Maintains all functionality** - Can continue using GT functions after the fix
4. ✅ **Works with complex tables** - Handles spanners, merged columns, and complex layouts

### Additional Accessibility Issues in GT

Beyond the header ID issue, GT tables may have:

- ❌ **No proper table caption** - Screen readers can't identify table purpose
- ❌ **Complex merged cell structure** - Confusing navigation for assistive technology  
- ❌ **Missing ARIA attributes** - No additional context for screen readers
- ❌ **Inadequate keyboard navigation** - Poor support for keyboard-only users

*See `exploration/` folder for comprehensive analysis and alternative table approaches.*

### Improvements in Accessible Version

The improved table achieved an accessibility score of **85/100** through:

- ✅ **Comprehensive table caption and summary** - Clear identification and description
- ✅ **Simplified column structure** - No complex cell merging
- ✅ **Descriptive column headers** - Clear, meaningful labels  
- ✅ **Semantic row grouping** - Proper hierarchical structure
- ✅ **Alternative CSV format** - Universal accessibility option
- ✅ **Detailed explanatory notes** - Context for screen reader users
- ✅ **Improved typography** - Better readability with larger fonts and spacing

## Accessibility Features Implemented

### 1. Table Structure
- Clear table caption using `tab_header()`
- Comprehensive table summary in `tab_source_note()`
- Proper row grouping with semantic meaning
- Simplified column structure avoiding complex merging

### 2. Content Clarity
- Descriptive column headers with sample sizes
- Clear data presentation patterns (count and percentage)
- Explanatory footnotes for abbreviations and methodology
- Consistent formatting across all data types

### 3. Alternative Formats
- HTML table with enhanced accessibility features
- CSV export for screen readers and data analysis tools
- Responsive design considerations

### 4. Screen Reader Support
- Detailed navigation instructions in table summary
- Clear relationships between headers and data
- Meaningful group labels and descriptions
- Alternative text for complex data relationships

## Usage Examples

### Basic Fix Implementation
```r
library(gt)
source("fix_gt_headers.R")

# Any GT table with spaces in column names
problematic_table <- data.frame(
  `Low Income` = c(100, 200),
  `High Income` = c(150, 250),
  Group = c("A", "B")
) |>
  gt(rowname_col = "Group") |>
  tab_spanner(label = "Income Levels", columns = c(`Low Income`, `High Income`))

# Fix the accessibility issue
fixed_table <- problematic_table |> fix_gt_headers()

# Continue with GT functions  
final_table <- fixed_table |>
  tab_header(title = "Income Analysis") |>
  fmt_currency(columns = everything(), currency = "USD")
```

### Integration with Existing Workflows
```r
# Drop into existing GT pipelines
create_demographic_table <- function(data) {
  data |>
    gt(rowname_col = "variable") |>
    tab_spanner_delim(delim = "_") |>        # Creates spanners
    fix_gt_headers() |>                       # 🔧 Fix accessibility
    tab_header(title = "Demographics") |>
    fmt_number(decimals = 1) |>
    tab_options(table.font.size = 14)
}
```

### Accessibility Testing
```r
# Run comprehensive accessibility validation
source("exploration/accessibility_testing.R")

# Test the header fix specifically  
source("test_fix_gt_headers.R")

# Compare fix approaches
source("compare_fix_methods.R")
```

## Best Practices for Accessible Tables

Based on this analysis, here are key recommendations for creating accessible tables with GT:

### Essential Requirements
1. **Always include a descriptive caption** using `tab_header()`
2. **Provide table summary information** using `tab_source_note()` 
3. **Avoid complex cell merging** that confuses screen readers
4. **Use clear, descriptive column headers** with context
5. **Offer alternative formats** (CSV, text) for different user needs

### Enhanced Accessibility
1. **Group related data semantically** using `gt(groupname_col)`
2. **Add explanatory footnotes** for abbreviations and methodology
3. **Use adequate font sizes and spacing** for visual accessibility
4. **Provide navigation instructions** for screen reader users
5. **Test with actual assistive technology** before publication

### Avoid These Common Mistakes
- ❌ Complex merged cell patterns using `cols_merge()`
- ❌ Unclear or abbreviated column headers
- ❌ Missing table captions or summaries
- ❌ Overly complex visual formatting that sacrifices structure
- ❌ No alternative format options

## Testing and Validation

### Automated Testing
The project includes comprehensive automated testing:
- HTML structure validation
- Accessibility feature detection
- Data integrity checks
- Screen reader simulation
- File generation validation

### Recommended Manual Testing
1. **Screen Reader Testing**
   - NVDA (Windows)
   - JAWS (Windows)
   - VoiceOver (macOS)

2. **Keyboard Navigation Testing**
   - Tab through table elements
   - Use arrow keys for navigation
   - Test with keyboard-only access

3. **Mobile Accessibility Testing**
   - iOS VoiceOver
   - Android TalkBack
   - Mobile browser zoom functionality

## Results Summary

| Feature | Original GT | Improved Accessible | Improvement |
|---------|-------------|--------------------|-----------| 
| Table Caption | ❌ Missing | ✅ Comprehensive | +100% |
| Header Structure | ❌ Poor | ✅ Clear | +100% |
| Screen Reader Support | ❌ Limited | ✅ Enhanced | +90% |
| Alternative Formats | ❌ None | ✅ CSV provided | +100% |
| Navigation Instructions | ❌ None | ✅ Detailed | +100% |
| **Overall Score** | **25/100** | **85/100** | **+240%** |

## Future Enhancements

Potential improvements for even better accessibility:
- [ ] Interactive filtering with keyboard support
- [ ] Audio descriptions for complex data relationships  
- [ ] High contrast theme options
- [ ] Multi-language support
- [ ] Integration with assistive technology APIs

## Contributing

This project demonstrates principles that can be applied to other GT table formats. When adapting these approaches:

1. Always prioritize semantic structure over visual appeal
2. Test with actual screen readers and keyboard navigation
3. Provide multiple format options when possible
4. Include comprehensive documentation and instructions
5. Validate accessibility before publication

## Resources

### GT Package & Related Issues
- [GT Package Documentation](https://gt.rstudio.com/)
- [GT GitHub Repository](https://github.com/rstudio/gt)
- [GT Issue #1577 - Column ID spaces problem](https://github.com/rstudio/gt/issues/1577) ⚠️ Open
- [GT Issue #1247 - Duplicate column IDs](https://github.com/rstudio/gt/issues/1247) ⚠️ Open

### Accessibility Standards & Testing  
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM Screen Reader Testing](https://webaim.org/articles/screenreader_testing/)
- [MDN Table Accessibility](https://developer.mozilla.org/en-US/docs/Learn/HTML/Tables/Advanced)

### Clinical & Research Standards
- [Clinical Table Standards](https://www.cdisc.org/)
- [R Accessibility Best Practices](https://rstudio.github.io/accessibility/)

## Contributing to GT Package

If this fix helps you, consider:
- 👍 **Adding reactions** to [GT Issue #1577](https://github.com/rstudio/gt/issues/1577) to show community interest  
- 📝 **Commenting** with your use case to help GT maintainers understand the scope
- 🐛 **Testing** our fix with your tables and reporting any issues
- 🔄 **Sharing** this solution with others facing similar accessibility challenges

## License

This project is for educational and research purposes, demonstrating accessibility best practices with the GT package.

---

**Need help?** Open an issue or check the `exploration/accessibility_testing_guide.md` for detailed testing instructions.