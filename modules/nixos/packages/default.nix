{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.packages;
in
{

  options.modules.packages = {
    enable = lib.mkEnableOption "enable standard packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      home-manager
      gcc
      vim
      git
    ];
  };
}
