## Context

The onboarding command needs an identity for SSH key comments and for GPG key creation. The
dotfiles configure one Git identity per user, while GnuPG may contain multiple secret keys
or user IDs. Selecting a GPG identity automatically in an ambiguous situation risks using
the wrong identity.

## Goals / Non-Goals

- Goals:
  - Avoid name and email prompts by reusing the configured Git identity.
  - Preserve non-interactive command-line overrides.
  - Leave credentials unchanged.
- Non-Goals:
  - Guess among multiple identities.
  - Add an `fzf` dependency to the security-key bootstrap command.
  - Alter any existing GPG user ID.

## Decisions

- Decision: Use `git config --get user.name` and `git config --get user.email` as the
  defaults when those command-line options are absent. Read GnuPG user IDs through
  machine-readable `--with-colons` output only to fill values Git does not provide, and
  only when exactly one valid candidate exists.
  - Alternatives considered: Preferring GnuPG would make a multiple-key keyring ambiguous;
    parsing human-readable GPG output is locale-dependent and unreliable.
- Decision: Command-line identity options take precedence over configured or detected values.
  - Alternatives considered: Overriding supplied values would make automation surprising.

## Risks / Trade-offs

- A missing or incomplete Git identity with multiple GPG identities will still require a
  prompt or explicit options. → This deliberately favours correctness over an unverified
  guess.

## Migration Plan

1. Configure Git's `user.name` and `user.email` through the dotfiles.
2. Rerun `onboard` and confirm it uses the configured identity without name/email prompts.
3. Use `onboard --name ... --email ...` to override the configured identity when needed.

## Open Questions

- None.
