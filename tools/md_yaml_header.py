#!/usr/bin/env python3
"""Ensure Markdown files include wiki-style YAML frontmatter metadata."""

from __future__ import annotations

import argparse
import json
import re
from datetime import datetime, timezone
from pathlib import Path

REQUIRED_KEYS = ["title", "token", "source_link", "topic", "tags", "generated_at"]
TOKEN_RE = re.compile(r"\S+")
HEADING_RE = re.compile(r"^#\s+(.+?)\s*$", re.MULTILINE)


def utc_now_iso() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def approx_token_count(text: str) -> int:
    return len(TOKEN_RE.findall(text))


def guess_title(path: Path, body: str) -> str:
    heading = HEADING_RE.search(body)
    if heading:
        return heading.group(1).strip("` ") or path.stem
    return path.stem.replace("-", " ").replace("_", " ").strip().title() or path.stem


def parse_tags(value: str) -> list[str]:
    stripped = value.strip()
    if not stripped:
        return []
    if stripped.startswith("[") and stripped.endswith("]"):
        try:
            parsed = json.loads(stripped)
            if isinstance(parsed, list):
                return [str(item).strip() for item in parsed if str(item).strip()]
        except json.JSONDecodeError:
            items = [item.strip().strip('"\'') for item in stripped[1:-1].split(",")]
            return [item for item in items if item]
    return [item.strip() for item in stripped.split(",") if item.strip()]


def parse_scalar(value: str):
    stripped = value.strip()
    if stripped.startswith("[") and stripped.endswith("]"):
        return parse_tags(stripped)
    if (stripped.startswith('"') and stripped.endswith('"')) or (
        stripped.startswith("'") and stripped.endswith("'")
    ):
        return stripped[1:-1]
    return stripped


def parse_frontmatter(markdown: str) -> tuple[dict[str, object], str]:
    if not markdown.startswith("---\n"):
        return {}, markdown

    end_marker = "\n---\n"
    end = markdown.find(end_marker, 4)
    if end == -1:
        return {}, markdown

    block = markdown[4:end]
    body = markdown[end + len(end_marker) :]
    data: dict[str, object] = {}

    for line in block.splitlines():
        if ":" not in line:
            continue
        key, raw_value = line.split(":", 1)
        key = key.strip()
        if not key:
            continue
        data[key] = parse_scalar(raw_value)

    return data, body


def render_frontmatter(data: dict[str, object]) -> str:
    ordered_keys = REQUIRED_KEYS + [key for key in data.keys() if key not in REQUIRED_KEYS]
    lines = ["---"]

    for key in ordered_keys:
        value = data.get(key, "")
        if key == "tags":
            tags = value if isinstance(value, list) else parse_tags(str(value))
            lines.append(f"{key}: {json.dumps(tags, ensure_ascii=False)}")
        elif isinstance(value, list):
            lines.append(f"{key}: {json.dumps(value, ensure_ascii=False)}")
        else:
            lines.append(f"{key}: {json.dumps(str(value), ensure_ascii=False)}")

    lines.append("---")
    lines.append("")
    return "\n".join(lines)


def process_markdown(path: Path, args: argparse.Namespace) -> bool:
    content = path.read_text(encoding="utf-8", errors="replace")
    existing, body = parse_frontmatter(content)
    metadata = dict(existing)

    metadata.setdefault("title", guess_title(path, body))
    metadata.setdefault("source_link", args.source_link)
    metadata.setdefault("topic", args.topic)
    metadata.setdefault("tags", args.tags)
    metadata.setdefault("generated_at", utc_now_iso())
    metadata["token"] = str(approx_token_count(body.strip()))

    updated = render_frontmatter(metadata) + body.lstrip("\n")
    changed = updated != content
    if changed:
        path.write_text(updated, encoding="utf-8")
    return changed


def iter_markdown_files(target: Path) -> list[Path]:
    if target.is_file():
        return [target] if target.suffix.lower() == ".md" else []
    if target.is_dir():
        return sorted(path for path in target.rglob("*.md") if path.is_file())
    return []


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Add or update YAML frontmatter for one Markdown file or recursively for a folder."
    )
    parser.add_argument(
        "paths",
        nargs="+",
        type=Path,
        help="Markdown file(s) and/or folder(s). Folders are traversed recursively.",
    )
    parser.add_argument("--topic", default="unclassified", help="Default topic when missing.")
    parser.add_argument("--source-link", default="", help="Default source_link when missing.")
    parser.add_argument(
        "--tags",
        default="",
        help="Comma-separated default tags used only when tags are missing.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    args.tags = parse_tags(args.tags)

    files: list[Path] = []
    for raw_path in args.paths:
        path = raw_path.resolve()
        files.extend(iter_markdown_files(path))

    unique_files = sorted({file for file in files})
    if not unique_files:
        raise FileNotFoundError("No markdown files found from provided paths.")

    updated = 0
    for file in unique_files:
        if process_markdown(file, args):
            updated += 1

    print(f"Processed {len(unique_files)} markdown files; updated {updated}.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
