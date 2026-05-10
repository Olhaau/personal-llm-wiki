# LLM Wiki Overview

## What Is LLM Wiki?

LLM Wiki is a workflow pattern for building a persistent, markdown-based knowledge base that an LLM continuously maintains. Instead of re-retrieving raw document chunks for every question, the model incrementally compiles sources into structured wiki pages and keeps them updated over time.

This pattern was introduced by Andrej Karpathy as an "idea file" and has since been extended by community implementations that add tooling, stricter workflows, and maintenance loops.

## Core Architecture

Most implementations follow three layers:

- Raw sources (immutable input documents)
- Wiki pages (LLM-maintained markdown knowledge)
- Schema/rules file (instructions that govern structure and operations)

This architecture makes the wiki a compounding artifact: each new source, query, or correction improves future answers.

## The Five Operations

### 1) Compile

Compile restructures existing wiki content: splitting oversized pages, merging duplicates, and rebuilding `wiki/index.md` so the knowledge graph remains navigable and consistent.

**References:**
- https://github.com/lewislulu/llm-wiki-skill/blob/main/llm-wiki/SKILL.md
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f

### 2) Ingest

Ingest adds a new source, creates a summary page, and propagates updates across concept and entity pages. The key principle is that knowledge is compiled into the wiki once and then maintained.

**References:**
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- https://gist.githubusercontent.com/karpathy/442a6bf555914893e9891c11519de94f/raw/ac46de1ad27f92b28ac95459c782c07f6b8c964a/llm-wiki.md
- https://github.com/lewislulu/llm-wiki-skill/blob/main/llm-wiki/SKILL.md

### 3) Query

Query answers questions from compiled wiki pages, then optionally promotes durable analyses back into the wiki as new pages. This makes exploration cumulative instead of ephemeral.

**References:**
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- https://github.com/lewislulu/llm-wiki-skill/blob/main/llm-wiki/SKILL.md

### 4) Lint

Lint runs health checks for dead links, orphan pages, missing index entries, and other structural quality issues so the wiki remains reliable as it grows.

**References:**
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- https://github.com/lewislulu/llm-wiki-skill/blob/main/llm-wiki/SKILL.md

### 5) Audit

Audit processes human feedback files, applies accepted corrections, records resolution notes, and archives processed feedback. This is the human-in-the-loop correction path.

**References:**
- https://github.com/lewislulu/llm-wiki-skill/blob/main/llm-wiki/SKILL.md
- https://github.com/lewislulu/llm-wiki-skill/blob/main/README.md

## Why This Pattern Works

- It shifts effort from repeated retrieval to persistent synthesis.
- It lowers maintenance overhead by letting the LLM handle bookkeeping.
- It preserves a visible, editable markdown artifact with git history.
- It supports continuous correction through explicit audit workflows.

## Clarification on Definitions

Karpathy's original document explicitly describes ingest, query, and lint as core operations. The five-operation version (compile + audit added) is a community extension represented in implementations like `lewislulu/llm-wiki-skill`.

**References:**
- https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- https://github.com/lewislulu/llm-wiki-skill/blob/main/llm-wiki/SKILL.md
