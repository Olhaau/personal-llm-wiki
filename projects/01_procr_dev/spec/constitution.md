# spec-kit constitution for procR

## Purpose
procR provides a fast, intuitive, and reproducible workflow for producing
custom cross-tabulations from microdata, including metadata-rich exports for
official statistical dissemination.

## Scope
- Applies to all core table creation, varformat utilities, and export features.
- Covers documentation, tests, and accessibility output.
- Excludes experimental or local scripts unless they are promoted into the API.

## Product principles
- **Reproducibility first**: identical inputs yield identical outputs.
- **Transparent tabulation**: metadata explains row/column composition and
  suppression rules.
- **Performance at scale**: large data and complex tables stay efficient.
- **Official-statistics alignment**: outputs meet disclosure and accessibility
  expectations.
- **Minimal surprises**: defaults are safe and explicit; avoid hidden behavior.

## Design principles
- **Small, composable functions** over monolithic pipelines.
- **Formula-driven UX** remains the primary interface.
- **Type-stable outputs** with predictable classes and attributes.
- **Vectorized operations** and sparse structures where appropriate.
- **Single source of truth** for labels, formats, and metadata.

## Data & output guarantees
- Table objects remain valid even after exporting.
- Export functions never mutate input data frames.
- Missing and suppressed values are explicit and documented.
- Accessibility outputs preserve ordering, labels, and context.

## API commitments
- Backward compatibility for public functions unless a breaking change is
  required; then document in NEWS and deprecate first.
- New functions include roxygen docs, examples, and tests.
- Export helpers must accept and return explicit classes (e.g., procr_table).

## Testing commitments
- New behavior requires unit tests covering normal, edge, and failure cases.
- Tests should not rely on external data or network access.
- Performance-sensitive code paths have at least one regression test for
  correctness.

## Documentation commitments
- README and pkgdown include new features and minimal examples.
- Vignettes show end-to-end workflows for new exports.
- Any disclosure-control behavior is documented clearly.

## Accessibility commitments
- Accessibility tables provide fully labeled, single-value-per-cell outputs.
- Structure must support screen readers and machine ingestion.
- Exported Excel is readable without hidden formatting tricks.

## Versioning & releases
- Follow semantic versioning aligned with NEWS.
- Document breaking changes and migration paths.

## Tooling notes
- Keep code style consistent with existing package conventions.
- Avoid non-ASCII unless already used in nearby files.
