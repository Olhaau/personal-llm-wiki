#!/usr/bin/env python3
"""Extract documents with Docling into markdown files with YAML frontmatter.

Example:
  python tools/docling_extract.py --input "inbox/*.pdf" --outdir "raw" --topic "my-topic"
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import UTC, datetime
from pathlib import Path
from urllib.parse import urlparse

DocumentConverter = None


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
    parser.add_argument(
        "--output-name",
        default="",
        help="Optional output base filename (without .md).",
    )
    return parser.parse_args()


def is_url(value: str) -> bool:
    parsed = urlparse(value)
    return parsed.scheme in {"http", "https"} and bool(parsed.netloc)


def expand_inputs(patterns: list[str], recursive: bool) -> list[str]:
    files: list[str] = []
    for pattern in patterns:
        if is_url(pattern):
            files.append(pattern)
            continue

        path = Path(pattern)
        if path.exists() and path.is_file():
            files.append(str(path.resolve()))
            continue

        if recursive:
            matched = [p for p in Path().glob(pattern) if p.is_file()]
        else:
            matched = [p for p in Path().glob(pattern) if p.is_file()]

        files.extend([str(p.resolve()) for p in matched])

    deduped = sorted(set(files))
    return deduped


def approx_token_count(text: str) -> int:
    return len(re.findall(r"\S+", text))


def frontmatter(
    title: str,
    source_link: str,
    topic: str,
    tags: list[str],
    token: int,
) -> str:
    now = datetime.now(UTC).replace(microsecond=0).isoformat().replace("+00:00", "Z")
    tags_yaml = ", ".join(tags)
    return (
        "---\n"
        f'title: "{title}"\n'
        f'token: "{token}"\n'
        f'source_link: "{source_link}"\n'
        f'topic: "{topic}"\n'
        f"tags: [{tags_yaml}]\n"
        f'generated_at: "{now}"\n'
        "---\n\n"
    )


def write_markdown(
    outdir: Path,
    input_ref: str,
    body: str,
    title: str,
    source_link: str,
    topic: str,
    tags: list[str],
    output_name: str,
) -> None:
    stem = output_name.strip()
    if not stem:
        if is_url(input_ref):
            parsed = urlparse(input_ref)
            tail = Path(parsed.path).stem.strip()
            stem = tail if tail else parsed.netloc.replace(".", "-")
        else:
            stem = Path(input_ref).stem

    md_path = outdir / f"{stem}.md"
    yaml = frontmatter(
        title=title,
        source_link=source_link,
        topic=topic,
        tags=tags,
        token=approx_token_count(body),
    )
    md_path.write_text(yaml + body, encoding="utf-8")


def convert_with_cli(input_ref: str) -> str:
    docling_bin = shutil.which("docling")
    if not docling_bin:
        candidate = Path(__file__).resolve().parents[2] / ".venv-docling" / "bin" / "docling"
        if candidate.exists():
            docling_bin = str(candidate)

    if not docling_bin:
        raise RuntimeError("Docling CLI not found on PATH or at .venv-docling/bin/docling")

    with tempfile.TemporaryDirectory(prefix="docling-extract-") as tmp:
        tmp_path = Path(tmp)
        cmd = [docling_bin, "--to", "md", "--output", str(tmp_path), input_ref]
        subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        files = sorted(tmp_path.glob("*.md"))
        if not files:
            raise RuntimeError(f"Docling CLI produced no markdown for input: {input_ref}")
        return files[0].read_text(encoding="utf-8", errors="replace")


def main() -> int:
    args = parse_args()
    files = expand_inputs(args.input, args.recursive)
    if not files:
        print("No input files matched.", file=sys.stderr)
        return 2

    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    tags = [tag.strip() for tag in args.tags.split(",") if tag.strip()]

    converter = None
    try:
        from docling.document_converter import DocumentConverter as _DocumentConverter

        converter = _DocumentConverter()
    except Exception:
        converter = None

    failures = 0
    for input_ref in files:
        try:
            body = ""
            if converter is not None:
                result = converter.convert(input_ref)
                body = result.document.export_to_markdown()
            else:
                body = convert_with_cli(input_ref)

            default_title = (
                Path(urlparse(input_ref).path).stem if is_url(input_ref) else Path(input_ref).stem
            )
            title = args.title if args.title else default_title.replace("-", " ")
            source_link = args.source_link if args.source_link else input_ref
            write_markdown(
                outdir=outdir,
                input_ref=input_ref,
                body=body,
                title=title,
                source_link=source_link,
                topic=args.topic,
                tags=tags,
                output_name=args.output_name,
            )
            print(f"OK  {input_ref}")
        except Exception as exc:  # pragma: no cover
            failures += 1
            print(f"ERR {input_ref}: {exc}", file=sys.stderr)

    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
