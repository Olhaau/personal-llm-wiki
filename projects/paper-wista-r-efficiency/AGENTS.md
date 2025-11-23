# AGENTS.md - WISTA Academic Paper Project

## Project Overview
Quarto book project for German academic paper on R efficiency analysis in official statistics.

## Build Commands
- **Full Build**: `quarto render` (PDF output in `_book/`)
- **Preview**: `quarto preview` (live reload)
- **Single File**: `quarto render index.qmd` or `quarto render sections/[name].qmd`

## Code Style Guidelines
### R Code Chunks
- Use `#| label: fig-name`, `#| fig-cap:`, `#| echo: false`, `#| warning: false`
- Libraries at chunk start; functions in `snake_case` with `stop()` for errors
- Fixed seeds for reproducibility; comment complex calculations

### Quarto Documents (.qmd)
- German primary language (`lang: de`), formal academic style
- Cross-refs: `@sec-name`, `@tbl-name`, `@fig-name`; Citations: `[@key]`
- Math: `$$` display, `$` inline; Section anchors: `{#sec-name}`

### LaTeX (title.tex, _quarto.yml)
- Custom WISTA colors defined: `wistaBlue`, `wistaDarkGray`, `wistaLightGray`
- Title page layout uses tikzpicture for vertical line, minipages for content
