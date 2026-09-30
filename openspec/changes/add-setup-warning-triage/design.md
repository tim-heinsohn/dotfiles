# Design

## Context

`setup-system` delegates installation to scripts that write directly to the terminal. A failed
official package batch falls back to individual package attempts, and `npm-packages` repeats npm's
warnings for every update. See `proposal.md` for motivation and the delta spec for required
behavior.

## Goals / Non-Goals

**Goals:**
- Preserve live command output while capturing it for classification.
- Make known, successful package-manager status messages quiet in review output.
- Give the user a sequential, interactive investigation path for each unique actionable issue.
- Keep all system changes explicitly user-controlled while an agent is involved.

**Non-Goals:**
- Automatically fixing every warning or parsing arbitrary package-manager output as a removal plan.
- Replacing package-manager, npm, or agent diagnostics.
- Running an agent in noninteractive provisioning or interpreting agent output as shell commands.

## Decisions

### Shared Bash diagnostic helper

Implement a small shared helper sourced by `setup-system` and, where needed, its child scripts. It
will execute a command with inherited stdin, stream combined output to the terminal and a temporary
log, and preserve the command exit status using `pipefail`/`PIPESTATUS`. The helper will collect
structured issue records only after a command exits, so interactive package-manager prompts remain
usable.

Alternative considered: suppress known warning output at command invocation. Rejected because
operators still need the original output while setup is running.

### Explicit, localized classifier rules

Maintain a short, auditable rule table that maps known npm warning forms (`deprecated`,
`ERESOLVE`, `EBADENGINE`) to actionable issue types and recognizes the German and English
already-current package-manager messages as informational after a successful command. Unknown text
is retained in the captured log but is not automatically labeled actionable unless the producing
command fails.

Alternative considered: infer severity from every `warn` or `warning` string. Rejected because
localized tools and successful upgrade status would create unbounded false positives.

### Stable grouping fingerprint

Normalize known warning records by type and dependency/package names, excluding volatile version
numbers, timestamps, package paths, and indentation. Retain a bounded excerpt, occurrence count,
and producing-command labels for each fingerprint. Group insertion order is first observation.

Alternative considered: group complete raw warning blocks. Rejected because package versions and
paths would prevent identical root causes from grouping.

### Agent session boundary

After each top-level setup phase, render the issue summary and, only with a TTY, prompt before each
agent launch. Resolve `opencode`, `claude`, and `codex` from `PATH` at that point and display only
available choices. Supply a bounded temporary context file or argument that has an explicit
untrusted-data delimiter and asks for investigation, options, and confirmation before changes.
Wait for the selected process to exit before offering the next group. Delete temporary context and
logs on normal exit and signal cleanup.

Alternative considered: feed a generated solution back into the shell. Rejected because an LLM
response and captured tool output are both untrusted, and system provisioning is high impact.

## Risks / Trade-offs

- A new warning will remain unclassified until a rule is added. -> Failed commands are always
  surfaced, raw logs remain available, and rule additions are deliberate.
- Captured output can contain instruction-like text or sensitive values. -> Bound excerpts, label
  them as untrusted data, do not pass environment secrets, and clean up temporary files.
- An interactive agent can make changes as the user. -> The script only starts an explicitly chosen
  agent and never executes its output; the agent prompt requires user confirmation for changes.
- Capturing output can affect pipeline exit status. -> Cover the wrapper with shell tests for
  successful and failing commands before integrating it with provisioning steps.

## Migration Plan

1. Add the helper and tests for classification, grouping, and exit-status preservation.
2. Wrap the package and npm installation invocations used by `setup-system`.
3. Validate an interactive run with synthetic repeated npm warnings and an already-current package
   message.
4. Roll back by removing helper integration; package and npm commands retain their existing direct
   behavior.
