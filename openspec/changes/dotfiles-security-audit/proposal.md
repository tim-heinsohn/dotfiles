# Proposal: dotfiles-security-audit

## Why

Dotfiles often contain sensitive information and configuration that could be exploited:
- Shell environment files may contain API keys or secrets
- Scripts may have insecure patterns (hardcoded passwords, command injection)
- File permissions may be too open on sensitive files
- Some configs may expose sensitive information

A security audit will identify and fix these issues.

## What Changes

### Audit File Permissions

1. **Review script permissions**
   - Check for overly permissive scripts (777, 766)
   - Ensure scripts are 755 (executable) or 644 (config)
   - Sensitive scripts should be 700

2. **Review sensitive file permissions**
   - `gpg/`, `gopass/` configs - should be 600 or 700
   - Shell environment files - check for secrets before making public

### Audit for Hardcoded Secrets

3. **Scan for hardcoded secrets**
   - API keys, tokens, passwords in config files
   - Use grep patterns: `api[_-]?key`, `password`, `secret`, `token`
   - Review `zsh/environment`, `shell/profile`, any .env files

4. **Review shell environment files**
   - `zsh/environment` - commonly contains PATH and sensitive variables
   - Check for actual secrets that should be elsewhere (e.g., keychain, env vars)

5. **Review git credentials**
   - `git/gitconfig` - may contain credentials for git operations
   - Ensure any stored credentials are appropriate

### Audit Script Security

6. **Review bin/ scripts for security issues**
   - Command injection vulnerabilities (unescaped variables in shell)
   - Use of `eval`, `bash -c` with user input
   - Insecure temporary file creation
   - Missing input validation

7. **Use semgrep for automated scanning**
   - Use `semgrep` skill for comprehensive security scanning
   - Run OWASP Top 10 ruleset
   - Run shell-specific ruleset for script analysis
   - Check for secrets with built-in patterns

8. **Check for dangerous patterns**
   - `curl | bash` or `wget | bash` patterns
   - Commands that use `sudo` without full paths
   - Insecure heredocs

### Infrastructure Security

8. **Review Docker/Service configs**
   - `docker/` - review for security best practices
   - `caddy/`, `traefik/` - review for TLS/secure defaults

9. **Review GitHub Actions / CI configs**
   - If any exist - verify they don't expose secrets
   - Check for secure token handling

### Backup/Restore Security

10. **Audit backup scripts**
    - `bin/backup-gnupg`, `bin/gnupg-backup` - handle sensitive data
    - Ensure backups are encrypted and stored securely

## Impact

- Affected: All config files, scripts, particularly shell env files
- Risk: Variable - some fixes may break configurations if not done carefully
- High importance: Security issues can lead to compromise

## Open Questions

1. Are there actual secrets in the environment files, or is secret handling externalized?
2. Which scripts handle sensitive data and need priority review?
3. Should we add automated secret scanning to the repository? (recommend: yes, add to pre-commit)
4. Are there any services (caddy, traefik) with exposed ports that need securing?
