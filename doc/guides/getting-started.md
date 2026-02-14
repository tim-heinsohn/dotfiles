# Getting Started Guide

This guide walks through setting up your environment with these dotfiles.

## Prerequisites

### Required Tools

1. **Bombadil** - Dotfile manager
   ```bash
   # Install via cargo
   cargo install toml-bombadil
   
   # Or see: https://oknozor.github.io/toml-bombadil/
   ```

2. **Git** - Version control

3. **Zsh** - Primary shell (optional but recommended)
   ```bash
   # Ubuntu/Debian
   sudo apt install zsh
   
   # Arch
   sudo pacman -S zsh
   ```

4. **Neovim** or Vim - Text editor
   ```bash
   # Neovim (recommended)
   # See: https://github.com/neovim/neovim#installing
   ```

### Optional Tools

- fzf - Fuzzy finder
- delta - Git pager
- GPG - Encryption
- GoPass - Password manager

## Installation Steps

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run Bombadil Link

```bash
bombadil link
```

This will:
- Create symlinks from `~/` and `~/.config/` to files in this repository
- Run `prehooks` to set up directories
- Run `posthooks` for additional configuration

### 3. Verify Installation

```bash
# Check key symlinks
ls -la ~/.zshrc
ls -la ~/.config/nvim/
ls -la ~/.gitconfig

# Should all point to ~/dotfiles/
```

### 4. Install Plugins

```bash
# Neovim plugins (inside nvim)
nvim +PlugInstall +qa

# Or with lazy.nvim, plugins will install automatically on first launch
```

## First-Time Setup

### Shell Configuration

1. Set Zsh as default shell:
   ```bash
   chsh -s $(which zsh)
   ```

2. Restart terminal or source config:
   ```bash
   source ~/.zshrc
   ```

### Editor Setup

1. Open Neovim and let plugins install
2. Check LSP servers:
   ```
   :LspInfo
   ```

## Next Steps

- Review `zsh/aliases` for available shortcuts
- Check `bin/` for utility scripts
- Read `doc/guides/workflows.md` for common tasks

## Troubleshooting

If you encounter issues, see `doc/guides/troubleshooting.md`.

Common issues:
- Symlinks not created → Run `bombadil link` again
- Plugins not loading → Check Neovim init logs
- Shell not starting → Check `zsh/zshrc` for errors

## Keeping Updated

```bash
cd ~/dotfiles
git pull
bombadil link
```
