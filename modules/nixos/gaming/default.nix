{ config, lib, ... }:
let
  cfg = config.modules.gaming;
in
{

  options.modules.gaming = {
    enable = lib.mkEnableOption "enable various settings/programs for gaming";
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
      ];
  };
}
