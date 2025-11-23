# AGENTS.md - WISTA Academic Paper Project

## Project Overview
Quarto book project for German academic paper on R efficiency analysis in official statistics.

## Build Commands
- **Full Build**: `quarto render` (PDF output in `_book/`)
- **Preview**: `quarto preview` (live reload)
- **Single Section**: `quarto render index.qmd`

## Code Style Guidelines
### R Code Chunks
- Use `#| label: fig-name`, `#| fig-cap:`, `#| echo: false`, `#| warning: false`
- Tables: Use `kableExtra::kbl()` with `kable_styling(latex_options = c("hold_position"), full_width = TRUE)`
- Libraries at chunk start (`library(kableExtra)`); functions in `snake_case`

### Quarto Documents (.qmd)
- German primary language (`lang: de`), formal academic style
- Cross-refs: `@sec-name`, `@tbl-name`, `@fig-name`; Citations: `[@key]`
- Sections use `{{< include sections/XX-name.qmd >}}` in index.qmd

### LaTeX (title.tex, _quarto.yml)
- Custom WISTA colors: `wistaBlue`, `wistaDarkGray`, `wistaLightGray`
- Bullets: `>` (black, scaled 0.35x0.95); Ref arrows: `\ding{247}` (blue pifont)
- Bibliography: full-width one-column; uses polyglossia for German/English
