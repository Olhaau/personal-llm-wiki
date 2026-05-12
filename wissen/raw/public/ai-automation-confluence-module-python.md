---
title: "Atlassian Python API Confluence module"
token: 280
source_link: "https://atlassian-python-api.readthedocs.io/confluence.html"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, confluence, atlassian, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# Atlassian Python API Confluence module

The Confluence module documentation distinguishes cloud and server client classes and describes page, space, user/group, search, template, and attachment operations.

Cloud/server client pattern:

```python
from atlassian.confluence import ConfluenceCloud, ConfluenceServer

confluence_cloud = ConfluenceCloud(
    url="https://your-domain.atlassian.net",
    token="your-api-token",
)

confluence_server = ConfluenceServer(
    url="https://your-confluence-server.com",
    username="your-username",
    password="your-password",
)
```

Page creation/update operations documented include:

```python
confluence.create_page(space, title, body)
confluence.update_page(page_id, title, body)
```

Search and retrieval use CQL and page getters, enabling automation workflows that synchronize issue data, docs pages, and knowledge updates.
