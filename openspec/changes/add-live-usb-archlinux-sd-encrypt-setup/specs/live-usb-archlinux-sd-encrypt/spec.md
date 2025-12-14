## ADDED Requirements

### Requirement: Serve setup scripts
The system SHALL provide a local HTTP server command that prints Wi‑Fi enabling instructions and one-liners to run both setup stages from an ArchISO live environment.

#### Scenario: User runs serve command
- **WHEN** the user runs the serve command on their workstation
- **THEN** it prints the local URL(s) to the stage1 and stage2 scripts
- **AND** it prints a one-liner to run stage1 via `curl | bash -s -- <disk>`
- **AND** it prints a one-liner to run stage2 via `arch-chroot /mnt ...`

### Requirement: Stage 1 partition and install guidance
The system SHALL provide a stage1 script that takes a target disk (e.g. `/dev/sda`) and guides the user through a UEFI GPT layout with EFI + encrypted swap + encrypted root, then installs a minimal Arch base and generates fstab under `/mnt`.

#### Scenario: User installs to a target disk
- **WHEN** the user runs stage1 with a valid disk argument
- **THEN** it prompts for destructive confirmation before wiping/partitioning
- **AND** it creates and mounts EFI, swap (LUKS), and root (LUKS)
- **AND** it installs base packages and generates `/mnt/etc/fstab`
- **AND** it writes a small state file under `/mnt` to help stage2

### Requirement: Stage 2 boot configuration guidance
The system SHALL provide a stage2 script intended to be run inside `arch-chroot` that configures mkinitcpio hooks for `systemd` + `sd-encrypt` (and `sd-vconsole`) and configures GRUB to pass the required `rd.luks.*` and `resume=` kernel parameters.

#### Scenario: User configures boot after chroot
- **WHEN** the user runs stage2 inside the installed system chroot
- **THEN** it guides configuring `/etc/vconsole.conf` and mkinitcpio hooks
- **AND** it configures GRUB and generates `/boot/grub/grub.cfg`
