#!/usr/bin/env python3
"""Fetch a web page and convert it to Markdown.

Features:
- Preserves tables through HTML -> Markdown conversion.
- Optional image download to a local folder.
- When images are downloaded, image references are written as Obsidian wiki-links.
- When images are not downloaded, references keep the original absolute web URLs.
"""

from __future__ import annotations

import argparse
import mimetypes
import re
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup
from markdownify import MarkdownConverter


DEFAULT_USER_AGENT = (
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
)


@dataclass
class ImageRecord:
    original_url: str
    local_wiki_path: str | None


class WikiMarkdownConverter(MarkdownConverter):
    """Markdownify converter with Obsidian image-link support."""

    def convert_img(self, el, text, parent_tags):  # type: ignore[override]
        src = (el.attrs.get("src") or "").strip()
        alt = (el.attrs.get("alt") or "").strip()

        if not src:
            return ""
        if src.startswith(("http://", "https://")):
            return f"![{alt}]({src})"
        return f"![[{src}]]"


def slugify(text: str) -> str:
    cleaned = re.sub(r"[^a-zA-Z0-9]+", "-", text).strip("-").lower()
    return cleaned or "webpage"


def pick_image_source(img_tag, base_url: str) -> str | None:
    attrs = img_tag.attrs
    candidates = [
        attrs.get("src"),
        attrs.get("data-src"),
        attrs.get("data-original"),
        attrs.get("data-lazy-src"),
        attrs.get("data-url"),
    ]

    srcset = attrs.get("srcset") or attrs.get("data-srcset")
    if srcset:
        first = srcset.split(",")[0].strip().split(" ")[0].strip()
        if first:
            candidates.append(first)

    for candidate in candidates:
        if not candidate:
            continue
        if candidate.startswith("data:"):
            continue
        return urljoin(base_url, candidate)
    return None


def clean_html(soup: BeautifulSoup) -> None:
    for tag in soup(["script", "style", "noscript", "template"]):
        tag.decompose()


def make_absolute_links(soup: BeautifulSoup, base_url: str) -> None:
    for tag in soup.find_all(["a", "img", "source"]):
        for attr in ("href", "src"):
            value = tag.get(attr)
            if value:
                tag[attr] = urljoin(base_url, value)


def infer_extension(url: str, content_type: str | None) -> str:
    if content_type:
        guessed = mimetypes.guess_extension(content_type.split(";")[0].strip())
        if guessed:
            return ".jpg" if guessed == ".jpe" else guessed

    path_ext = Path(urlparse(url).path).suffix.lower()
    if path_ext in {".png", ".jpg", ".jpeg", ".webp", ".gif", ".svg", ".bmp", ".tiff"}:
        return ".jpg" if path_ext == ".jpeg" else path_ext
    return ".jpg"


def download_image(
    session: requests.Session,
    image_url: str,
    images_dir: Path,
    image_prefix: str,
    index: int,
    timeout: int,
) -> tuple[Path | None, str | None]:
    try:
        resp = session.get(image_url, timeout=timeout)
        resp.raise_for_status()
    except requests.RequestException:
        return None, None

    ext = infer_extension(image_url, resp.headers.get("Content-Type"))
    filename = f"{image_prefix}-{index}{ext}"
    out_path = images_dir / filename
    counter = 1
    while out_path.exists():
        filename = f"{image_prefix}-{index}-{counter}{ext}"
        out_path = images_dir / filename
        counter += 1

    out_path.write_bytes(resp.content)
    return out_path, filename


def convert_html_to_markdown(html: str) -> str:
    converter = WikiMarkdownConverter(
        heading_style="ATX",
        bullets="-",
        wrap=False,
        table_infer_header=True,
    )
    return converter.convert(html).strip() + "\n"


def yaml_quote(value: str) -> str:
    return '"' + value.replace('"', '\\"') + '"'


def ingest_web(
    url: str,
    output: Path | None,
    download_images: bool,
    images_dir: Path,
    timeout: int,
    user_agent: str,
) -> tuple[Path, dict[str, int]]:
    session = requests.Session()
    session.headers.update({"User-Agent": user_agent})

    response = session.get(url, timeout=timeout)
    response.raise_for_status()
    base_url = response.url

    soup = BeautifulSoup(response.text, "html.parser")
    clean_html(soup)
    make_absolute_links(soup, base_url)

    title = (soup.title.string.strip() if soup.title and soup.title.string else base_url)
    page_slug = slugify(title)

    if output is None:
        output = Path("raw") / f"{page_slug}.md"

    image_records: list[ImageRecord] = []
    seen: dict[str, str] = {}

    if download_images:
        images_dir.mkdir(parents=True, exist_ok=True)

    image_index = 1
    for img in soup.find_all("img"):
        src = pick_image_source(img, base_url)
        if not src:
            continue

        if download_images:
            cached = seen.get(src)
            if cached:
                img["src"] = cached
                image_records.append(ImageRecord(original_url=src, local_wiki_path=cached))
                continue

            _, filename = download_image(
                session=session,
                image_url=src,
                images_dir=images_dir,
                image_prefix=page_slug,
                index=image_index,
                timeout=timeout,
            )
            if filename:
                wiki_ref = f"{images_dir.as_posix().rstrip('/')}/{filename}"
                seen[src] = wiki_ref
                img["src"] = wiki_ref
                image_records.append(ImageRecord(original_url=src, local_wiki_path=wiki_ref))
                image_index += 1
            else:
                img["src"] = src
                image_records.append(ImageRecord(original_url=src, local_wiki_path=None))
        else:
            img["src"] = src
            image_records.append(ImageRecord(original_url=src, local_wiki_path=None))

    main = soup.find("main") or soup.find("article") or soup.body or soup
    markdown_body = convert_html_to_markdown(str(main))

    generated_at = datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")
    frontmatter = (
        "---\n"
        f"title: {yaml_quote(title)}\n"
        "source: web\n"
        f"source_link: {yaml_quote(base_url)}\n"
        f"generated_at: {yaml_quote(generated_at)}\n"
        "---\n\n"
    )

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(frontmatter + markdown_body, encoding="utf-8")

    return output, {
        "images_found": len(image_records),
        "images_downloaded": sum(1 for rec in image_records if rec.local_wiki_path),
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Convert a website to Markdown.")
    parser.add_argument("url", help="Page URL to ingest.")
    parser.add_argument(
        "--output",
        "-o",
        type=Path,
        default=None,
        help="Output markdown file path (default: raw/<page-slug>.md).",
    )
    parser.add_argument(
        "--download-images",
        action="store_true",
        help="Download images and write them as wiki-links in markdown.",
    )
    parser.add_argument(
        "--images-dir",
        type=Path,
        default=Path("inbox/images"),
        help="Local image directory used when --download-images is set (default: inbox/images).",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=30,
        help="HTTP timeout in seconds (default: 30).",
    )
    parser.add_argument(
        "--user-agent",
        default=DEFAULT_USER_AGENT,
        help="HTTP User-Agent string.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_path, stats = ingest_web(
        url=args.url,
        output=args.output,
        download_images=args.download_images,
        images_dir=args.images_dir,
        timeout=args.timeout,
        user_agent=args.user_agent,
    )
    print(f"Wrote markdown to: {output_path}")
    print(f"Images found: {stats['images_found']}")
    print(f"Images downloaded: {stats['images_downloaded']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
