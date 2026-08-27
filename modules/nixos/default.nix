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

  environment.systemPackages = with pkgs; [
    gcc
    git
    home-manager
    vim
  ];
}
