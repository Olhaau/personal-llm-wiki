---
title: "Executable Prompt for Save Chat"
token: "93"
---

# Executable Prompt for Save Chat

```text
Run prompt-save-chat for the current conversation.

Inputs:
- topic: <topic-slug>
- model: <model-name>

Required output file:
- raw/chat-<topic-slug>-<YYYYMMDDTHHMMSSZ>.md

Required frontmatter:
---
title: "Chat Concepts - <topic-slug>"
token: "<token-count>"
source_link: "chat://current-session"
topic: "<topic-slug>"
tags: [source/chat, privacy/internal, ingest]
generated_at: "<ISO-8601-UTC>"
model: "<model-name>"
---

Body requirements:
1) capture only relevant concepts, decisions, and actions from the current conversation
2) avoid private secrets
3) include concise bullets and concrete file paths
4) update raw/_index.md with a new row for the saved chat file
```

## References

- [[lewislulu-llm-wiki-skill.md]]
- [[nvk-llm-wiki.md]]
