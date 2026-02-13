# Tasks: dotfiles-security-audit

## 1. File Permissions
- [x] 1.1 Audit bin/ scripts for overly permissive permissions
- [x] 1.2 Fix permissions on sensitive files (gpg/, gopass/)
- [x] 1.3 Ensure shell configs have appropriate permissions

## 2. Secret Scanning
- [x] 2.1 Scan for hardcoded API keys/tokens
- [x] 2.2 Review zsh/environment for secrets
- [x] 2.3 Review shell/profile for secrets
- [x] 2.4 Review git/gitconfig for credentials
- [x] 2.5 Document any secrets found and how to handle

## 3. Script Security (use semgrep)
- [x] 3.1 Run semgrep OWASP Top 10 ruleset
- [x] 3.2 Run semgrep shell-specific ruleset
- [x] 3.3 Review bin/ scripts for command injection
- [x] 3.4 Review for insecure eval/bash -c usage
- [x] 3.5 Check for curl | bash patterns
- [x] 3.6 Verify input validation in scripts

## 4. Infrastructure Security
- [x] 4.1 Review docker/ configs
- [x] 4.2 Review caddy/ configs for TLS settings
- [x] 4.3 Review traefik/ configs for secure defaults

## 5. Backup Security
- [x] 5.1 Audit backup scripts (gnupg-backup, etc.)
- [x] 5.2 Ensure backup handling is secure

## 6. Hardening
- [x] 6.1 Add .gitignore entries for sensitive files
- [ ] 6.2 Consider adding pre-commit secrets detection
- [x] 6.3 Document security best practices
