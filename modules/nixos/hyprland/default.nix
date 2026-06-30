{ config, lib, ... }:
let
  cfg = config.modules.hyprland.system;
in
{

  options.modules.hyprland.system = {
    enable = lib.mkEnableOption "enable hyprland window manager system-wide";
  };

  config = lib.mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    security.pam.services.hyprlock.enable = false;
  };
}
