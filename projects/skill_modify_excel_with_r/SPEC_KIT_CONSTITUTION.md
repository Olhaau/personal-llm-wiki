# SPEC KIT CONSTITUTION
## Exact Excel Recreation: "Statistischer Bericht" with gt Tables in R

**Version**: 1.0  
**Date**: 2025-01-15  
**Project Goal**: Create pixel-perfect German statistical reports from gt tables

---

## 🎯 PROJECT MISSION

**Primary Objective**: Develop a comprehensive workflow to recreate exact Excel "Statistischer Bericht" files using R's gt package and openxlsx2, maintaining 100% fidelity to official German statistical office (Destatis) standards.

**Success Criteria**: Generated Excel files must be indistinguishable from original Destatis publications in:
- Visual appearance (fonts, colors, spacing)
- Navigation structure (hyperlinks, table of contents)
- Data formatting (German number formats, date formats)
- Accessibility compliance (barrier-free tables)
- Corporate design standards (logo placement, headers, footers)

---

## 📋 PROJECT SCOPE

### Core Components

#### 1. TEMPLATE ANALYSIS
- **Source Document**: `statistischer-bericht-ausgewaehlte-mineraloelerzeugnisse-2170200252125(1).xlsx`
- **Analysis Goals**:
  - Extract all formatting specifications
  - Document sheet structure and navigation
  - Identify color schemes, fonts, and styling
  - Map data table layouts and hierarchy

#### 2. GT TABLE INTEGRATION
- **Primary Tool**: R's `gt` package for table creation
- **Integration Points**:
  - Convert gt tables to Excel with exact formatting
  - use the same combined headers
  - Preserve gt styling in Excel output
  - Maintain German statistical formatting standards
  - Bridge gt capabilities with openxlsx2 Excel formatting

#### 3. EXCEL RECREATION ENGINE
- **Framework**: openxlsx2 package with custom formatting functions
- **Features**:
  - Automatic sheet generation from gt tables
  - Navigation system implementation
  - German formatting application
  - Accessibility features integration

---

## 🏗️ ARCHITECTURE DESIGN

### Workflow Pipeline

```
1. DATA INPUT
   ├── Raw data (data.frames, lists)
   ├── Metadata (titles, periods, EVAS numbers)
   └── Configuration (table IDs, descriptions)

2. GT TABLE CREATION
   ├── Apply German statistical formatting
   ├── Create professional table layouts
   ├── Add calculated columns/summaries
   └── Generate table descriptions

3. EXCEL CONVERSION
   ├── Extract gt formatting specifications
   ├── Map to openxlsx2 styling
   ├── Create multi-sheet structure
   └── Apply corporate design

4. QUALITY ASSURANCE
   ├── Check identical content
   ├── Validate against original template
   ├── Check navigation functionality
   ├── Verify German formatting
   └── Test accessibility features
```

### Component Structure

```
spec_kit/
├── core/
│   ├── gt_to_excel.R          # Core conversion engine
│   ├── german_formatting.R    # Statistical formatting rules
│   ├── navigation_system.R    # Hyperlink and TOC generation
│   └── quality_control.R      # Validation and testing
├── templates/
│   ├── destatis_styles.yaml   # Official styling definitions
│   ├── sheet_layouts.R        # Standard sheet templates
│   └── corporate_design.R     # Branding and visual elements
├── examples/
│   ├── mineral_oil_prices.Rmd # Recreation of original file
│   ├── clinical_study.Rmd     # Extended example
│   └── economic_indicators.Rmd # Additional test case
└── validation/
    ├── format_checker.R       # Automated validation
    ├── visual_comparison.R    # Side-by-side testing
    └── comparison_cell_content.R # comparison of the content of each cell
```

---

## 📏 TECHNICAL SPECIFICATIONS

### German Statistical Formatting Standards

#### Number Formats
```r
# Price/Currency Values
format_currency <- function(x) {
  sprintf("%.2f", x) %>%
    str_replace("\\.", ",") %>%
    str_replace_all("(?<=\\d)(?=(\\d{3})+(?!\\d))", " ")
}

# Percentage Values  
format_percentage <- function(x) {
  sprintf("%.2f%%", x * 100) %>%
    str_replace("\\.", ",")
}

# Index Numbers
format_index <- function(x) {
  sprintf("%.2f", x) %>%
    str_replace("\\.", ",")
}

# Large Numbers with Space Separators
format_large_number <- function(x) {
  format(x, big.mark = " ", decimal.mark = ",", scientific = FALSE)
}
```

