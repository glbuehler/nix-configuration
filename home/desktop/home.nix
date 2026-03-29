{ config, pkgs, ... }:
{
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.stateVersion = "24.05";

  news.display = "silent";

  imports = [ 
    ../common/base.nix
    ../common/hyprland.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    prismlauncher
  ];

  programs.ghostty.settings.font-size = 16;

  home.file = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
