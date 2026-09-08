{
  config,
  pkgs,
  lib,
  ...
}:
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
      package = pkgs.ghostty-bin;
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

          "cmd+a=text:\x01"
          "cmd+b=text:\x02"
          "cmd+c=text:\x03"
          "cmd+d=text:\x04"
          "cmd+e=text:\x05"
          "cmd+f=text:\x06"
          "cmd+g=text:\x07"
          "cmd+h=text:\x08"
          "cmd+i=text:\x09"
          "cmd+j=text:\x0A"
          "cmd+k=text:\x0B"
          "cmd+l=text:\x0C"
          "cmd+m=text:\x0D"
          "cmd+n=text:\x0E"
          "cmd+o=text:\x0F"
          "cmd+p=text:\x10"
          "cmd+q=text:\x11"
          "cmd+r=text:\x12"
          "cmd+s=text:\x13"
          "cmd+u=text:\x15"
          "cmd+w=text:\x17"
          "cmd+x=text:\x18"
          "cmd+y=text:\x19"
          "cmd+z=text:\x1A"
        ];
        confirm-close-surface = false;
      };
    };
  };
}
