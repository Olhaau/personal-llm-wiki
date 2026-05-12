---
title: "ActiveDirectory Module | Microsoft Learn"
token: 190
source_link: "https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2025-ps"
topic: "windows-server-ad-ds"
tags: [ingest, web, windows-server, active-directory, powershell, microsoft-learn, source/web, privacy/public, fetched]
generated_at: "2026-05-12T00:00:00Z"
---

# ActiveDirectory Module | Microsoft Learn

The Active Directory module for Windows PowerShell is a module that consolidates cmdlets for managing:

- Active Directory domains
- Active Directory Lightweight Directory Services (AD LDS) configuration sets
- Active Directory Database Mounting Tool instances

The source notes:

- If the module is not installed, install the correct RSAT components for the operating system.
- In older setups, importing the module with `Import-Module ActiveDirectory` from an elevated session may be required.
- On newer Windows versions, RSAT is available via optional features.
- For PowerShell 7 usage, module compatibility guidance applies.

## ActiveDirectory Cmdlets (source-provided reference list)

The Microsoft Learn page provides the complete cmdlet catalog for this module, including read, create, update, delete, replication, policy, account, and trust operations.

Representative cmdlets from the source list include:

- `Get-ADUser`
- `Get-ADComputer`
- `Get-ADGroup`
- `New-ADUser`
- `Set-ADUser`
- `Remove-ADUser`
- `Get-ADDomainController`
- `Get-ADReplicationFailure`
- `Set-ADAccountPassword`
- `Unlock-ADAccount`

The canonical source page should be used for the full and current cmdlet table and per-cmdlet documentation links.

## Other supported versions

The page links to additional module-reference views for:

- `windowsserver2016-ps`
- `windowsserver2019-ps`
- `windowsserver2022-ps`
