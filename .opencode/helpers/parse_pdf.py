#!/usr/bin/env python3
"""
PDF Parser for AI Agents

Smartly parses PDFs with:
- Section detection and extraction
- Content compaction for context window efficiency
- Hierarchical structure preservation
- Table and figure detection
- Metadata extraction
- Smart summarization modes

Dependencies:
    pip install pymupdf pdfplumber

Usage:
    python3 parse_pdf.py <pdf_path> [options]

Options:
    --mode [full|compact|sections|toc|metadata]
        full: Extract all text (default)
        compact: Smart compaction for limited context
        sections: Parse by detected sections
        toc: Extract table of contents only
        metadata: Extract metadata only

    --max-tokens <int>: Target max tokens for output (default: 8000)
    --section <name>: Extract specific section by name
    --pages <range>: Page range (e.g., "1-10" or "1,3,5")
    --output <path>: Output file path (optional, prints to stdout by default)
    --format [text|markdown|json]: Output format (default: markdown)
"""

import sys
import re
import json
import argparse
from pathlib import Path
from dataclasses import dataclass, field, asdict
from typing import Optional
from collections.abc import Generator


# Lazy imports for better error handling
def import_pymupdf():
    try:
        import fitz  # PyMuPDF

        return fitz
    except ImportError:
        print("Error: PyMuPDF not installed. Run: pip install pymupdf", file=sys.stderr)
        sys.exit(1)


def import_pdfplumber():
    try:
        import pdfplumber

        return pdfplumber
    except ImportError:
        return None  # Optional dependency


@dataclass
class PDFMetadata:
    """PDF document metadata"""

    title: str = ""
    author: str = ""
    subject: str = ""
    keywords: str = ""
    creator: str = ""
    producer: str = ""
    creation_date: str = ""
    modification_date: str = ""
    page_count: int = 0
    file_size: str = ""
    file_path: str = ""


@dataclass
class Section:
    """Represents a document section"""

    title: str
    level: int
    page_start: int
    page_end: int = -1
    content: str = ""
    subsections: list = field(default_factory=list)

    def to_dict(self):
        return {
            "title": self.title,
            "level": self.level,
            "page_start": self.page_start,
            "page_end": self.page_end,
            "content_preview": self.content[:200] + "..."
            if len(self.content) > 200
            else self.content,
            "subsections": [s.to_dict() for s in self.subsections],
        }


@dataclass
class ParseResult:
    """Result of PDF parsing"""

    metadata: PDFMetadata
    sections: list
    full_text: str = ""
    toc: list = field(default_factory=list)
    tables: list = field(default_factory=list)
    figures: list = field(default_factory=list)


