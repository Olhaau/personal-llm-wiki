# Excel Round-Trip Test Project

## Overview
This project tests the complete round-trip functionality of the excel-extractor skill:
1. **Extract**: Load existing Excel file → Extract to JSON specifications
2. **Reconstruct**: Load JSON specifications → Create new Excel file  
3. **Validate**: Compare original and reconstructed files for accuracy

## Project Structure
```
excel-roundtrip-test/
├── README.md
├── test_roundtrip.R              # Main test script
├── create_reconstruction.R       # Reconstruction engine
├── validate_roundtrip.R         # Validation and comparison
├── input/                       # Test Excel files
│   ├── simple_test.xlsx
│   ├── complex_formatting.xlsx
│   └── advanced_features.xlsx
├── output/                      # Generated files
│   ├── extracted_specs/         # JSON specifications
│   ├── reconstructed/           # Rebuilt Excel files
│   └── validation_reports/      # Comparison reports
└── test_results/               # Test execution results
    ├── test_log.txt
    └── benchmark_results.json
```

## Test Cases

### 1. Simple Test Case
- Basic data with headers
- Simple number and text formatting
- Column width adjustments
- Row height modifications

### 2. Complex Formatting Test Case  
- Multiple formatting blocks and overlays
- Conditional formatting rules
- Custom number formats
- Font variations and colors
- Cell borders and fills
- Merged cells

### 3. Advanced Features Test Case
- Charts and sparklines
- Pivot tables
- Data validation rules
- Hyperlinks and comments
- Formula cells with dependencies
- Print settings and page setup

## Usage

### Run Complete Round-Trip Test
```r
source("test_roundtrip.R")
results <- run_complete_roundtrip_test()
```

### Test Individual Components
```r
# Extract only
specs <- extract_excel_to_json("input/test.xlsx")

# Reconstruct only  
wb <- reconstruct_excel_from_json("output/extracted_specs/test_specs.json")

# Validate only
validation <- validate_roundtrip("input/test.xlsx", "output/reconstructed/test_reconstructed.xlsx")
```

### Run Benchmarks
```r
source("test_roundtrip.R")
benchmarks <- run_roundtrip_benchmarks()
```

## Success Criteria

### Extraction Accuracy (≥95%)
- All cell values preserved with correct types
- All formatting captured (fonts, colors, borders, fills)
- Sheet structure maintained (merged cells, dimensions)
- Advanced features identified and documented

### Reconstruction Fidelity (≥90%)
- Visual appearance matches original
- Data integrity maintained
- Formulas work correctly
- Conditional formatting applies properly

### Performance Benchmarks
- Extraction: <2 seconds per MB of Excel file
- Reconstruction: <3 seconds per MB of specifications
- Round-trip: <5 seconds total for typical business files

## Test Results Interpretation

### Grade Scale
- **A (90-100%)**: Production ready, minimal differences
- **B (80-89%)**: Good quality, minor visual differences
- **C (70-79%)**: Acceptable, some functionality differences  
- **D (60-69%)**: Needs improvement, significant differences
- **F (<60%)**: Major issues, round-trip failed

### Common Issues Tracked
- Font substitution differences
- Color value variations (RGB vs theme colors)
- Border style approximations
- Chart positioning variations
- Formula reference adjustments

## Integration with excel-operations Skill

This test project validates the integration between:
- **excel-extractor**: Converts Excel → JSON specifications
- **excel-operations**: Creates Excel from specifications (reconstruction)

Both skills must work together seamlessly for successful round-trip testing.