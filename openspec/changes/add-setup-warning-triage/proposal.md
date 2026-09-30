# Proposal

## Why

`setup-system` exposes every package-manager and npm warning inline, which obscures actionable
problems and repeats the same dependency warning for every global npm update. Users need a
reviewable, supervised way to investigate grouped setup diagnostics before continuing.

## What Changes

- Capture output from package and npm installation steps and classify it as successful status,
  ignorable informational output, warning, or failure.
- Normalize and group repeated actionable diagnostics into one issue with all affected commands.
- Suppress known successful package-manager messages, such as an already-current package, from
  the warning review.
- Present actionable issue groups after their producing step and offer an interactive selection of
  an available `opencode`, `claude`, or `codex` executable for each group in sequence.
- Preserve the existing setup flow when the user skips review or no supported agent is available.

## Capabilities

### New Capabilities
- `setup-warning-triage`: Classifies, groups, displays, and supports supervised investigation of
  actionable setup diagnostics.

### Modified Capabilities
- None.

## Impact

- Affected code: `bin/setup-system`, `bin/packages-install`, `bin/npm-packages`, and a small
  shared Bash helper if needed.
- External executables: `pacman`, `yay`, `npm`, `opencode`, `claude`, and `codex`.
- No noninteractive run will invoke an agent or remove output required for installation failure
  diagnosis.
