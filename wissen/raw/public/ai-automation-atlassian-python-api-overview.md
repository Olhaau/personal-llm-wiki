---
title: "Atlassian Python API overview"
token: 238
source_link: "https://atlassian-python-api.readthedocs.io/"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, jira, confluence, atlassian, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# Atlassian Python API overview

The documentation shows a shared Python client package for multiple Atlassian products, including Jira and Confluence.

Install:

```bash
pip install atlassian-python-api
```

Python connection pattern:

```python
from atlassian import Jira, Confluence

jira = Jira(
    url="https://your-domain.atlassian.net",
    username=atlassian_username,
    password=atlassian_api_token,
    cloud=True,
)

confluence = Confluence(
    url="https://your-domain.atlassian.net",
    username=atlassian_username,
    password=atlassian_api_token,
    cloud=True,
)
```

Authentication variants listed in the page include API token usage for cloud, OAuth-based flows, kerberos mode, and cookie-based reuse.

The page links to module-specific operation references for Jira and Confluence.