class PDFParser:
    """Smart PDF parser for AI agent consumption"""

    # Common section header patterns (multilingual)
    SECTION_PATTERNS = [
        # Numbered sections: "1. Introduction", "1.1 Background"
        r"^(\d+(?:\.\d+)*)\s+([A-ZÄÖÜ][^\n]{2,60})$",
        # Roman numerals: "I. Introduction", "II. Methods"
        r"^([IVXLC]+)\.\s+([A-ZÄÖÜ][^\n]{2,60})$",
        # All caps headers
        r"^([A-ZÄÖÜ][A-ZÄÖÜ\s]{4,50})$",
        # Common section names (English)
        r"^(Abstract|Introduction|Background|Methods?|Methodology|Results?|Discussion|Conclusion|References|Appendix|Summary|Overview)s?$",
        # Common section names (German)
        r"^(Zusammenfassung|Einleitung|Hintergrund|Methoden?|Methodik|Ergebnisse?|Diskussion|Fazit|Schlussfolgerung|Literatur|Anhang|Überblick)$",
    ]

    def __init__(self, pdf_path: str):
        self.fitz = import_pymupdf()
        self.pdfplumber = import_pdfplumber()
        self.pdf_path = Path(pdf_path)

        if not self.pdf_path.exists():
            raise FileNotFoundError(f"PDF not found: {pdf_path}")

        self.doc = self.fitz.open(str(self.pdf_path))
        self._compiled_patterns = [
            re.compile(p, re.MULTILINE | re.IGNORECASE) for p in self.SECTION_PATTERNS
        ]

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    def close(self):
        if self.doc:
            self.doc.close()

    def get_metadata(self) -> PDFMetadata:
        """Extract PDF metadata"""
        meta = self.doc.metadata
        file_size = self.pdf_path.stat().st_size

        # Format file size
        if file_size > 1024 * 1024:
            size_str = f"{file_size / (1024 * 1024):.1f} MB"
        else:
            size_str = f"{file_size / 1024:.1f} KB"

        return PDFMetadata(
            title=meta.get("title", "") or self.pdf_path.stem,
            author=meta.get("author", ""),
            subject=meta.get("subject", ""),
            keywords=meta.get("keywords", ""),
            creator=meta.get("creator", ""),
            producer=meta.get("producer", ""),
            creation_date=meta.get("creationDate", ""),
            modification_date=meta.get("modDate", ""),
            page_count=len(self.doc),
            file_size=size_str,
            file_path=str(self.pdf_path),
        )

    def get_toc(self) -> list:
        """Extract table of contents if available"""
        toc = self.doc.get_toc()
        return [
            {"level": level, "title": title, "page": page} for level, title, page in toc
        ]

    def extract_page_text(self, page_num: int) -> str:
        """Extract text from a specific page"""
        if page_num < 0 or page_num >= len(self.doc):
            return ""
        page = self.doc[page_num]
        return page.get_text("text")

    def extract_full_text(self, page_range: Optional[tuple] = None) -> str:
        """Extract full text from PDF"""
        texts = []
        start = page_range[0] if page_range else 0
        end = page_range[1] if page_range else len(self.doc)

        for page_num in range(start, min(end, len(self.doc))):
            page = self.doc[page_num]
            text = page.get_text("text")
            texts.append(f"--- Page {page_num + 1} ---\n{text}")

        return "\n\n".join(texts)

    def detect_sections(self) -> list[Section]:
        """Detect document sections based on formatting and patterns"""
        sections = []
        current_section = None

        for page_num in range(len(self.doc)):
            page = self.doc[page_num]
            blocks = page.get_text("dict")["blocks"]

            for block in blocks:
                if block["type"] != 0:  # Skip non-text blocks
                    continue

                for line in block.get("lines", []):
                    line_text = "".join(span["text"] for span in line["spans"]).strip()

                    if not line_text:
                        continue

                    # Check if this looks like a section header
                    is_header, level = self._is_section_header(line, line_text)

                    if is_header:
                        if current_section:
                            current_section.page_end = page_num + 1
                            sections.append(current_section)

                        current_section = Section(
                            title=line_text, level=level, page_start=page_num + 1
                        )
                    elif current_section:
                        current_section.content += line_text + " "

        # Don't forget last section
        if current_section:
            current_section.page_end = len(self.doc)
            sections.append(current_section)

        return sections

    def _is_section_header(self, line: dict, text: str) -> tuple[bool, int]:
        """Determine if a line is a section header"""
        if len(text) < 3 or len(text) > 100:
            return False, 0

        # Check font size - headers are usually larger
        spans = line.get("spans", [])
        if spans:
            font_size = spans[0].get("size", 12)
            is_bold = "bold" in spans[0].get("font", "").lower()

            # Large text or bold text might be headers
            if font_size > 14 or (font_size > 12 and is_bold):
                # Check against patterns
                for pattern in self._compiled_patterns:
                    if pattern.match(text):
                        level = 1 if font_size > 16 else 2
                        return True, level

        # Pattern-based detection for regular-sized text
        for i, pattern in enumerate(self._compiled_patterns):
            if pattern.match(text):
                # Numbered sections have natural levels
                if i == 0:  # Numbered pattern
                    level = text.count(".") + 1
                    return True, min(level, 4)
                return True, 2

        return False, 0

    def extract_tables(self) -> list:
        """Extract tables using pdfplumber if available"""
        if not self.pdfplumber:
            return []

        tables = []
        try:
            with self.pdfplumber.open(str(self.pdf_path)) as pdf:
                for page_num, page in enumerate(pdf.pages):
                    page_tables = page.extract_tables()
                    for table_idx, table in enumerate(page_tables):
                        if table:
                            tables.append(
                                {
                                    "page": page_num + 1,
                                    "table_index": table_idx,
                                    "data": table,
                                    "row_count": len(table),
                                    "col_count": len(table[0]) if table else 0,
                                }
                            )
        except Exception as e:
            print(f"Warning: Table extraction failed: {e}", file=sys.stderr)

        return tables

    def compact_text(self, text: str, max_tokens: int = 8000) -> str:
        """
        Smart text compaction for limited context windows.

        Strategies:
        1. Remove redundant whitespace and formatting
        2. Compress repeated patterns
        3. Summarize less important sections
        4. Preserve key content (headings, first sentences, conclusions)
        """
        # Rough token estimate (1 token ≈ 4 chars for English, 2-3 for German)
        estimated_tokens = len(text) / 3.5

        if estimated_tokens <= max_tokens:
            return self._clean_text(text)

        lines = text.split("\n")
        compacted = []
        current_tokens = 0
        target_tokens = max_tokens * 0.9  # Leave some buffer

        # Priority processing
        priority_sections = []
        regular_content = []

        for line in lines:
            line = line.strip()
            if not line:
                continue

            # High priority: section headers, page markers
            is_priority = (
                line.startswith("---")
                or any(p.match(line) for p in self._compiled_patterns)
                or line.isupper()
                and len(line) < 50
            )

            if is_priority:
                priority_sections.append(line)
            else:
                regular_content.append(line)

        # Always include priority content
        for line in priority_sections:
            compacted.append(line)
            current_tokens += len(line) / 3.5

        # Add regular content with smart truncation
        remaining_tokens = target_tokens - current_tokens
        if remaining_tokens > 0:
            # Take first and last portions of each paragraph group
            chunk_size = int(remaining_tokens * 3.5)  # Convert back to chars
            total_regular = sum(len(line) for line in regular_content)

            if total_regular <= chunk_size:
                compacted.extend(regular_content)
            else:
                # Take beginning, some middle samples, and end
                regular_text = "\n".join(regular_content)
                begin_size = chunk_size // 3
                end_size = chunk_size // 3

                compacted.append(regular_text[:begin_size])
                compacted.append(
                    "\n[... content truncated for context efficiency ...]\n"
                )
                compacted.append(regular_text[-end_size:])

        return self._clean_text("\n".join(compacted))

    def _clean_text(self, text: str) -> str:
        """Clean and normalize text"""
        # Remove excessive whitespace
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = re.sub(r" {2,}", " ", text)
        text = re.sub(r"\t+", " ", text)

        # Remove page numbers and headers/footers (common patterns)
        text = re.sub(r"\n\d+\n", "\n", text)  # Standalone page numbers
        text = re.sub(r"Page \d+ of \d+", "", text)
        text = re.sub(r"Seite \d+ von \d+", "", text)

        return text.strip()

    def parse(
        self,
        mode: str = "full",
        max_tokens: int = 8000,
        section_name: Optional[str] = None,
        page_range: Optional[tuple] = None,
    ) -> ParseResult:
        """
        Main parsing method with multiple modes.

        Args:
            mode: Parsing mode (full|compact|sections|toc|metadata)
            max_tokens: Target max tokens for compact mode
            section_name: Specific section to extract
            page_range: Tuple of (start, end) pages (1-indexed)
        """
        metadata = self.get_metadata()
        toc = self.get_toc()

        result = ParseResult(metadata=metadata, sections=[], toc=toc)

        if mode == "metadata":
            return result

        if mode == "toc":
            return result

        # Convert 1-indexed to 0-indexed for internal use
        internal_range = None
        if page_range:
            internal_range = (page_range[0] - 1, page_range[1])

        if mode == "sections":
            result.sections = self.detect_sections()
            if section_name:
                # Filter to specific section
                result.sections = [
                    s
                    for s in result.sections
                    if section_name.lower() in s.title.lower()
                ]
            return result

        # Extract full text
        full_text = self.extract_full_text(internal_range)

        if mode == "compact":
            result.full_text = self.compact_text(full_text, max_tokens)
        else:
            result.full_text = self._clean_text(full_text)

        # Try to extract tables
        result.tables = self.extract_tables()

        return result


