services.xserver.videoDrivers = [ "nvidia" ];

hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;

nixpkgs.config = {
  allowUnfree = true;
};
