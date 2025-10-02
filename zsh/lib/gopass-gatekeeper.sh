#!/bin/bash
# Gopass/GPG gatekeeper - test once and set flag to skip if unavailable
# This prevents multiple password prompts when keyboard layout is wrong

# Only run the check once per shell session
if [ -n "${_GOPASS_GATEKEEPER_CHECKED:-}" ]; then
  return 0
fi

export _GOPASS_GATEKEEPER_CHECKED=1

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
