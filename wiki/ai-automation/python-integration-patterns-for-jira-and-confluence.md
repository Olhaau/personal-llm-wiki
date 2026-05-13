---
title: "Python Integration Patterns for Jira and Confluence"
token: "86"
---

# Python Integration Patterns for Jira and Confluence

The Atlassian Python API documentation defines a common integration approach: initialize product-specific clients with cloud credentials, then call high-level methods for issue and page operations.

Typical Python setup:

```python
from atlassian import Jira
from atlassian.confluence import ConfluenceCloud
```

Jira automation patterns include JQL search, issue updates, and issue creation.
Confluence automation patterns include create/update page flows, CQL search, and attachment management.

## Connected Concepts

- [[ai-automation.md]]
- [[outlook-automation-with-microsoft-graph-python.md]]
- [[ticket-mail-docs-secret-flow.md]]

## References

- [[ai-automation-atlassian-python-api-overview.md]]
- [[ai-automation-jira-module-python.md]]
- [[ai-automation-confluence-module-python.md]]
