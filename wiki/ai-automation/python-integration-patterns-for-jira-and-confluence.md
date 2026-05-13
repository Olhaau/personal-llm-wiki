---
title: "Python Integration Patterns for Jira and Confluence"
token: "93"
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

- [[ai-automation]]
- [[Outlook Automation with Microsoft Graph Python]]
- [[Ticket-Mail-Docs Secret Flow]]

## References

- [[raw/ai-automation-atlassian-python-api-overview.md]]
- [[raw/ai-automation-jira-module-python.md]]
- [[raw/ai-automation-confluence-module-python.md]]
