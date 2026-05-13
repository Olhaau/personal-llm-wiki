---
title: "Executable Prompt for Spec Kit Workflow"
token: 108
---

# Executable Prompt for Spec Kit Workflow

```text
Run a Spec Kit feature workflow for <feature-description>.

Requirements:
1) Initialize integration if missing: `specify init . --integration <agent-key>`.
2) Run constitution step for project principles.
3) Run specify step to produce the feature spec.
4) Run clarify step before planning when requirements are underspecified.
5) Run plan step with technical constraints.
6) Run tasks step to generate implementation tasks.
7) Run implement step only after tasks exist.
8) Report generated artifacts and integration key used.
9) If integration is uncertain, run `specify integration list` first.
10) If issue tracking is needed, optionally run `speckit.taskstoissues` after task generation.
```

## References

- [[raw/public/github-spec-kit-readme.md]]
- [[raw/public/github-spec-kit-integrations.md]]
