---
description: Stage changes, commit, and push branch
---
Create a git commit and push it to the current branch remote.

Commit message input: $ARGUMENTS

Behavior:
- Inspect repo state first (`git status`, `git diff`, recent `git log`) and summarize what will be committed.
- Stage relevant changes (`git add`) while avoiding likely secret files (`.env`, credentials, keys).
- If `$ARGUMENTS` is non-empty, use it as the commit message.
- If `$ARGUMENTS` is empty, draft a concise commit message in repository style focused on why.
- Create the commit and then push to the tracked remote branch.
- If no upstream exists, push with `-u origin <current-branch>`.

Return:
- Commit hash and message
- Branch and remote pushed to
- Any files skipped (with reason)
