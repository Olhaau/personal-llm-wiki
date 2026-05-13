---
title: "ActiveDirectory PowerShell Module Operations"
token: "107"
---

# ActiveDirectory PowerShell Module Operations

The ActiveDirectory PowerShell module provides an administrative surface for AD DS and AD LDS through a broad cmdlet catalog that supports object retrieval, provisioning, updates, security-policy handling, replication diagnostics, and account operations.

Operational highlights from the source:

- The module is distributed via RSAT and can be imported with `Import-Module ActiveDirectory` where required.
- The cmdlet set spans identity lifecycle (`Get/New/Set/Remove-ADUser`), group and computer operations, and domain or forest management.
- Replication and domain-controller diagnostics are available (`Get-ADReplicationFailure`, `Get-ADDomainController`).
- Account security and recovery actions are included (`Set-ADAccountPassword`, `Unlock-ADAccount`).

## Connected Concepts

- [[windows-server-ad-ds.md]]
- [[ad-ds-and-python-automation-control-plane.md]]

## References

- [[powershell-activedirectory-module.md]]
- [[windows-server-ad-ds-overview.md]]
