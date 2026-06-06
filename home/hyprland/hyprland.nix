{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.hyprland.host = lib.mkOption {
    type = lib.types.str;
  };
  config =
    let
      host = config.hyprland.host;
      luaVars = {
        mod = "SUPER";
        terminal = "${pkgs.ghostty}/bin/ghostty";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        browser = "${pkgs.brave}/bin/brave";
        hyprshot = "${pkgs.hyprshot}/bin/hyprshot";
        host_config_path = host;
      }
      // (
        if host == "desktop" then
          {
            discord = "${pkgs.discord}/bin/discord";
          }
        else
          { }
      );
    in
    {

      home.packages = with pkgs; [
        hyprshot
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        configType = "lua";
        extraConfig = ''require("init")'';
        # make hyprland use the system-wide package defined in configuration.nix
        package = null;
        portalPackage = null;
      };

      xdg.configFile =
        let
          allPaths = lib.filesystem.listFilesRecursive ./.;
          paths = builtins.filter (lib.hasSuffix ".lua") allPaths;
          file = path: lib.path.removePrefix ./. path;
          luaVarsStr = lib.foldlAttrs (
            acc: name: value:
            acc + ''${name} = "${value}",'' + "\n"
          ) "" luaVars;
        in
        builtins.listToAttrs (
          (builtins.map (p: {
            name = "hypr/${file p}";
            value = {
              text = builtins.readFile p;
            };
          }) paths)
          ++ [
            {
              name = "hypr/generated/variables.lua";
              value = {
                text = ''
                  return {
                    ${luaVarsStr}
                  }
                '';
              };
            }
          ]
        );

      services.hypridle.enable = true;
      services.hypridle.settings = {
        general = {
          lock_cmd = "dms lock lock";
          before_sleep_cmd = "dms lock lock";
        };
      };

      services.hypridle.settings.listener =
        {
          desktop = [
            {
              timeout = 590;
              on-timeout = "brightnessctl -s set 10";
              on-resume = "brightnessctl -r";
            }
            {
              timeout = 600;
              on-timeout = "hyprlock";
            }
            {
              timeout = 1800;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
            }
          ];
          laptop =
            let
              brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
            in
            [
              {
                timeout = 180;
                on-timeout = "dms ipc lock lock";
              }
              # on ac power
              {
                timeout = 300;
                on-timeout = "systemd-ac-power && ${brightnessctl} -s set 10";
                on-resume = "${brightnessctl} -r";
              }
              # on battery
              {
                timeout = 120;
                on-timeout = "systemd-ac-power || ${brightnessctl} -s set 10";
                on-resume = "${brightnessctl} -r";
              }
              {
                timeout = 240;
                on-timeout = "systemd-ac-power || hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on && ${brightnessctl} -r";
              }
              {
                timeout = 1800;
                on-timeout = "systemd-ac-power || systemctl suspend";
              }
            ];
        }
        .${host};
    };
}
