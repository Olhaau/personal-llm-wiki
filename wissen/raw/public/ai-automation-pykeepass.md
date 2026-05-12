---
title: "PyKeePass documentation"
token: 274
source_link: "https://pykeepass.readthedocs.io/en/latest/index.html"
topic: "ai-automation"
tags: [ingest, web, ai-automation, python, keepass, secrets, fetched]
generated_at: "2026-05-11T00:00:00Z"
---

# PyKeePass documentation

PyKeePass provides Python access to KeePass databases (`.kdbx`) for reading and updating credentials and entries.

Basic open/find/read pattern from docs:

```python
from pykeepass import PyKeePass

kp = PyKeePass("db.kdbx", password="somePassw0rd")
entry = kp.find_entries(title="facebook", first=True)
password = entry.password
```

Create and persist entries:

```python
group = kp.add_group(kp.root_group, "email")
kp.add_entry(group, "gmail", "myusername", "myPassw0rdXX")
kp.save()
```

The documentation also covers attachment APIs, group operations, and search with path and regex options.
