# Custom p10k segments

# API key indicator: shows $$ for personal key, (c) for company key
function prompt_api_key() {
  if [[ -n "$ANTHROPIC_API_KEY" && -n "$PERSONAL_ANTHROPIC_API_KEY" ]]; then
    if [[ "$ANTHROPIC_API_KEY" == "$PERSONAL_ANTHROPIC_API_KEY" ]]; then
      p10k segment -f 208 -t '$$'
    else
      p10k segment -f 172 -t '(c)'
    fi
  fi
}

function instant_prompt_api_key() {
  prompt_api_key
}

# Add api_key segment to right prompt elements
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  api_key                 # anthropic api key indicator  
  ${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[@]}
)