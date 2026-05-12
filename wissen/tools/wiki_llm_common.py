#!/usr/bin/env python3
"""Shared helpers for intern-first LLM wiki scripts."""

from __future__ import annotations

import os
import re
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

from langchain_core.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI


TOKEN_RE = re.compile(r"\S+")
NON_SLUG_RE = re.compile(r"[^a-z0-9\-]+")


@dataclass
class LLMConfig:
    model: str
    base_url: str
    api_key: str
    temperature: float


def utc_now_iso() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def approx_token_count(text: str) -> int:
    return len(TOKEN_RE.findall(text))


def slugify(value: str) -> str:
    base = value.strip().lower().replace("_", "-").replace(" ", "-")
    base = NON_SLUG_RE.sub("-", base)
    base = re.sub(r"-+", "-", base).strip("-")
    return base or "untitled"


def parse_frontmatter(md_text: str) -> tuple[dict[str, str], str]:
    if not md_text.startswith("---\n"):
        return {}, md_text
    end = md_text.find("\n---\n", 4)
    if end == -1:
        return {}, md_text
    block = md_text[4:end]
    body = md_text[end + 5 :]
    data: dict[str, str] = {}
    for line in block.splitlines():
        if ":" not in line:
            continue
        k, v = line.split(":", 1)
        data[k.strip()] = v.strip().strip('"')
    return data, body


def with_frontmatter(body: str, **kwargs: str) -> str:
    fields = ["---"]
    for key, value in kwargs.items():
        if key == "tags" and value.startswith("[") and value.endswith("]"):
            fields.append(f"{key}: {value}")
        else:
            fields.append(f'{key}: "{value}"')
    fields.append("---")
    fields.append("")
    fields.append(body.strip() + "\n")
    return "\n".join(fields)


def build_llm() -> ChatOpenAI:
    cfg = LLMConfig(
        model=os.getenv("WIKI_LLM_MODEL", "gpt-oss-130b"),
        base_url=os.getenv("WIKI_LLM_BASE_URL", "http://localhost:8000/v1"),
        api_key=os.getenv("WIKI_LLM_API_KEY", "dummy"),
        temperature=float(os.getenv("WIKI_LLM_TEMPERATURE", "0.1")),
    )
    return ChatOpenAI(
        model=cfg.model,
        base_url=cfg.base_url,
        api_key=cfg.api_key,
        temperature=cfg.temperature,
    )


def run_prompt(llm: ChatOpenAI, system_prompt: str, user_prompt: str) -> str:
    prompt = ChatPromptTemplate.from_messages(
        [
            ("system", system_prompt),
            ("user", user_prompt),
        ]
    )
    chain = prompt | llm
    result = chain.invoke({})
    return (result.content or "").strip()


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)
