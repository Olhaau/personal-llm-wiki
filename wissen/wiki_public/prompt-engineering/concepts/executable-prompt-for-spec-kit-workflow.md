---
title: "Executable Prompt for Spec Kit Workflow"
token: 91
---

# Executable Prompt for Spec Kit Workflow

```text
Run a Spec Kit feature workflow for <feature-description>.

Requirements:
1) Initialize integration if missing: `specify init . --integration <agent-key>`.
2) Run constitution step for project principles.
3) Run specify step to produce the feature spec.
4) Run plan step with technical constraints.
5) Run tasks step to generate implementation tasks.
6) Run implement step only after tasks exist.
7) Report generated artifacts and integration key used.
8) If integration is uncertain, run `specify integration list` first.
```

## References

- [[raw/public/github-spec-kit-readme.md]]
- [[raw/public/github-spec-kit-integrations.md]]
