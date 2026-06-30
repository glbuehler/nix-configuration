{ config, lib, ... }:
let
  cfg = config.modules.networking;
in
{

  options.modules.networking = {
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
