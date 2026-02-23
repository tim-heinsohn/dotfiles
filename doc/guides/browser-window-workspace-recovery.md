# Browser Window Workspace Recovery

## Goal

Restore Firefox/Chromium windows to their previous i3 workspaces after reboot,
without hardcoded static i3 rules per title.

## Components

- Cache/restore script: `bin/browser-workspace-cache`
- Startup restore unit: `services/browser-workspace-restore.service`
- Snapshot unit: `services/browser-workspace-snapshot.service`
- Snapshot timer: `services/browser-workspace-snapshot.timer`
- i3 startup trigger: `i3/config`

Cache location (not versioned):

- `${XDG_CACHE_HOME:-~/.cache}/i3-browser-workspaces.json`

## Commands

```bash
# Update cache from current browser window placement
browser-workspace-cache snapshot

# Restore current browser windows to cached workspaces
browser-workspace-cache restore

# Wait for stable browser windows, then restore
browser-workspace-cache restore-wait

# Print cached entries
browser-workspace-cache show
```

## Safety Against Startup Races

The script includes guards to avoid bad snapshots right after browser startup:

- Skip snapshot when browser process uptime is too low
- Skip snapshot for a cooldown period after restore
- Use lock directory to prevent concurrent runs
- `restore-wait` waits for a stable window set before moving windows

Tune with environment variables:

- `BWC_MIN_BROWSER_UPTIME_SEC` (default `45`)
- `BWC_SNAPSHOT_COOLDOWN_SEC` (default `120`)
- `BWC_RESTORE_STABLE_ITERATIONS` (default `3`)
- `BWC_RESTORE_STABLE_INTERVAL_SEC` (default `2`)
- `BWC_RESTORE_MAX_WAIT_SEC` (default `180`)

## Setup

Run once after pulling dotfiles changes:

```bash
~/dotfiles/services/setup
```

This links user units, reloads systemd user config, and enables timers.
