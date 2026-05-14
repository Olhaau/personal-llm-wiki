---
title: "Docling agent skill (Cursor and compatible assistants)"
token: "227"
source_link: "https://docling-project.github.io/docling/examples/agent_skill/docling-document-intelligence/"
topic: "docling"
tags: ["source/web", "privacy/public", "ingest", "docling", "agent-skill"]
generated_at: "2026-05-13T23:51:08Z"
---

# Docling agent skill (Cursor and compatible assistants)

This folder is an [Agent Skill](https://agentskills.io/specification)-style bundle for AI coding assistants: structured instructions (`SKILL.md`), a pipeline reference (`pipelines.md`), and a quality evaluator (`scripts/docling-evaluate.py`).

Conversion is done via the `docling` CLI (included with `pip install docling`). The evaluator adds a convert -> evaluate -> refine feedback loop that the base CLI does not cover.

It complements the official Docling docs and CLI reference. The same layout is published in the Docling repository under `docs/examples/agent_skill/docling-document-intelligence/`.

## Contents

| Path | Purpose |
|---|---|
| `SKILL.md` | Full skill instructions (pipelines, chunking, evaluation loop) |
| `pipelines.md` | Standard and VLM pipelines, OCR engines, API notes |
| `EXAMPLE.md` | Installing into `~/.cursor/skills/`; running the CLI and evaluator |
| `improvement-log.md` | Optional template for local "what worked" notes |
| `scripts/docling-evaluate.py` | Heuristic quality report on JSON (and optional Markdown) |
| `scripts/requirements.txt` | Minimal pip dependencies for evaluator |

## Quick start

```bash
pip install docling docling-core

# Convert to Markdown
docling https://arxiv.org/pdf/2408.09869 --output /tmp/

# Convert to JSON
docling https://arxiv.org/pdf/2408.09869 --to json --output /tmp/

# Evaluate quality
python3 scripts/docling-evaluate.py /tmp/2408.09869.json --markdown /tmp/2408.09869.md
```

Use `--pipeline vlm` for vision-model pipelines.

## License

MIT (aligned with Docling).
