---
title: "Fabric GitHub README"
token: "419"
source_link: "https://github.com/danielmiessler/fabric"
topic: "ai-tooling"
tags: ["source/web", "privacy/public", "ingest", "fabric", "github", "readme"]
generated_at: "2026-05-14T12:17:56Z"
---

# `fabric`

`fabric` is an open-source framework for augmenting humans using AI.

## What and why

Since the start of modern AI in late 2022 we've seen an extraordinary number of AI applications for accomplishing tasks. There are thousands of websites, chat-bots, mobile apps, and other interfaces for using different models.

AI does not have a capabilities problem; it has an integration problem.

Fabric was created to address this by creating and organizing the fundamental units of AI - the prompts themselves.

Fabric organizes prompts by real-world task, allowing people to create, collect, and organize AI workflows in one place, and use Fabric itself as a command-line interface.

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

### Manual Binary Downloads

The latest release binary archives and SHA256 hashes are available at:

<https://github.com/danielmiessler/fabric/releases/latest>

### Using package managers

- Homebrew: `brew install fabric-ai`
- Arch Linux (AUR): `yay -S fabric-ai`
- Winget: `winget install danielmiessler.Fabric`
- Scoop: `scoop install fabric-ai`

When using Homebrew or AUR, `fabric` is installed as `fabric-ai`, so aliasing is recommended:

```bash
alias fabric='fabric-ai'
```

### From Source

```bash
go install github.com/danielmiessler/fabric/cmd/fabric@latest
```

## Usage

```bash
fabric -h
```

Common capabilities include pattern execution, setup, listing patterns/models, web scraping, YouTube transcript extraction, REST API serving, and extension support.

Examples:

```bash
pbpaste | fabric --pattern summarize
```

```bash
fabric -u https://github.com/danielmiessler/fabric/ -p analyze_claims
```

## Philosophy and patterns

Fabric centers on human flourishing via AI augmentation and breaks problems into components that can be solved with reusable patterns.

Patterns are authored in Markdown for readability and maintainability, and users can also create private custom patterns outside the built-in set.

## REST API server

Fabric can expose its functionality over HTTP:

```bash
fabric --serve
```

It also supports an Ollama-compatible mode:

```bash
fabric --serve --serveOllama
```

## Source note

Normalized from the Fabric project README in the repository root.
