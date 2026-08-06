## ADDED Requirements

### Requirement: Graphical login provisioning

The base system setup SHALL enable and start Plasma Login Manager (`plasmalogin.service`)
after installing the repository package bundle.

#### Scenario: Fresh system setup

- **WHEN** a user runs `setup-system base` or `setup-system all` after the Plasma Login
  Manager package is installed
- **THEN** `plasmalogin.service` SHALL be enabled and started.

### Requirement: Session choice remains user-directed

The setup SHALL preserve the graphical login manager's session chooser and SHALL NOT enable
autologin or configure a system-wide default session.

#### Scenario: Multiple users with different desktop sessions

- **WHEN** installed users sign in through Plasma Login Manager
- **THEN** each user can select an available session at the graphical login screen without
  the setup forcing all users into one session.
