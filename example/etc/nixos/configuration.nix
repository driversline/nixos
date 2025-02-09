{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./nvidia.nix
      ./locale.nix
    ];

# - - - - - - Boot - - - - - - #

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.displayManager.ly.enable = true;
  boot.consoleLogLevel = 0;
  systemd.extraConfig = ''
    [Manager]
    LogLevel=emerg
    LogTarget=null
  '';

  systemd.services = {
   "default" = {
    wantedBy = ["multi-user.target"];
   };
  };

  boot.kernelModules = [ ];

  boot.supportedFilesystems = [ "vfat" "ext4" ];

  boot.blacklistedKernelModules = [ ];

# - - - - - - Journald - - - - - -#

  services.journald = {
   extraConfig = ''
    Storage=none
   '';
  };

# - - - - - - Swap - - - - - - #

  swapDevices = [];

  systemd.services.swap = {
    enable = false;
  };

# - - - - - - Cache - - - - - - #

  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

# - - - - - - Build - - - - - - #

  boot.loader.systemd-boot.configurationLimit = 1;

# - - - - - - Kernel - - - - - - #

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelParams = [
    "quiet"
    "loglevel=0"
    "udev.log_priority=0"
    "iommu=soft"
    "rcu_nocbs=0-11"
    "noht"
    "nmi_watchdog=0"
    "audit=0"
    "mitigations=off"
  ];

# - - - - - - Time - - - - - - #

  time.timeZone = "Europe/Moscow";

# - - - - - - Docker - - - - - - #

#   virtualisation.docker.enable = true;

# - - - - - - Shell - - - - - - #

   users.defaultUserShell = pkgs.fish;
   programs.fish.enable = true;

# - - - - - - Disable - - - - - - #

   programs.command-not-found.enable = false;

# - - - - - - x11 / bspwm - - - - - - #

   services.xserver.enable = true;
   services.xserver.windowManager.bspwm.enable = true;
   services.displayManager.defaultSession = "none+bspwm";

   services.xserver.displayManager.sessionCommands = ''

   feh --bg-scale $HOME/bspwm/wallpapers/*.png &
   xrandr --output HDMI-0 --mode 1920x1080 --rate 144

   '';

# - - - - - - Config - - - - - - #

   nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
   };

# - - - - - - Sound - - - - - - #

  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

# - - - - - - Users - - - - - - #

   users.users.user = {
     isNormalUser = true;
     home = "/home/user";
     extraGroups = [ "wheel" ];
  #  packages = with pkgs; [
  #
  #   ];
   };

   security.sudo.enable = true;

   security.sudo.configFile = ''
    Defaults !authenticate
  '';

# - - - - - - GTK - - - - - - #

  qt.enable = false;

# - - - - - - Package - - - - - - #

   environment.systemPackages = with pkgs; [
     neovim
     alacritty
     bspwm
     git
     sxhkd
     feh
     neofetch
     firefox
     home-manager
     gtk2
     gtk3
     flameshot
     xorg.xrandr
     xorg.xsetroot
 #   pkgs.docker
     pkgs.lsof
     pkgs.fish
     pkgs.cava
     pkgs.pulseaudio
     pkgs.microcode-intel
     pkgs.xorg.xhost
     pkgs.ly
     pkgs.fzf
     pkgs.nodejs_23
     pkgs.gcc
 #   pkgs.libreoffice
     pkgs.dig
     pkgs.curl
   ];

# - - - - - - Fonts - - - - - - #

   fonts.packages = with pkgs; [
     cascadia-code
   ];

# - - - - - - Service - - - - - - #

   systemd.services."*".serviceConfig.TimeoutStopSec = "1s";

# - - - - - - System - - - - - - #

   system.autoUpgrade.enable = false;

   system.autoUpgrade.allowReboot = false;

   system = {
    stateVersion = "24.11";
   };

}
