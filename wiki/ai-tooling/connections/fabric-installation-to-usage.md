---
title: "Fabric Installation to Usage"
token: "0"
topic: "ai-tooling"
generated_at: "2026-05-14T12:17:56Z"
---

## Summary

Fabric usage quality depends on installation and setup choices because command naming, provider initialization, and optional serving modes are configured during onboarding [[raw/fabric-readme.md]].

## Details

Package-manager installs can expose the executable as `fabric-ai`, requiring shell aliasing before standard command examples work as written [[raw/fabric-readme.md]]. Running `fabric --setup` establishes the environment needed for pattern execution and vendor-backed model usage [[raw/fabric-readme.md]].

Operational modes such as `fabric --serve` and `fabric --serve --serveOllama` depend on a working baseline installation and configuration [[raw/fabric-readme.md]].

## Connected Concepts

- [[wiki/ai-tooling/concepts/fabric.md]] - Usage patterns and serving modes extend the core Fabric workflow model.
- [[wiki/ai-tooling/concepts/fabric-installation-and-setup.md]] - Installation paths and setup steps are prerequisites for stable CLI execution.

## References

- [[raw/fabric-readme.md]]
- https://github.com/danielmiessler/fabric
