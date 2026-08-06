## Why

Adding a desktop user requires several security-relevant `useradd` options and a separate
password step. A repository command can make the intended workstation defaults explicit and
avoid accidental account or privilege creation.

## What Changes

- Add an interactive `bin/user-add` command for creating a local desktop account.
- Create the home directory and a private primary group, set zsh as the login shell, and
  set the password through `sudo passwd`.
- Offer an explicit, default-no choice to grant `wheel` membership.
- Document the command in `bin/README.md`.

## Impact

- Affected specs: `local-user-management` (new capability)
- Affected code: `bin/user-add`, `bin/README.md`
