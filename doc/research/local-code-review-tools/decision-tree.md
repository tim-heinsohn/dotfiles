# Local Code Review Tools - Decision Tree

**Quick tool selection guide based on your needs**

## Start Here

```
╔════════════════════════════════════════════════════════════════╗
║  What type of code review do you need?                         ║
╚════════════════════════════════════════════════════════════════╝
                              │
                ┌─────────────┴─────────────┐
                │                           │
                ▼                           ▼
    ┌───────────────────────┐   ┌──────────────────────┐
    │ Quick diff checking   │   │ Formal review process │
    │ (understanding code)  │   │ (PR-like workflow)    │
    └───────────┬───────────┘   └──────────┬───────────┘
                │                          │
                │                          ▼
                │              ┌──────────────────────────┐
                │              │ Can accept infrastructure│
                │              │ overhead (~170MB RAM +   │
                │              │ systemd service)?        │
                │              └──────┬──────────┬────────┘
                │                     │          │
                │                   YES         NO
                │                     │          │
                │                     ▼          ▼
                │            ┌────────────┐  ┌─────────────────┐
                │            │  GITEA     │  │ No perfect      │
                │            │            │  │ solution exists │
                │            │ Full PR    │  │                 │
                │            │ simulation │  │ → Use LazyGit + │
                │            │            │  │   external PR   │
                │            │ yay -S     │  │   platform      │
                │            │ gitea      │  │                 │
                │            └────────────┘  └─────────────────┘
                │
                ▼
    ╔══════════════════════════════════════╗
    ║  What's your preferred interface?    ║
    ╚══════════════════════════════════════╝
                │
    ┌───────────┼───────────┬────────────┐
    │           │           │            │
    ▼           ▼           ▼            ▼
┌────────┐ ┌────────┐ ┌─────────┐ ┌──────────┐
│Terminal│ │Terminal│ │   GUI   │ │IDE-based │
│(TUI)   │ │(text)  │ │(visual) │ │(VS Code) │
│        │ │        │ │         │ │          │
│Speed   │ │Flex    │ │Merging  │ │Context   │
│focused │ │focused │ │focused  │ │focused   │
└────┬───┘ └───┬────┘ └────┬────┘ └────┬─────┘
     │         │           │           │
     ▼         ▼           ▼           ▼
```

## Path 1: Terminal TUI (Speed Focused)

**→ LazyGit**

```
Install: sudo pacman -S lazygit
Launch: lazygit

Perfect for:
✅ Fast commit/branch/stash operations
✅ Interactive rebase and amending
✅ Visual commit graph in terminal
✅ Keyboard-driven workflow

Not suitable for:
❌ PR-like comments/approvals
❌ Visual three-way merges
```

**When to use**:
- You work primarily in terminal
- Speed is priority over visual precision
- You manage commits/branches frequently
- You like keyboard-driven UIs

**Complement with**: Meld for complex merges

---

## Path 2: Terminal Text (Flexibility Focused)

**→ Tig + git-delta**

```
Install: sudo pacman -S tig git-delta
Config:  git config --global core.pager delta
         git config --global delta.side-by-side true
Usage:   tig diff ref1..ref2

Perfect for:
✅ Any arbitrary ref comparison
✅ Scriptable/automatable workflows
✅ SSH environments (no X11 needed)
✅ Side-by-side syntax-highlighted diffs

Not suitable for:
❌ Visual learners preferring GUIs
❌ Narrow terminal windows (<200 cols)
```

**When to use**:
- Maximum flexibility is priority
- You need scriptable diff viewing
- You work over SSH frequently
- You want the most powerful terminal git UI

**Complement with**: Meld for merges, LazyGit for commits

---

## Path 3: GUI (Visual Merge Focused)

**→ Meld**

```
Install: sudo pacman -S meld
Config:  git config --global merge.tool meld
         git config --global diff.tool meld
Usage:   git difftool -t meld ref1 ref2
         git mergetool -t meld

Perfect for:
✅ Visual three-way merge conflicts
✅ Side-by-side file comparison
✅ Directory tree comparison
✅ Intuitive GUI for non-power-users

Not suitable for:
❌ Fast commit workflows
❌ PR-like review process
❌ Bulk diff operations
```

**When to use**:
- You frequently resolve merge conflicts
- Visual comparison is important
- You prefer GUI over terminal
- You want lightweight tool (no IDE)

**Complement with**: LazyGit or Tig for diff viewing

---

## Path 4: IDE Integration (Context Focused)

**→ VS Code + GitLens**

