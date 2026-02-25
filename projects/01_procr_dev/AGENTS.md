# AGENTS.md - procR repository guide for coding agents

## Purpose
This repository contains the procR R package for fast, custom cross-tabulations
with export helpers. Follow this guide when editing, testing, or adding features.

## Repo layout
- R/                  Core R functions (public and internal helpers)
- src/                Rcpp sources and compiled hooks
- man/                Generated roxygen docs
- tests/testthat/     Unit tests (testthat edition 3)
- vignettes/          Package vignettes
- data/, data-raw/    Package data inputs
- pkgdown/            Site artifacts

## Rules from other configs
- No .cursor rules found in .cursor/rules/ or .cursorrules.
- No Copilot instructions found in .github/copilot-instructions.md.

## Build, check, test
Run commands from the repo root.

Build source tarball:
- R CMD build .

Check package (local):
- R CMD check --no-manual --as-cran <tarball>

Run all tests:
- Rscript -e "testthat::test_dir('tests/testthat')"
- Rscript -e "testthat::test_package('procR')"
- Rscript -e "devtools::test()"  # only if devtools is installed

Run a single test file:
- Rscript -e "testthat::test_file('tests/testthat/test-utils.R')"

Run a single test by name (if filter matches):
- Rscript -e "testthat::test_dir('tests/testthat', filter = 'varformat')"

Run Rcpp-related tests only:
- Rscript -e "testthat::test_file('tests/testthat/test-RcppExports.R')"

Linting (optional, if lintr installed):
- Rscript -e "lintr::lint_package()"
- Rscript -e "lintr::lint('R/table_internal.R')"

Styling (optional, if styler installed):
- Rscript -e "styler::style_pkg()"

## Code style guidelines
Keep edits consistent with existing style in R/ files.

General
- Use snake_case for functions and variables.
- Keep line width <= 100 characters.
- Prefer native pipe `|>` for new code.
- Avoid non-ASCII unless the file already contains it.
- Keep section headers and TODO markers as-is.

Imports and namespaces
- Prefer qualified calls when ambiguity exists (e.g., stats::as.formula).
- Use collapse, Matrix, and formula.tools as in existing code.
- Do not add new dependencies without updating DESCRIPTION.

Function signatures
- Use explicit arguments, avoid relying on `...` for data.
- When `...` exists for named-arg enforcement, validate with check_empty_dots().
- Capture user calls when needed with match.call().

Naming and classes
- Public API functions are exported and documented with roxygen.
- Internal helpers are unexported and tagged with @keywords internal.
- Custom classes in this repo: procr_table, procr_varformat.
- Preserve class names and return types for public functions.

Error handling
- Prefer assert_class() and stop_if() for input validation.
- Use stopifnot() for simple internal assertions.
- Provide clear error messages and set call. = FALSE where appropriate.
- Validate that inputs are in the data frame and formulas are supported.

Roxygen documentation
- Add @export for new public functions.
- Include @param, @return, and @examples sections.
- Keep examples minimal and consistent with README patterns.

Data handling
- Do not mutate user data frames in-place.
- Filter and select columns explicitly (see prepare_data()).
- Handle NA rules consistently with existing methods.

Performance
- Prefer vectorized operations and sparse matrices.
- Reuse existing helper patterns (compute_groups, compute_varformat_codes).
- Avoid repeated evaluation of formats or expressions.

Rcpp
- Do not edit generated R/RcppExports.R manually.
- If adding C++ code, update src/ and regenerate exports as needed.

Testing
- Use testthat edition 3 conventions.
- Add tests for edge cases (NA handling, empty subsets, weights).
- Include failure-case tests for invalid inputs.

Documentation
- Update README and vignettes when user-facing behavior changes.
- Keep NEWS.md updated for notable changes.

## Excel and export guidance
- openxlsx2 is the current Excel dependency.
- Do not manually edit binary xlsx files.
- Ensure export helpers accept and return explicit classes (wbWorkbook).
- Keep formatting consistent with add_table_to_wb() defaults.

## Notes for agents
- This repo uses GPL-3 license.
- Avoid network calls during tests.
- Keep outputs deterministic for tests and examples.
