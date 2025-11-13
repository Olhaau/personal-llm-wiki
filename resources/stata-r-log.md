# Stata 13 Reference Manual - log command

**Source:** https://www.stata.com/manuals13/rlog.pdf

## Summary

This is the official Stata 13 Reference Manual entry for the `log` command, providing comprehensive documentation for session logging functionality including syntax, options, and examples. The manual covers all aspects of creating, managing, and closing log files in Stata.

**Content Type:** Official Stata reference documentation (PDF manual entry) - StataCorp LP, 2013

## Key Facts

- **Command Syntax**: Complete `log` command syntax with all options and variations (p. R-1)
- **File Types**: Support for both SMCL (Stata Markup and Control Language) and text log formats
- **Multiple Logs**: Capability to maintain multiple named log sessions simultaneously
- **Session Control**: Commands for `log on`, `log off`, `log close`, and `log query` operations
- **File Management**: Options for `replace`, `append`, and automatic file extension handling
- **Cross-Platform**: Compatible across all Stata-supported operating systems

## Insightful Quotes

*Note: Specific quotes require direct text extraction from the PDF. The document contains detailed syntax examples and usage guidelines for the log command.*

## Technical Details

- **Primary Command**: `log using filename [, options]`
- **Log Types**: SMCL (.smcl) and text (.log) formats supported
- **Status Commands**: `log query` displays current logging status
- **Control Commands**: `log on|off` for temporary suspension/resumption
- **Error Handling**: Built-in protections against overwriting existing files
- **Named Sessions**: Support for multiple concurrent log sessions with unique identifiers

## Document Metadata

- **PDF Creation**: June 8, 2013 (14:08:29 -05'00')
- **Generator**: pdfTeX-1.40.13 with TeX Live 2012
- **Format**: Multi-page reference manual entry with comprehensive examples
- **Document Series**: Part of complete Stata 13 Reference Manual set
- **Page Structure**: Systematic layout with syntax, description, options, and examples sections

## AI Context Notes

- Essential reference for Stata logging syntax and advanced features
- Contains complete option descriptions and error handling scenarios
- More technical and detailed than User's Guide chapter on same topic
- Includes programming considerations for automated log management
- Cross-references related commands like `cmdlog`, `log2html`, and `translate`
- Suitable for both interactive use and do-file programming
- Legacy documentation (2013) - current Stata versions may have enhanced options

---
*This reference manual entry provides authoritative technical documentation. For current command enhancements, consult the latest Stata documentation at stata.com*