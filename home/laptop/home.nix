{ config, pkgs, ... }:
{
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.stateVersion = "24.05";

  news.display = "silent";

  imports = [ 
    ../common/base.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [ ];

  programs.ghostty.settings.font-size = 18;

  home.file = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
