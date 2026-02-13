# Tasks: dotfiles-security-audit

## 1. File Permissions
- [ ] 1.1 Audit bin/ scripts for overly permissive permissions
- [ ] 1.2 Fix permissions on sensitive files (gpg/, gopass/)
- [ ] 1.3 Ensure shell configs have appropriate permissions

## 2. Secret Scanning
- [ ] 2.1 Scan for hardcoded API keys/tokens
- [ ] 2.2 Review zsh/environment for secrets
- [ ] 2.3 Review shell/profile for secrets
- [ ] 2.4 Review git/gitconfig for credentials
- [ ] 2.5 Document any secrets found and how to handle

## 3. Script Security (use semgrep)
- [ ] 3.1 Run semgrep OWASP Top 10 ruleset
- [ ] 3.2 Run semgrep shell-specific ruleset
- [ ] 3.3 Review bin/ scripts for command injection
- [ ] 3.4 Review for insecure eval/bash -c usage
- [ ] 3.5 Check for curl | bash patterns
- [ ] 3.6 Verify input validation in scripts

## 4. Infrastructure Security
- [ ] 4.1 Review docker/ configs
- [ ] 4.2 Review caddy/ configs for TLS settings
- [ ] 4.3 Review traefik/ configs for secure defaults

## 5. Backup Security
- [ ] 5.1 Audit backup scripts (gnupg-backup, etc.)
- [ ] 5.2 Ensure backup handling is secure

## 6. Hardening
- [ ] 6.1 Add .gitignore entries for sensitive files
- [ ] 6.2 Consider adding pre-commit secrets detection
- [ ] 6.3 Document security best practices
