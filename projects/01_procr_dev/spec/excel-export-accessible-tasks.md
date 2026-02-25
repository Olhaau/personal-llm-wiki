# Task List: Excel Export and Accessibility

## 1. Review
- Review `procr/R/export.R` for current Excel export behavior.
- Identify current suppression, formatting, and style handling.
- Confirm existing docs/tests touching exports.

## 2. Design
- Define pretty-sheet layout and style rules.
- Define accessible-sheet columns and suppression markers.
- Decide on API arguments for `add_table_to_wb()`.

## 3. Implement
- Add helper functions for labels and accessibility layout.
- Extend `add_table_to_wb()` to write accessible worksheet.
- Apply updated styles to pretty sheet.

## 4. Document
- Update roxygen docs for `add_table_to_wb()`.
- Add README/pkgdown or vignette example for export.

## 5. Test
- Add testthat tests for accessible sheet structure.
- Cover suppression/missing values and edge cases.
- Validate that default behavior remains unchanged.
