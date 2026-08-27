{ pkgs, config, lib, pkgs-unstable, ... }:
let
  cfg = config.modules.hyprland.system;
in
{

  options.modules.hyprland.system = {
    enable = lib.mkEnableOption "enable hyprland window manager system-wide";
    useUnstable = lib.mkOption {
      description = "use nixpkgs-unstable hyprland package";
      default = true;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = if cfg.useUnstable then pkgs-unstable.hyprland else pkgs.hyprland;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    security.pam.services.hyprlock.enable = false;
  };
}
