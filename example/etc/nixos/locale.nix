{ config, lib, pkgs, ... }:

{
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = false;
  };
}
