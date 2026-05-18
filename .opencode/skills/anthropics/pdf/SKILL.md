---
name: pdf
description: "Use this skill whenever a PDF is involved, including reading, extracting text or tables, OCR, merging, splitting, rotating, watermarking, encrypting, decrypting, form filling, or generating PDF output."
---

# PDF Skill

## When To Use

Use this skill for any `.pdf`-related task, including:

- Reading or extracting text from PDFs.
- Extracting tables and images.
- OCR for scanned PDFs.
- Merging, splitting, rotating, encrypting, or watermarking PDFs.
- Filling PDF forms.

## Quick Start

```python
from pypdf import PdfReader, PdfWriter

reader = PdfReader("document.pdf")
print(len(reader.pages))
```

## Common Operations

- `pypdf` for page-level manipulation and merging/splitting.
- `pdfplumber` for robust text and table extraction.
- `reportlab` for generating PDFs.
- OCR pipeline for image-based PDFs when text extraction fails.

## Quality Gates

- Validate output file opens without corruption.
- Preserve page order and dimensions unless explicitly changed.
- Confirm extracted text/tables are complete for requested scope.
- For OCR, document accuracy caveats when scan quality is low.

## References

- https://www.skills.sh/anthropics/skills/pdf
- https://github.com/anthropics/skills/tree/main/skills/pdf
