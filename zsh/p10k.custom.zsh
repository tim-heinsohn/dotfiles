# Custom p10k segments

# API key indicator: shows $ for personal key, or current project CODE
__project_code() {
  local code
  if [[ -f "$HOME/.projects" ]]; then
    if [[ -f "/tmp/project_secondary_on" ]]; then
      # Extract SECONDARY_PROJECT_CODE without sourcing (avoids gopass calls)
      code=$(grep -E '^export SECONDARY_PROJECT_CODE=' "$HOME/.projects" | cut -d'"' -f2)
    else
      # Extract PRIMARY_PROJECT_CODE without sourcing
      code=$(grep -E '^export PRIMARY_PROJECT_CODE=' "$HOME/.projects" | cut -d'"' -f2)
    fi
  fi
  echo "${code:-PRJ}"
}

__project_color() {
  local color
  if [[ -f "$HOME/.projects" ]]; then
    if [[ -f "/tmp/project_secondary_on" ]]; then
      # Extract SECONDARY_PROJECT_PROMPT_COLOR without sourcing
      color=$(grep -E '^export SECONDARY_PROJECT_PROMPT_COLOR=' "$HOME/.projects" | cut -d'"' -f2)
    else
      # Extract PRIMARY_PROJECT_PROMPT_COLOR without sourcing
      color=$(grep -E '^export PRIMARY_PROJECT_PROMPT_COLOR=' "$HOME/.projects" | cut -d'"' -f2)
    fi
  fi
  echo "${color:-172}"
}

function prompt_api_key() {
  local code color
  code=$(__project_code)
  color=$(__project_color)
  if kimi_enabled; then
    # Kimi provider: show project code only (provider shown via separate segment)
    p10k segment -f "$color" -t "$code"
  elif [[ -n "$ANTHROPIC_API_KEY" || -n "$ANTHROPIC_AUTH_TOKEN" ]]; then
    # Anthropic provider active (direct or via token): show project then provider
    p10k segment -f "$color" -t "$code"
    p10k segment -f white -t "A\\"
  else
    # Default: show project code if available
    p10k segment -f "$color" -t "$code"
  fi
}

function instant_prompt_api_key() {
  prompt_api_key
}

# Battery percentage indicator
function prompt_battery_level() {
  local percentage
  local battery_status
  if command -v acpi &>/dev/null; then
    local acpi_output=$(acpi -b)
    percentage=$(echo "$acpi_output" | grep -o '[0-9]\+%' | tr -d '%')
    battery_status=$(echo "$acpi_output" | grep -o 'Discharging')
  else
    local battery_dir=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n 1)
    if [[ -n "$battery_dir" ]]; then
      percentage=$(cat "$battery_dir/capacity")
      battery_status=$(cat "$battery_dir/status")
    else
      return
    fi
  fi

  if [[ "$battery_status" == "Discharging" && "$percentage" -lt 95 ]]; then
    local background_color='172' # Orange
    if (( percentage < 50 )); then
      background_color='red'
    fi
    p10k segment -f white -b $background_color -t "⚡${percentage}%%"
  fi
}

function instant_prompt_battery_level() {
  prompt_battery_level
}

# Kimi mode indicator
function prompt_kimi_mode() {
  if kimi_enabled; then
    p10k segment -f yellow -t 'K'
  fi
}

function instant_prompt_kimi_mode() {
  prompt_kimi_mode
}

# Add custom segments to right prompt elements
# Source Claude Code status line functions
if [[ -f "$HOME/.zsh/p10k.claude.zsh" ]]; then
  source "$HOME/.zsh/p10k.claude.zsh"
elif [[ -f "$HOME/dotfiles/zsh/p10k.claude.zsh" ]]; then
  source "$HOME/dotfiles/zsh/p10k.claude.zsh"
fi

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  api_key                 # project code and/or provider
  kimi_mode               # provider (Kimi) indicator
  battery_level           # battery percentage
  claude_status           # claude code status
  ${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]}
)
