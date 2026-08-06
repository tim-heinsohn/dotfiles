## ADDED Requirements

### Requirement: Interactive onboarding command

The system SHALL provide an executable `bin/onboard` command that runs only as a normal
user and presents clearly headed onboarding stages.

#### Scenario: Normal-user invocation

- **WHEN** a normal user runs `bin/onboard`
- **THEN** the command presents the SSH and GPG key stages and reserves a clearly headed
  section for later onboarding steps.

#### Scenario: Root invocation

- **WHEN** the command is invoked as root
- **THEN** it SHALL stop before generating or changing credentials and explain that it must
  run as the target user.

### Requirement: Secure SSH key generation

The command SHALL interactively generate a passphrase-protected Ed25519 SSH key with a
high bcrypt KDF work factor, without exposing private-key material or the passphrase.

#### Scenario: No existing default SSH key

- **WHEN** the default Ed25519 private-key path is absent
- **THEN** the command generates the key, writes its public counterpart, and reports the
  public-key path.

#### Scenario: Existing default SSH key

- **WHEN** the default Ed25519 private-key path already exists
- **THEN** the command SHALL leave it unchanged and report that it was retained.

### Requirement: Secure GPG key generation

The command SHALL interactively generate a modern GPG signing and encryption key with a
finite expiry, without accepting a passphrase through command arguments or environment
variables.

#### Scenario: New GPG identity

- **WHEN** the user supplies an identity and no corresponding secret key exists
- **THEN** the command invokes GnuPG's interactive passphrase flow and reports the new
  public fingerprint.

#### Scenario: Existing GPG identity

- **WHEN** a corresponding secret key already exists
- **THEN** the command SHALL leave it unchanged and report that it was retained.
