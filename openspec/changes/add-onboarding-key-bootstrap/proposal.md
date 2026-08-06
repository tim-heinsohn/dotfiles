## Why

A freshly provisioned user account needs SSH and OpenPGP credentials before it can safely
access source-control hosts, sign commits, and use encrypted services.

## What Changes

- Add an interactive `bin/onboard` script for a normal user.
- Generate an encrypted Ed25519 SSH key without overwriting an existing key.
- Generate a modern GPG key with an expiry and an interactive passphrase prompt.
- Present clear headings for each completed onboarding stage and reserved next steps.

## Impact

- Affected specs: `onboarding-key-bootstrap` (new)
- Affected code: `bin/onboard`
- Dependencies: OpenSSH and GnuPG installed on the target system
