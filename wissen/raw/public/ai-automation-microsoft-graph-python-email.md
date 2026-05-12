---
title: "Microsoft Graph Python email tutorial"
token: 322
source_link: "https://learn.microsoft.com/en-us/graph/tutorials/python-email"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, outlook, microsoft-graph, email, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# Microsoft Graph Python email tutorial

The tutorial extends a Python Graph app with mailbox automation, including reading inbox messages and sending mail.

Inbox query pattern:

```python
query_params = MessagesRequestBuilder.MessagesRequestBuilderGetQueryParameters(
    select=["from", "isRead", "receivedDateTime", "subject"],
    top=25,
    orderby=["receivedDateTime DESC"],
)

messages = await self.user_client.me.mail_folders.by_mail_folder_id("inbox").messages.get(
    request_configuration=request_config
)
```

Send-mail pattern:

```python
request_body = SendMailPostRequestBody()
request_body.message = message
await self.user_client.me.send_mail.post(body=request_body)
```

The page also explains paging behavior via `odata_next_link` and maps these SDK calls to Graph endpoints for list-messages and send-mail operations.
