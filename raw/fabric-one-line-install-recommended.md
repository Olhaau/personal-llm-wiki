---
title: "Fabric README: One-Line Install (Recommended)"
token: "123"
source_link: "https://github.com/danielmiessler/fabric#one-line-install-recommended"
topic: "ai-tooling"
tags: ["source/web", "privacy/public", "ingest", "fabric", "installation"]
generated_at: "2026-05-14T07:42:37Z"
---

## Installation

### One-Line Install (Recommended)

**Unix/Linux/macOS:**

```bash
curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash
```

**Windows PowerShell:**

```powershell
iwr -useb https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.ps1 | iex
```

See `scripts/installer/README.md` for custom installation options and troubleshooting:

`https://github.com/danielmiessler/Fabric/blob/main/scripts/installer/README.md`

### Manual Binary Downloads

The latest release binaries and expected SHA256 hashes are available at:

`https://github.com/danielmiessler/fabric/releases/latest`

### Using package managers

Homebrew and Arch Linux package managers install the command as `fabric-ai`.

```bash
alias fabric='fabric-ai'
```

Package manager commands listed in the same Installation section:

- macOS (Homebrew): `brew install fabric-ai`
- Arch Linux (AUR): `yay -S fabric-ai`
- Windows (Winget): `winget install danielmiessler.Fabric`
- Windows (Scoop): `scoop install fabric-ai`
