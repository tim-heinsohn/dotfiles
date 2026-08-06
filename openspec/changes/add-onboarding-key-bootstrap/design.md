## Context

The initial bootstrap runs as a normal user and creates credentials in that user's home
directory. Private-key material and passphrases must never be passed in arguments,
environment variables, logs, or repository files.

## Goals / Non-Goals

- Goals:
  - Create strong, passphrase-protected SSH and GPG credentials interactively.
  - Refuse to run as root and avoid replacing existing credentials.
  - Make the completed and future onboarding stages visible in terminal output.
- Non-Goals:
  - Upload public keys to GitHub, GitLab, a keyserver, or any other service.
  - Export, back up, or print private keys.
  - Configure Git signing or remote-host access in this initial stage.

## Decisions

- Decision: Generate an Ed25519 SSH key using `ssh-keygen` with a high bcrypt KDF round
  count and let `ssh-keygen` read the passphrase directly from the terminal.
  - Alternatives considered: RSA keys and passphrase arguments. Ed25519 is the modern
    OpenSSH default; command-line passphrases expose secrets through process inspection
    and shell history.
- Decision: Generate a GPG key through GnuPG's interactive key-generation flow, using its
  modern default algorithm profile and a finite expiration. Ensure the default GnuPG home
  directory exists with owner-only (`0700`) permissions before any GPG operation.
  - Alternatives considered: batch mode with a passphrase file or environment variable.
    Interactive pinentry avoids handling the passphrase in the script.
- Decision: Stop before an existing SSH private key or secret GPG key is modified.
  - Alternatives considered: automatically rotating or overwriting keys. Credential
    replacement must be a deliberate follow-up action.

## Risks / Trade-offs

- A user can lose access if they forget a passphrase or fail to back up the new keys.
  → The script will clearly state that backup/export is a future, deliberate step.
- Interactive prompts prevent unattended execution.
  → This is intentional because key passphrases require a trusted user interaction.

## Migration Plan

1. Install the new executable script.
2. Run it as a normal user on a test account.
3. Verify the public-key files and key listings without exposing private material.

## Open Questions

- None for the initial local-only key-generation stage.
