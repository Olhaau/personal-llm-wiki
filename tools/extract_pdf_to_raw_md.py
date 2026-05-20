#!/usr/bin/env python3
"""Extract PDF content to a markdown file in raw/ for LLM ingestion.

Preferred path:
- Use PyMuPDF4LLM for layout-aware markdown extraction.

Fallback:
- Use PyMuPDF text extraction when PyMuPDF4LLM is unavailable.
"""

from __future__ import annotations

import argparse
import json
import re
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

    pages: list[str] = []
    with pymupdf.open(str(pdf_path)) as doc:
        for idx, page in enumerate(doc, start=1):
            text = page.get_text("text").strip()
            pages.append(f"## Page {idx}\n\n{text}" if text else f"## Page {idx}")
    return "\n\n".join(pages).strip() + "\n"


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
