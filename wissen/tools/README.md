# Tools

## Docling extractor

Use `docling_extract.py` to extract files (for example PDF) into markdown only.
The output markdown includes YAML frontmatter (`title`, `source_link`, `topic`,
`tags`, `generated_at`) and is intended for `raw/public/` ingest.

### Use a dedicated uv environment (recommended)

```bash
tools/run_docling_uv.sh --input "inbox/*.pdf" --outdir "raw/public" --topic "unclassified"
```

### Make target

```bash
make docling-extract
```

Optional overrides:

```bash
make docling-extract INPUT="inbox/cell-key-methode-teil2-032024.pdf" OUTDIR="raw/public" TOPIC="fdz-microdata-access-security" SOURCE_LINK="https://www.destatis.de/DE/Methoden/WISTA-Wirtschaft-und-Statistik/2024/03/cell-key-methode-teil2-032024.html" TAGS="ingest,pdf,docling,source/web,privacy/public"
```

This wrapper script will:
- create a dedicated environment at `.venv-docling` (if missing),
- install `docling` in that environment,
- run the extractor with that specific environment.

### Manual install (alternative)

```bash
pip install docling
python tools/docling_extract.py --input "inbox/*.pdf" --outdir "raw/public" --topic "unclassified"
```

## Knowledge graph builder

Build a visual graph from `wiki/public/` pages and their links (including links to `raw/public/` sources):

```bash
make knowledge-graph
```

Outputs in `wissen/` root:
- `wissen-knowledge-graph.html` (interactive, responsive)
- `wissen-knowledge-graph.png` (snapshot, if Graphviz `dot` is available)
- `wissen-knowledge-graph.dot` (graph source)
- `wissen-knowledge-graph.json` (graph data)

## Wiki query operation

Query starts at the top-level index, walks section and topic indexes, and answers from relevant pages.

Direct usage:

```bash
python3 tools/wiki_query.py --root . --wiki wiki --scope intern "your question"
```

Make target:

```bash
make wiki-query QUERY="your question"
```

Scopes:
- `intern` (default): `wiki/intern/` plus `wiki/public/`
- `public`: only `wiki/public/`
- `all`: all configured sections

## Intern-first LLM operations

These scripts are designed for private environments with a local OpenAI-compatible server.
They default to internal folders only (`inbox_intern/`, `raw/intern/`, `wiki/intern/`).

Dependencies:

```bash
pip install langchain langchain-openai
```

Environment variables:

```bash
export WIKI_LLM_BASE_URL="http://localhost:8000/v1"
export WIKI_LLM_API_KEY="dummy"
export WIKI_LLM_MODEL="gpt-oss-130b"
```

### Ingest (intern by default)

```bash
python3 tools/wiki_ingest.py --root .
# or
make wiki-ingest
```

### Compile (intern by default)

```bash
python3 tools/wiki_compile.py --root .
# or
make wiki-compile
```

### Query (intern by default)

```bash
python3 tools/wiki_query.py --root . --scope intern "your question"
# or
make wiki-query QUERY="your question"
```
