---
title: "Confluence REST API v2 Update page"
token: 0
source_link: "https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-page/#api-pages-id-put"
topic: "ai-automation"
tags: [ingest, web, ai-automation, confluence, rest-api, page-update, atlassian, fetched]
generated_at: "2026-05-12T00:00:00Z"
---

# Confluence REST API v2 Update page

The Confluence Cloud REST API v2 page group documents `PUT /pages/{id}` for updating page content.

Key details captured from the source:

- Updating a page requires page view and update permissions in the target space.
- OAuth scope for update operations is `write:page:confluence`.
- Request body for update requires key fields including `id`, `status`, `title`, `body`, and `version`.
- The page body can be provided with structured representations such as `storage`.
- Versioning matters: updates are tied to version metadata in the request body.

Related operations on the same source page include creating pages (`POST /pages`) and updating only titles (`PUT /pages/{id}/title`).
