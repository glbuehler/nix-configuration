{ config, pkgs, ... }:
{
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.stateVersion = "24.05";

  imports = [ 
    ../common/base.nix
    ../common/hyprland.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [ ];
  home.file = { };

  programs.ghostty.settings.font-size = 16;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
