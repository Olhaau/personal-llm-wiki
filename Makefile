.PHONY: docling-extract knowledge-graph wiki-ingest wiki-compile wiki-query

INPUT ?= inbox/*.pdf
OUTDIR ?= raw
TOPIC ?= fdz-microdata-access-security
SOURCE_LINK ?=
TITLE ?=
TAGS ?= ingest,pdf,docling,source/web,privacy/public
QUERY ?=
SCOPE ?= public
INBOX ?= inbox
RAW ?= raw
WIKI_SECTION ?= wiki
INGEST_GLOB ?= *.md

docling-extract:
	tools/run_docling_uv.sh --input "$(INPUT)" --outdir "$(OUTDIR)" --topic "$(TOPIC)" --source-link "$(SOURCE_LINK)" --title "$(TITLE)" --tags "$(TAGS)"

knowledge-graph:
	python3 tools/build_knowledge_graph.py --root . --wiki-dir wiki --raw-dir raw --html-out wissen-knowledge-graph.html --png-out wissen-knowledge-graph.png --dot-out wissen-knowledge-graph.dot --json-out wissen-knowledge-graph.json

wiki-ingest:
	python3 tools/wiki_ingest.py --root . --inbox "$(INBOX)" --raw "$(RAW)" --glob "$(INGEST_GLOB)"

wiki-compile:
	python3 tools/wiki_compile.py --root . --raw "$(RAW)" --wiki-section "$(WIKI_SECTION)"

wiki-query:
	python3 tools/wiki_query.py --root . --wiki . --scope "$(SCOPE)" "$(QUERY)"
