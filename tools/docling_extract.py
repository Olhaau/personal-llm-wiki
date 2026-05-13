#!/usr/bin/env python3
"""Extract documents with Docling into markdown files with YAML frontmatter.

Example:
  python tools/docling_extract.py --input "inbox/*.pdf" --outdir "raw" --topic "my-topic"
"""

from __future__ import annotations

import argparse
import sys
from datetime import UTC, datetime
from pathlib import Path

try:
    from docling.document_converter import DocumentConverter
except ImportError as exc:  # pragma: no cover
    raise SystemExit(
        "Docling is not installed. Install with: pip install docling"
    ) from exc


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Extract files (e.g. PDF) using Docling."
    )
    parser.add_argument(
        "--input",
        "-i",
        nargs="+",
        required=True,
        help="Input file paths or glob patterns.",
    )
    parser.add_argument(
        "--outdir",
        "-o",
        default="raw",
        help="Directory for extracted outputs.",
    )
    parser.add_argument(
        "--topic",
        default="unclassified",
        help="Topic value for YAML frontmatter.",
    )
    parser.add_argument(
        "--source-link",
        default="",
        help="Original source URL for YAML frontmatter.",
    )
    parser.add_argument(
        "--title",
        default="",
        help="Optional explicit title. Defaults to file stem.",
    )
    parser.add_argument(
        "--tags",
        default="ingest,pdf,docling,source/web,privacy/public",
        help="Comma-separated tags for YAML frontmatter.",
    )
    parser.add_argument(
        "--recursive",
        action="store_true",
        help="Use recursive glob expansion for patterns.",
    )
    return parser.parse_args()


def expand_inputs(patterns: list[str], recursive: bool) -> list[Path]:
    files: list[Path] = []
    for pattern in patterns:
        path = Path(pattern)
        if path.exists() and path.is_file():
            files.append(path.resolve())
            continue

        if recursive:
            matched = [p for p in Path().glob(pattern) if p.is_file()]
        else:
            matched = [p for p in Path().glob(pattern) if p.is_file()]

        files.extend([p.resolve() for p in matched])

    deduped = sorted(set(files))
    return deduped


def frontmatter(
    title: str,
    source_link: str,
    topic: str,
    tags: list[str],
) -> str:
    now = datetime.now(UTC).replace(microsecond=0).isoformat().replace("+00:00", "Z")
    tags_yaml = ", ".join(tags)
    return (
        "---\n"
        f'title: "{title}"\n'
        f'source_link: "{source_link}"\n'
        f'topic: "{topic}"\n'
        f"tags: [{tags_yaml}]\n"
        f'generated_at: "{now}"\n'
        "---\n\n"
    )


def write_markdown(
    outdir: Path,
    input_file: Path,
    document: object,
    title: str,
    source_link: str,
    topic: str,
    tags: list[str],
) -> None:
    md_path = outdir / f"{input_file.stem}.md"
    body = document.export_to_markdown()
    yaml = frontmatter(
        title=title,
        source_link=source_link,
        topic=topic,
        tags=tags,
    )
    md_path.write_text(yaml + body, encoding="utf-8")


def main() -> int:
    args = parse_args()
    files = expand_inputs(args.input, args.recursive)
    if not files:
        print("No input files matched.", file=sys.stderr)
        return 2

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    tags = [tag.strip() for tag in args.tags.split(",") if tag.strip()]

    converter = DocumentConverter()

    failures = 0
    for input_file in files:
        try:
            result = converter.convert(str(input_file))
            title = args.title if args.title else input_file.stem.replace("-", " ")
            write_markdown(
                outdir=outdir,
                input_file=input_file,
                document=result.document,
                title=title,
                source_link=args.source_link,
                topic=args.topic,
                tags=tags,
            )
            print(f"OK  {input_file}")
        except Exception as exc:  # pragma: no cover
            failures += 1
            print(f"ERR {input_file}: {exc}", file=sys.stderr)

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
