#!/usr/bin/env python3
"""Extract PDF content to a markdown file in raw/ for LLM ingestion.

Preferred path:
- Use Docling CLI conversion for higher-fidelity markdown output.

Fallback:
- Use PyMuPDF4LLM when Docling is unavailable.
- Use PyMuPDF text extraction when PyMuPDF4LLM is unavailable.
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import tempfile
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path


TOKEN_RE = re.compile(r"\S+")


def utc_now_iso() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def token_count(text: str) -> int:
    return len(TOKEN_RE.findall(text))


def slugify(name: str) -> str:
    return re.sub(r"[^a-zA-Z0-9]+", "-", name).strip("-").lower() or "document"


def extract_with_pymupdf4llm(pdf_path: Path, use_ocr: bool, force_ocr: bool) -> str:
    import pymupdf4llm  # type: ignore

    return pymupdf4llm.to_markdown(str(pdf_path), use_ocr=use_ocr, force_ocr=force_ocr)


def extract_with_pymupdf(pdf_path: Path) -> str:
    import pymupdf  # type: ignore

    def normalize_spaces(line: str) -> str:
        return re.sub(r"\s+", " ", line).strip()

    def is_heading_like(line: str) -> bool:
        if not line or len(line) > 120:
            return False
        if re.match(r"^\d+(?:\.\d+)*\.?\s+\S", line):
            return True
        if re.match(r"^[A-Z0-9][A-Za-z0-9\-\(\)\.,/ ]{2,80}$", line) and line.count(" ") <= 10:
            return True
        return False

    pages: list[str] = []
    with pymupdf.open(str(pdf_path)) as doc:
        raw_lines_by_page: list[list[str]] = []
        recurring_candidates: Counter[str] = Counter()

        for page in doc:
            text = page.get_text("text")
            page_lines: list[str] = []
            for raw_line in text.splitlines():
                line = normalize_spaces(raw_line)
                page_lines.append(line)
                if line and len(line) <= 120:
                    recurring_candidates[line] += 1
            raw_lines_by_page.append(page_lines)

        total_pages = len(raw_lines_by_page)
        recurring_cutoff = max(2, total_pages // 2)
        recurring_header_lines = {
            line
            for line, count in recurring_candidates.items()
            if count >= recurring_cutoff
            and not re.match(r"^\d+(?:\.\d+)*", line)
            and not re.match(r"^Seite\s+\d+\s+von\s+\d+$", line)
        }

        for idx, page_lines in enumerate(raw_lines_by_page, start=1):
            cleaned_lines: list[str] = []
            for line in page_lines:
                if not line:
                    cleaned_lines.append("")
                    continue
                if re.match(r"^Seite\s+\d+\s+von\s+\d+$", line):
                    continue
                if line in recurring_header_lines:
                    continue
                cleaned_lines.append(line)

            paragraphs: list[str] = []
            current = ""
            for line in cleaned_lines:
                if not line:
                    if current:
                        paragraphs.append(current)
                        current = ""
                    continue

                if is_heading_like(line):
                    if current:
                        paragraphs.append(current)
                        current = ""
                    paragraphs.append(f"### {line}" if not line.startswith("#") else line)
                    continue

                if not current:
                    current = line
                    continue

                if current.endswith("-") and re.match(r"^[a-z0-9].*", line):
                    current = current[:-1] + line
                else:
                    current = f"{current} {line}"

            if current:
                paragraphs.append(current)

            page_body = "\n\n".join(paragraphs).strip()
            pages.append(f"## Page {idx}\n\n{page_body}" if page_body else f"## Page {idx}")
    return "\n\n".join(pages).strip() + "\n"


def extract_with_docling(pdf_path: Path) -> str:
    with tempfile.TemporaryDirectory(prefix="docling-convert-") as tmpdir:
        output_dir = Path(tmpdir)
        cmd = [
            "docling",
            str(pdf_path),
            "--output",
            str(output_dir),
        ]
        proc = subprocess.run(cmd, capture_output=True, text=True, check=False)
        if proc.returncode != 0:
            stderr = proc.stderr.strip() or proc.stdout.strip() or "unknown docling error"
            raise RuntimeError(f"docling conversion failed: {stderr}")

        markdown_candidates = sorted(output_dir.glob("*.md"))
        if not markdown_candidates:
            raise RuntimeError("docling conversion produced no markdown output")

        markdown_path = max(markdown_candidates, key=lambda p: p.stat().st_size)
        return markdown_path.read_text(encoding="utf-8").strip() + "\n"


def yaml_quote(value: str) -> str:
    return json.dumps(value, ensure_ascii=True)


def build_frontmatter(
    *,
    title: str,
    token: int,
    source_link: str,
    topic: str,
    tags: list[str],
) -> str:
    return (
        "---\n"
        f"title: {yaml_quote(title)}\n"
        f"token: {yaml_quote(str(token))}\n"
        f"source_link: {yaml_quote(source_link)}\n"
        f"topic: {yaml_quote(topic)}\n"
        f"tags: {json.dumps(tags, ensure_ascii=True)}\n"
        f"generated_at: {yaml_quote(utc_now_iso())}\n"
        "source: \"file\"\n"
        "---\n\n"
    )


def parse_tags(tags: str) -> list[str]:
    return [part.strip() for part in tags.split(",") if part.strip()]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Extract PDF content into raw/*.md for LLM ingestion.")
    parser.add_argument("pdf", type=Path, help="Input PDF file path.")
    parser.add_argument("--output", "-o", type=Path, default=None, help="Output markdown path.")
    parser.add_argument("--topic", default="pdf-llm-ingestion", help="Frontmatter topic value.")
    parser.add_argument(
        "--tags",
        default="source/file,ingest,pdf,llm,extraction",
        help="Comma-separated frontmatter tags.",
    )
    parser.add_argument(
        "--source-link",
        default="",
        help="Optional source_link value. Defaults to the PDF file path.",
    )
    parser.add_argument(
        "--title",
        default="",
        help="Optional title override. Defaults to the PDF file stem.",
    )
    parser.add_argument(
        "--disable-ocr",
        action="store_true",
        help="Disable OCR when PyMuPDF4LLM is used.",
    )
    parser.add_argument(
        "--force-ocr",
        action="store_true",
        help="Force OCR when PyMuPDF4LLM is used.",
    )
    parser.add_argument(
        "--skip-docling",
        action="store_true",
        help="Skip Docling and start with PyMuPDF4LLM extraction.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    pdf_path = args.pdf.resolve()
    if not pdf_path.exists() or not pdf_path.is_file():
        raise FileNotFoundError(f"PDF not found: {pdf_path}")

    if args.output is None:
        output_path = Path("raw") / f"{slugify(pdf_path.stem)}.md"
    else:
        output_path = args.output

    output_path = output_path.resolve()
    output_path.parent.mkdir(parents=True, exist_ok=True)

    used_extractor = "pymupdf"
    try:
        if args.skip_docling:
            raise RuntimeError("Docling explicitly skipped")
        markdown_body = extract_with_docling(pdf_path)
        used_extractor = "docling"
    except Exception:
        try:
            markdown_body = extract_with_pymupdf4llm(
                pdf_path,
                use_ocr=not args.disable_ocr,
                force_ocr=args.force_ocr,
            )
            used_extractor = "pymupdf4llm"
        except Exception:
            markdown_body = extract_with_pymupdf(pdf_path)

    markdown_body = markdown_body.strip() + "\n"
    metadata = build_frontmatter(
        title=args.title.strip() or pdf_path.stem,
        token=token_count(markdown_body),
        source_link=args.source_link.strip() or str(pdf_path),
        topic=args.topic.strip() or "pdf-llm-ingestion",
        tags=parse_tags(args.tags),
    )

    output_path.write_text(metadata + markdown_body, encoding="utf-8")
    print(f"Wrote markdown to: {output_path}")
    print(f"Extractor: {used_extractor}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
