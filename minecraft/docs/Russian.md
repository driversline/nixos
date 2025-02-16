# Необходимые пакеты

```bash
pkgs.libGL
pkgs.zulu17
pkgs.minecraft
```

# Поиск библиотеки

```bash
find /nix/store -name libGL.so.1
```

# Пример

```bash
[ /home ] ~> sudo find /nix/store -name libGL.so.1
/nix/store/kynlrr98p2c235b00c72b14apn7l8l4y-libglvnd-1.7.0/lib/libGL.so.1
/nix/store/a4gc0s3i5vdz3fa1f36ic7w8xcjrw325-libglvnd-1.7.0/lib/libGL.so.1
[ /home ] ~>
```

# Вставка в configuration.nix (Без libGL.so.1)

```bash
environment.variables.LD_LIBRARY_PATH = "/nix/store/kynlrr98p2c235b00c72b14apn7l8l4y-libglvnd-1.7.0/lib";
```

# Последнее, что надо сделать

```bash
sudo reboot
```

# Помощь

```bash
Вам подойдет любой путь к libGL.so.1, определенный командой `find` (Как в примере)
```
