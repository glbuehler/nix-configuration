{ config, pkgs, lib, ... }:
{
  imports = [
    ../common/config.nix
    ./hardware-configuration.nix
  ];

  # Disable pcie power saving
  boot.kernelParams = [
    "pcie_aspm=off"
  ];

  # Networking
  networking.hostName = "nixos-desktop";

  # Filesystems
  fileSystems."/tmp" = {
    fsType = "tmpfs";
    options = [ "mode=1777" "size=8G" ];
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          left = "rightcontrol";
        };
      };
    };
  }; 

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };

  services.dbus.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  system.stateVersion = "24.11";
}
