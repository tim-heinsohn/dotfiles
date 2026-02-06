#!/bin/bash
# Setup script for opencode-smart-title fork with CWD patch
# 
# This script is called by bin/npm-packages to set up the local patched
# version of opencode-smart-title. It can also be run manually.
#
# Usage: ./opencode/setup-smart-title-fork.sh

set -euo pipefail

REPO_PATH="/srv/lib/opencode-smart-title"
FORK_URL="https://github.com/tim-heinsohn/opencode-smart-title"
UPSTREAM_URL="https://github.com/Tarquinen/opencode-smart-title"
PLUGIN_DIR="$HOME/.config/opencode/plugins"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# 1. Clone or update repo
if [ ! -d "$REPO_PATH" ]; then
    log "Cloning fork from $FORK_URL to $REPO_PATH"
    mkdir -p /srv/lib
    git clone "$FORK_URL" "$REPO_PATH"
    cd "$REPO_PATH"
    git remote add upstream "$UPSTREAM_URL" || true
else
    log "Repository exists at $REPO_PATH"
    cd "$REPO_PATH"
    
    # Ensure remotes are correct
    if ! git remote get-url fork >/dev/null 2>&1; then
        git remote add fork "$FORK_URL"
    fi
    if ! git remote get-url upstream >/dev/null 2>&1; then
        git remote add upstream "$UPSTREAM_URL"
    fi
    
    # Update from fork
    log "Fetching latest from fork"
    git fetch fork || log "⚠ Failed to fetch from fork"
fi

# 2. Install dependencies
log "Installing dependencies"
if npm ci; then
    log "✓ Dependencies installed"
else
    log "✗ npm ci failed"
    exit 1
fi

# 3. Build plugin
log "Building plugin"
if npm run build; then
    log "✓ Plugin built successfully"
else
    log "✗ Build failed"
    exit 1
fi

# 4. Symlink to OpenCode plugins directory
log "Symlinking to $PLUGIN_DIR/opencode-smart-title"
mkdir -p "$PLUGIN_DIR"
rm -rf "$PLUGIN_DIR/opencode-smart-title"
ln -sf "$REPO_PATH/dist" "$PLUGIN_DIR/opencode-smart-title"

log "✓ Setup complete!"
log ""
log "Next steps:"
log "1. Create fork on GitHub: https://github.com/Tarquinen/opencode-smart-title/fork"
log "2. Commit your changes: cd $REPO_PATH && git add -A && git commit -m 'Add CWD to session titles'"
log "3. Push to fork: git push fork main"
log "4. Restart OpenCode to load the local plugin"
