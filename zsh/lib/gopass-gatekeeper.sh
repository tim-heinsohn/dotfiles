#!/bin/bash
# Gopass/GPG gatekeeper - test once and set flag to skip if unavailable
# This prevents multiple password prompts when keyboard layout is wrong

# Only run the check once per shell session
if [ -n "${_GOPASS_GATEKEEPER_CHECKED:-}" ]; then
  return 0
fi

export _GOPASS_GATEKEEPER_CHECKED=1

# When VS Code / Antigravity resolves shell environment on startup, it sets
# VSCODE_RESOLVING_ENVIRONMENT=1. Skip the slow bulk gopass loading to avoid
# exceeding the IDE's shell resolution timeout (default 10s). Instead, attempt
# a single fast fetch for the one key needed by IDE extensions (GEMINI_API_KEY).
if [ "${VSCODE_RESOLVING_ENVIRONMENT:-}" = "1" ]; then
  export SKIP_GOPASS_LOAD=1
  if command -v gopass >/dev/null 2>&1; then
    _gk_key=$(timeout 2s gopass show -o t/ai/gemini/api-key 2>/dev/null)
    if [ -n "$_gk_key" ]; then
      export GEMINI_API_KEY="$_gk_key"
      export PERSONAL_GEMINI_API_KEY="$_gk_key"
    fi
    unset _gk_key
  fi
  return 0
fi

# Check if gopass is available and working
if ! command -v gopass >/dev/null 2>&1; then
  echo "⚠️  Gopass not found - skipping all secret loading" >&2
  export SKIP_GOPASS_LOAD=1
  return 1
fi

# Try a quick test operation with timeout
# Use 'ls' as it requires GPG but is fast
if ! timeout 3s gopass ls >/dev/null 2>&1; then
  echo "⚠️  Gopass/GPG not accessible - skipping all secret loading" >&2
  echo "   (Keyboard layout issue? Try: setxkbmap fr)" >&2
  export SKIP_GOPASS_LOAD=1
  return 1
fi

# Gopass is working - allow loads
export SKIP_GOPASS_LOAD=0
return 0
