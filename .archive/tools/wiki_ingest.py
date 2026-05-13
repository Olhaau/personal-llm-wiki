#!/usr/bin/env python3
"""Ingest sources into normalized raw markdown."""

from __future__ import annotations

import argparse
import json
import re
from html import unescape
from pathlib import Path
from urllib.parse import urljoin, urlparse
from urllib.request import Request, urlopen

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
    parser.add_argument("--inbox", default="inbox", help="Inbox folder.")
    parser.add_argument("--raw", default="raw", help="Raw output folder.")
    parser.add_argument("--glob", default="*.md", help="Input pattern inside inbox.")
    parser.add_argument("--source-type", default="file", help="Source type for inbox ledger.")
    parser.add_argument(
        "--web-index",
        default="",
        help="Path to markdown table with web URLs (for example inbox/weburl-index.md).",
    )
    parser.add_argument(
        "--web-status",
        default="x",
        help="Only ingest rows with this status marker, default: x (matches [x]).",
    )
    parser.add_argument(
        "--web-timeout",
        type=int,
        default=45,
        help="HTTP timeout in seconds for web fetches.",
    )
    parser.add_argument(
        "--max-source-links",
        type=int,
        default=120,
        help="Maximum number of discovered links to store in YAML source_links.",
    )
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
            "# Inbox Index\n\n"
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
            "# Raw Index\n\n"
            "| raw_file | title | topic | source_link | generated_at | tags |\n"
            "|---|---|---|---|---|---|\n"
        )
        token = approx_token_count(body)
        path.write_text(with_frontmatter(body, title="Raw Index", token=str(token)), encoding="utf-8")

    row = (
        f"| {raw_rel} | {title} | {topic} | {source_link} | {utc_now_iso()} | {','.join(tags)} |\n"
    )
    with path.open("a", encoding="utf-8") as f:
        f.write(row)


WEB_TABLE_ROW_RE = re.compile(r"^\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(https?://[^|\s]+.*?)\s*\|\s*(.*?)\s*\|$")
HREF_RE = re.compile(r"href\s*=\s*[\"']([^\"'#]+)[\"']", re.IGNORECASE)
MD_LINK_RE = re.compile(r"\[[^\]]+\]\((https?://[^)\s]+)\)")
URL_RE = re.compile(r'https?://[^\s)\]>"\']+')


def as_yaml_list(values: list[str]) -> str:
    encoded = [json.dumps(v, ensure_ascii=False) for v in values]
    return "[" + ", ".join(encoded) + "]"


def parse_web_index(path: Path, status_marker: str) -> list[dict[str, str]]:
    marker = status_marker.strip().lower()
    rows: list[dict[str, str]] = []
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        m = WEB_TABLE_ROW_RE.match(line.strip())
        if not m:
            continue
        status, topic, source, url, _added_at = [part.strip() for part in m.groups()]
        if not status.startswith("["):
            continue
        normalized = status.strip("[] ").lower()
        if normalized != marker:
            continue
        rows.append(
            {
                "status": status,
                "topic": topic,
                "source": source,
                "url": url,
            }
        )
    return rows


def fetch_url(url: str, timeout_sec: int) -> tuple[str, str, str]:
    req = Request(
        url,
        headers={
            "User-Agent": "personal-llm-wiki-ingest/1.0 (+https://github.com)"
        },
    )
    with urlopen(req, timeout=timeout_sec) as resp:
        final_url = str(resp.geturl())
        content_type = (resp.headers.get("Content-Type") or "").split(";")[0].strip().lower()
        raw = resp.read()
        charset = "utf-8"
        ctype_full = resp.headers.get("Content-Type") or ""
        if "charset=" in ctype_full:
            charset = ctype_full.split("charset=", 1)[1].split(";", 1)[0].strip() or "utf-8"
        text = raw.decode(charset, errors="replace")
    return final_url, content_type, text


def discover_links(content: str, base_url: str, content_type: str) -> list[str]:
    links: list[str] = []
    if "html" in content_type or "<html" in content.lower():
        for rel in HREF_RE.findall(content):
            if rel.startswith("javascript:") or rel.startswith("mailto:"):
                continue
            links.append(urljoin(base_url, unescape(rel)))
    else:
        links.extend(MD_LINK_RE.findall(content))
        links.extend(URL_RE.findall(content))

    cleaned: list[str] = []
    seen: set[str] = set()
    for link in links:
        item = link.strip()
        if not item.startswith("http"):
            continue
        if item in seen:
            continue
        seen.add(item)
        cleaned.append(item)
    return cleaned


