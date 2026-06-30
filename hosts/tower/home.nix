{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/home-manager
  ];

  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  news.display = "silent";
  home.stateVersion = "24.05";

  modules = {
    hyprland.home = {
      enable = true;
      autoStart = {
        "ws1" = [ "${pkgs.ghostty}/bin/ghostty" ];
        "ws2" = [ "${pkgs.firefox}/bin/firefox" ];
      };
    };
  };
}
