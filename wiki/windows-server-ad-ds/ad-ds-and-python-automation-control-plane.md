---
title: "AD DS and Python Automation Control Plane"
token: "120"
---

# AD DS and Python Automation Control Plane

AD DS provides the directory authority layer (accounts, policy context, and domain operations), while automation stacks can orchestrate surrounding workflows across messaging and ticketing systems. In practice, this creates a split control plane:

- AD operations remain anchored in AD DS and the ActiveDirectory PowerShell module.
- Cross-system workflow execution (for example Outlook API actions) can be delegated to Python-based automation components.
- Governance is strengthened when automation workflows treat AD changes and messaging actions as linked operational steps with explicit identity boundaries.

## Connected Concepts

- [[windows-server-ad-ds]]
- [[ActiveDirectory PowerShell Module Operations]]
- [[Outlook Automation with Microsoft Graph Python]]
- [[ai-automation]]

## References

- [[raw/windows-server-ad-ds-overview.md]]
- [[raw/powershell-activedirectory-module.md]]
- [[raw/ai-automation-microsoft-graph-create-client-python.md]]
- [[raw/ai-automation-microsoft-graph-python-email.md]]
