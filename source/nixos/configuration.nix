{ config, lib, pkgs, ... }:

{

#  disabledModules = [
#    "/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/programs/regreet.nix"
#  ];

  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./nvidia.nix
      ./locale.nix
    ];

  programs.dconf.enable = false;

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

# - - - - - - Boot - - - - - - #

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.consoleLogLevel = 0;
  boot.kernelModules = [ ];
  boot.supportedFilesystems = [ "vfat" "ext4" ];
  boot.blacklistedKernelModules = [ ];

# - - - - - - Systemd - - - - - -#

  systemd = {
  extraConfig = ''
    [Manager]
    LogLevel=emerg
    LogTarget=null
  '';

  services = {
    "default" = {
      wantedBy = ["multi-user.target"];
    };

  swap = {
    enable = false;
  };

    "*".serviceConfig.TimeoutStopSec = "1s";

    systemd-timesyncd.enable = false;
    "time-sync.target".enable = false;
    "time-set.target".enable = false;
    systemd-oomd.enable = false;
    "default.service".enable = false;
    "sleep.target".enable = false;
    "hybrid-sleep.target".enable = false;
    "systemd-hybrid-sleep.service".enable = false;
    "pre-sleep.service".enable = false;
    journald.enable = true;
    acpid.enable = false;

    };
  };

  services.journald.extraConfig = ''
    [Journal]
    Storage=none
    ForwardToSyslog=no
    ForwardToKMsg=no
    ForwardToConsole=no
    ForwardToWall=no
    MaxRetentionSec=1s
    MaxFileSec=1s
    RateLimitInterval=0
    RateLimitBurst=0
    SystemMaxUse=0
    RuntimeMaxUse=0
    SystemKeepFree=0
    RuntimeKeepFree=0
    SystemMaxFileSize=0
    RuntimeMaxFileSize=0
    SystemMaxFiles=0
    RuntimeMaxFiles=0
  '';

# - - - - - - Swap - - - - - - #

  swapDevices = [ ];

# - - - - - - Cache - - - - - - #

  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

# - - - - - - Build - - - - - - #

  boot.loader.systemd-boot.configurationLimit = 5;

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

# virtualisation.docker.enable = true;

# - - - - - - Shell - - - - - - #

   users.defaultUserShell = pkgs.fish;
   programs.fish.enable = true;

# - - - - - - Disable - - - - - - #

   programs.command-not-found.enable = false;

# - - - - - - Config - - - - - - #

   nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
   };

# - - - - - - Users - - - - - - #

   users.users.user = {
     isNormalUser = true;
     home = "/home/user";
     extraGroups = [ "wheel" ];
   };

   security.sudo = {
    enable = true;
    configFile = ''
      Defaults !authenticate
    '';
   };

# - - - - - - Theme - - - - - - #

   qt.enable = true;

# - - - - - - Package - - - - - - #

   environment.systemPackages = with pkgs; [
     neovim
     alacritty
     kitty
     bspwm
     git
     sxhkd
     feh
     neofetch
     firefox
     home-manager
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
     pkgs.zulu23
     pkgs.gcc
 #   pkgs.libreoffice
     pkgs.dig
     pkgs.curl
     pkgs.evtest
     pkgs.gnumake
     pkgs.cmake
 #   pkgs.libsForQt5.qt5.qtbase
 #   pkgs.libsForQt5.qt5.qtwebengine
     pkgs.vimPlugins.vim-plug
     pkgs.nginx
     pkgs.spotify
   ];

# - - - - - - Fonts - - - - - - #

   fonts.packages = with pkgs; [
     cascadia-code
   ];

# - - - - - - Service - - - - - - #

   services = {
     xserver.displayManager.lightdm.enable = false;
     displayManager.ly.enable = true;
     xserver.enable = true;
     xserver.windowManager.bspwm.enable = true;
     displayManager.defaultSession = "none+bspwm";
     pipewire.enable = true;
     pipewire.wireplumber.enable = true;
     logrotate.enable = false;

     xserver.displayManager.sessionCommands = ''
       feh --bg-scale $HOME/bspwm/wallpapers/*.png &
       xrandr --output HDMI-0 --mode 1920x1080 --rate 144
     '';

     logind.extraConfig = ''
       HandleLidSwitch=ignore
       HandleSuspendKey=ignore
       HandleHibernateKey=ignore
       HandlePowerKey=ignore
       HandleLidSwitchExternalPower=ignore
       HandleLidSwitchDocked=ignore
     '';
   };

# - - - - - - System - - - - - - #

   system = {
    autoUpgrade.enable = false;
    autoUpgrade.allowReboot = false;
    stateVersion = "24.11";
   };

}
