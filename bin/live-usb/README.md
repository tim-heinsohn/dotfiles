# Live USB helpers

## Arch Linux: UEFI + sd-encrypt (root + swap)

This setup is split into two stages and intended to be run from ArchISO.

1) On your workstation: serve the scripts via HTTP

```bash
bin/live-usb/serve-archlinux-sd-encrypt-setup
```

2) On the ArchISO live system: run stage1 (partition + encrypt + pacstrap)

```bash
curl http://<HOST>:8000/arch1 | bash -s -- /dev/sdX
```

3) On the ArchISO live system: run stage2 inside the target system chroot

```bash
curl http://<HOST>:8000/arch2 | arch-chroot /mnt bash -s --
```

4) After first boot into the installed system: provision dotfiles

```bash
curl http://<HOST>:8000/setup-system | bash -s --
```
