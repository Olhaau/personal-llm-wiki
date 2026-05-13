---
title: "Executable Prompt for Ingest"
token: "84"
---

# Executable Prompt for Ingest

```text
Ingest this source into the wiki.

SOURCE: <url-or-local-path>
TARGET_TOPIC: <topic-slug>
SCOPE: public

Requirements:
1) Save normalized markdown to raw/<slug>.md.
2) Use YAML frontmatter with: title, token, source_link, topic, tags, generated_at.
3) Preserve factual source content; do not add analysis beyond minimal normalization.
4) Update raw/_index.md with a new row.
5) If images are not explicitly requested, keep ingest text-only.
6) Return the created file path and the new raw index row.
```

## References

- [[raw/lewislulu-llm-wiki-skill.md]]
- [[raw/nvk-llm-wiki.md]]
