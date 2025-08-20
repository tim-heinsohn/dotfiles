# Claude Code status line configuration for Powerlevel10k
# This file provides real-time Claude Code session monitoring

# 1. Context Usage Monitor with color coding
function prompt_claude_context() {
    local claude_dir="${HOME}/.claude"
    local session_file="${claude_dir}/current_session.json"
    
    if [[ -f "$session_file" ]]; then
        local context_pct=$(jq -r '.context_percentage // 0' "$session_file" 2>/dev/null)
        local tokens=$(jq -r '.tokens_used // 0' "$session_file" 2>/dev/null)
        
        # Color coding based on context usage
        local color="green"
        if (( context_pct > 80 )); then
            color="red"
        elif (( context_pct > 60 )); then
            color="yellow"
        fi
        
        p10k segment -f $color -t "${context_pct}% ${tokens}t"
    fi
}

function instant_prompt_claude_context() {
    prompt_claude_context
}

# 2. Session Health Indicator
function prompt_claude_health() {
    local active_sessions=$(pgrep -f "claude" | wc -l)
    local api_key_source=""
    
    if [[ -n "$ANTHROPIC_API_KEY" ]]; then
        # Simple check for work vs personal key patterns
        if [[ ${#ANTHROPIC_API_KEY} -gt 20 ]]; then
            api_key_source="🔑"
        else
            api_key_source="🏠"
        fi
    fi
    
    if [[ $active_sessions -gt 0 ]]; then
        p10k segment -f green -t "🤖${active_sessions}${api_key_source}"
    fi
}

function instant_prompt_claude_health() {
    prompt_claude_health
}

# 3. Model & Token Counter
function prompt_claude_model() {
    local claude_dir="${HOME}/.claude"
    local session_file="${claude_dir}/current_session.json"
    
    if [[ -f "$session_file" ]]; then
        local model=$(jq -r '.model // "unknown"' "$session_file" 2>/dev/null)
        local tokens=$(jq -r '.tokens_used // 0' "$session_file" 2>/dev/null)
        
        # Shorten model names for display
        case "$model" in
            *"claude-3-5-sonnet"*) model="35s" ;;
            *"claude-3-5-haiku"*) model="35h" ;;
            *"claude-3-opus"*) model="3o" ;;
            *"claude-3-sonnet"*) model="3s" ;;
            *"claude-3-haiku"*) model="3h" ;;
            *) model="?" ;;
        esac
        
        p10k segment -f cyan -t "${model} ${tokens}t"
    fi
}

function instant_prompt_claude_model() {
    prompt_claude_model
}

# 4. Workspace Context
function prompt_claude_workspace() {
    if [[ -n "$CLAUDE_WORKSPACE" ]]; then
        local short_dir=$(basename "$CLAUDE_WORKSPACE")
        p10k segment -f blue -t "[🤖 $short_dir]"
    elif [[ -f ".claude-session" ]]; then
        local short_dir=$(basename "$PWD")
        p10k segment -f 244 -t "[🤖 $short_dir]"
    fi
}

function instant_prompt_claude_workspace() {
    prompt_claude_workspace
}

# Combined Claude status function
function prompt_claude_status() {
    local claude_dir="${HOME}/.claude"
    local session_file="${claude_dir}/current_session.json"
    
    if [[ -f "$session_file" ]]; then
        local model=$(jq -r '.model // "unknown"' "$session_file" 2>/dev/null)
        local tokens=$(jq -r '.tokens_used // 0' "$session_file" 2>/dev/null)
        local context_pct=$(jq -r '.context_percentage // 0' "$session_file" 2>/dev/null)
        
        # Color coding
        local color="green"
        if (( context_pct > 80 )); then
            color="red"
        elif (( context_pct > 60 )); then
            color="yellow"
        fi
        
        # Short model name
        case "$model" in
            *"claude-3-5-sonnet"*) model="35s" ;;
            *"claude-3-5-haiku"*) model="35h" ;;
            *"claude-3-opus"*) model="3o" ;;
            *"claude-3-sonnet"*) model="3s" ;;
            *"claude-3-haiku"*) model="3h" ;;
            *) model="?" ;;
        esac
        
        p10k segment -f $color -t "🤖 ${model} ${context_pct}% ${tokens}t"
    fi
}

function instant_prompt_claude_status() {
    prompt_claude_status
}