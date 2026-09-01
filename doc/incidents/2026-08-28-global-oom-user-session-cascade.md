# Global OOM User-Session Cascade

**Date:** 2026-08-28

**Status:** Resolved with safeguards; a recurrence requires a full session restart.

## Summary

An unbounded ShellCheck invocation exhausted system memory and triggered the kernel's global
OOM killer. The system remained partially usable, but the OOM killer terminated core
user-session infrastructure, including the user systemd manager, D-Bus, GNOME Keyring,
AT-SPI, and Evolution services.

Individual services restarted, but they did not share a coherent session state. This produced
seemingly unrelated follow-on failures: OpenCode sessions disappeared, Evolution crashed and
could not authenticate, and accessibility-bus state became stale.

## Impact

- OpenCode sessions were lost.
- Evolution's local mail store needed SQLite index repair.
- Evolution crashed while registering accessibility objects against a stale AT-SPI bus address.
- Evolution connected to IMAP but stalled before folder discovery because GNOME Keyring's Secret
  Service was internally invalid after the OOM cascade.
- Mail cache recovery and IMAP configuration changes were attempted during diagnosis, but they
  were not the primary cause of the remaining connection problem.
- The Tea CLI was suspected because `tea logins oauth-refresh` failed; investigation showed this
  is a separate authentication configuration/state issue, documented below.

## Timeline

All times are local and from the system journal.

| Time | Event |
| --- | --- |
| 13:34 | Repeated global kernel OOM events began. |
| 13:38:58 | The kernel killed `gnome-keyring-daemon`; systemd restarted it. |
| 13:40:45 | The kernel killed Evolution source, calendar, and address-book factories. |
| 13:42:53 | The kernel killed D-Bus, AT-SPI, GNOME Keyring, and other session services. |
| 13:43:44 | GNOME Keyring was killed again after its restart. |
| 13:43:48 | The kernel killed the user manager and `shellcheck` (approximately 4.4 GiB RSS). |

## Root Cause

The direct cause was global memory exhaustion from ShellCheck. The kernel OOM killer, not a
configured userspace OOM daemon, selected processes throughout the user session.

Evidence at the time of investigation:

- `systemd-oomd.service` was disabled and inactive.
- `earlyoom` and `nohang` were not installed.
- The journal records `shellcheck` with approximately 4.4 GiB RSS when it was killed.
- The journal records OOM termination of `user@1000.service`, `dbus-broker`,
  `gnome-keyring-daemon`, `at-spi-dbus-bus`, and Evolution services.

The memory guard added afterward did not cause the incident. It was introduced specifically to
prevent the global OOM condition from recurring.

## Why Partial Recovery Failed

The session manager restarted some services after they were killed. However, service restart
does not recreate the complete desktop session atomically:

- Existing applications retained environment variables referring to the old AT-SPI bus.
- GNOME Keyring restarted around D-Bus disruption and subsequently emitted repeated Secret
  Service assertions such as `GKD_SECRET_IS_SERVICE` and `G_IS_DBUS_CONNECTION`.
- Evolution could open a TLS connection to `mail.friendsoft.de`, but credential retrieval from
  the broken Secret Service stalled before it created IMAP folder metadata.

This is a degraded session, not an Evolution-only failure. Once the user manager or session
D-Bus has been OOM-killed, logging out and back in is the reliable recovery because it rebuilds
the user-session dependency graph together.

## Recovery Performed

### Local Evolution Store

- `~/.local/share/evolution/mail/local/folders.db` initially failed SQLite integrity checking
  with a missing autoindex row.
- A backup was preserved as `folders.db.before-reindex`.
- `REINDEX` restored `PRAGMA integrity_check` to `ok`.

### AT-SPI

- The stale `AT_SPI_BUS` value pointed to `/run/user/1000/at-spi/bus_0`.
- The live bus was `/run/user/1000/at-spi/bus`.
- This stale address caused Evolution to crash through `libatk-bridge` during accessibility
  registration.

### Credential Prompts

- The restarted user manager had `DBUS_SESSION_BUS_ADDRESS`, but lacked `DISPLAY` and
  `XAUTHORITY`.
- D-Bus activation consequently started `gcr-prompter` without an X display. It failed with
  `cannot open display`, so password prompts could not save credentials for Evolution and other
  desktop applications.
- The current user manager was repaired with `DISPLAY=:0` and `XAUTHORITY=/home/t/.Xauthority`.

### Evolution IMAP

- The `smile` IMAP cache was preserved before rebuilding:
  `~/.cache/evolution/mail/1517600024.31887.2@SMXT2.before-rebuild-20260830`.
- The IMAP server was verified to respond immediately over TLS and advertise `AUTH=PLAIN` and
  `AUTH=LOGIN`.
- Disabling QRESYNC and broad folder checks did not advance folder discovery; these settings were
  not the root cause.
- Restarting GNOME Keyring restored the Secret Service collection. Evolution subsequently
  authenticated and loaded mail normally.

## Safeguards Added

Commit `c2f23f6` added the following compensating controls:

- `bin/shellcheck` runs each invocation in a transient systemd scope with
  `MemoryHigh=1G`, `MemoryMax=2G`, and `OOMPolicy=kill`.
- `bin/xmodmap-watchdog` compares the inherited `AT_SPI_BUS` with the live accessibility bus and
  repairs stale state.
- `services/xmodmap-watchdog.service` supplies the X11 display environment after user-manager
  restarts.
- `i3/config` imports `DISPLAY` and `XAUTHORITY` into the D-Bus and systemd user-manager
  activation environments at startup and on i3 reload. This lets `gcr-prompter` display and save
  credentials after user-manager recovery.

Bombadil was relinked after the managed changes, and the ShellCheck wrapper is resolved before
`/usr/bin/shellcheck`.

## Tea Authentication Follow-Up

Observed command:

```text
tea logins oauth-refresh
Error: login 'smileson' does not have a refresh token. It may have been created using a different authentication method
```

This error is not evidence that the OOM event removed Tea credentials:

- `~/.config/tea/credentials.json.enc` was last modified on 2026-08-27, before the OOM event.
- Tea could read and use the credential: `tea whoami` successfully reached Gitea with the
  `smileson` login.
- `oauth-refresh` only applies to logins created with an OAuth refresh token. The stored login
  does not have one, consistent with a personal access token or another non-refreshable method.

`tea whoami` returned a disabled profile. That is Gitea server-side account state and requires
separate investigation if it blocks normal Gitea operations; a local OOM event cannot disable a
remote account. Do not use `oauth-refresh` for this login until it is intentionally recreated as
an OAuth login.

## Future Response

If the kernel OOM killer terminates `dbus-broker`, `user@UID.service`, or multiple desktop
session services:

1. Stop the memory-consuming workload.
2. Log out and back in before relying on desktop applications.
3. Treat targeted service restarts as temporary recovery only.
4. Inspect the journal for OOM victims before changing application configuration or deleting
   caches.
5. Keep expensive developer tools inside bounded systemd scopes so they are killed before a
   global OOM cascade can affect the desktop session.