def format_output(result: ParseResult, format_type: str = "markdown") -> str:
    """Format parse result for output"""

    if format_type == "json":
        output = {
            "metadata": asdict(result.metadata),
            "toc": result.toc,
            "sections": [s.to_dict() for s in result.sections],
            "tables_count": len(result.tables),
            "text_length": len(result.full_text),
            "content": result.full_text[:50000]
            if result.full_text
            else None,  # Limit JSON content
        }
        return json.dumps(output, indent=2, ensure_ascii=False)

    if format_type == "text":
        output = []
        meta = result.metadata
        output.append(f"Title: {meta.title}")
        output.append(f"Author: {meta.author}")
        output.append(f"Pages: {meta.page_count}")
        output.append(f"Size: {meta.file_size}")
        output.append("")
        if result.full_text:
            output.append(result.full_text)
        return "\n".join(output)

    # Default: markdown
    output = []
    meta = result.metadata

    output.append(f"# {meta.title}\n")
    output.append("## Document Metadata\n")
    output.append("| Field | Value |")
    output.append("|-------|-------|")
    output.append(f"| **Title** | {meta.title} |")
    if meta.author:
        output.append(f"| **Author** | {meta.author} |")
    if meta.subject:
        output.append(f"| **Subject** | {meta.subject} |")
    output.append(f"| **Pages** | {meta.page_count} |")
    output.append(f"| **File Size** | {meta.file_size} |")
    output.append(f"| **File** | `{meta.file_path}` |")
    output.append("")

    if result.toc:
        output.append("## Table of Contents\n")
        for item in result.toc:
            indent = "  " * (item["level"] - 1)
            output.append(f"{indent}- {item['title']} (p. {item['page']})")
        output.append("")

    if result.sections:
        output.append("## Detected Sections\n")
        for section in result.sections:
            prefix = "#" * (section.level + 2)
            output.append(f"{prefix} {section.title}")
            output.append(f"*Pages {section.page_start}-{section.page_end}*\n")
            if section.content:
                preview = (
                    section.content[:500] + "..."
                    if len(section.content) > 500
                    else section.content
                )
                output.append(preview)
                output.append("")

    if result.tables:
        output.append(f"## Tables Found: {len(result.tables)}\n")
        for table in result.tables[:5]:  # Limit to first 5 tables
            output.append(f"### Table on Page {table['page']}")
            output.append(
                f"*{table['row_count']} rows × {table['col_count']} columns*\n"
            )
            # Show first few rows as markdown table
            if table["data"]:
                for row in table["data"][:3]:
                    output.append(
                        "| " + " | ".join(str(cell or "") for cell in row) + " |"
                    )
            output.append("")

    if result.full_text:
        output.append("## Content\n")
        output.append(result.full_text)

    return "\n".join(output)


