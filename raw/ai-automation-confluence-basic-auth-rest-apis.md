---
title: "Confluence Cloud basic auth for REST APIs"
token: "93"
source_link: "https://developer.atlassian.com/cloud/confluence/basic-auth-for-rest-apis/"
topic: "ai-automation"
tags: [ingest, web, ai-automation, confluence, auth, basic-auth, api-token, atlassian, fetched]
generated_at: "2026-05-12T00:00:00Z"
---

# Confluence Cloud basic auth for REST APIs

The source explains how to authenticate Confluence REST API calls with Atlassian account email and API token.

Operational points:

- Basic auth is supported for scripts and manual REST calls.
- Atlassian recommends stronger auth models (for example OAuth 2.0 via app frameworks) for broader integrations.
- Credentials are formatted as `email:api_token`, base64 encoded, and sent as an `Authorization: Basic ...` header.
- Example calls target Confluence REST endpoints under `/wiki/rest/api/...`.
- API permissions still follow Confluence view and space permissions of the authenticated user.
