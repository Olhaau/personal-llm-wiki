#!/usr/bin/env python3
"""Compile raw markdown into topic wiki pages."""

from __future__ import annotations

import argparse
import json
from collections import defaultdict
from pathlib import Path

from wiki_llm_common import (
    approx_token_count,
    build_llm,
    ensure_dir,
    parse_frontmatter,
    run_prompt,
    slugify,
    utc_now_iso,
    with_frontmatter,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Compile raw sources into wiki pages.")
    parser.add_argument("--root", default=".", help="Workspace root.")
    parser.add_argument("--raw", default="raw", help="Raw source directory.")
    parser.add_argument("--wiki-section", default="wiki", help="Target wiki section.")
    return parser.parse_args()


def raw_sources_by_topic(raw_dir: Path) -> dict[str, list[tuple[Path, str, str]]]:
    grouped: dict[str, list[tuple[Path, str, str]]] = defaultdict(list)
    for path in sorted(raw_dir.glob("*.md")):
        if path.name == "_index.md":
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        meta, body = parse_frontmatter(text)
        topic = slugify(meta.get("topic", "unclassified"))
        title = meta.get("title", path.stem)
        grouped[topic].append((path, title, body.strip()))
    return grouped


def compile_topic(llm, topic: str, docs: list[tuple[Path, str, str]]) -> dict[str, object]:
    packed = []
    for path, title, body in docs:
        packed.append(
            {
                "path": str(path),
                "title": title,
                "excerpt": body[:4000],
            }
        )

    system = (
        "You compile topic wiki content from normalized sources. "
        "Return strict JSON with keys: core_title, core_body, concepts. "
        "concepts is an array of objects with keys slug,title,body. "
        "All pages are concepts; do not create a separate connections layer. "
        "Every body must include sections: '## Summary', '## Details', '## Connected Concepts', and '## References'. "
        "Summary must be 2-3 sentences. Connected Concepts must use one bullet per link with a one-sentence relation note. "
        "Do not use wording like 'this concept' or 'topic-level concept'. "
        "Cite raw sources inline in the text and also in the References section using wiki links like [[raw/file.md]]."
    )
    user = (
        f"Topic: {topic}\n"
        "Create concise but concrete wiki pages. Use markdown bodies only. "
        "Keep claims grounded in provided sources.\n\n"
        f"SOURCES_JSON:\n{json.dumps(packed, ensure_ascii=False)}"
    )
    response = run_prompt(llm, system, user)
    return json.loads(response)


def write_page(path: Path, title: str, body: str) -> None:
    content = with_frontmatter(
        body.strip() + "\n",
        title=title,
        token=str(approx_token_count(body)),
    )
    path.write_text(content, encoding="utf-8")


def write_topic_index(topic_dir: Path, topic: str, concepts: list[tuple[str, str]]) -> None:
    lines = [
        f"# {topic} Topic Index",
        "",
        f"Compiled topic index for `{topic}`.",
        "",
        "## Concepts",
        "",
    ]
    for slug, title in concepts:
        lines.append(f"- [{title}](./{slug}.md)")

    body = "\n".join(lines) + "\n"
    write_page(topic_dir / "_index.md", f"{topic} Topic Index", body)


def write_section_index(section_dir: Path, topics: list[str]) -> None:
    lines = [
        "# Wiki Index",
        "",
        "Master index for topic subwikis in `wiki/`.",
        "",
        "## Topics",
        "",
    ]
    for topic in sorted(topics):
        lines.append(f"- [{topic}](./{topic}/_index.md)")
    body = "\n".join(lines) + "\n"
    write_page(section_dir / "_index.md", "Wiki Index", body)


def append_log(root: Path, created: list[str]) -> None:
    log_dir = root / "log"
    ensure_dir(log_dir)
    log_path = log_dir / (utc_now_iso()[:10].replace("-", "") + ".md")
    if not log_path.exists():
        log_path.write_text(f"# {utc_now_iso()[:10]}\n\n", encoding="utf-8")
    with log_path.open("a", encoding="utf-8") as f:
        f.write("## compile\n\n")
        for item in created:
            f.write(f"- {item}\n")


def main() -> None:
    args = parse_args()
    root = Path(args.root).resolve()
    raw_dir = (root / args.raw).resolve()
    section_dir = (root / args.wiki_section).resolve()

    ensure_dir(section_dir)
    llm = build_llm()
    by_topic = raw_sources_by_topic(raw_dir)
    if not by_topic:
        print("No raw sources found to compile.")
        return

    created: list[str] = []
    all_topics: list[str] = []

    for topic, docs in sorted(by_topic.items()):
        topic_dir = section_dir / topic
        ensure_dir(topic_dir)

        payload = compile_topic(llm, topic, docs)

        core_title = str(payload.get("core_title", topic))
        core_body = str(payload.get("core_body", ""))
        core_slug = slugify(topic)
        write_page(topic_dir / f"{core_slug}.md", core_title, core_body)
        created.append(f"created `{(topic_dir / f'{core_slug}.md').relative_to(root)}`")

        concept_entries: list[tuple[str, str]] = [(core_slug, core_title)]
        for item in payload.get("concepts", []):
            slug = slugify(str(item.get("slug", "concept")))
            title = str(item.get("title", slug))
            body = str(item.get("body", ""))
            write_page(topic_dir / f"{slug}.md", title, body)
            concept_entries.append((slug, title))
            created.append(f"created `{(topic_dir / f'{slug}.md').relative_to(root)}`")

        write_topic_index(topic_dir, topic, concept_entries)
        created.append(f"updated `{(topic_dir / '_index.md').relative_to(root)}`")
        all_topics.append(topic)

    write_section_index(section_dir, all_topics)
    created.append(f"updated `{section_dir.relative_to(root) / '_index.md'}`")
    append_log(root, created)

    for line in created:
        print(line)


if __name__ == "__main__":
    main()
