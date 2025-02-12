# Offical manual - [Wiki](https://nixos.wiki/wiki/Cursor_Themes)

# Example - [Here](https://github.com/driversline/nixos/blob/main/example/home-manager/home.nix)

# Command

```bash
nix-prefetch-url "Ссылка"
```

```bash
[ /home ] ~> nix-prefetch-url "https://github.com/driversline/bspwm/blob/main/dotfiles/cursors/Nordzy-cursors-white.tar.gz?raw=true"
path is '/nix/store/4syqlxpa5p6192gx2q9zimwvqx07pcwy-Nordzy-cursors-white.tar.gz?raw=true'
1i2ypkfaid5fh5dk3m2q2r0qc6az9a6l9psyin6n9djyymciknb2
[ /home ] ~>
```

```bash
Here 1i2ypkfaid5fh5dk3m2q2r0qc6az9a6l9psyin6n9djyymciknb2 - calculated hash
```

# Structure

```bash
{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";
  home.username = "Ваш-Юзер";
  home.homeDirectory = "/home/Ваш-Юзер";

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
        "https://-Ссылка-К-Курсору"
        "Хеш-Полученный-Через-nix-prefetch-url"
        "Название-Вашего-Курсора";

  home.sessionVariables = {
   XCURSOR_THEME = "Название-Вашего-Курсора";
  };

}
```

# Cursor Size

```bash
size = X
```


