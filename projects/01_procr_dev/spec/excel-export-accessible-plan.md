# Excel Export and Accessibility Plan

## Summary
Add a prettier Excel export for `procr_table` objects and add an accessible
worksheet in the same workbook. Update documentation and add testthat coverage.

## Goals
- Preserve reproducibility and non-mutating behavior for inputs.
- Keep public API backwards compatible unless documented in NEWS.
- Provide a dedicated accessible worksheet with single-value-per-cell layout.
- Ensure suppression and missing values are explicit and consistent.

## Non-Goals
- No changes to core table computation or varformat evaluation.
- No changes to user data frames or input objects beyond workbook output.
- No external dependencies beyond current package stack.

## Current State
- Excel export lives in `procr/R/export.R` (`add_table_to_wb`, `write_wb`).
- Styling is minimal and oriented to numeric formatting.
- No accessible worksheet is produced.
- Existing tests do not cover Excel export behavior.

## Proposed API
- Extend `add_table_to_wb()` with new optional arguments:
  - `accessible_sheet` (character scalar or `NULL`).
  - `include_accessible` (logical, default `FALSE`).
- Default behavior remains unchanged unless `include_accessible = TRUE`.

## Accessible Worksheet Specification
- Sheet contains a long-format table with one value per row.
- Required columns (in order):
  - `row_label`
  - `col_label`
  - `value`
  - `n`
  - `suppression`
- Suppression markers are explicit and consistent:
  - `/` for suppressed values (slash rule)
  - `()` for bracketed values, or a dedicated `suppression` marker
- Ordering must match the `procr_table` row and column order.
- No merged cells, no hidden rows/columns, no formula-driven labels.

## Pretty Export Specification
- Main sheet keeps the matrix layout with row/column labels.
- Apply clear header styling, alignment, and borders.
- Keep number formats and rounding consistent with `num_style` and `digits`.
- Explicitly handle suppression and missing values.

## Implementation Plan
1) Add layout helpers in `procr/R/export.R`:
   - Build label matrices for row/column headers.
   - Build an accessible long-format data frame.
2) Extend `add_table_to_wb()`:
   - Write the pretty sheet as before, but with improved styling.
   - When `include_accessible = TRUE`, add the accessible worksheet.
3) Update roxygen docs and examples for `add_table_to_wb()`.
4) Update README/pkgdown or vignette with a short export example.
5) Add testthat tests for:
   - Accessible sheet presence and structure.
   - Suppression and missing value markers.
   - Edge cases (empty, single row/col, all suppressed).

## Risks and Mitigations
- Workbook style changes may affect existing expectations.
  - Mitigate by keeping defaults compatible and opt-in accessibility sheet.
- Suppression rules could be inconsistent across sheets.
  - Centralize suppression logic in a helper and reuse it.

## Acceptance Criteria
- `add_table_to_wb()` can write both pretty and accessible sheets.
- Accessible worksheet meets the single-value-per-cell requirement.
- Docs mention accessibility output and suppression behavior.
- Unit tests cover normal, edge, and failure cases without network use.
