# Sudo Authentication Issues

Quick reference for diagnosing and fixing sudo authentication problems.

## Symptoms

- Sudo prompts for password but rejects correct password
- Password works in new terminal but not in existing ones
- System appears to hang after failed sudo attempts
- i3lock or other authentication systems fail

## Diagnosis Commands

### Check account status
```bash
# Check if account is locked (P = active, L = locked)
sudo passwd -S $USER
# Output: username P last-change min max warn inactive
```

### Check failed authentication attempts
```bash
# View failed login attempts
sudo faillock --user $USER

# Check sudo credential cache status
sudo -v
```

### Check for hung sudo processes
```bash
# List sudo processes for your user
ps aux | grep sudo | grep $USER
```

## Fix Commands

### Quick fixes (try in order)

1. **Clear sudo credential cache**
   ```bash
   sudo -k
   ```

2. **Try in a fresh terminal**
   ```bash
   # Open completely new terminal window (not tab)
   sudo echo "test"
   ```

3. **Reset PAM faillock**
   ```bash
   sudo faillock --user $USER --reset
   ```

4. **Kill hung sudo processes**
   ```bash
   pkill -u $USER sudo
   ```

5. **Reboot** (clears all PAM/sudo state)
   ```bash
   # If sudo works:
   sudo systemctl reboot

   # If sudo broken, from TTY (Ctrl+Alt+F2):
   systemctl reboot
   ```

## Prevention

### For scripts requiring sudo

1. **Never run sudo in non-interactive contexts** (e.g., from Claude Code)
2. **Prompt user before sudo operations**
3. **Batch sudo operations** - ask for password once, do all operations
4. **Consider passwordless sudo for specific safe commands**:
   ```bash
   sudo visudo -f /etc/sudoers.d/safe-commands
   ```
   Add lines like:
   ```
   username ALL=(ALL) NOPASSWD: /usr/bin/smartctl
   username ALL=(ALL) NOPASSWD: /usr/bin/systemctl start service-name
   ```

### When Claude Code needs sudo

- ❌ **Don't**: Let Claude run sudo commands directly
- ✅ **Do**: Have Claude show you the command to run manually
- ✅ **Do**: Run commands in your own terminal
- ✅ **Do**: Use --install flags that handle sudo internally after prompting

## Common Cause

**Sudo attempts without TTY** (like from automated scripts or Claude Code) can cause:
- Failed authentication attempts counted against account
- PAM state corruption
- Sudo credential cache locks

**Solution**: Always run sudo commands interactively in a real terminal.
