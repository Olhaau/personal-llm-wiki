---
title: "Fabric Installation and Setup"
token: "0"
topic: "ai-tooling"
generated_at: "2026-05-14T12:17:56Z"
---

## Summary

Fabric installation is offered through multiple channels: one-line shell installers, package managers, and source install with Go [[raw/fabric-readme.md]]. Setup is completed by running `fabric --setup`, which initializes runtime configuration for provider and pattern usage [[raw/fabric-readme.md]].

## Details

The recommended install path uses hosted installer scripts for Unix and PowerShell, while binary releases are published at GitHub Releases with hashes [[raw/fabric-readme.md]]. Package managers include Homebrew, Arch AUR, Winget, and Scoop, with a naming caveat that Homebrew and AUR expose the command as `fabric-ai` [[raw/fabric-readme.md]].

From source, installation is performed through `go install github.com/danielmiessler/fabric/cmd/fabric@latest`, which aligns with the project's Go-first distribution model [[raw/fabric-readme.md]].

## Connected Concepts

- [[wiki/ai-tooling/fabric.md]] - Installation paths support the broader Fabric model of reusable pattern-driven workflows.
- [[wiki/ai-tooling/fabric-installation-to-usage.md]] - Setup decisions determine how patterns, providers, and serving modes are used operationally.

## References

- [[raw/fabric-readme.md]]
- https://github.com/danielmiessler/fabric
