# Установка

## Разделение диска - Шаг 1

```sh
cfdisk
```

> 128MB / 256MB для загрузки Type - EFI System

> Остальное пространство Type - Linux filesystem

> Свап опционально Type - Linux swap

## Файловая система - Шаг 2

```sh
sudo mkfs.fat -F 32 /dev/sda1
sudo fatlabel /dev/sda1 NIXBOOT
sudo mkfs.ext4 /dev/sda2 -L NIXROOT
```

## Монтирование - Шаг 3

```sh
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
```

## Гайд на свап [здесь](https://nixos.wiki/wiki/NixOS_Installation_Guide) - Шаг ?

```sh
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=2097152 # 2GB size
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swapon /mnt/.swapfile
```

## Генерация файла конфигурации - Шаг 4

```sh
nixos-generate-config --root /mnt
```

## Установка - Шаг 5

```sh
nixos-install
```

## Рекомендация для первого билда

```sh
nixos-rebuild --upgrade switch
```

## Вспомогательные команды

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
