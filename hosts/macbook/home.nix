{
  _config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/home-manager
  ];

  services.dunst.enable = lib.mkForce false;
  fonts.fontconfig.enable = lib.mkForce false;
  programs.dank-material-shell.enable = lib.mkForce false;

  home.username = "gideon";
  home.homeDirectory = "/Users/gideon";

  home.stateVersion = "24.05";

  modules = {
    aerospace.enable = true;
    browser.enable = true;
    fish.enable = true;
    ghostty.enable = true;
    git = {
      enable = true;
      userName = "Gideon Bühler";
      userEmail = "g.buehler@fkm-group.com";
    };
    tmux.enable = true;
  };
}
