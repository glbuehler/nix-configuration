{ config, lib, ... }:
let
  cfg = config.modules.browser;
in
{

  options.modules.browser = {
    enable = lib.mkEnableOption "enable browser module";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      languagePacks = [
        "en-US"
        "de"
      ];
    };
  };
}
