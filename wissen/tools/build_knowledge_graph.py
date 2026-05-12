#!/usr/bin/env python3
"""Build a visual knowledge graph from wiki pages and their links.

Outputs in repo root by default:
- knowledge-graph.html (interactive, responsive)
- knowledge-graph.png (snapshot if graphviz `dot` is available)
- knowledge-graph.dot (graph source)
- knowledge-graph.json (graph data)
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from dataclasses import dataclass
from pathlib import Path


WIKILINK_RE = re.compile(r"\[\[([^\]]+)\]\]")
MDLINK_RE = re.compile(r"\[[^\]]*\]\(([^)]+\.md)\)")
H1_RE = re.compile(r"^#\s+(.+?)\s*$", re.MULTILINE)


@dataclass
class Node:
    node_id: str
    label: str
    kind: str
    topic: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Build wiki knowledge graph artifacts.")
    parser.add_argument("--root", default=".", help="Repo root (default: current dir).")
    parser.add_argument("--wiki-dir", default="wiki/public", help="Wiki directory path.")
    parser.add_argument("--raw-dir", default="raw/public", help="Raw directory path.")
    parser.add_argument("--html-out", default="knowledge-graph.html", help="Interactive HTML output.")
    parser.add_argument("--png-out", default="knowledge-graph.png", help="Snapshot PNG output.")
    parser.add_argument("--dot-out", default="knowledge-graph.dot", help="DOT output.")
    parser.add_argument("--json-out", default="knowledge-graph.json", help="JSON output.")
    return parser.parse_args()


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def first_h1(text: str) -> str | None:
    match = H1_RE.search(text)
    return match.group(1).strip() if match else None


def node_kind(path: Path, wiki_dir: Path, raw_dir: Path) -> str:
    if path.is_relative_to(raw_dir):
        return "raw"
    rel = path.relative_to(wiki_dir)
    if rel.name == "_index.md":
        if len(rel.parts) == 1:
            return "wiki-index"
        return "topic-index"
    if "connections" in rel.parts:
        return "connection"
    if "concepts" in rel.parts:
        return "concept"
    return "wiki"


def frontmatter_topic(text: str) -> str | None:
    if not text.startswith("---\n"):
        return None
    end = text.find("\n---\n", 4)
    if end == -1:
        return None
    block = text[4:end]
    for line in block.splitlines():
        if line.startswith("topic:"):
            return line.split(":", 1)[1].strip().strip('"')
    return None


def infer_topic(path: Path, text: str, wiki_dir: Path, raw_dir: Path) -> str:
    if path.is_relative_to(wiki_dir):
        rel = path.relative_to(wiki_dir)
        return rel.parts[0] if len(rel.parts) >= 2 else "wiki-root"
    if path.is_relative_to(raw_dir):
        return frontmatter_topic(text) or "raw-unclassified"
    return "unknown"


def title_index(wiki_files: list[Path]) -> dict[str, Path]:
    mapping: dict[str, Path] = {}
    for path in wiki_files:
        title = first_h1(read_text(path))
        if title:
            mapping[title.casefold()] = path
    return mapping


def normalize_target(
    source: Path,
    target_raw: str,
    wiki_dir: Path,
    raw_dir: Path,
    by_title: dict[str, Path],
) -> Path | None:
    target = target_raw.split("|", 1)[0].strip()
    if not target:
        return None

    if target.startswith("raw/"):
        path = (wiki_dir.parent / target).resolve()
        return path if path.exists() else None

    if target.startswith("wiki/"):
        path = (wiki_dir.parent / target).resolve()
        return path if path.exists() else None

    if target.endswith(".md"):
        local = (source.parent / target).resolve()
        if local.exists():
            return local
        absolute = (wiki_dir.parent / target).resolve()
        return absolute if absolute.exists() else None

    by_name = by_title.get(target.casefold())
    if by_name:
        return by_name.resolve()

    return None


def collect_links(text: str) -> list[str]:
    links: list[str] = []
    links.extend(WIKILINK_RE.findall(text))
    links.extend(MDLINK_RE.findall(text))
    return links


def build_graph(root: Path, wiki_dir: Path, raw_dir: Path) -> tuple[list[Node], list[tuple[str, str]]]:
    wiki_files = sorted(wiki_dir.rglob("*.md"))
    raw_files = sorted(raw_dir.rglob("*.md"))
    by_title = title_index(wiki_files)

    nodes: dict[str, Node] = {}
    edges: set[tuple[str, str]] = set()

    def ensure(path: Path, default_label: str | None = None) -> Node:
        nid = str(path.relative_to(root))
        if nid not in nodes:
            text = read_text(path)
            label = default_label or path.stem
            kind = node_kind(path, wiki_dir, raw_dir)
            topic = infer_topic(path, text, wiki_dir, raw_dir)
            nodes[nid] = Node(node_id=nid, label=label, kind=kind, topic=topic)
        return nodes[nid]

    for path in wiki_files:
        text = read_text(path)
        ensure(path, first_h1(text) or path.stem)

    for path in raw_files:
        text = read_text(path)
        ensure(path, first_h1(text) or path.stem)

    for source in wiki_files:
        source_id = str(source.relative_to(root))
        text = read_text(source)
        for raw_target in collect_links(text):
            resolved = normalize_target(source, raw_target, wiki_dir, raw_dir, by_title)
            if not resolved:
                continue
            if not resolved.exists() or not resolved.is_file() or resolved.suffix != ".md":
                continue
            if not resolved.is_relative_to(root):
                continue
            target_id = str(resolved.relative_to(root))
            ensure(resolved)
            edges.add((source_id, target_id))

    return list(nodes.values()), sorted(edges)


def color_for_topic(topic: str) -> str:
    digest = hashlib.md5(topic.encode("utf-8")).hexdigest()
    hue = int(digest[:6], 16) % 360
    return f"hsl({hue}, 62%, 52%)"


def write_json(path: Path, nodes: list[Node], edges: list[tuple[str, str]]) -> None:
    payload = {
        "nodes": [
            {
                "id": n.node_id,
                "label": n.label,
                "group": n.topic,
                "topic": n.topic,
                "kind": n.kind,
                "color": color_for_topic(n.topic),
                "title": n.node_id,
            }
            for n in nodes
        ],
        "edges": [{"from": s, "to": t} for s, t in edges],
    }
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")


def write_dot(path: Path, nodes: list[Node], edges: list[tuple[str, str]]) -> None:
    lines = [
        "digraph Wissen {",
        "  rankdir=LR;",
        "  graph [bgcolor=\"white\"];",
        "  node [shape=box, style=filled, fontname=\"Helvetica\"];",
        "  edge [color=\"#999999\", arrowsize=0.6];",
    ]
    for n in nodes:
        node_id = n.node_id.replace('"', '\\"')
        label = n.label.replace('"', '\\"')
        color = color_for_topic(n.topic)
        lines.append(f'  "{node_id}" [label="{label}", fillcolor="{color}"];')
    for s, t in edges:
        s_esc = s.replace('"', '\\"')
        t_esc = t.replace('"', '\\"')
        lines.append(f'  "{s_esc}" -> "{t_esc}";')
    lines.append("}")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def write_html(path: Path, json_path: Path) -> None:
    html = f"""<!doctype html>
