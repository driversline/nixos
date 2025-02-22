{ pkgs, ... }:

{
  home.sessionVariables = {
    LD_LIBRARY_PATH = "/nix/store/kynlrr98p2c235b00c72b14apn7l8l4y-libglvnd-1.7.0/lib";
  };

  home.packages = with pkgs; [
    minecraft
    libGL
    zulu17
  ];
}
