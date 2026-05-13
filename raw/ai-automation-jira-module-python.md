---
title: "Atlassian Python API Jira module"
token: "106"
source_link: "https://atlassian-python-api.readthedocs.io/jira.html"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, jira, atlassian, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# Atlassian Python API Jira module

The Jira module page documents Python methods for common automation operations: querying issues, managing projects, creating/updating issues, transitions, comments, attachments, and agile board interactions.

Query and pagination example:

```python
jql_request = "project = DEMO AND status NOT IN (Closed, Resolved) ORDER BY issuekey"
issues = jira.jql(jql_request)
```

Issue update example:

```python
fields = {"summary": "New summary"}
jira.update_issue_field("PROJECT-123", fields, notify_users=True)
```

Issue creation syntax (from docs):

```python
fields = {
    "summary": "Into The Night",
    "project": {"key": "APA"},
    "issuetype": {"name": "Story"},
}
jira.create_issue(fields)
```

The module groups methods by automation domains such as project administration, issue lifecycle, permission/group handling, and reporting/export tasks.
