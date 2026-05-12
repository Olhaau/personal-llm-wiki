#!/usr/bin/env python3
"""Query wiki content through index traversal and LLM answer synthesis."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

from wiki_llm_common import build_llm, run_prompt


MD_LINK_RE = re.compile(r"\[[^\]]+\]\(([^)]+\.md)\)")
WORD_RE = re.compile(r"[a-z0-9][a-z0-9\-]+", re.IGNORECASE)
FRONTMATTER_RE = re.compile(r"^---\n.*?\n---\n", re.DOTALL)
STOPWORDS = {
    "a",
    "an",
    "and",
    "are",
    "as",
    "at",
    "be",
    "for",
    "from",
    "how",
    "in",
    "is",
    "it",
    "of",
    "on",
    "or",
    "the",
    "to",
    "what",
    "with",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Query the wiki via section and topic indexes.")
    parser.add_argument("query", help="Question to answer.")
    parser.add_argument("--root", default=".", help="Workspace root.")
    parser.add_argument("--wiki", default="wiki", help="Wiki root directory.")
    parser.add_argument(
        "--scope",
        choices=("intern", "public", "all"),
        default="intern",
        help="Query scope (default: intern).",
    )
    parser.add_argument("--top-k", type=int, default=8, help="Number of pages to pass to LLM.")
    return parser.parse_args()


def strip_frontmatter(text: str) -> str:
    return FRONTMATTER_RE.sub("", text, count=1)


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def links_from_index(path: Path) -> list[Path]:
    base = path.parent
    text = read(path)
    links: list[Path] = []
    for rel in MD_LINK_RE.findall(text):
        target = (base / rel).resolve()
        if target.exists() and target.is_file():
            links.append(target)
    return links


def tokens(text: str) -> set[str]:
    return {
        t.lower()
        for t in WORD_RE.findall(text)
        if len(t) > 2 and t.lower() not in STOPWORDS
    }


def score(query_tokens: set[str], text: str) -> int:
    low = text.lower()
    return sum(min(low.count(t), 10) for t in query_tokens)


def candidate_pages(root: Path, wiki_root: Path, scope: str) -> list[Path]:
    top = wiki_root / "_index.md"
    if not top.exists():
        return []

    section_targets: list[str]
    if scope == "intern":
        section_targets = ["wiki/intern/_index.md", "wiki/public/_index.md"]
    elif scope == "public":
        section_targets = ["wiki/public/_index.md"]
    else:
        section_targets = ["wiki/intern/_index.md", "wiki/public/_index.md"]

    sections = []
    for path in links_from_index(top):
        rel = str(path.relative_to(root))
        if rel in section_targets:
            sections.append(path)

    pages: list[Path] = []
    for section in sections:
        for topic_idx in links_from_index(section):
            if topic_idx.name != "_index.md":
                continue
            topic_dir = topic_idx.parent
            for page in topic_dir.rglob("*.md"):
                if page.name == "_index.md":
                    continue
                pages.append(page)
    return sorted(set(pages))


def select_relevant(query: str, pages: list[Path], top_k: int) -> list[tuple[Path, str]]:
    q = tokens(query)
    scored: list[tuple[int, Path, str]] = []
    for page in pages:
        text = strip_frontmatter(read(page))
        s = score(q, text)
        if s > 0:
            scored.append((s, page, text))
    scored.sort(key=lambda x: (-x[0], str(x[1])))
    return [(p, t) for _, p, t in scored[:top_k]]


def answer_with_llm(llm, query: str, root: Path, docs: list[tuple[Path, str]]) -> str:
    packed = []
    for path, text in docs:
        packed.append({"path": str(path.relative_to(root)), "content": text[:5000]})

    system = (
        "Answer the question only from provided wiki excerpts. "
        "If evidence is incomplete, say so. "
        "Always include a '## References' section with used local paths."
    )
    user = f"Question: {query}\n\nWiki excerpts:\n{packed}"
    return run_prompt(llm, system, user)


def fallback_answer(query: str, root: Path, docs: list[tuple[Path, str]]) -> str:
    lines = ["## Answer", ""]
    if not docs:
        lines.append("No relevant wiki pages found for this query.")
    else:
        for path, text in docs:
            sentence = next((ln.strip() for ln in text.splitlines() if ln.strip()), "")
            lines.append(f"- {path.relative_to(root)}: {sentence[:220]}")
    lines.extend(["", "## References"])
    for path, _ in docs:
        lines.append(f"- {path.relative_to(root)}")
    return "\n".join(lines)


def main() -> None:
    args = parse_args()
    root = Path(args.root).resolve()
    wiki_root = (root / args.wiki).resolve()

    pages = candidate_pages(root, wiki_root, args.scope)
    docs = select_relevant(args.query, pages, args.top_k)
    if not docs:
        print("## Answer\n\nNo relevant wiki pages found.\n\n## References\n- wiki/_index.md")
        return

    try:
        llm = build_llm()
        print(answer_with_llm(llm, args.query, root, docs))
    except Exception:
        print(fallback_answer(args.query, root, docs))


if __name__ == "__main__":
    main()
