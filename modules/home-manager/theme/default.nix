{ pkgs, config, lib, ... }:
let
  cfg = config.modules.theme;
in
{

  options.modules.theme = {
    enable = lib.mkEnableOption "enable theme";
  };

  config = lib.mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    gtk = {
      enable = true;
      theme.name = "Adwaita-dark";
      iconTheme.name = "Yaru";
      cursorTheme.name = "Adwaita";
    };
    gtk.gtk4.theme = config.gtk.theme;

    home.pointerCursor = {
      enable = true;
      x11.enable = true;
      gtk.enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;

      hyprcursor.enable = config.modules.hyprland.home.enable;
      hyprcursor.size = 16;
    };
  };
}
