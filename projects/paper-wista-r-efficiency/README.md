# WISTA-Style Academic Article Template

A Quarto project template for creating academic articles in the style of **WISTA – Wirtschaft und Statistik**, the official scientific journal of the German Federal Statistical Office (Statistisches Bundesamt).

## About WISTA

**WISTA** is the bimonthly scientific journal published by Destatis focusing on methods and analyses in official statistics. The journal publishes methodological articles, analytical pieces, and technical papers relevant to statistical practice and policy.

### Journal Characteristics
- **Publisher**: Statistisches Bundesamt (German Federal Statistical Office)
- **Frequency**: Bimonthly (6 issues per year)
- **Language**: Primarily German with English abstracts
- **Focus**: Official statistics methodology, analysis, and developments
- **Target Audience**: Statisticians, researchers, policy makers

## Project Structure

```
paper-wista-r-efficiency/
├── _quarto.yml              # Main project configuration
├── index.qmd                # Main article file with introduction
├── sections/                # Article sections
│   ├── methodology.qmd      # Methodological framework section
│   └── results.qmd          # Results and analysis section
├── references.bib           # Bibliography file
├── dev/                     # Development and testing files
│   └── test_files/         # Test documents and assets
├── _freeze/                 # Quarto cache (auto-generated)
└── _book/                   # Rendered output (auto-generated)
```

## Article Format Requirements

Based on analysis of published WISTA articles, this template follows these specifications:

### Content Structure
- **German or English title** (bilingual preferred)
- **Author affiliations** with institutional details
- **German abstract** ("Zusammenfassung")
- **English abstract** (required since 2015)
- **Keywords** in both languages
- **Structured main text** with numbered sections
- **References** in academic format
- **Author information**

### Article Specifications
- **Length**: 8-20 pages (approximately 4,000-8,000 words)
- **Format**: Academic article structure
- **Citations**: Author-year format with full bibliography
- **Language**: German preferred, English acceptable
- **Technical accuracy**: Essential for statistical content

### Visual Elements
This template supports all standard academic content types:

#### Tables
- Performance comparison tables
- Statistical results matrices  
- Bias analysis summaries
- Cost-benefit evaluation matrices

#### Figures
- Charts and plots (ggplot2 integration)
- Methodological flowcharts
- Scaling behavior visualizations
- Framework diagrams

#### Code Blocks
- R code for statistical analysis
- Algorithm implementations
- Reproducible research examples
- Performance benchmarks

#### Mathematical Notation
- LaTeX mathematical expressions
- Statistical formulas
- Hypothesis testing notation
- Complexity analysis

## Content Types Examples

This article demonstrates all major content types used in WISTA publications:

### 1. Statistical Tables (`sections/results.qmd`)

**Performance Analysis Table** (`@tbl-performance`)
- Execution times across different data sizes (N=10³ to N=10⁷)
- Comparison of 5 statistical methods (Naive, Optimized, Parallelized, Online, Sketching)
- German column headers: `"N=10³", "N=10⁴", "N=10⁵", "N=10⁶", "N=10⁷"`

**Bias Analysis Table** (`@tbl-bias`)
- Statistical bias measurements (×10⁻³)  
- Mean, variance, and standard deviation comparisons
- Multiple statistical estimators evaluation

**Cost-Benefit Matrix** (`@tbl-cost-benefit`)
- Multi-criteria evaluation (1=poor, 5=excellent)
- Six evaluation dimensions: computation time, memory, accuracy, robustness, implementation, overall
- Comparative scoring across algorithm families

### 2. Data Visualizations (`sections/methodology.qmd`, `sections/results.qmd`)

**Framework Diagram** (`@fig-evaluation-framework`)
- ggplot2 bar chart showing evaluation criteria weights
- Color-coded categories: Performance, Quality, Practicability
- German labels: "Bewertungsdimension", "Relative Gewichtung"

