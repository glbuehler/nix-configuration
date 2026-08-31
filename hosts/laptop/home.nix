{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/home-manager
  ];

  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.stateVersion = "24.05";

  modules = {
    browser.enable = true;
    fish.enable = true;
    ghostty.enable = true;
    git = {
      enable = true;
      userName = "Gideon Bühler";
      userEmail = "gideonbuehler18@gmail.com";
    };
    hyprland.home = {
      enable = true;
      autoStart = {
        "ws1" = [ "${pkgs.ghostty}/bin/ghostty" ];
        "ws2" = [ "${pkgs.firefox}/bin/firefox" ];
      };
      hostConfigPath = ./hyprland.lua;
    };
    theme.enable = true;
    tmux.enable = true;
  };
}
