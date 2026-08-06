## MODIFIED Requirements

### Requirement: Interactive onboarding command

The system SHALL provide an executable `bin/onboard` command that runs only as a normal
user and presents clearly headed onboarding stages. When the user does not supply identity
options, the command SHALL use Git's configured `user.name` and `user.email` as defaults.
It SHALL use a single valid identity present on existing secret GPG keys only to fill values
Git does not provide. When an identity value cannot be determined, it SHALL request that
value interactively.

#### Scenario: Normal-user invocation

- **WHEN** a normal user runs `bin/onboard`
- **THEN** the command presents the SSH and GPG key stages and reserves a clearly headed
  section for later onboarding steps.

#### Scenario: Configured Git identity

- **WHEN** the user runs `bin/onboard` without identity options and Git has configured
  `user.name` and `user.email`
- **THEN** the command SHALL reuse both values without prompting, regardless of how many
  secret GPG identities exist.

#### Scenario: Missing Git identity value

- **WHEN** Git does not configure an identity value and exactly one valid secret GPG identity
  exists
- **THEN** the command SHALL reuse the corresponding GPG value without prompting for it.

#### Scenario: No unambiguous identity value

- **WHEN** Git does not configure an identity value and no single valid GPG identity can
  provide it
- **THEN** the command SHALL request that value interactively.

#### Scenario: Explicit identity options

- **WHEN** the user supplies `--name` and/or `--email`
- **THEN** the command SHALL preserve the supplied values rather than replacing them with a
  discovered identity.

#### Scenario: Root invocation

- **WHEN** the command is invoked as root
- **THEN** it SHALL stop before generating or changing credentials and explain that it must
  run as the target user.
