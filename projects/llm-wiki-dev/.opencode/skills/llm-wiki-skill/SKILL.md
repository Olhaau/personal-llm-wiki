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
│   ├── index.md
│   └── <drop-files-and-captured-inputs>
├── raw/
│   ├── index.md
│   └── <one-markdown-file-per-input>.md
├── wiki/
│   ├── index.md
│   └── <topic-slug>/
│       ├── index.md
│       ├── concepts/
│       └── connections/
└── log/
```

`inbox/index.md` is the intake ledger. It tracks each dropped item with source/location/time metadata before normalization.

`raw/` is the normalized corpus. Each input from `inbox/` becomes one markdown file with YAML frontmatter.

`wiki/index.md` is the master wiki index. Each `wiki/<topic>/index.md` is the topic-local index.

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

1. **Raw is immutable**: never rewrite files under `raw/`.
2. **Index-first**: read `wiki/index.md` before broad scans.
3. **No hallucinated evidence**: if unsupported, say so and propose what to ingest.
4. **Every factual output must include references**.
5. **Cross-topic connections are allowed**: `connections/` entries may link across `wiki/<topic>/` subwikis.

## Reference Policy (Mandatory)

For every answer, report, or article generated from the wiki:

- Add a `## References` section.
- Include only concrete sources used (raw/wiki paths and URLs).
- Prefer path-level citations when source is local (`raw/...`, `wiki/...`).
- If evidence is weak or conflicting, state it explicitly.

## The Five Operations

### 1) compile

Extract concepts and connections from `raw/` into topic subwikis.

- Read `AGENTS.md` and `wiki/index.md` first.
- Group raw files by `topic` frontmatter value.
- Create missing `wiki/<topic>/` folders with `concepts/`, `connections/`, and `index.md`.
- Extract/update concept pages in `wiki/<topic>/concepts/`.
- Extract/update connection pages in `wiki/<topic>/connections/`.
- Rebuild each topic `index.md` and then rebuild `wiki/index.md`.
- Append a `compile` log entry to `log/YYYYMMDD.md`.

### 2) ingest

Normalize input from `inbox/` into `raw/`.

- Record the input item in `inbox/index.md` with source/location/time.
- Convert item into one markdown file in `raw/` with required YAML.
- Keep a clear mapping from inbox item -> raw file in both indexes.
- Append an `ingest` log entry listing created raw files.

### 3) query

Answer from `wiki/` content with explicit source traceability.

- Start from `wiki/index.md`.
- Read relevant pages and one link-hop deeper if needed.
- Prefer topic-local concepts and connections first.
- If needed, traverse linked connections across other topic subwikis.
- Include `## References` in all outputs.
- Append a `query` log entry.

### 4) lint

Run structural and linkage checks.

Check for:

- inbox index coverage (every intake item tracked)
- raw index coverage and valid required YAML keys
- topic subwiki shape (`concepts/`, `connections/`, `index.md`)
- master index coverage (`wiki/index.md` lists all topic subwikis)
- dead links and orphan pages

Apply safe fixes, then append a `lint` log entry.

### 5) audit

Validate extraction quality and correct concept/connection drift.

- Spot-check random raw -> concept mappings.
- Verify key claims in `connections/` have supporting raw/wiki references.
- Correct weak or wrong connections and update topic/master indexes.
- Append an `audit` log entry with corrected files.

## Out of Scope

- Replacing source provenance with model memory
- Skipping `inbox/` and writing directly to `wiki/`
- Creating raw files without required YAML fields

## Session Start Checklist

At session start, do this order:

1. Read `AGENTS.md`
2. Read `wiki/index.md`
3. Inspect most recent `log/*.md`
4. Read `inbox/index.md` for unprocessed intake items
