#!/usr/bin/env sh

mkfs.fat -F 32 /dev/sda1 -n NIXBOOT
mkfs.ext4 /dev/sda2 -L NIXROOT
mount /dev/disk/by-label/NIXROOT /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/NIXBOOT /mnt/boot
nixos-generate-config --root /mnt
nixos-install
