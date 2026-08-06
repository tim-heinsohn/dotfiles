## Why

Installing Plasma and KWin alone does not start a graphical login screen. A new Arch
installation needs its installed Plasma Login Manager enabled so users can select an
account and a desktop session at boot.

## What Changes

- Enable and start Plasma Login Manager (`plasmalogin.service`) after the base package
  bundle has installed it.
- Report that the graphical login screen provides the session chooser; do not configure
  autologin or a system-wide session default.

## Impact

- Affected specs: `graphical-login` (new capability)
- Affected code: `bin/setup-system`
