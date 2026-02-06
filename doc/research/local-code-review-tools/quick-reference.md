# Local Code Review Tools - Quick Reference

**Research Date**: 2026-02-02  
**Full Report**: `local-code-review-tools.md`

## TL;DR

**No single tool provides complete GitLab MR/GitHub PR experience locally without trade-offs.**

### Top Picks by Use Case

| Use Case | Tool | Install | Why |
|----------|------|---------|-----|
| 🚀 **Fast local workflow** | LazyGit | `pacman -S lazygit` | Best TUI, active dev, speed |
| 🔧 **Maximum flexibility** | Tig + git-delta | `pacman -S tig git-delta` | Any ref comparison, scriptable |
| 🌐 **Full PR simulation** | Gitea | `yay -S gitea` | True web MR/PR interface |
| 🎨 **Visual merging** | Meld | `pacman -S meld` | Best three-way merge UI |
| 💻 **IDE integration** | VS Code + GitLens | `pacman -S code` | Full context, modern UI |

## Quick Install (Recommended Stack)

```bash
# Core tools (lightweight)
sudo pacman -S lazygit tig git-delta meld

# Configure git-delta for beautiful diffs
git config --global core.pager delta
git config --global delta.side-by-side true
git config --global delta.syntax-theme "Monokai Extended"

# Configure meld for visual merges
git config --global merge.tool meld
```

**You now have**:
- ⚡ LazyGit for fast commit/branch operations
- 🔍 Tig for any ref comparison (`tig diff main..feature`)
- 🎨 Delta for syntax-highlighted side-by-side diffs
- 🔀 Meld for visual merge conflict resolution

## Common Workflows

### Compare branches
```bash
# LazyGit: Launch and use Branches panel (key: 3)
lazygit

# Tig: Direct comparison
tig diff main..feature-branch

# Meld: Visual side-by-side
git difftool -t meld main feature-branch
```

### Review uncommitted changes
```bash
# LazyGit: Files panel shows unstaged/staged
lazygit

# Tig: Show unstaged changes
tig diff HEAD

# Meld: Visual comparison
git difftool -t meld HEAD
```

### Resolve merge conflicts
```bash
# Meld (recommended)
git mergetool -t meld

# LazyGit: Files panel shows conflicts
lazygit
```

## Feature Matrix

| Feature | LazyGit | Tig+Delta | Gitea | Meld |
|---------|---------|-----------|-------|------|
| Visual diffs | ✅ TUI | ✅ Text | ✅✅ Web | ✅✅ GUI |
| Arbitrary refs | ✅ | ✅✅ | ✅ | ✅ |
| Side-by-side | ⚠️ | ✅ | ✅ | ✅ |
| Comments/approvals | ❌ | ❌ | ✅ | ❌ |
| Three-way merge | ❌ | ⚠️ | ⚠️ | ✅✅ |
| Memory footprint | 50MB | 10MB | 170MB | 30MB |
| Launch time | <1s | <0.5s | 5-10s | 1-2s |

## When to Add More Tools

### Add Gitea if you need:
- ✅ Full PR/MR workflow locally
- ✅ Threaded code comments
- ✅ Web-based review interface
- ❌ Don't mind ~170MB RAM + systemd service

```bash
yay -S gitea
sudo systemctl enable --now gitea
xdg-open http://localhost:3000
```

### Add VS Code + GitLens if you need:
- ✅ IDE-integrated review
- ✅ Full code context during review
- ✅ Modern visual interface
- ❌ Don't mind Electron overhead (~300MB)

```bash
sudo pacman -S code
code --install-extension eamodio.gitlens
```

### Add Difftastic if you want:
- ✅ Syntax-aware structural diffs
- ✅ Better understanding of code changes
- ✅ Terminal-based precision

```bash
sudo pacman -S difftastic
git config --global diff.external difftastic
```

## Limitations

### What NO local tool provides:
- ❌ Full PR/MR workflow WITHOUT server infrastructure (only Gitea comes close)
- ❌ Lightweight browser-based modern UI (git-instaweb is deprecated)
- ❌ Collaborative features offline (comments require web platform)

### Known Trade-offs:
- **LazyGit**: No PR features, TUI learning curve
- **Tig+Delta**: Terminal-only, needs wide terminal (≥200 cols)
- **Gitea**: Infrastructure overhead, overkill for solo use
- **Meld**: Limited to diff/merge, no PR workflow
- **VS Code**: Electron overhead, requires full IDE

## Next Steps

1. **Start minimal**: Install core stack (LazyGit, Tig, Delta, Meld)
2. **Learn one tool**: Try LazyGit for daily workflow
3. **Expand as needed**: Add Gitea for PR simulation or VS Code for IDE integration
4. **Customize**: Configure keybindings in `~/.config/lazygit/config.yml`

**Full research details**: See `local-code-review-tools.md`
