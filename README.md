# Install

## Disk part - Step 1
```bash
cfdisk
```
> 128MB / 256MB for boot Type - EFI System

> The remainder disk space Type - Linux filesystem

> Swap is optional Type - Linux swap

### You can change NIXROOT and NIXBOOT value

## File system - Step 2
```bash
sudo mkfs.fat -F 32 /dev/sda1
sudo fatlabel /dev/sda1 NIXBOOT
sudo mkfs.ext4 /dev/sda2 -L NIXROOT
```

## Mount - Step 3
```bash
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

## Swap guide [from here](https://nixos.wiki/wiki/NixOS_Installation_Guide) - Step ?
```bash
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152 # 2GB size
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swapon /mnt/.swapfile
```

## Config - Step 4
```bash
nixos-generate-config --root /mnt
```

## Nix - Step 5
```bash
nixos-install
```

## Recommendation with first build
```bash
nixos-rebuild --upgrade switch
```

## Help command
```bash
sudo su
```
```bash
lsblk
```
```bash
passwd
```
```bash
umount
```
