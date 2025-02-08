{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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

# - - - - - - Locale - - - - - - #

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";

   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
     useXkbConfig = false;
   };

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

# - - - - - - Nvidia - - - - - - #

   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;

   services.xserver.config = ''
  Section "Device"
    Identifier "Device0"
    Driver "nvidia"
    Option "Coolbits" "28"
    Option "TripleBuffer" "true"
    Option "AllowIndirectGLXProtocol" "off"
    Option "AllowFlipping" "true"
    Option "ModeValidation" "NoVesaModes, NoXServerModes"
    Option "NoLogo" "true"
    Option "ConnectToAcpid" "0"
    Option "UseEdidDpi" "FALSE"
    Option "UseEdidFreqs" "FALSE"
    Option "UseEdid" "FALSE"
    Option "IgnoreEDID" "TRUE"
    Option "RegistryDwords" "PerfLevelSrc=0x2222"
    Option "PowerMizerDefault" "0"
    Option "PowerMizerDefaultAC" "0"
    Option "SyncToVBlank" "0"
    Option "LogAniso" "0"
    Option "FSAA" "0"
    Option "TextureClamping" "0"
    Option "FXAA" "0"
    Option "FSAAAppControlled" "1"
    Option "LogAnisoAppControlled" "1"
    Option "OpenGLImageSettings" "3"
    Option "FSAAAppEnhanced" "0"
    Option "ShowGraphicsVisualIndicator" "0"
    Option "XVideoSyncToDisplayID" "HDMI-0"
  EndSection
  Section "Screen"
    Identifier "Screen0"
    Device "Device0"
    Monitor "Monitor0"
    DefaultDepth 24
    SubSection "Display"
      Depth 24
      Modes "nvidia-auto-select"
    EndSubSection
  EndSection
  Section "Monitor"
    Identifier "Monitor0"
  EndSection
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

   users.users.driversline = {
     isNormalUser = true;
     home = "/home/user";
     extraGroups = [ "wheel" ];
  #  packages = with pkgs; [
  #
  #   ];
   };

   security.sudo = {
    enable = true;
   };

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
     pkgs.docker
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
     pkgs.libreoffice
     pkgs.dig
     pkgs.curl
   ];

# - - - - - - Fonts - - - - - - #

   fonts.packages = with pkgs; [
     cascadia-code
   ];

# - - - - - - Network - - - - - - #

   networking.nameservers = [ "208.67.222.222" "208.67.220.220" ];

   networking.interfaces.enp4s0.mtu = 9000;

   networking.firewall.enable = false;

   networking.wireless.enable = false;

   boot.kernel.sysctl = {
  "net.core.rmem_max" = 25165824;
  "net.core.wmem_max" = 25165824;
  "net.ipv4.tcp_rmem" = "4096 16777216 33554432";
  "net.ipv4.tcp_wmem" = "4096 16777216 33554432";
  "net.ipv4.tcp_window_scaling" = 1;
  "net.ipv4.tcp_sack" = 1;
  "net.ipv4.tcp_timestamps" = 1;
  "net.ipv4.tcp_fin_timeout" = 5;
  "net.ipv4.tcp_keepalive_time" = 600;
  "net.core.netdev_max_backlog" = 10000;
  "net.ipv4.tcp_max_syn_backlog" = 4096;
  "net.ipv4.tcp_syn_retries" = 2;
  "net.ipv4.tcp_synack_retries" = 2;
  "net.ipv4.tcp_mtu_probing" = 1;
  "net.ipv4.tcp_fastopen" = 3;
  "net.ipv4.tcp_low_latency" = 1;
  "net.ipv4.tcp_no_metrics_save" = 1;
  "net.ipv4.tcp_retries1" = 2;
  "net.ipv4.tcp_retries2" = 3;
  "net.ipv4.tcp_keepalive_intvl" = 60;
  "net.ipv4.tcp_keepalive_probes" = 5;
  "net.ipv4.tcp_abort_on_overflow" = 1;
  "net.ipv4.tcp_moderate_rcvbuf" = 1;
  "net.ipv4.tcp_rfc1337" = 1;
  "net.ipv4.tcp_tw_reuse" = 1;
  "net.ipv4.tcp_max_tw_buckets" = 2000000;
  "net.ipv4.tcp_mem" = "125000000 250000000 262144000";
  "net.ipv4.tcp_slow_start_after_idle" = 0;
  "net.ipv4.tcp_ecn" = 1;
  "net.ipv4.tcp_fack" = 1;
  "net.ipv4.tcp_dsack" = 1;
  "net.ipv4.tcp_retrans_collapse" = 1;
  "net.ipv4.tcp_early_retrans" = 1;
  "net.ipv6.conf.all.disable_ipv6" = 1;
  "net.ipv6.conf.default.disable_ipv6" = 1;
   };

# - - - - - - Service - - - - - - #

   systemd.services."*".serviceConfig.TimeoutStopSec = "1s";

# - - - - - - System - - - - - - #

   system.autoUpgrade.enable = false;

   system.autoUpgrade.allowReboot = false;

   system = {
    stateVersion = "24.11";
   };

}
