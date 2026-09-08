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
      description = "gideon";
      shell = pkgs.fish;
    } // (if pkgs.stdenv.hostPlatform.isLinux then {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "power"
      ];
    } else {
      home = "/Users/gideon";
    });
  };
}
