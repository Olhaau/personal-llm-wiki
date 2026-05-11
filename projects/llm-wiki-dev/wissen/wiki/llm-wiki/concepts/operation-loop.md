# Operation Loop

Across sources, the workflow converges on a repeatable loop of operations:
- ingest new sources into a normalized raw layer,
- compile/synthesize into topic pages,
- query against compiled knowledge with references,
- lint/audit for drift, stale claims, and structural issues.

Implementation variants differ in command names and tooling, but the operational intent is stable: keep a long-lived knowledge base coherent as evidence grows.

## References

- `raw/karpathy-llm-wiki-raw-idea-file.md`
- `raw/lewislulu-llm-wiki-skill.md`
- `raw/nvk-llm-wiki.md`
