## ADDED Requirements

### Requirement: Secret-Free Configuration
The repository SHALL not contain hardcoded secrets in configuration files.

#### Scenario: Scanning for secrets
- **WHEN** a security scan is run
- **THEN** no hardcoded API keys, passwords, or tokens are found

### Requirement: Secure File Permissions
The repository SHALL use appropriate file permissions for sensitive files.

#### Scenario: Checking permissions
- **WHEN** sensitive files are reviewed
- **THEN** they have appropriate permissions (600/700 for sensitive, 644/755 for general)

### Requirement: Script Security Review
Shell scripts SHALL be reviewed for common security vulnerabilities.

#### Scenario: Security review
- **WHEN** scripts are added or modified
- **THEN** they are reviewed for command injection, insecure patterns
