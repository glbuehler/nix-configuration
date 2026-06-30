{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/users/gideon.nix
  ];

  modules = {
    boot.enable = true;
    tmpfs.enable = true;
    networking.enable = true;
    locale.enable = true;
    gaming.enable = true;
    bluetooth.enable = true;
    users.gideon.enable = true;
    hyprland.system.enable = true;
    amdgpu = {
      enable = true;
      amd_kernelparams = true;
    };
    power = {
      enable = true;
      aspm = false;
    };
  };

  # Networking
  networking.hostName = "nixos-desktop";
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          left = "rightcontrol";
        };
        "control:left" = {
          left = "left";
        };
      };
    };
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb-with-all-plugins;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
