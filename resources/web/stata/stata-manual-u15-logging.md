---
title: "Stata User's Guide Chapter 15: Logging Your Session"
type: "official_documentation"
category: "stata"
subcategory: "session-logging"
tags: ["stata", "logging", "session", "documentation", "manual"]
language: "Stata"
project: "stata"
source_type: "official"
maintainer: "statacorp"
created_date: "2024-11-17"
last_updated: "2024-11-17"
status: "archived"
scope: "session-logging"
target_audience: ["stata-users", "researchers", "analysts"]
technical_level: "beginner-to-intermediate"
coverage: ["logging", "session-management", "file-formats", "documentation"]
related_technologies: ["smcl", "text-files", "session-management"]
source_urls: ["https://www.stata.com/manuals13/u15.pdf"]
version: "Stata 13"
publisher: "StataCorp LP"
year: "2013"
---

# Stata User's Guide Chapter 15: Logging Your Session

**Source**: https://www.stata.com/manuals13/u15.pdf

## Summary

Stata User's Guide Chapter 15 covers session logging functionality, including log file creation, management, and formats. The chapter explains how to create permanent records of Stata sessions using SMCL and text formats. This is official StataCorp documentation from the Stata 13 release.

## Key Facts

- **Log Command Syntax**: `log using filename` creates log files with automatic format detection based on file extension (p. 15-1)
- **Two Log Formats**: SMCL (default, preserves formatting) vs. text (plain, portable) formats available (p. 15-2)
- **File Persistence**: Log files remain open throughout session until explicitly closed with `log close` (p. 15-3)
- **Multiple Logs**: Stata supports up to 5 SMCL and 5 text logs simultaneously with named log sessions (p. 15-4)
- **Session Control**: `log off` and `log on` commands temporarily suspend/resume logging without closing files (p. 15-5)
- **Automatic Extensions**: `.smcl` extension added automatically for SMCL logs, `.log` for text logs when not specified (p. 15-2)

## Insightful Quotes

> "By default, the resulting log file contains what you type and what Stata produces in response, recorded in a format called Stata Markup and Control Language (SMCL)" (p. 15-1)

> "Once you have started logging your session, you can turn logging on and off. When you turn logging off, Stata temporarily stops recording your session but leaves the log file open." (p. 15-5)

> "You can start multiple log files, give each a different logname, and then close, temporarily suspend, or resume them each individually." (p. 15-4)

> "We recommend SMCL because it preserves fonts and colors, but you can specify the text option if you wish." (p. 15-2)

## Technical Details

- **Command**: `log using filename [, options]` where options include `text`, `replace`, `append`
- **Status Check**: `log query` shows current logging status and active log files
- **Error Handling**: Stata prevents overwriting existing logs unless `replace` option specified
- **Compatibility**: SMCL logs readable only in Stata, text logs universally accessible

## Document Metadata

- **PDF Creation**: June 8, 2013 (14:22:36 -05'00')
- **Generator**: pdfTeX-1.40.13 with TeX Live 2012
- **Format**: Multi-page PDF with embedded fonts and structured content
- **File Size**: Comprehensive chapter with detailed examples and syntax references
- **Document ID**: Part of complete Stata 13 User's Guide documentation set

## AI Context Notes

- Essential reference for Stata workflow documentation and reproducibility
- Contains complete command syntax with practical examples
- Includes troubleshooting guidance for common logging issues  
- Legacy documentation (2013) - current Stata versions may have enhanced features
- Cross-references other User's Guide chapters for related functionality
- Suitable for both beginners learning Stata and advanced users implementing reproducible research workflows

---
*This document is part of the official Stata 13 documentation. For current features, consult the latest Stata manuals at stata.com*