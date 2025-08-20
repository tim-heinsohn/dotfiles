# Custom p10k segments

# API key indicator: shows $ for personal key, (c) for company key
function prompt_api_key() {
  if kimi_enabled; then
    if [[ "$MOONSHOT_AI_API_KEY" == "$PERSONAL_MOONSHOT_AI_API_KEY" ]]; then
      p10k segment -f 208 -t '$'
    else
      p10k segment -f 172 -t '(c)'
    fi
  elif [[ -n "$ANTHROPIC_API_KEY" && -n "$PERSONAL_ANTHROPIC_API_KEY" ]]; then
    if [[ "$ANTHROPIC_API_KEY" == "$PERSONAL_ANTHROPIC_API_KEY" ]]; then
      p10k segment -f 208 -t '$'
    else
      p10k segment -f 172 -t '(c)'
    fi
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
source ~/dotfiles/zsh/p10k.claude.zsh

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  kimi_mode               # kimi mode indicator
  battery_level           # battery percentage
  api_key                 # anthropic api key indicator
  claude_status           # claude code status
  ${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]}
)