**Performance Charts** (`@fig-memory-usage`, `@fig-scaling`, `@fig-robustness`)
- Log-scale memory usage comparison across algorithms
- Empirical scaling behavior (execution time vs. dataset size)
- Robustness analysis with contamination levels
- Professional academic styling with German captions

### 3. Mathematical Formulations (`sections/methodology.qmd`, `sections/results.qmd`)

**Statistical Hypothesis Testing:**
```latex
$$H_0: \text{median}(T_A - T_B) = 0$$
```

**Equivalence Testing (TOST):**
```latex
$$H_0: |\theta_A - \theta_B| \geq \delta \text{ vs. } H_1: |\theta_A - \theta_B| < \delta$$
```

**Relative Efficiency Formula:**
```latex
$$\text{Relative Effizienz} = \frac{\text{Var}(\hat{\theta}_{\text{Referenz}})}{\text{Var}(\hat{\theta}_{\text{Verfahren}})}$$
```

### 4. Code Documentation (`sections/methodology.qmd`)

**Benchmarking Function Example:**
```r
benchmark_function <- function(func, data, n_iterations = 100) {
  times <- replicate(n_iterations, {
    start_time <- Sys.time()
    result <- func(data)
    end_time <- Sys.time()
    as.numeric(end_time - start_time, units = "secs")
  })
  
  list(
    mean_time = mean(times),
    median_time = median(times),
    sd_time = sd(times),
    result = result
  )
}
```

**R Code Chunks with German Captions:**
- `#| label: fig-evaluation-framework`
- `#| fig-cap: "Mehrdimensionales Bewertungsframework für statistische Verfahren"`
- `#| echo: false` and `#| warning: false` for clean output

### 5. Cross-References (`index.qmd`, `sections/results.qmd`)

**Section References:**
- `@sec-methodology` → "Methodische Grundlagen und Bewertungsframework"
- `@sec-results` → "Empirische Ergebnisse und Bewertung"

**Table References:**
- `@tbl-performance` → Performance comparison across algorithms
- `@tbl-bias` → Statistical bias analysis
- `@tbl-cost-benefit` → Multi-criteria evaluation matrix

**Figure References:**
- `@fig-evaluation-framework` → Evaluation framework visualization
- `@fig-memory-usage` → Memory usage comparison charts
- `@fig-scaling` → Algorithm scaling behavior
- `@fig-robustness` → Robustness analysis plots

### 6. Academic Structure (`index.qmd`)

**Bilingual Abstracts:**
- German "Zusammenfassung" with keywords ("Schlagwörter")
- English "Abstract" with keywords
- Research questions ("Forschungsfragen") with numbered lists

**Research Framework:**
- Motivation and objectives ("Motivation und Zielsetzung")
- Structured research questions with sub-criteria
- Article structure overview ("Aufbau der Arbeit")

### 7. Full-Width Content Handling

All figures and tables use the `{.fullwidth}` environment for proper two-column layout:

```markdown
::: {.fullwidth}
```{r}
#| label: fig-example
#| fig-cap: "German caption text"
# R code for visualization
```
:::
```

This ensures content spans both columns when needed while maintaining the WISTA two-column text flow.

## Getting Started

### Prerequisites
- **Quarto** (latest version)
- **R** with required packages:
  - `ggplot2` (visualization)
  - `knitr` (document rendering)
  - `dplyr` (data manipulation)

### Rendering the Document

```bash
# Render to PDF
quarto render

# Preview during development
quarto preview
```

### Customization

1. **Update metadata** in `_quarto.yml`:
   - Change title and subtitle
   - Update author information and affiliations
   - Modify formatting preferences

2. **Modify content sections**:
   - Edit `index.qmd` for introduction
   - Update `sections/methodology.qmd` for your methods
   - Revise `sections/results.qmd` for your findings

3. **Add references**:
   - Update `references.bib` with your sources
   - Use proper BibTeX format for German academic standards

