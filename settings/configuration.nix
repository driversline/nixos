{ config, lib, pkgs, ... }:

{

nix.settings = {
  auto-optimise-store = true;
  max-jobs = "auto";
  cores = 0;
  experimental-features = ["nix-command" "flakes"];
  substituters = ["https://cache.nixos.org/"];
  trusted-public-keys = [ ]; # ВАШ-КЛЮЧ|YOUR-KEY
};

}
