## Context

The package bundle installs `plasma-login-manager`, which supplies `plasmalogin.service`
and an alias for `display-manager.service`. It is separate from KWin, which runs inside a
user's selected Plasma session. The system is intended for several users who may choose
different installed sessions.

## Goals / Non-Goals

- Goals:
  - Enable a graphical login screen after the package bundle is installed.
  - Preserve the greeter's session chooser for each login.
- Non-Goals:
  - Enable autologin.
  - Force a single desktop session globally or per user.
  - Replace another enabled display manager automatically.

## Decisions

- Decision: Run `systemctl enable --now plasmalogin.service` from the base setup stage,
  after `packages-install` has installed the service.
  - Alternatives considered: Only installing the package leaves the system at a TTY;
    requiring a separate manual command makes a fresh setup incomplete.
- Decision: Do not have `onboard` select a desktop session with `fzf`.
  - Alternatives considered: Writing Plasma Login's `Autologin.Session` setting. That
    setting couples a single system user to automatic login and is incompatible with a
    shared system where users choose their own session at the greeter.

## Risks / Trade-offs

- An existing, different display manager can conflict with Plasma Login.
  → This initial setup intentionally does not disable or replace an existing manager.

## Migration Plan

1. Run the base setup stage.
2. Confirm `plasmalogin.service` is enabled and active.
3. At the greeter, select each user's desired installed session.

## Open Questions

- None.
