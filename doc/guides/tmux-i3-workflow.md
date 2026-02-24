# Tmux + i3 Workflow

## Goal

Use i3 to place windows on workspaces and tmux to manage terminal sessions,
windows, and panes inside WezTerm.

## Current Setup

- Tmux config source: `tmux/tmux.conf`
- Generic session launcher: `bin/tmux-session`
- Startup autoloader: `bin/tmuxp-autoload`
- Default profile for dotfiles: `tmuxp/dotfiles.yaml`
- i3 shortcut for workspace 5:
  - `Mod+Shift+Return` starts `tmux-session dotfiles` in WezTerm

At i3 startup, autoload entries are read from:

- `~/${PRIMARY_PROJECT_CODE}.dotfiles/tmuxp/autoload`

Each non-empty line uses this format:

- `<workspace>:<session-identifier>`

`<session-identifier>` is passed as-is to `tmux-session`.
Use explicit names (`dotfiles`) or project-prefixed names (`ia:dotfiles`)
depending on which tmux session you want.

Examples:

- `5:dotfiles` -> starts `tmux-session dotfiles` on workspace 5
- `6:ia:dotfiles` -> starts `tmux-session ia:dotfiles` on workspace 6

Tip: keep this autoload list minimal and include only essential startup sessions.

## Session Profiles

Profiles are stored in `tmuxp/*.yaml`. The profile name is the filename.

Examples:

- `tmuxp/dotfiles.yaml` -> `tmux-session dotfiles`
- `tmuxp/ia.yaml` -> `tmux-session ia`
- `tmuxp/sas.yaml` -> `tmux-session sas`

Minimal profile:

```yaml
session_name: ia
start_directory: ~/code/ia
windows:
  - window_name: app
    panes:
      - nvim
  - window_name: shell
    panes:
      -
```

## Daily Commands

Start or attach:

```bash
tmux-session dotfiles
tmux-session ia
```

Inside tmux (default prefix `Ctrl-b`):

- `Ctrl-b 1/2/...`: switch window
- `Ctrl-b h/j/k/l`: move pane focus
- `Ctrl-b H/J/K/L`: resize pane
- `Ctrl-b d`: detach

## Why This Scales

- One launcher script for all projects
- One tmuxp YAML per project/workspace intent
- Easy to review and version in dotfiles
- Less custom shell glue over time
