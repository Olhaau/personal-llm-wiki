---
title: "Microsoft Graph create client (Python)"
token: 234
source_link: "https://learn.microsoft.com/en-us/graph/sdks/create-client?tabs=python"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, outlook, microsoft-graph, auth, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# Microsoft Graph create client (Python)

The page describes how to instantiate a Microsoft Graph client with a token credential provider in Python.

Python snippet from the page:

```python
from azure.identity import DeviceCodeCredential
from msgraph.graph_service_client import GraphServiceClient

scopes = ["User.Read"]
tenant_id = "common"
client_id = "YOUR_CLIENT_ID"

credential = DeviceCodeCredential(
    tenant_id=tenant_id,
    client_id=client_id,
)

graph_client = GraphServiceClient(credential, scopes)
```

The document emphasizes choosing an authentication provider appropriate to the app scenario and reusing one client instance for the application lifecycle.