<html lang=\"en\">
<head>
  <meta charset=\"utf-8\" />
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
  <title>Wissen Knowledge Graph</title>
  <script src=\"https://unpkg.com/vis-network@9.1.9/dist/vis-network.min.js\"></script>
  <style>
    html, body {{ margin: 0; padding: 0; height: 100%; font-family: system-ui, sans-serif; }}
    #app {{ display: grid; grid-template-rows: auto 1fr; height: 100%; }}
    #toolbar {{ padding: 10px 12px; border-bottom: 1px solid #ddd; display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }}
    #graph {{ width: 100%; height: 100%; }}
    #legend {{ display: flex; gap: 10px; align-items: center; flex-wrap: wrap; font-size: 12px; }}
    .dot {{ width: 10px; height: 10px; border-radius: 50%; display: inline-block; margin-right: 6px; }}
  </style>
</head>
<body>
  <div id=\"app\">
    <div id=\"toolbar\">
      <strong>Wissen Knowledge Graph</strong>
      <span>Colors represent topic folders.</span>
      <div id=\"legend\"></div>
    </div>
    <div id=\"graph\"></div>
  </div>
  <script>
    fetch({json.dumps(json_path.name)})
      .then(r => r.json())
      .then(data => {{
        const nodes = new vis.DataSet(data.nodes);
        const edges = new vis.DataSet(data.edges);
        const legend = document.getElementById('legend');
        const topics = [...new Set(data.nodes.map(n => n.topic))].sort();
        topics.forEach(topic => {{
          const n = data.nodes.find(x => x.topic === topic);
          const el = document.createElement('span');
          el.innerHTML = `<span class=\"dot\" style=\"background:${{n.color}}\"></span>${{topic}}`;
          legend.appendChild(el);
        }});
        const container = document.getElementById('graph');
        const network = new vis.Network(container, {{ nodes, edges }}, {{
          autoResize: true,
          layout: {{ improvedLayout: true }},
          physics: {{ stabilization: true, barnesHut: {{ gravitationalConstant: -5000 }} }},
          nodes: {{ shape: 'dot', size: 10, font: {{ size: 14 }} }},
          edges: {{ smooth: {{ type: 'dynamic' }}, width: 1 }}
        }});
        window.addEventListener('resize', () => network.redraw());
      }});
  </script>
</body>
</html>
"""
    path.write_text(html, encoding="utf-8")


def render_png(dot_path: Path, png_path: Path) -> bool:
    try:
        subprocess.run(
            ["dot", "-Tpng", str(dot_path), "-o", str(png_path)],
            check=True,
            capture_output=True,
            text=True,
        )
        return True
    except (FileNotFoundError, subprocess.CalledProcessError):
        return False


def main() -> int:
    args = parse_args()
    root = Path(args.root).resolve()
    wiki_dir = (root / args.wiki_dir).resolve()
    raw_dir = (root / args.raw_dir).resolve()

    if not wiki_dir.exists() or not raw_dir.exists():
        print("wiki/ or raw/public directory not found.")
        return 2

    nodes, edges = build_graph(root, wiki_dir, raw_dir)

    html_path = (root / args.html_out).resolve()
    png_path = (root / args.png_out).resolve()
    dot_path = (root / args.dot_out).resolve()
    json_path = (root / args.json_out).resolve()

    write_json(json_path, nodes, edges)
    write_dot(dot_path, nodes, edges)
    write_html(html_path, json_path)

    if render_png(dot_path, png_path):
        print(f"OK  wrote {png_path.relative_to(root)}")
    else:
        print("WARN graphviz 'dot' not available; PNG snapshot was not generated.")
    print(f"OK  wrote {html_path.relative_to(root)}")
    print(f"OK  wrote {json_path.relative_to(root)}")
    print(f"OK  wrote {dot_path.relative_to(root)}")
    print(f"NODES={len(nodes)} EDGES={len(edges)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
