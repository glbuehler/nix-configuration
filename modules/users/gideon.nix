{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.users.gideon;
in
{

  options.modules.users.gideon = {
    enable = lib.mkEnableOption "enable gideon user";
  };

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;
    users.users.gideon = {
      isNormalUser = true;
      description = "gideon";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
        "power"
      ];
    };
  };
}