## WISTA Submission Guidelines

### Author Eligibility
Typical WISTA authors include:
- Federal and state statistical office employees
- Academic researchers in statistics/economics
- International statistical office personnel
- Research institute scientists

### Content Requirements
- **Relevance**: Must relate to official statistics
- **Methodology**: Sound statistical methods required
- **Policy relevance**: Practical implications preferred
- **Technical accuracy**: Essential for publication

### Submission Process
Since detailed guidelines are not publicly available:

1. **Contact editorial team** directly:
   ```
   Statistisches Bundesamt
   Gustav-Stresemann-Ring 11
   65189 Wiesbaden, Germany
   ```

2. **Study recent issues** for current themes and style
3. **Prepare English abstract** regardless of main language
4. **Ensure topic relevance** to official statistics

### Recent Focus Areas
- Digital transformation in statistics
- AI/ML applications in official statistics
- Data protection and privacy methods
- European statistical harmonization
- Census methodology innovations
- Administrative data utilization

## Development Notes

### PDF Configuration
The template uses:
- **Document class**: `article`
- **Font**: Times New Roman, 11pt
- **Line spacing**: 1.2
- **Margins**: 2.5cm all sides
- **Citation style**: AuthorYear with Biblatex
- **Language**: German typographical conventions

### LaTeX Packages
Included packages for professional formatting:
- German language support
- Advanced table formatting (`booktabs`, `longtable`)
- Mathematics (`amsmath`, `amsfonts`)
- Graphics and color support
- Professional citation handling

### Quality Assurance
- Reproducible research practices
- Version control integration
- Automated bibliography management
- Cross-reference validation

## Contributing

To improve this template:

1. **Study WISTA issues** for formatting updates
2. **Test with different content types**
3. **Validate against German academic standards**
4. **Submit improvements** via pull requests

## License

This template is provided for academic and research purposes. Content should follow appropriate citation and attribution practices when adapting for actual WISTA submissions.

## WISTA Articles with Code Examples

The following WISTA articles include code snippets, algorithms, or technical implementations that serve as references for this template:

1. **Verbesserung der Data-Matching-Qualität mit optimierter String-Distanz-Metrik-Auswahl und Random Forest** (WISTA 5/2025)
   - Machine learning approach for record linkage
   - String distance metrics and Random Forest classification
   - [Download PDF](https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/Downloads/data-matching-random-forest-052025.html)

2. **Vergleich von Record-Linkage-Methoden anhand der Mikrosimulation eines bundesweiten Bildungsverlaufsregisters** (WISTA 4/2025)
   - Comparison of record linkage algorithms
   - Microsimulation methodology
   - [Download PDF](https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/Downloads/record-linkage-mikrosimulation-042025.html)

3. **Machine Learning in der amtlichen Statistik** (WISTA 5/2020)
   - Overview of ML applications in official statistics
   - Python and R code examples for classification
   - Practical implementation guidelines

4. **Automatische Texterkennung und -klassifikation für die Wirtschaftszweigkodierung** (WISTA 3/2021)
   - Natural language processing for industry classification
   - Text classification algorithms
   - Code examples for automated coding

5. **Web Scraping für die amtliche Preisstatistik** (WISTA 2/2022)
   - Web scraping methodology with R/Python
   - Data extraction and processing pipelines
   - Reproducible code examples

*Note: Article availability may vary. Check the [WISTA Archive](https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/_inhalt.html) for current downloads.*

## Resources

- [WISTA Journal Homepage](https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/_inhalt.html)
- [WISTA Article Archive](https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/Downloads/aufsatzarchiv.html)
- [Destatis Contact](https://www.destatis.de/EN/Service/Contact/contact_node.html)
- [Quarto Documentation](https://quarto.org)
- [R Documentation](https://www.r-project.org)

---

*This template was created based on analysis of published WISTA articles and German academic formatting standards. For official submission requirements, contact the Destatis editorial team directly.*