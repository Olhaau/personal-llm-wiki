---
description: LLM Wiki audit concept and connection quality
---
Use the `llm-wiki-skill` and run the `audit` operation for `wissen/`.

Goal:
- Validate extraction quality from raw -> concepts.
- Verify connection claims and cross-topic links.
- Correct weak or inconsistent concept/connection pages.
- Update topic indexes and `wissen/wiki/index.md` if changes are made.

Audit scope: $ARGUMENTS

If `$ARGUMENTS` is empty, run a broad audit over all topics.

Return:
- Findings
- Corrections made
- High-risk pages still needing review
- `## References` with concrete raw/wiki evidence
