# Installation

## Disk Partitioning - Step 1

```sh
cfdisk
```

> 128MB / 256MB for system boot Type - EFI System

> The remaining space Type - Linux filesystem

> Swap is optional Type - Linux swap

## Filesystem - Step 2

```sh
sudo mkfs.fat -F 32 /dev/sda1
sudo fatlabel /dev/sda1 NIXBOOT
sudo mkfs.ext4 /dev/sda2 -L NIXROOT
```

## Mounting - Step 3

```sh
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

## Swap Guide [here](https://nixos.wiki/wiki/NixOS_Installation_Guide) - Step ?

```sh
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152 # 2GB size
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swapon /mnt/.swapfile
```

## Configuration File Generation - Step 4

```sh
nixos-generate-config --root /mnt
```

## Installation - Step 5

```sh
nixos-install
```

## Recommendation for the First Build

```sh
nixos-rebuild --upgrade switch
```

## Auxiliary Commands

```sh
sudo su
```

```sh
lsblk
```

```sh
passwd
```

```sh
umount
```
