#!/usr/bin/env python3
"""Download YouTube subtitles and save transcript as Markdown."""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from datetime import datetime, timezone
from html import unescape
from pathlib import Path


TAG_RE = re.compile(r"<[^>]+>")
TIMECODE_RE = re.compile(r"^\d\d:\d\d:\d\d\.\d\d\d\s+-->\s+\d\d:\d\d:\d\d\.\d\d\d")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Fetch YouTube subtitles and save transcript Markdown."
    )
    parser.add_argument("url", help="YouTube video URL")
    parser.add_argument(
        "-o",
        "--output",
        help="Output Markdown path (default: transcripts/<video-id>.md)",
    )
    parser.add_argument(
        "--lang",
        default="en",
        help="Preferred subtitle language code (default: en)",
    )
    parser.add_argument(
        "--workdir",
        default="transcripts",
        help="Directory for subtitle downloads and default output (default: transcripts)",
    )
    return parser.parse_args()


def now_iso() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def run_cmd(args: list[str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(args, capture_output=True, text=True, check=False)


def ensure_yt_dlp() -> None:
    result = run_cmd(["yt-dlp", "--version"])
    if result.returncode != 0:
        raise RuntimeError(
            "yt-dlp is required but not available. Install it with: pip install yt-dlp"
        )


def fetch_video_info(url: str) -> dict[str, object]:
    result = run_cmd(["yt-dlp", "--dump-single-json", "--skip-download", url])
    if result.returncode != 0:
        raise RuntimeError(f"Unable to fetch video metadata: {result.stderr.strip()}")
    return json.loads(result.stdout)


def subtitle_candidates(download_dir: Path, video_id: str) -> list[Path]:
    patterns = [
        f"{video_id}.*.vtt",
        f"{video_id}.vtt",
    ]
    found: list[Path] = []
    for pattern in patterns:
        found.extend(download_dir.glob(pattern))
    return sorted(set(found))


def download_subtitles(url: str, video_id: str, lang: str, download_dir: Path) -> Path:
    base_cmd = [
        "yt-dlp",
        "--skip-download",
        "--sub-format",
        "vtt",
        "--output",
        f"{video_id}.%(ext)s",
        "--paths",
        str(download_dir),
        "--sub-langs",
        f"{lang}.*,{lang},en.*,en",
    ]

    manual = run_cmd(base_cmd + ["--write-subs", url])
    candidates = subtitle_candidates(download_dir, video_id)
    if candidates:
        return candidates[0]

    auto = run_cmd(base_cmd + ["--write-auto-subs", url])
    candidates = subtitle_candidates(download_dir, video_id)
    if candidates:
        return candidates[0]

    raise RuntimeError(
        "No subtitles were downloaded. "
        f"manual_subs_error={manual.stderr.strip()} auto_subs_error={auto.stderr.strip()}"
    )


def vtt_to_text(vtt: str) -> str:
    lines = []
    for raw_line in vtt.splitlines():
        line = raw_line.strip()
        if not line:
            continue
        if line == "WEBVTT" or line.startswith("Kind:") or line.startswith("Language:"):
            continue
        if line.isdigit() or TIMECODE_RE.match(line):
            continue
        line = TAG_RE.sub("", line)
        line = unescape(line)
        line = re.sub(r"\s+", " ", line).strip()
        if line:
            lines.append(line)

    deduped = []
    for line in lines:
        if not deduped or deduped[-1] != line:
            deduped.append(line)
    return "\n".join(deduped).strip() + "\n"


def render_markdown(title: str, url: str, subtitle_file: str, transcript: str) -> str:
    safe_title = title.replace('"', "'")
    return (
        f"---\n"
        f"title: \"{safe_title}\"\n"
        f"source_link: \"{url}\"\n"
        f"subtitle_file: \"{subtitle_file}\"\n"
        f"generated_at: \"{now_iso()}\"\n"
        f"---\n\n"
        f"# {safe_title}\n\n"
        f"Source: {url}\n\n"
        f"## Transcript\n\n"
        f"{transcript}"
    )


def main() -> int:
    args = parse_args()
    try:
        ensure_yt_dlp()
        info = fetch_video_info(args.url)
        video_id = str(info.get("id") or "youtube-video")
        title = str(info.get("title") or video_id)

        workdir = Path(args.workdir).resolve()
        workdir.mkdir(parents=True, exist_ok=True)
        subtitle_path = download_subtitles(args.url, video_id, args.lang, workdir)
        transcript = vtt_to_text(subtitle_path.read_text(encoding="utf-8", errors="replace"))

        output_path = Path(args.output).resolve() if args.output else (workdir / f"{video_id}.md")
        output_path.parent.mkdir(parents=True, exist_ok=True)
        markdown = render_markdown(title, args.url, subtitle_path.name, transcript)
        output_path.write_text(markdown, encoding="utf-8")

        print(f"Saved transcript markdown: {output_path}")
        return 0
    except Exception as exc:  # noqa: BLE001
        print(f"Error: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
