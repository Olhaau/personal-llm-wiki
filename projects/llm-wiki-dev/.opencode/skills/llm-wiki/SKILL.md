---
name: llm-wiki
description: Build and maintain a Karpathy-style LLM wiki with persistent markdown knowledge, structured ingest/query/lint/audit workflows, and OpenCode-native project conventions.
compatibility: opencode
license: MIT
---

# LLM Wiki for OpenCode

## Purpose

Use this skill when building a persistent markdown knowledge base where the LLM incrementally compiles source material into structured wiki pages.

Prefer this pattern over one-shot RAG when the user wants knowledge to compound over time.

## When to Use

- Creating a fresh LLM wiki scaffold for a research topic
- Ingesting new sources into `raw/` and updating compiled pages
- Querying and saving durable analyses back into the wiki
- Running lint and audit maintenance on existing wiki content

Do not use for generic daily journaling or ad-hoc note capture without wiki structure.

## Standard Layout

```text
<wiki-root>/
├── AGENTS.md              # schema and operating rules for the wiki
├── raw/                   # immutable source files
│   ├── articles/
│   ├── papers/
│   ├── notes/
│   └── refs/              # pointer files for large external assets
├── wiki/                  # LLM-maintained markdown knowledge
│   ├── index.md
│   ├── concepts/
│   ├── entities/
│   └── summaries/
├── outputs/
│   └── queries/
├── audit/
│   └── resolved/
└── log/
```

## Non-Negotiable Rules

1. `raw/` is immutable; never rewrite source material.
2. Keep concept pages focused (roughly 400-1200 words). Split large topics.
3. Prefer mermaid for diagrams and KaTeX for formulas.
4. Every wiki page appears exactly once in `wiki/index.md`.
5. Human feedback in `audit/` is processed and archived, never discarded.

## Core Operations

### compile

Restructure wiki pages from existing content.

- Read `AGENTS.md` and `wiki/index.md` first.
- Split oversized pages into topic folders with `index.md` hubs.
- Merge near-duplicates only when content overlap is substantial.
- Rebuild `wiki/index.md` to reflect exact structure.
- Append a `compile` entry to `log/YYYYMMDD.md`.

### ingest

Add one new source and propagate changes.

- Place source in the correct `raw/*` directory.
- Create `wiki/summaries/<slug>.md`.
- Update related `wiki/concepts/*` and `wiki/entities/*`.
- Update `wiki/index.md`.
- Log touched pages in `log/YYYYMMDD.md`.

### query

Answer against the compiled wiki, not generic memory.

- Start from `wiki/index.md`.
- Cite with wikilinks to supporting pages.
- Save answer to `outputs/queries/YYYY-MM-DD-<slug>.md`.
- Promote durable analyses into `wiki/concepts/`.
- Log `query` and optional `promote` entries.

### lint

Run periodic health checks.

Validate:

- dead wikilinks
- orphan pages
- missing index entries
- frequently referenced missing pages
- malformed `audit/` or `log/` shape

Fix issues, then log the pass.

### audit

Process human feedback files from `audit/`.

- Read each open audit item.
- Apply accepted corrections to target pages.
- Append a `# Resolution` section.
- Move processed file to `audit/resolved/`.
- Log each resolved audit item.

## Authoring Conventions

- Use concise, scan-friendly markdown with explicit headings.
- Keep claims attributable to sources or summary pages.
- Prefer additive edits over destructive rewrites.
- If evidence is weak or conflicting, record uncertainty explicitly.

## Suggested Bootstrap Flow

1. Create folder structure and a minimal `AGENTS.md` scope definition.
2. Add 3-5 seed sources under `raw/`.
3. Run an ingest pass per source.
4. Generate first `wiki/index.md` and initial concept graph.
5. Run lint, then query and promote durable answers.
6. Process audit feedback on a regular cadence.

## Quick `AGENTS.md` Starter

```markdown
# <Topic> LLM Wiki

## Scope
- Primary topic boundaries
- Included and excluded subtopics

## Naming
- Slug conventions for files
- Entity naming conventions

## Workflow
- Ingest policy
- Query citation style
- Lint cadence
- Audit cadence
```
