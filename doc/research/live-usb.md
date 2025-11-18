# Live USB Research (Updated November 18, 2025)

## Requirements Recap
- Need a Live USB that boots straight into a usable Arch- or Debian-based environment without forcing an install workflow.
- Persistence is optional (and currently not desired); overlay or RAM-based sessions that reset on reboot are acceptable.
- Essential tooling: disk inspection/repair, imaging/cloning, network access (SSH, VPN, browser if possible), and standard admin utilities.

## Arch-Based Non-Persistent Options
- **Official Arch ISO** – Monthly image already runs as a stateless overlay session with a getty prompt (and GNOME terminal if you start the minimal graphical profile). No installer runs automatically; `archinstall` is only launched manually. Includes core admin stack: `pacman`, `systemd-networkd`, `iwd`, `iproute2`, `smartmontools`, `parted`, `fsck.*`, etc.
- **Custom `archiso` build** – Rebuild the ISO with `mkarchiso` to preinstall extra packages (e.g., `xfce4`, `gparted`, `ddrescue`, `wireless_tools`) and auto-start desired services/DMs so the stick boots directly into your preferred CLI or desktop workflow.
- **EndeavourOS (Mercury / Mercury Neo)** – Arch-based live KDE Plasma 6.x environment with hardware helpers, Firefox, `nvim`, `ssh`, drivers, and Calamares only when launched manually. Good when you want a ready-to-work desktop plus Arch repos.
- **Garuda Linux (Broadwing)** – Ships multiple spins (Dr460nized KDE, GNOME, Hyprland, COSMIC preview) with Garuda tools, Btrfs snapshots, network widgets, and the new Rani assistant. Boots to live desktop; installer is optional.
- **GreenBANG (formerly ArchBang)** – Lightweight Openbox live session focused on speed and older hardware, includes SpaceFM, Firefox, network scripts, `gparted`, `partclone`, and basic recovery utilities.
- **Arka Linux GUI (ALG)** – Debian-style Calamares installer bundled, but live KDE/GNOME/Xfce desktops stay in “try” mode until invoked. Ships with SSH, GParted, Timeshift, and driver helpers.
- **Artix Linux** – Weekly Arch-compatible live images with alternative init systems (OpenRC, runit, s6, dinit) and desktops like Xfce/LXQt. Boots to a live environment with `openssh`, `gparted`, `connman` or `NetworkManager`, and typical rescue tools while staying install-optional.

## Debian-Based Rescue Systems (Tools Included Out-of-the-Box)
- **Grml 2025.08** – Debian 13 “trixie” base, kernel 6.12, Zsh-focused CLI (optional minimal X). Bundles `ddrescue`, `partimage`, `testdisk`, `smartmontools`, `btrfs-progs`, SSH client/server (configurable via boot parameters), tmux, and remote access helpers.
- **Debian Live “Rescue” flavour** – Official Debian live build that boots to a text rescue shell with optional Calamares. Includes `openssh-client`/`server`, `sshfs`, `pssh`, VPN clients, `parted`, `fsarchiver`, `rsync`, `iftop`, and `live-tools` (e.g., `live-toram`).
- **Finnix 250 (Nov 17, 2025)** – 577 MiB Debian testing image that launches directly into a root shell with >600 curated packages: `lvm2`, `mdadm`, `nvme-cli`, `iperf3`, `netcat-traditional`, `memtest86+`, `partclone`, `btrfs-progs`, and convenience scripts like `wifi-connect`.
- **GParted Live 1.7.0-8** – Debian Sid/LXDE desktop with GParted, GSmartControl, Firefox, `fsarchiver`, `testdisk`, `ddrescue`, `ssh`, `tcpdump`, and `partclone`. Ideal when GUI partition management plus CLI networking is needed.
- **Dr.Parted Live 25.11** – Debian testing + Openbox; ships `gparted`, Apart GTK, `gsmartcontrol`, `grsync`, `clonezilla`, `nwipe`, `cryptsetup`, `nvme-cli`, `testdisk`, `rclone`, plus menu shortcuts to install Boot-Repair, Samba, FileZilla, and SSH extras.
- **Rescuezilla 2.6.1** – Ubuntu/Debian-based imaging tool with Clonezilla-compatible backup/restore GUI, file browser, Firefox, and networking (SSH/NFS/SMB). Multiple kernel bases (25.04→18.04) help with hardware quirks.
- **Rescatux 0.74 (legacy)** – Debian-based wizard-driven toolkit for repairing GRUB/UEFI entries, resetting Windows/Linux passwords, running `testdisk`, `gparted`, and `chntpw`. Still useful but hardware support is aging; keep as a niche option.

## Practical Usage Notes
- Verify ISO integrity (SHA256 + signature where provided) before flashing via `dd`, `cp`, `bcat`, Ventoy, or graphical tools (GNOME Disks, Etcher). Ventoy is convenient for multi-ISO sticks but validate each distro’s compatibility.
- Test UEFI/BIOS boot paths and Secure Boot status per target machine; some Debian derivatives include signed Shim, others require disabling Secure Boot or enrolling keys.
- Keep a short field cheat sheet covering Wi-Fi enablement, SSH server startup, disk discovery (`lsblk`, `smartctl`, `nvme-cli`), and imaging commands (`ddrescue`, `partclone`, `restic`), stored on a second device or printed.
- For wear leveling on persistent installs (if you ever enable persistence later), schedule `fstrim` and prefer `noatime` mounts. Even without persistence, avoid unnecessary write loads when working on flash media.

## Next Steps
1. Decide whether to run stock Arch, a friendlier Arch derivative, or one of the Debian-based rescue suites based on the target hardware and tooling needs.
2. Download and flash 1–2 Arch options plus at least one Debian rescue ISO to cover both base systems; label sticks clearly.
3. Boot-test on representative hardware now so you know firmware hotkeys, network quirks, and any modules you might need to preload before an outage.
