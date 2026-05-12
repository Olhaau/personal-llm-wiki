#!/usr/bin/env python3
"""Ingest sources into normalized raw markdown (intern-first by default)."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from wiki_llm_common import (
    approx_token_count,
    build_llm,
    ensure_dir,
    run_prompt,
    slugify,
    utc_now_iso,
    with_frontmatter,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Ingest local sources into wiki raw layer.")
    parser.add_argument("--root", default=".", help="Workspace root.")
    parser.add_argument("--inbox", default="inbox_intern", help="Inbox folder.")
    parser.add_argument("--raw", default="raw/intern", help="Raw output folder.")
    parser.add_argument("--glob", default="*.md", help="Input pattern inside inbox.")
    parser.add_argument("--source-type", default="file", help="Source type for inbox ledger.")
    return parser.parse_args()


def load_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def normalize_with_llm(llm, source_name: str, content: str) -> dict[str, object]:
    system = (
        "You normalize source documents into wiki-ready markdown. "
        "Return strict JSON with keys: title, topic, tags, normalized_markdown. "
        "topic must be a short kebab-case slug. tags must be a JSON array of strings. "
        "Do not include markdown fences."
    )
    user = (
        f"Source name: {source_name}\n"
        "Produce concise cleaned markdown while preserving factual meaning. "
        "Mark this as private/internal in tags.\n\n"
        f"SOURCE:\n{content[:35000]}"
    )
    raw = run_prompt(llm, system, user)
    return json.loads(raw)


def append_inbox_index(path: Path, intake_id: str, source: str, location: str, raw_file: str) -> None:
    if not path.exists():
        path.write_text(
            "# Internal Inbox Index\n\n"
            "| intake_id | source_type | source | location | received_at | status | raw_file |\n"
            "|---|---|---|---|---|---|---|\n",
            encoding="utf-8",
        )

    line = (
        f"| {intake_id} | file | {source} | {location} | {utc_now_iso()} | ingested | {raw_file} |\n"
    )
    with path.open("a", encoding="utf-8") as f:
        f.write(line)


def append_raw_index(path: Path, raw_rel: str, title: str, topic: str, source_link: str, tags: list[str]) -> None:
    if not path.exists():
        body = (
            "# Internal Raw Index\n\n"
            "| raw_file | title | topic | source_link | generated_at | tags |\n"
            "|---|---|---|---|---|---|\n"
        )
        token = approx_token_count(body)
        path.write_text(with_frontmatter(body, title="Internal Raw Index", token=str(token)), encoding="utf-8")

    row = (
        f"| {raw_rel} | {title} | {topic} | {source_link} | {utc_now_iso()} | {','.join(tags)} |\n"
    )
    with path.open("a", encoding="utf-8") as f:
        f.write(row)


def main() -> None:
    args = parse_args()
    root = Path(args.root).resolve()
    inbox_dir = (root / args.inbox).resolve()
    raw_dir = (root / args.raw).resolve()
    ensure_dir(inbox_dir)
    ensure_dir(raw_dir)

    llm = build_llm()
    files = sorted(inbox_dir.glob(args.glob))
    files = [p for p in files if p.is_file() and p.name not in {"_index.md", ".gitkeep"}]
    if not files:
        print("No matching inbox files.")
        return

    inbox_index = inbox_dir / "_index.md"
    raw_index = raw_dir / "_index.md"

    for i, src in enumerate(files, start=1):
        text = load_text(src)
        data = normalize_with_llm(llm, src.name, text)

        title = str(data.get("title", src.stem)).strip() or src.stem
        topic = slugify(str(data.get("topic", "intern-topic")))
        tags = [str(t).strip() for t in data.get("tags", []) if str(t).strip()]
        tags = list(dict.fromkeys(tags + ["privacy/internal", "source/local"]))
        markdown = str(data.get("normalized_markdown", "")).strip() or text

        raw_name = f"{slugify(src.stem)}.md"
        raw_path = raw_dir / raw_name
        source_link = f"file://{src.relative_to(root)}"

        body = markdown + "\n"
        md = with_frontmatter(
            body,
            title=title,
            token=str(approx_token_count(body)),
            source_link=source_link,
            topic=topic,
            tags="[" + ", ".join(tags) + "]",
            generated_at=utc_now_iso(),
        )
        raw_path.write_text(md, encoding="utf-8")

        intake_id = f"intake-intern-{utc_now_iso().replace(':', '').replace('-', '')}-{i:03d}"
        append_inbox_index(
            inbox_index,
            intake_id=intake_id,
            source=src.name,
            location=str(src.relative_to(root)),
            raw_file=str(raw_path.relative_to(root)),
        )
        append_raw_index(
            raw_index,
            raw_rel=str(raw_path.relative_to(root)),
            title=title,
            topic=topic,
            source_link=source_link,
            tags=tags,
        )
        print(f"ingested: {src.relative_to(root)} -> {raw_path.relative_to(root)}")


if __name__ == "__main__":
    main()
