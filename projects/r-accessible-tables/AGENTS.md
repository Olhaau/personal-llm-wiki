# AGENTS.md - R Accessibility Tables Project

## Project Overview
R package development focused on making GT tables accessible for screen readers and assistive technologies. Core functionality centers around the `fix_gt_headers()` function for WCAG 2.1 compliance.

## Build/Test Commands
- **Run single test**: `Rscript test_fix_gt_headers.R` (basic functionality test)
- **Run enhanced tests**: `Rscript test_fix_gt_headers_enhanced.R` (comprehensive validation)
- **Run specific test**: `Rscript test_german_encoding.R` (German character handling)
- **Generate demo table**: `Rscript gt-issue.R` (creates original problematic table)
- **No formal build process** - R scripts executed directly

## Code Style Guidelines
### R Scripts
- **Function naming**: Use `snake_case` for all functions (`generate_valid_html_id`, `fix_gt_headers`)
- **Section separators**: Use `# ----` (exactly 4 dashes) for major sections
- **Headers**: Include roxygen2 documentation with `#'` for all exported functions
- **Libraries**: Load with `library()` at script top, use `suppressPackageStartupMessages()` for quiet loading
- **Pipe operator**: Use native `|>` pipe (R 4.1+), avoid magrittr `%>%`
- **Column references**: Use backticks for non-standard names: `df$`married_low income``
- **Parameter naming**: Use full descriptive names (`id_suffix`, `preserve_mapping`)
- **Constants**: Use UPPER_CASE for package constants
- **Error handling**: Use `stop()` with descriptive messages, validate inputs early
- **File naming**: Use underscores for scripts (`fix_gt_headers.R`, `test_german_encoding.R`)