#!/usr/bin/env bash
set -euo pipefail

# Uses a dedicated UV-managed environment for Docling.
#
# Example:
#   tools/run_docling_uv.sh --input "inbox/*.pdf" --outdir "raw/extracted"

ENV_DIR="${DOCLING_ENV_DIR:-.venv-docling}"
PYTHON_BIN="$ENV_DIR/bin/python"

if ! command -v uv >/dev/null 2>&1; then
  echo "uv is not installed. Install it first: https://docs.astral.sh/uv/" >&2
  exit 2
fi

if [ ! -x "$PYTHON_BIN" ]; then
  uv venv "$ENV_DIR"
fi

uv pip install --python "$PYTHON_BIN" "docling"

exec "$PYTHON_BIN" "tools/docling_extract.py" "$@"