#### Font Standards
- **Primary Font**: Arial (required for accessibility)
- **Sizes**: 10pt (body), 11pt (headers), 14pt (titles), 16pt (main title)
- **Weights**: Regular, Bold only (no italic or other variants)

#### Color Palette (Destatis Official)
```r
destatis_colors <- list(
  primary_blue = "#004B76",      # Main headers, navigation
  secondary_blue = "#0080C8",    # Sub-headers, accents  
  background_gray = "#F5F5F5",   # Alternating rows
  header_gray = "#E6E6E6",       # Column headers
  text_black = "#000000",        # Body text
  white = "#FFFFFF"              # Backgrounds
)
```

### Sheet Architecture

#### Required Sheets (in order)
1. **Titel** - Title page with report metadata
2. **Informationen_Barrierefreiheit** - Accessibility information
3. **Inhaltsübersicht** - Table of contents with navigation
4. **GENESIS-Online** - Database reference sheet
5. **Impressum** - Legal notice/imprint  
6. **Informationen_zur_Statistik** - Methodology information
7. **Data Tables** - Main statistical content (format: `61241-01`, `61241-02`, etc.)
8. **CSV Tables** - Machine-readable versions (format: `csv-61241-01`, etc.)
9. **Barrier-Free Tables** - Accessible versions (format: `61241-b01`, etc.)

