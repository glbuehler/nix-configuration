{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.modules.hyprland.home;
  simpleNixToLua =
    val:
    if builtins.typeOf val == "lambda" then
      throw "cannot convert lambda to lua"
    else if builtins.typeOf val == "list" then
      (builtins.foldl' (acc: elem: acc + "${simpleNixToLua elem}, ") "{" val) + "}"
    else if builtins.typeOf val == "set" then
      (lib.foldlAttrs (
        acc: name: value:
        acc + "${name} = ${simpleNixToLua value}, "
      ) "{" val)
      + "}"
    else if builtins.typeOf val == "null" then
      "nil"
    else if builtins.typeOf val == "string" then
      ''"${val}"''
    else
      toString val;
in
{

  options.modules.hyprland.home = {
    enable = lib.mkEnableOption "hyprland home module";
    powerProfile = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = ''
        Power profile for hypridle
        can be one of
          "default"
          "save"
          "off"
      '';
    };
    modKey = lib.mkOption {
      type = lib.types.str;
      default = "SUPER";
      description = "hyprland modifier key";
    };
    autoStart = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = ''
        Programs to autostart in specified workspace
        Example:
          {
            "ws1" = [ "$${pkgs.ghostty}/bin/ghostty" ];
            "ws3" = [ "$${pkgs.discord}/bin/discord" "$${pkgs.firefox}/bin/firefox" ];
          }
      '';
    };
  };

  config =
    let
      luaVars = {
        mod = cfg.modKey;
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        hyprshot = "${pkgs.hyprshot}/bin/hyprshot";

        autoStart = cfg.autoStart;
        # host_config_path = "";
      };
    in
    lib.mkIf cfg.enable {

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
          luaVarsStr = simpleNixToLua luaVars;
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

      home.packages = [
        pkgs.hyprshot
      ];

      services.hypridle.enable = cfg.powerProfile != "off";
      services.hypridle.settings = {
        general = {
          lock_cmd = "dms lock lock";
          before_sleep_cmd = "dms lock lock";
        };
      };
      services.hypridle.settings.listener =
        let
          brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          profiles = {
            default = [
              {
                timeout = 590;
                on-timeout = "${brightnessctl} -s set 10";
                on-resume = "${brightnessctl} -r";
              }
              {
                timeout = 600;
                on-timeout = "hyprlock";
              }
              {
                timeout = 1800;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on && ${brightnessctl} -r";
              }
            ];
            save = [
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
            off = [ ];
          };
        in
        if builtins.hasAttr cfg.powerProfile profiles then
          profiles.${cfg.powerProfile}
        else
          profiles.default;

    };
}
