## ADDED Requirements

### Requirement: Directory Structure Documentation
The repository SHALL document its directory structure in a centralized location.

#### Scenario: New user explores repository
- **WHEN** a new user clones the repository
- **THEN** they can find a README.md at root explaining the structure

### Requirement: Dotfiles Relationship Clarity
The relationship between root directories and .dots/ SHALL be clearly documented.

#### Scenario: Understanding .dots/ purpose
- **WHEN** a user wants to modify a config
- **THEN** they understand which directory to edit (root vs .dots/)

## MODIFIED Requirements

### Requirement: Service Organization
**Previous text:** Service setup scripts may exist in various locations

**Updated text:** Service setup scripts SHALL be organized in a dedicated services/ directory

#### Scenario: Finding service setup
- **WHEN** a user wants to set up a service (e.g., docker, postgresql)
- **THEN** they can find all setup scripts in services/