#### Navigation Requirements
- **Universal back-link**: "zur Inhaltsübersicht" on every data sheet (cell A1)
- **TOC hyperlinks**: All sheets linked from table of contents
- **Working links**: All hyperlinks must function correctly in Excel
- **Consistent styling**: Blue hyperlink text (#0080C8), underlined

---

## 🔧 IMPLEMENTATION FRAMEWORK

### Core Functions

#### 1. GT Table Enhancement
```r
#' Prepare GT table for Excel export with German formatting
#' @param data Data frame to format
#' @param table_id Official table identifier
#' @param title Table title/description
create_german_gt_table <- function(data, table_id, title) {
  gt(data) %>%
    tab_header(title = title) %>%
    fmt_currency(
      columns = where(is.numeric),
      currency = "EUR",
      decimals = 2,
      locale = "de"
    ) %>%
    tab_style(
      style = cell_text(font = "Arial", size = px(10)),
      locations = cells_body()
    ) %>%
    tab_style(
      style = list(
        cell_fill(color = "#E6E6E6"),
        cell_text(font = "Arial", size = px(10), weight = "bold")
      ),
      locations = cells_column_labels()
    ) %>%
    # Add German thousand separators
    fmt_number(
      columns = where(is.numeric),
      decimals = 2,
      sep_mark = " ",
      dec_mark = ","
    )
}
```

#### 2. Excel Conversion Engine
```r
#' Convert GT tables to Excel with exact Destatis formatting
#' @param gt_tables Named list of gt table objects
#' @param filename Output Excel filename
#' @param metadata Report metadata (title, period, EVAS number)
create_statistischer_bericht_from_gt <- function(gt_tables, filename, metadata) {
  wb <- wb_workbook()
  
  # Set base formatting
  wb$set_base_font(font_name = "Arial", font_size = 10)
  
  # Create required sheets
  create_title_sheet(wb, metadata)
  create_accessibility_sheet(wb)
  create_table_of_contents(wb, names(gt_tables))
  create_info_sheets(wb)
  
  # Convert each GT table to Excel sheet
  for (table_id in names(gt_tables)) {
    convert_gt_to_sheet(wb, gt_tables[[table_id]], table_id)
    create_csv_version(wb, gt_tables[[table_id]], table_id)
    create_barrier_free_version(wb, gt_tables[[table_id]], table_id)
  }
  
  # Final setup and save
  setup_navigation_system(wb)
  apply_destatis_styling(wb)
  wb_save(wb, filename, overwrite = TRUE)
  
  validate_output(filename)
}
```

#### 3. Quality Assurance Framework
```r
#' Validate Excel output against Destatis standards
#' @param filename Generated Excel file
validate_output <- function(filename) {
  wb <- wb_load(filename)
  
  results <- list(
    sheets_present = check_required_sheets(wb),
    navigation_works = test_hyperlinks(wb),
    formatting_correct = validate_german_formatting(wb),
    accessibility_compliant = check_barrier_free_features(wb),
    colors_accurate = verify_destatis_colors(wb),
    fonts_consistent = check_arial_usage(wb)
  )
  
  # Generate validation report
  create_validation_report(results, filename)
  return(all(unlist(results)))
}
```

---

## 🎨 DESIGN PRINCIPLES

### Visual Consistency
1. **Exact Color Matching**: Use official Destatis hex codes
2. **Typography Uniformity**: Arial font throughout, consistent sizing
3. **Spacing Standards**: Maintain official padding and margins
4. **Grid Alignment**: Precise cell positioning and table layouts

### Functional Reliability
1. **Navigation Integrity**: All hyperlinks must work correctly
2. **Data Accuracy**: Preserve original data while applying formatting
3. **Cross-Platform Compatibility**: Excel files work on Windows/Mac/LibreOffice
4. **Accessibility Compliance**: Meet German barrier-free standards

### Maintainability
1. **Modular Design**: Separate formatting, navigation, and data processing
2. **Configuration-Driven**: External YAML/JSON for styling specifications
3. **Version Control**: Track template changes and formatting updates
4. **Documentation**: Comprehensive inline documentation for all functions

---

## 📝 DEVELOPMENT PHASES

### Phase 1: Template Analysis & Documentation
- [ ] Complete analysis of original Excel file structure
- [ ] Document all formatting specifications 
- [ ] Create style guide and technical requirements
- [ ] Establish validation criteria

### Phase 2: Core Engine Development
- [ ] Build gt-to-Excel conversion functions
- [ ] Implement German formatting modules
- [ ] Create navigation system generator
- [ ] Develop accessibility features

### Phase 3: Template Recreation
- [ ] Recreate original mineral oil prices report
- [ ] Generate equivalent gt tables
- [ ] Apply exact formatting specifications
- [ ] Validate against original file

### Phase 4: Extension & Testing
- [ ] Create additional example reports
- [ ] Test with different data types
- [ ] Validate accessibility compliance
- [ ] Performance optimization

### Phase 5: Production Readiness
- [ ] Final quality assurance
- [ ] User documentation
- [ ] Integration testing
- [ ] Deployment preparation

---

## 🎯 SUCCESS METRICS

### Technical Metrics
- **Visual Fidelity**: 99%+ match with original formatting
- **Navigation Functionality**: 100% working hyperlinks
- **Performance**: Generate reports in <30 seconds
- **Compatibility**: Works across Excel versions (2016+)

### Quality Metrics
- **Accessibility**: Pass all barrier-free requirements
- **Compliance**: Meet Destatis style guide standards
- **Reliability**: Generate consistent outputs across runs
- **Maintainability**: <2 hours for new template adaptation

### Process Metrics
- **Development Speed**: Complete templates in <1 week
- **Documentation Quality**: 95%+ function documentation coverage
- **Test Coverage**: 90%+ automated validation coverage
- **User Adoption**: Seamless integration with existing workflows

---

## 🔄 CONTINUOUS IMPROVEMENT

### Regular Reviews
- **Monthly**: Review and update formatting specifications
- **Quarterly**: Assess new Destatis template changes
- **Annually**: Major version updates and feature additions

### Feedback Integration
- **User Reports**: Track formatting discrepancies
- **Template Updates**: Monitor official Destatis changes
- **Technology Updates**: Adapt to gt/openxlsx2 package updates

### Quality Assurance
- **Automated Testing**: Daily validation runs on example files
- **Visual Inspection**: Manual review of generated reports
- **Accessibility Audits**: Regular barrier-free compliance checks

---

## 📚 REFERENCES & STANDARDS

### Official Sources
- Destatis Style Guide (internal)
- German Federal Statistical Office formatting standards
- Accessibility guidelines (BITV 2.0)
- EU statistical reporting requirements

### Technical Documentation
- [openxlsx2 documentation](https://janmarvin.github.io/openxlsx2/)
- [gt package guide](https://gt.rstudio.com/)
- [German localization standards](https://www.localedata.org/docs/de/)

### Related Projects
- Corporate design system (existing)
- Statistical reporting automation
- Data visualization standards

---

**Document Status**: DRAFT  
**Next Review**: 2025-02-15  
**Maintainer**: Development Team  
**Approval Required**: Project Lead, Quality Assurance

---

*This constitution serves as the foundational document for the spec kit project, establishing clear objectives, technical requirements, and quality standards for recreating exact Excel "Statistischer Bericht" files using R and gt tables.*