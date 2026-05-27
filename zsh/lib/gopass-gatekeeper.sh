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

# Check if gopass is available
if ! command -v gopass >/dev/null 2>&1; then
  echo "⚠️  Gopass not found - skipping all secret loading" >&2
  export SKIP_GOPASS_LOAD=1
  return 1
fi

# Check whether the GPG cache is actually warm.
# gopass ls does NOT decrypt anything, so it always succeeds quickly and
# tells us nothing about the cache state.  We must attempt a real decrypt
# with loopback pinentry (which never spawns a GUI dialog) to know if the
# passphrase is cached.  Redirecting stdin from /dev/null so a cold cache
# fails immediately instead of hanging on a TTY prompt in every shell.
GPG_TEST_FILE="$HOME/.password-store/t/ai/claude/api-key.gpg"
if [ -f "$GPG_TEST_FILE" ]; then
  if gpg --batch --quiet --pinentry-mode loopback \
       --decrypt "$GPG_TEST_FILE" >/dev/null 2>&1 < /dev/null; then
    export SKIP_GOPASS_LOAD=0
    return 0
  fi
fi

# Cache is cold or inaccessible - skip loads to avoid a pinentry storm
echo "⚠️  GPG cache cold - skipping secret loading (run gpg-prewarm to unlock)" >&2
export SKIP_GOPASS_LOAD=1
return 1
