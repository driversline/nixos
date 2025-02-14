{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";
  home.username = "user";
  home.homeDirectory = "/home/user";

  imports = [
    ./sxhkd.nix
    ./alacritty.nix
    ./neovim.nix
    ./fish.nix
  ];
  
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
                sha256 = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom
        "https://github.com/driversline/cursors/blob/main/list/Nordzy-cursors-white.tar.gz?raw=true"
        "7yY1yDUzNg+SJynv7WFdAYApOFGFc7T3DT1C/auGORQ="
        "Nordzy-cursors-white";

  home.sessionVariables = {
    XCURSOR_THEME = "Nordzy-cursors-white";
  };
