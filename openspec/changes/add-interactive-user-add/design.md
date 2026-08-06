## Context

The system uses Plasma Login for several local users and zsh as the standard login shell.
`useradd` is the native Arch tool, but a direct invocation can omit the home directory,
shell, password, or a deliberate administrator-access decision.

## Goals / Non-Goals

- Goals:
  - Safely create one normal local desktop account through guided prompts.
  - Use the repository's zsh default and standard private-user-group layout.
  - Make administrator access an explicit opt-in choice.
- Non-Goals:
  - Create system/service accounts.
  - Enable autologin or select a desktop session.
  - Grant Docker, audio, video, or other supplementary groups automatically.
  - Modify existing users.

## Decisions

- Decision: Use a normal-user command that invokes narrowly scoped `sudo useradd` and
  `sudo passwd` commands.
  - Alternatives considered: Requiring the entire command to run under sudo loses the
    invoking-user context and encourages broad root-shell usage.
- Decision: Require confirmation after showing the chosen username and whether `wheel` will
  be granted; default the `wheel` prompt to no.
  - Alternatives considered: Automatically granting administrator access gives every local
    account system-wide power.
- Decision: Validate a human-account username before any privileged command, reject existing
  names, and pass it as a quoted argument rather than constructing shell code.
  - Alternatives considered: Passing user text through `eval` or accepting a shell fragment
    would permit command injection.

## Risks / Trade-offs

- Account creation cannot be fully rolled back once files are written to the new home.
  → The command will validate first and obtain an explicit confirmation before creating it.
- A user without `wheel` cannot use sudo.
  → This is intentional; an administrator can add it later with `usermod -aG wheel`.

## Migration Plan

1. Run `user-add` from an existing administrator account.
2. Choose the new account name and administrator-access option.
3. Set its password when prompted by `passwd`.
4. Sign in through Plasma Login and select an installed desktop session.

## Open Questions

- None.
