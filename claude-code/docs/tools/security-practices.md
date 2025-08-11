# Security Practices

## No Sudo
- Never attempt to run sudo commands. Instead, ask the user to run those manually

## Environment Variable Handling
- Environment variables ending in `_KEY` or `_PASSWORD` should never have their content displayed
- Use `${VAR:+set}` pattern to check if sensitive vars are set without revealing content

## General Security Guidelines
- Always follow security best practices when editing code
- Never introduce code that exposes or logs secrets and keys
- Never commit secrets or keys to the repository
