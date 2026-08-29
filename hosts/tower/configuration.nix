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
    amdgpu = {
      enable = true;
      amd_kernelparams = true;
    };
    bluetooth.enable = true;
    boot.enable = true;
    gaming.enable = true;
    greeter = {
      enable = true;
      background = ../../pictures/japan-artistic-1680x1050.jpg;
    };
    hyprland.system.enable = true;
    locale.enable = true;
    networking.enable = true;
    power = {
      enable = true;
      aspm = false;
    };
    tmpfs.enable = true;
    users.gideon.enable = true;
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
