{ config, lib, ... }:
let
  cfg = config.modules.ghostty;
in
{

  options.modules.ghostty = {
    enable = lib.mkEnableOption "enable ghostty module";
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = config.modules.fish.enable;
      settings = {
        mouse-hide-while-typing = true;
        background = "#1a1b26";
        window-decoration = "none";
        app-notifications = "no-clipboard-copy";
        theme = "TokyoNight";
        keybind = [
          "clear"
          "ctrl+shift+c=copy_to_clipboard"
          "ctrl+shift+v=paste_from_clipboard"
          "ctrl+plus=increase_font_size:2"
          "ctrl+slash=decrease_font_size:2" # is slash on US layout, works for minus on DE
        ];
        confirm-close-surface = false;
      };
    };
  };
}
