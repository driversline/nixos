{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # This value determines the NixOS release with which your system is to be compatible.
  # You should change this only after NixOS release notes say you should.
  system.stateVersion = "24.11"; # Did you read the comment?
}