```
Install: sudo pacman -S code
         code --install-extension eamodio.gitlens
Usage:   code .
         (Use GitLens sidebar for git operations)

Perfect for:
✅ Full code context during review
✅ Visual blame and commit graphs
✅ Modern, polished interface
✅ Already using VS Code as editor

Not suitable for:
❌ Lightweight/minimal setups
❌ Non-VS Code users
❌ Terminal-only workflows
```

**When to use**:
- VS Code is your primary editor
- You want IDE-integrated git review
- Visual quality is priority
- Electron overhead is acceptable (~300MB)

**Complement with**: Meld for complex merges

---

## Path 5: Full PR Simulation

**→ Gitea**

```
Install: yay -S gitea
Config:  sudo systemctl enable --now gitea
Usage:   xdg-open http://localhost:3000

Perfect for:
✅ Complete GitLab MR/GitHub PR interface
✅ Threaded code comments
✅ Review approvals and assignments
✅ Team collaboration locally

Not suitable for:
❌ Solo developer quick reviews
❌ Minimal infrastructure setups
❌ Limited RAM environments (<512MB)
```

**When to use**:
- You need full PR workflow locally
- Team collaboration on local network
- Learning PR review workflows
- Infrastructure overhead is acceptable

**Complement with**: Nothing needed - Gitea is complete

---

## Multi-Tool Strategies

### Strategy 1: Minimal (90% coverage)
```bash
sudo pacman -S lazygit meld

Daily workflow → LazyGit
Merge conflicts → Meld

Footprint: ~80MB
Learning curve: Low
```

### Strategy 2: Recommended (95% coverage)
```bash
sudo pacman -S lazygit tig git-delta meld

Daily workflow → LazyGit
Flexible diffs → Tig + delta
Merge conflicts → Meld

Footprint: ~100MB
Learning curve: Medium
```

### Strategy 3: Complete (100% coverage)
```bash
sudo pacman -S lazygit tig git-delta meld code
code --install-extension eamodio.gitlens
yay -S gitea

Daily workflow → LazyGit
Flexible diffs → Tig + delta
Merge conflicts → Meld
IDE review → VS Code + GitLens
PR simulation → Gitea

Footprint: ~600MB
Learning curve: High
```

---

## Special Use Cases

### Use Case: Solo Developer, Primarily Terminal
**Recommendation**: LazyGit + Meld
- Fast for commits/branches
- Visual for conflicts
- Lightweight (~80MB)

### Use Case: Team Using External PR Platform (GitHub/GitLab)
**Recommendation**: LazyGit + Tig
- Local speed with LazyGit
- Flexible ref comparison with Tig
- Use GitHub/GitLab for formal reviews

### Use Case: Learning Git Workflows
**Recommendation**: LazyGit + Gitea
- LazyGit for understanding git operations visually
- Gitea for learning PR/MR workflows
- Full visibility into git state

### Use Case: DevOps/CI Integration
**Recommendation**: Tig + git-delta
- Scriptable and automatable
- Works in headless environments
- SSH-friendly

### Use Case: VS Code Power User
**Recommendation**: VS Code + GitLens + Meld
- IDE-integrated review with GitLens
- Meld for complex merges
- No need for separate terminal tools

### Use Case: Maximum Flexibility, No Compromises
**Recommendation**: Complete stack (Strategy 3)
- Have the right tool for every scenario
- ~600MB footprint
- Worth it for daily git-heavy workflows

---

## Quick Selection Matrix

| Your Priority | Tool(s) | Install Command |
|---------------|---------|-----------------|
| Speed | LazyGit | `pacman -S lazygit` |
| Flexibility | Tig + Delta | `pacman -S tig git-delta` |
| Visual quality | Meld | `pacman -S meld` |
| PR simulation | Gitea | `yay -S gitea` |
| IDE integration | VS Code + GitLens | `pacman -S code` |
| Lightweight | LazyGit + Meld | `pacman -S lazygit meld` |
| Complete | All tools | See Strategy 3 above |

---

## Still Not Sure?

**Try this**: Install the recommended stack and experiment for a week

```bash
# Run the automated installer
cd doc/research/local-code-review-tools
./install-recommended-stack.sh

# Week 1: Use LazyGit exclusively
# Week 2: Try Tig for complex comparisons  
# Week 3: Use Meld for merges
# Week 4: Decide which tools stuck
```

**Or read more**:
- `quick-reference.md` for common workflows
- `local-code-review-tools.md` for detailed analysis
- `README.md` for overview

---

**Remember**: No single tool is perfect. Most developers use 2-3 tools together:
- **One for speed** (LazyGit)
- **One for flexibility** (Tig)
- **One for visual tasks** (Meld or VS Code)
