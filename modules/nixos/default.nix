{ pkgs, ... }:
{
  imports = [
    ./amdgpu
    ./bluetooth
    ./boot
    ./desktop
    ./desktop
    ./gaming
    ./greeter
    ./hyprland
    ./locale
    ./networking
    ./power
    ./tmpfs
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];


  environment.systemPackages = with pkgs; [
    gcc
    git
    home-manager
    vim
  ];
}