def parse_page_range(range_str: str) -> tuple:
    """Parse page range string like '1-10' or '1,3,5'"""
    if "-" in range_str:
        parts = range_str.split("-")
        return (int(parts[0]), int(parts[1]) + 1)
    elif "," in range_str:
        pages = [int(p) for p in range_str.split(",")]
        return (min(pages), max(pages) + 1)
    else:
        page = int(range_str)
        return (page, page + 1)


def main():
    parser = argparse.ArgumentParser(
        description="Smart PDF parser for AI agents",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )

    parser.add_argument("pdf_path", help="Path to PDF file")
    parser.add_argument(
        "--mode",
        choices=["full", "compact", "sections", "toc", "metadata"],
        default="full",
        help="Parsing mode (default: full)",
    )
    parser.add_argument(
        "--max-tokens",
        type=int,
        default=8000,
        help="Target max tokens for compact mode (default: 8000)",
    )
    parser.add_argument("--section", type=str, help="Extract specific section by name")
    parser.add_argument(
        "--pages", type=str, help="Page range (e.g., '1-10' or '1,3,5')"
    )
    parser.add_argument("--output", type=str, help="Output file path")
    parser.add_argument(
        "--format",
        choices=["text", "markdown", "json"],
        default="markdown",
        help="Output format (default: markdown)",
    )

    args = parser.parse_args()

    try:
        page_range = parse_page_range(args.pages) if args.pages else None

        with PDFParser(args.pdf_path) as parser_instance:
            result = parser_instance.parse(
                mode=args.mode,
                max_tokens=args.max_tokens,
                section_name=args.section,
                page_range=page_range,
            )

        output = format_output(result, args.format)

        if args.output:
            with open(args.output, "w", encoding="utf-8") as f:
                f.write(output)
            print(f"Output saved to: {args.output}", file=sys.stderr)
        else:
            print(output)

    except FileNotFoundError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error parsing PDF: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
