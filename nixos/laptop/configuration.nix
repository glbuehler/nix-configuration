{ config, pkgs, lib, ... }:
{
  imports = [
    ../common/config.nix
    ./hardware-configuration.nix
  ];

  # Networking
  networking.hostName = "nixos-laptop";
  networking.firewall.allowedTCPPorts = [ 8080 5432 ];
  networking.firewall.allowedUDPPorts = [ 8080 5432 ];

  # Power management daemon
  services.tlp.enable = true;

  # Filesystems
  fileSystems."/tmp" = {
    fsType = "tmpfs";
    options = [ "mode=1777" "size=8G" ];
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  system.stateVersion = "24.11";
}
