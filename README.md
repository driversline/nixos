# Install

## Disk part
```bash
cfdisk
```
-- 128MB / 256MB for boot Type - EFI System
-- The remainder for the file system Type - Linux filesystem
-- Swap is optional Type - Linux swap

### You can change NIXROOT and NIXBOOT value

## File system
```bash
sudo mkfs.fat -F 32 /dev/sda1
sudo fatlabel /dev/sda1 NIXBOOT
sudo mkfs.ext4 /dev/sda2 -L NIXROOT
```

## Mount
```bash
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

## Swap guide [from here](https://nixos.wiki/wiki/NixOS_Installation_Guide)
```bash
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152 # 2GB size
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swapon /mnt/.swapfile
```

## Config
```bash
nixos-generate-config --root /mnt
```

## Nix
```bash
nixos-install
```

## Help command
```bash
sudo su
```
```bash
lsblk
```
```bash
passwd user
```
