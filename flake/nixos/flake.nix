{
  description = "NixOS configuration with various modules";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./sxhkd.nix
          ./nvidia.nix
          ./network.nix
          ./neovim.nix
          ./locale.nix
          ./home.nix
          ./fish.nix
          ./configuration.nix
          ./bspwm.nix
          ./alacritty.nix
        ];
      };
    };
  };
}
