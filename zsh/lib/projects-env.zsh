#!/usr/bin/env zsh

# Apply per-project LLM env vars based on current selection (primary/secondary).
# - Reads ~/.projects for *_PROJECT_* keys
# - Detects selection via /tmp/project_secondary_on
# - Exports OPENAI_API_KEY, ANTHROPIC_API_KEY, MOONSHOT_AI_API_KEY if present
# - Syncs PERSONAL_* aliases and Goose API key
# Return 0 if secondary project is active, else 1.
function __projects_is_secondary() {
  # If zsh/functions is already loaded, prefer the canonical helper
  if typeset -f project_secondary_enabled >/dev/null 2>&1; then
    project_secondary_enabled
    return $?
  fi
  # Fallback to file marker
  [[ -f "/tmp/project_secondary_on" ]]
}

function projects_apply_llm_env_from_selection() {
  local PROJECTS_FILE="$HOME/.projects"
  [[ -f "$PROJECTS_FILE" ]] || return 0
  source "$PROJECTS_FILE"

  local project_prefix project_label
  if __projects_is_secondary; then
    project_prefix="SECONDARY"; project_label="secondary"
  else
    project_prefix="PRIMARY"; project_label="primary"
  fi

  # Helper to read dynamic var names using zsh parameter expansion
  local key_var key_value

  # OPENAI
  key_var="${project_prefix}_PROJECT_OPENAI_API_KEY"
  key_value="${(P)key_var}"
  if [[ -n "$key_value" ]]; then
    export OPENAI_API_KEY="$key_value"
  fi

  # Anthropic
  key_var="${project_prefix}_PROJECT_ANTHROPIC_API_KEY"
  key_value="${(P)key_var}"
  if [[ -n "$key_value" ]]; then
    export ANTHROPIC_API_KEY="$key_value"
  fi

  # Moonshot (Kimi)
  key_var="${project_prefix}_PROJECT_MOONSHOT_AI_API_KEY"
  key_value="${(P)key_var}"
  if [[ -n "$key_value" ]]; then
    export MOONSHOT_AI_API_KEY="$key_value"
  fi

  # Refresh PERSONAL_* aliases
  export PERSONAL_OPENAI_API_KEY="${OPENAI_API_KEY}"
  export PERSONAL_ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}"
  export PERSONAL_MOONSHOT_AI_API_KEY="${MOONSHOT_AI_API_KEY}"

  # Keep Goose OpenAI key in sync if Goose is installed
  if command -v goose-gui >/dev/null 2>&1 \
    || command -v goose-desktop >/dev/null 2>&1 \
    || command -v goose >/dev/null 2>&1 \
    || command -v goose-cli >/dev/null 2>&1; then
    # Goose reads provider-specific keys (e.g., OPENAI_API_KEY, ANTHROPIC_API_KEY) directly.
    :
  fi
}

# vim: set ft=zsh:
