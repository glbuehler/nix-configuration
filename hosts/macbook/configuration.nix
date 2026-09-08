{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ../../modules/users/gideon.nix
    ../../modules/darwin
  ];

  # Networking
  networking.hostName = "darwin-macbook";

  environment.systemPackages = [
    pkgs.git
    pkgs.ghostty-bin
    pkgs.home-manager
  ];
  
  system.primaryUser = "gideon";

  modules = {
    users.gideon.enable = true;
    darwin = {
      input.enable = true;
      dock.enable = true;
    };
  };

  system.stateVersion = 6;
}
