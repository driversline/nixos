# Package

```bash
pkgs.libGL
pkgs.zulu17
pkgs.minecraft
```

# Find library

```bash
find /nix/store -name libGL.so.1
```

# Example

```bash
[ /home ] ~> sudo find /nix/store -name libGL.so.1
/nix/store/kynlrr98p2c235b00c72b14apn7l8l4y-libglvnd-1.7.0/lib/libGL.so.1
/nix/store/a4gc0s3i5vdz3fa1f36ic7w8xcjrw325-libglvnd-1.7.0/lib/libGL.so.1
[ /home ] ~>
```

# Paste in configuration.nix (Without libGL.so.1)

```bash
environment.variables.LD_LIBRARY_PATH = "/nix/store/kynlrr98p2c235b00c72b14apn7l8l4y-libglvnd-1.7.0/lib";
```

# Help

```bash
Your can paste your path to libGL.so.1, all paths found by the command find (In Example) will work
```
