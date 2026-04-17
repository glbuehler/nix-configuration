{ config, pkgs, lib, ... }:
{
  imports = [
    ../common/config.nix
    ./hardware-configuration.nix
  ];

  # Networking
  networking.hostName = "nixos-laptop";

  # Power management daemon
  services.tlp.enable = true;
  services.upower.enable = true;

  # Filesystems
  fileSystems."/tmp" = {
    fsType = "tmpfs";
    options = [ "mode=1777" "size=8G" ];
  };

  system.stateVersion = "24.11";
}
