{ config, lib, pkgs, ... }:

{
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
}
