---
name: llm-wiki-skill
description: Manage a Karpathy-style LLM wiki in OpenCode with structured compile, ingest, query, lint, and audit workflows and strict source-referenced outputs.
compatibility: opencode
license: MIT
metadata:
  derived-from: karpathy-gist,lewislulu,nvk
---

# LLM Wiki Skill

Use this skill to build and maintain a persistent markdown knowledge base where the LLM compiles and updates wiki pages over time.

## Derived Design

This skill combines:

- Karpathy's core pattern: persistent wiki between user and raw sources
- Lewislulu's five-operation loop: compile, ingest, query, lint, audit
- NVK's operational rigor: index-first navigation, immutable raw layer, and strict structure

## When to Use

- You want a long-lived knowledge base, not one-off document Q&A
- You are ingesting sources incrementally over days/weeks
- You need traceable answers with explicit references
- You want periodic quality checks and human correction workflows

Do not use for generic daily journaling or unsourced brainstorming.

## Required Wiki Layout

```text
<wiki-root>/
├── AGENTS.md
├── inbox/
│   ├── _index.md
│   └── <drop-files-and-captured-inputs>
├── raw/
│   ├── _index.md
│   └── <one-markdown-file-per-input>.md
├── wiki/
│   ├── _index.md
│   └── <topic-slug>/
│       ├── _index.md
│       └── <concept-pages>.md
└── log/
```

`inbox/_index.md` is the intake ledger. It tracks each dropped item with source/location/time metadata before normalization.

`raw/` is the normalized corpus. Each input from `inbox/` becomes one markdown file with YAML frontmatter.

`wiki/_index.md` is the master wiki index. Each `wiki/<topic>/_index.md` is the topic-local index.

## Raw File Frontmatter (Required)

Every file in `raw/` must include at least:

```yaml
---
title: "..."
source_link: "original URL/path/mail-id"
topic: "main-topic"
tags: [tag1, tag2]
generated_at: "YYYY-MM-DDTHH:MM:SSZ"
---
```

## Operating Rules

1. **Raw is immutable by default**: avoid rewriting existing files under `raw/` unless explicitly requested by the user.
2. **Index-first**: read `wiki/_index.md` before broad scans.
3. **No hallucinated evidence**: if unsupported, say so and propose what to ingest.
4. **Every factual output must include references**.
5. **Cross-topic connections are allowed**: any concept page may link across `wiki/<topic>/` subwikis.

## Reference Policy (Mandatory)

For every answer, report, or article generated from the wiki:

- Add a `## References` section.
- Include only concrete sources used (raw/wiki paths and URLs).
- Prefer path-level citations when source is local (`raw/...`, `wiki/...`).
- If evidence is weak or conflicting, state it explicitly.

## The Five Operations

### 1) compile

Extract concepts from `raw/` into topic subwikis. Relationship pages are concepts too.

- Read `AGENTS.md` and `wiki/_index.md` first.
- Group raw files by `topic` frontmatter value.
- Create missing `wiki/<topic>/` folders and `index.md`.
- Extract/update concept pages directly in `wiki/<topic>/`.
- Do not create `concepts/` or `connections/` subfolders.
- Every concept page must include `## Summary` (2-3 sentences), `## Details`, `## Connected Concepts` (one-sentence relation notes), and `## References`.
- Avoid self-referential phrasing like "this concept" or "topic-level concept".
- Cite `[[raw/...]]` sources inline in the prose and again in `## References`.
- Rebuild each topic `_index.md` and then rebuild `wiki/_index.md`.
- Append a `compile` log entry to `log/YYYYMMDD.md`.

### 2) ingest

Normalize input from `inbox/` into `raw/`.

- Record the input item in `inbox/_index.md` with source/location/time.
- Convert item into one markdown file in `raw/` with required YAML.
- For `.xlsx` files, default to full-fidelity JSON extraction with `python .opencode/skills/llm-wiki-skill/xlsx_to_json.py <input.xlsx> <output.json>`.
- For `.xlsx` ingest, write JSON to `raw/<input-stem>.json` and preserve workbook metadata, sheet structure, merged ranges, formulas, and populated cells.
- Keep a clear mapping from inbox item -> raw file in both indexes.
- Append an `ingest` log entry listing created raw files.

### 3) query

Answer from `wiki/` content with explicit source traceability.

- Start from `wiki/_index.md`.
- Read relevant pages and one link-hop deeper if needed.
- Prefer topic-local concept pages first.
- If needed, traverse linked concept pages across other topic subwikis.
- Include `## References` in all outputs.
- Append a `query` log entry.

### 4) lint

Run structural and linkage checks.

Check for:

- inbox index coverage (every intake item tracked)
- raw index coverage and valid required YAML keys
- topic subwiki shape (`index.md` plus concept pages directly in topic root)
- master index coverage (`wiki/_index.md` lists all topic subwikis)
- dead links and orphan pages

Apply safe fixes, then append a `lint` log entry.

### 5) audit

Validate extraction quality and correct concept-link drift.

- Spot-check random raw -> concept mappings.
- Verify key claims in concept pages have supporting raw/wiki references.
- Correct weak or wrong concept links and update topic/master indexes.
- Append an `audit` log entry with corrected files.

## Out of Scope

- Replacing source provenance with model memory
- Skipping `inbox/` and writing directly to `wiki/`
- Creating raw files without required YAML fields

## Session Start Checklist

At session start, do this order:

1. Read `AGENTS.md`
2. Read `wiki/_index.md`
3. Inspect most recent `log/*.md`
4. Read `inbox/_index.md` for unprocessed intake items
