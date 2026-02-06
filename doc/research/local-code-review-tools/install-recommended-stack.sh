#!/bin/bash
# Local Code Review Tools - Recommended Stack Installer
# Research: local-code-review-tools.md (2026-02-02)

set -e

echo "==================================================="
echo "Local Code Review Tools - Installation Script"
echo "==================================================="
echo ""

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    echo "❌ Error: This script is designed for Arch Linux (pacman required)"
    exit 1
fi

echo "This script will install and configure:"
echo "  - LazyGit (TUI for fast git workflows)"
echo "  - Tig (Terminal git browser)"
echo "  - git-delta (Syntax-highlighted diffs)"
echo "  - Meld (Visual merge tool)"
echo "  - Difftastic (Syntax-aware diff tool)"
echo ""

# Confirm installation
read -p "Continue with installation? (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Installing packages from official repositories..."
echo "=================================================="

# Install core tools
sudo pacman -S --needed lazygit tig git-delta meld difftastic

echo ""
echo "✅ Packages installed successfully!"
echo ""

# Configure git-delta
echo "Configuring git-delta as default pager..."
echo "==========================================="

git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.side-by-side true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "Monokai Extended"

# Configure merge strategy to use delta
git config --global merge.conflictstyle diff3

echo "✅ git-delta configured!"
echo ""

# Configure meld
echo "Configuring Meld as default merge/diff tool..."
echo "==============================================="

git config --global merge.tool meld
git config --global mergetool.meld.cmd 'meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"'
git config --global diff.tool meld
git config --global difftool.prompt false

echo "✅ Meld configured!"
echo ""

# Optional: Ask about Gitea installation
echo ""
echo "==================================================="
echo "Optional: Full PR Simulation with Gitea"
echo "==================================================="
echo ""
echo "Gitea provides a complete GitLab MR/GitHub PR interface locally."
echo "Requirements: ~170MB RAM, systemd service, AUR package"
echo ""
read -p "Install Gitea? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v yay &> /dev/null; then
        echo "Installing Gitea from AUR..."
        yay -S --needed gitea
        
        echo ""
        echo "To start Gitea:"
        echo "  sudo systemctl enable --now gitea"
        echo "  xdg-open http://localhost:3000"
    else
        echo "⚠️  Warning: 'yay' AUR helper not found."
        echo "Please install Gitea manually:"
        echo "  git clone https://aur.archlinux.org/gitea.git"
        echo "  cd gitea"
        echo "  makepkg -si"
    fi
fi

# Optional: Ask about VS Code installation
echo ""
echo "==================================================="
echo "Optional: IDE Integration with VS Code + GitLens"
echo "==================================================="
echo ""
echo "VS Code with GitLens provides IDE-integrated code review."
echo "Requirements: ~300MB (Electron-based)"
echo ""
read -p "Install VS Code? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing VS Code..."
    sudo pacman -S --needed code
    
    echo ""
    read -p "Install GitLens extension? (y/N): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing GitLens extension..."
        code --install-extension eamodio.gitlens
        echo "✅ GitLens installed!"
    fi
fi

echo ""
echo "==================================================="
echo "Installation Complete!"
echo "==================================================="
echo ""
echo "✅ Core tools installed and configured:"
echo "   - LazyGit: Run 'lazygit' in any git repository"
echo "   - Tig: Run 'tig' or 'tig diff ref1..ref2'"
echo "   - git-delta: Automatically used for 'git diff' and 'git log -p'"
echo "   - Meld: Use 'git difftool' or 'git mergetool'"
echo "   - Difftastic: Run 'difft file1 file2' for syntax-aware diffs"
echo ""
echo "Quick start commands:"
echo "  lazygit                          # Launch TUI"
echo "  tig diff main..feature-branch    # Compare branches"
echo "  git difftool -t meld HEAD~1 HEAD # Visual diff"
echo "  git log -p                       # Pretty log with delta"
echo ""
echo "For more information, see:"
echo "  - doc/research/local-code-review-tools/quick-reference.md"
echo "  - doc/research/local-code-review-tools/local-code-review-tools.md"
echo ""
echo "Happy reviewing! 🎉"
