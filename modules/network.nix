{ config, lib, ... }:
let
  cfg = config.modules.network;
in
{

  options.modules.network = {
    enable = lib.mkEnableOption "enable networking";
    firewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable firewall - block everything by default";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}
