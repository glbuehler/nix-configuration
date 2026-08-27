{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.fish;
in
{

  options.modules.fish = {
    enable = lib.mkEnableOption "enable fish shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellInit = builtins.readFile ./config.fish;
    };
  };
}
