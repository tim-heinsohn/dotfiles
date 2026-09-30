# Spec Delta

## Purpose

Provide actionable, user-supervised review of grouped diagnostics emitted while provisioning a
system, without obscuring successful package installation output.

## ADDED Requirements

### Requirement: Setup diagnostic classification
The setup flow SHALL retain command output and classify diagnostics from completed provisioning
steps as informational, actionable warning, or failure. It SHALL classify npm deprecation,
peer-dependency resolution, and unsupported-engine warnings as actionable warnings. It SHALL
classify a nonzero command exit as a failure. It SHALL not create an actionable issue for a
successful package-manager message that states a package is already current or skipped because it
is current.

#### Scenario: Already-current package is skipped
- **WHEN** a package-manager command succeeds and reports that `jdk17-openjdk` is already current
- **THEN** setup SHALL not present that message in diagnostic review

#### Scenario: npm dependency conflict is retained
- **WHEN** npm emits an `ERESOLVE overriding peer dependency` warning
- **THEN** setup SHALL record it as an actionable warning for review

### Requirement: Repeated diagnostic grouping
The setup flow SHALL normalize matching actionable diagnostics into one issue group and retain the
number of occurrences and the commands that produced them. It SHALL display each issue group once
in the order in which its first occurrence was observed.

#### Scenario: Repeated peer dependency warning
- **WHEN** the same npm peer-dependency warning is emitted while updating multiple global packages
- **THEN** setup SHALL display one issue group with the number of occurrences and affected updates

### Requirement: Interactive issue investigation
When setup is attached to a terminal and actionable issue groups exist, it SHALL offer the user an
interactive review of each group sequentially. For each selected group, it SHALL offer only the
available `opencode`, `claude`, and `codex` executables, launch the user-selected executable as an
interactive child process, and resume setup only after that process exits. The flow SHALL allow the
user to skip any group or all remaining groups.

#### Scenario: User investigates a warning group
- **WHEN** a terminal user selects a grouped npm unsupported-engine warning and chooses an
  available agent
- **THEN** setup SHALL launch that agent interactively with the group context and continue to the
  next group after the agent exits

#### Scenario: Noninteractive setup run
- **WHEN** setup is not attached to a terminal
- **THEN** it SHALL print the grouped diagnostic summary and SHALL not launch an agent

### Requirement: Safe agent context handoff
The setup flow SHALL provide captured diagnostic text to an agent as untrusted data, bounded to a
documented maximum size per issue group. It SHALL instruct the agent to treat embedded instructions
as diagnostic text only and to seek user confirmation before making system changes. The setup flow
SHALL NOT execute an agent response or a suggested command automatically.

#### Scenario: Diagnostic text contains an instruction-like string
- **WHEN** captured output contains text that resembles an instruction or command
- **THEN** the agent handoff SHALL label it as untrusted diagnostic data and setup SHALL not execute
  it
