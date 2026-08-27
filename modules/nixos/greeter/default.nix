{
  pkgs,
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.modules.greeter;
in
{

  options.modules.greeter = {
    enable = lib.mkEnableOption "enable greeter module";
    background = lib.mkOption {
      description = "path to background image used by greeter";
      default = /usr/share/backgrounds/regreet-bg;
    };
  };

  config =
    let
      hyprland = pkgs-unstable.hyprland;
      hyprland-config =
        pkgs.writeText "config.lua"
          # lua
          ''
            hl.on("hyprland.start", function()
            	hl.exec_cmd(
                "${pkgs.regreet}/bin/regreet;"
                .. " ${hyprland}/bin/hyprctl dispatch 'hl.dsp.exit()'"
              )
            end)
            hl.config({
            	misc = {
            		disable_hyprland_logo = true,
            		disable_splash_rendering = true,
                disable_hyprland_guiutils_check = true,
            	},
              animations = { enabled = false },
              input = {
                  kb_layout = "de",
                  repeat_delay = 250,
                  repeat_rate = 40,
              },
              ecosystem = {
                  no_update_news = true,
                  no_donation_nag = true,
              },
              cursor = {
                inactive_timeout = 0.01,
              },
            })
          '';
    in
    lib.mkIf cfg.enable {
      services.greetd = {
        enable = true;
        settings.default_session = {
          command =
            "${pkgs.dbus}/bin/dbus-run-session"
            + " ${hyprland}/bin/start-hyprland --"
            + " --config ${hyprland-config}";
          user = "greeter";
        };
      };

      programs.regreet = {
        enable = true;
        theme.name = "Adwaita-dark";
        extraCss = "";
        settings = {
          GTK = {
            cursor_theme_name = "Adwaita";
          };
          background = {
            path = toString cfg.background;
            fit = "Cover";
          };
          appearance.greeting_msg = "NixOs, btw";
          widget.clock.format = "%H:%M";
        };
      };
    };
}
