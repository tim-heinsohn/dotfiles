## ADDED Requirements

### Requirement: Guided local desktop account creation

The system SHALL provide an executable `bin/user-add` command that interactively creates one
new normal local account with a home directory, a private primary group, and `/usr/bin/zsh`
as its login shell.

#### Scenario: Valid new account

- **WHEN** an administrator confirms a valid, unused username
- **THEN** the command SHALL create its home directory and private group, configure zsh as
  the login shell, and invoke the system password prompt for that account.

#### Scenario: Existing or invalid username

- **WHEN** the supplied username is invalid or already exists
- **THEN** the command SHALL stop before invoking a privileged account-creation command.

### Requirement: Deliberate administrator access

The command SHALL ask whether to add the new account to `wheel`, defaulting to no, and SHALL
show the selected privilege before the final confirmation.

#### Scenario: Standard user

- **WHEN** the administrator accepts the default privilege choice
- **THEN** the command SHALL create the account without `wheel` membership.

#### Scenario: Administrator user

- **WHEN** the administrator explicitly requests `wheel` membership and confirms the summary
- **THEN** the command SHALL add the new account to `wheel`.
