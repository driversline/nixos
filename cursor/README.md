# Offical manual - [Wiki](https://nixos.wiki/wiki/Cursor_Themes)

# Structure

```bash
{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.pointerCursor =
    let
      getFrom = url: hash: name: {
          gtk.enable = false;
          x11.enable = true;
          name = name;
          size = 18;
          package =
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                sha256 = "Хеш-Полученный-Через-nix-prefetch-url";
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom
        "https://github.com/driversline/bspwm/blob/main/dotfiles/cursors/Nordzy-cursors-white.tar.gz?raw=true"
        "Хеш-Полученный-Через-nix-prefetch-url"
        "Название-Вашей-Темы";

  home.sessionVariables = {
   XCURSOR_THEME = "Название-Вашей-Темы";
  };

}
```

# Cursor Size

```bash
size = X
```

# Example - [Here](https://github.com/driversline/nixos/blob/main/example/home-manager/home.nix) - Or

```bash
[ /home ] ~> nix-prefetch-url "https://github.com/driversline/bspwm/blob/main/dotfiles/cursors/Nordzy-cursors-white.tar.gz?raw=true"
path is '/nix/store/4syqlxpa5p6192gx2q9zimwvqx07pcwy-Nordzy-cursors-white.tar.gz?raw=true'
1i2ypkfaid5fh5dk3m2q2r0qc6az9a6l9psyin6n9djyymciknb2
[ /home ] ~>
```


