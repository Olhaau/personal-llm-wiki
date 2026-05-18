---
name: pptx
description: "Use this skill any time a .pptx file is involved in any way as input, output, or both. Trigger when users mention pptx, deck, slides, or presentation tasks such as creating, editing, extracting content, or restructuring slide files."
---

# PPTX Skill

## When To Use

Use this skill whenever work touches PowerPoint content, including:

- Creating a new presentation from scratch.
- Editing an existing `.pptx` deck.
- Extracting text or structure from slides.
- Reformatting layouts, notes, or slide organization.

## Core Workflows

### Read or extract content

```bash
python -m markitdown presentation.pptx
```

### Edit an existing deck

- Unpack, modify, and repack slide content carefully.
- Preserve visual hierarchy, spacing, and typography consistency.
- Verify no text overflow, overlap, or low-contrast regions.

### Create a deck from scratch

- Prefer programmatic generation with reusable layouts.
- Keep a consistent visual system across all slides.
- Use clear title/body hierarchy and concise slide copy.

## Quality Gates

- Ensure no placeholder text remains.
- Ensure no overlapping elements exist.
- Ensure text is readable and contrast is sufficient.
- Ensure output opens correctly in standard PowerPoint clients.

## References

- https://www.skills.sh/anthropics/skills/pptx
- https://github.com/anthropics/skills/tree/main/skills/pptx