def raw_name_from_source(source_name: str, url: str) -> str:
    parsed = urlparse(url)
    path_tail = Path(parsed.path).name
    if path_tail and path_tail.endswith(".md"):
        return slugify(path_tail.removesuffix(".md")) + ".md"
    return slugify(source_name) + ".md"


def infer_tags(topic: str, url: str) -> list[str]:
    parsed = urlparse(url)
    host = (parsed.netloc or "web").replace("www.", "")
    host_slug = slugify(host.replace(".", "-"))
    topic_slug = slugify(topic)
    return ["ingest", "web", "source/web", "privacy/public", "fetched", topic_slug, host_slug]


def render_full_source_body(source: str, source_url: str, final_url: str, content_type: str, content: str) -> str:
    lines = [
        f"# {source}",
        "",
        f"Source URL: {source_url}",
        f"Fetched URL: {final_url}",
        f"Content-Type: {content_type or 'unknown'}",
        "",
        "## Source Content",
        "",
    ]

    lower = content.lower()
    if "html" in content_type or "<html" in lower:
        lines.extend(["```html", content, "```"])
    elif "markdown" in content_type or content.strip().startswith("#"):
        lines.extend(["```markdown", content, "```"])
    else:
        lines.extend(["```text", content, "```"])

    return "\n".join(lines) + "\n"


def ingest_web_index(root: Path, inbox_dir: Path, raw_dir: Path, web_index_path: Path, status_marker: str, timeout_sec: int, max_source_links: int) -> None:
    rows = parse_web_index(web_index_path, status_marker=status_marker)
    if not rows:
        print(f"No web rows matched status [{status_marker}] in {web_index_path.relative_to(root)}")
        return

    inbox_index = inbox_dir / "_index.md"
    raw_index = raw_dir / "_index.md"

    for i, row in enumerate(rows, start=1):
        source = row["source"]
        topic = slugify(row["topic"])
        url = row["url"]

        try:
            final_url, content_type, content = fetch_url(url, timeout_sec=timeout_sec)
        except Exception as exc:
            print(f"failed: {url} ({exc})")
            continue

        discovered = discover_links(content, base_url=final_url, content_type=content_type)
        source_links = [final_url] + [lnk for lnk in discovered if lnk != final_url]
        source_links = source_links[:max_source_links]

        body = render_full_source_body(
            source=source,
            source_url=url,
            final_url=final_url,
            content_type=content_type,
            content=content,
        )

        raw_name = raw_name_from_source(source, final_url)
        raw_path = raw_dir / raw_name
        tags = infer_tags(topic=topic, url=final_url)

        md = with_frontmatter(
            body,
            title=source,
            token=str(approx_token_count(body)),
            source_link=url,
            source_links=as_yaml_list(source_links),
            topic=topic,
            tags=as_yaml_list(tags),
            generated_at=utc_now_iso(),
        )
        raw_path.write_text(md, encoding="utf-8")

        intake_id = f"intake-{utc_now_iso().replace(':', '').replace('-', '')}-{i:03d}"
        append_inbox_index(
            inbox_index,
            intake_id=intake_id,
            source=source,
            location=str(web_index_path.relative_to(root)),
            raw_file=str(raw_path.relative_to(root)),
        )
        append_raw_index(
            raw_index,
            raw_rel=str(raw_path.relative_to(root)),
            title=source,
            topic=topic,
            source_link=url,
            tags=tags,
        )
        print(f"ingested web: {url} -> {raw_path.relative_to(root)}")


def main() -> None:
    args = parse_args()
    root = Path(args.root).resolve()
    inbox_dir = (root / args.inbox).resolve()
    raw_dir = (root / args.raw).resolve()
    ensure_dir(inbox_dir)
    ensure_dir(raw_dir)

    if args.web_index:
        web_index = (root / args.web_index).resolve()
        if not web_index.exists() or not web_index.is_file():
            raise FileNotFoundError(f"web index not found: {web_index}")
        ingest_web_index(
            root=root,
            inbox_dir=inbox_dir,
            raw_dir=raw_dir,
            web_index_path=web_index,
            status_marker=args.web_status,
            timeout_sec=args.web_timeout,
            max_source_links=args.max_source_links,
        )
        return

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
        topic = slugify(str(data.get("topic", "unclassified")))
        tags = [str(t).strip() for t in data.get("tags", []) if str(t).strip()]
        tags = list(dict.fromkeys(tags + ["privacy/public", "source/local"]))
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
            tags=as_yaml_list(tags),
            generated_at=utc_now_iso(),
        )
        raw_path.write_text(md, encoding="utf-8")

        intake_id = f"intake-{utc_now_iso().replace(':', '').replace('-', '')}-{i:03d}"
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
