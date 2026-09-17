#!/usr/bin/env python3
"""Local DeepSeek worker for Cursor. Key stays outside this folder."""

from __future__ import annotations

import json
import os
import ssl
import urllib.error
import urllib.request
from pathlib import Path

import certifi
from mcp.server.mcpserver import MCPServer

API_URL = "https://api.deepseek.com/chat/completions"
DEFAULT_MODEL = "deepseek-flash"
DEFAULT_KEY_PATH = Path.home() / ".config" / "deepseek" / "api_key"
ALLOWED_MODELS = ("deepseek-flash", "deepseek-v4-pro")

mcp = MCPServer("deepseek")


def tool_error(label: str, exc: BaseException) -> str:
    return f"{label} failed: {type(exc).__name__}: {exc}"


def load_api_key() -> str:
    env_key = os.environ.get("DEEPSEEK_API_KEY", "").strip()
    if env_key:
        return env_key
    key_path = Path(os.environ.get("DEEPSEEK_API_KEY_FILE", DEFAULT_KEY_PATH))
    if not key_path.is_file():
        raise RuntimeError(
            f"DeepSeek API key not found. Set DEEPSEEK_API_KEY or create {key_path}."
        )
    key = key_path.read_text(encoding="utf-8").strip()
    if not key:
        raise RuntimeError(f"DeepSeek API key file is empty: {key_path}")
    return key


def resolve_model(model: str | None) -> str:
    name = (model or DEFAULT_MODEL).strip()
    if name not in ALLOWED_MODELS:
        raise ValueError(f"Unsupported model {name!r}. Use one of: {', '.join(ALLOWED_MODELS)}")
    return name


def chat_completion(
    messages: list[dict[str, str]],
    model: str | None = None,
    max_tokens: int = 2048,
    thinking: bool = False,
) -> str:
    body = {
        "model": resolve_model(model),
        "messages": messages,
        "max_tokens": max_tokens,
        "thinking": {"type": "enabled" if thinking else "disabled"},
    }
    request = urllib.request.Request(
        API_URL,
        data=json.dumps(body).encode("utf-8"),
        method="POST",
        headers={
            "Authorization": f"Bearer {load_api_key()}",
            "Content-Type": "application/json",
        },
    )
    context = ssl.create_default_context(cafile=certifi.where())
    try:
        with urllib.request.urlopen(request, timeout=90, context=context) as response:
            payload = json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"DeepSeek API HTTP {exc.code}: {detail[:500]}") from exc
    except urllib.error.URLError as exc:
        raise RuntimeError(f"DeepSeek API network error: {exc.reason}") from exc

    choices = payload.get("choices") or []
    if not choices:
        raise RuntimeError("DeepSeek API returned no choices.")
    content = choices[0].get("message", {}).get("content")
    if not content:
        raise RuntimeError("DeepSeek API returned an empty message.")
    usage = payload.get("usage") or {}
    model_used = payload.get("model", resolve_model(model))
    return (
        f"{content.strip()}\n\n"
        f"— model: {model_used}; "
        f"tokens in/out: {usage.get('prompt_tokens', '?')}/{usage.get('completion_tokens', '?')}"
    )


@mcp.tool()
def deepseek_ping() -> str:
    """Check that the DeepSeek API key works. Uses a tiny paid request."""
    try:
        reply = chat_completion(
            messages=[{"role": "user", "content": "Reply with exactly: MCP connection successful"}],
            model=DEFAULT_MODEL,
            max_tokens=32,
            thinking=False,
        )
        return f"DeepSeek MCP ping ok.\n{reply}"
    except Exception as exc:
        return tool_error("deepseek_ping", exc)


@mcp.tool()
def deepseek_chat(
    prompt: str,
    model: str = DEFAULT_MODEL,
    thinking: bool = False,
    max_tokens: int = 2048,
) -> str:
    """Ask DeepSeek a general question. Cursor stays the planner."""
    try:
        return chat_completion(
            messages=[{"role": "user", "content": prompt}],
            model=model,
            max_tokens=max_tokens,
            thinking=thinking,
        )
    except Exception as exc:
        return tool_error("deepseek_chat", exc)


@mcp.tool()
def deepseek_code(
    task: str,
    context: str = "",
    model: str = DEFAULT_MODEL,
    max_tokens: int = 4096,
) -> str:
    """Ask DeepSeek to implement or edit code. Returns text only; Cursor applies it."""
    try:
        user = task if not context else f"{task}\n\nContext:\n{context}"
        return chat_completion(
            messages=[
                {
                    "role": "system",
                    "content": (
                        "You implement code for a Cursor orchestrator. "
                        "Return only the requested code or a tight patch. "
                        "Do not invent files you were not asked to change."
                    ),
                },
                {"role": "user", "content": user},
            ],
            model=model,
            max_tokens=max_tokens,
            thinking=False,
        )
    except Exception as exc:
        return tool_error("deepseek_code", exc)


@mcp.tool()
def deepseek_analyze(
    text: str,
    question: str = "Review this and list risks, bugs, and the smallest fix.",
    model: str = DEFAULT_MODEL,
    max_tokens: int = 2048,
) -> str:
    """Ask DeepSeek to review or analyze text or code."""
    try:
        return chat_completion(
            messages=[
                {
                    "role": "system",
                    "content": "You are a concise code and design reviewer. Be specific.",
                },
                {"role": "user", "content": f"{question}\n\n---\n{text}"},
            ],
            model=model,
            max_tokens=max_tokens,
            thinking=False,
        )
    except Exception as exc:
        return tool_error("deepseek_analyze", exc)


if __name__ == "__main__":
    mcp.run(transport="stdio")
