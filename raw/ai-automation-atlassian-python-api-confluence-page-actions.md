---
title: "Atlassian Python API Confluence page actions"
token: "76"
source_link: "https://atlassian-python-api.readthedocs.io/confluence.html"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, confluence, atlassian-python-api, page-update, fetched]
generated_at: "2026-05-12T00:00:00Z"
---

# Atlassian Python API Confluence page actions

The Confluence module documentation in `atlassian-python-api` describes high-level operations for page lifecycle automation.

Captured methods relevant to modifying pages:

- `update_page(page_id, title, body, ...)` for replacing page content.
- `update_or_create(parent_id, title, body, ...)` for idempotent publish flow.
- `append_page(page_id, title, append_body, ...)` for incremental content updates.
- `set_page_property(page_id, data)` and `get_page_property(...)` for metadata-controlled workflows.

The page also documents Cloud vs Server implementation differences and shared CRUD-style content management capabilities.
