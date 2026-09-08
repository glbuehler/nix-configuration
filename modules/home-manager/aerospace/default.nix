{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  cfg = config.modules.aerospace;
in
{

  options.modules.aerospace = {
    enable = lib.mkEnableOption "enable aerospace window manager";
  };

  config = lib.mkIf cfg.enable {
    programs.aerospace = {
      enable = true;
      package = pkgs-unstable.aerospace;

      launchd.enable = true;

      settings = {
        enable-normalization-flatten-containers = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;

        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";
        accordion-padding = 0;

        key-mapping.preset = "qwerty";

        gaps = {
          inner = {
            horizontal = 6;
            vertical = 6;
          };

          outer = {
            left = 8;
            right = 8;
            top = 8;
            bottom = 8;
          };
        };

        mode.main.binding = {
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";
          alt-0 = "workspace 10";

          alt-shift-1 = "move-node-to-workspace 1 --focus-follows-window";
          alt-shift-2 = "move-node-to-workspace 2 --focus-follows-window";
          alt-shift-3 = "move-node-to-workspace 3 --focus-follows-window";
          alt-shift-4 = "move-node-to-workspace 4 --focus-follows-window";
          alt-shift-5 = "move-node-to-workspace 5 --focus-follows-window";
          alt-shift-6 = "move-node-to-workspace 6 --focus-follows-window";
          alt-shift-7 = "move-node-to-workspace 7 --focus-follows-window";
          alt-shift-8 = "move-node-to-workspace 8 --focus-follows-window";
          alt-shift-9 = "move-node-to-workspace 9 --focus-follows-window";
          alt-shift-0 = "move-node-to-workspace 10 --focus-follows-window";

          alt-enter = "exec-and-forget ${pkgs.ghostty-bin}";
          alt-d = "exec-and-forget open -a Raycast";

          alt-q = "close";
          alt-shift-q = "close --quit-if-last-window";

          alt-f = "layout floating tiling";
          alt-shift-f = "fullscreen";

          alt-s = "exec-and-forget screencapture -w -c";
          alt-shift-s = "exec-and-forget screencapture -w ~/Pictures/screenshot.png";
          ctrl-alt-s = "exec-and-forget screencapture -i -c";
          ctrl-alt-shift-s = "exec-and-forget screencapture -i ~/Pictures/screenshot.png";

          alt-r = "mode resize";
        };

        mode.resize.binding = {
          h = "resize width -50";
          j = "resize height +50";
          k = "resize height -50";
          l = "resize width +50";
          enter = "mode main";
          esc = "mode main";
        };

        on-window-detected = [
          {
            "if".app-name-regex-substring = "Firefox";
            run = "move-node-to-workspace 2";
          }
          {
            "if".app-name-regex-substring = "Discord";
            run = "move-node-to-workspace 10";
          }
        ];
      };
    };
  };
}
