## Why
Setting up Arch Linux with UEFI + encrypted root + encrypted swap (sd-encrypt/systemd initramfs) is repetitive and error-prone across machines (partitioning, cryptsetup, mkinitcpio hooks, GRUB kernel cmdline).

## What Changes
- Add a small "serve" helper in `bin/live-usb/` that serves two install scripts over HTTP (similar to `termux/serve`).
- Add an early-boot (pre-chroot) setup script that guides partitioning + luksFormat/open + formatting + mounting + pacstrap + fstab generation.
- Add an in-chroot setup script that guides mkinitcpio + vconsole keymap + GRUB configuration for `sd-encrypt` with encrypted swap (and optional resume).

## Non-Goals
- Supporting BIOS/legacy installs (UEFI only).
- Supporting exotic storage stacks (RAID/LVM/btrfs subvolumes) in v1.
- Automatic Wi‑Fi provisioning (the serve script prints manual steps).

## Impact
- New scripts under `bin/live-usb/` for Arch install automation/guidance.
