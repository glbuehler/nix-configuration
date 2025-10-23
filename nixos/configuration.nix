{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./greet.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  programs.fish.enable = true;


  # Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    useOSProber = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.seatd.enable = true;
  services.blueman.enable = true;
  services.tlp.enable = true;
  security.pam.services.hyprlock = {};

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  console.keyMap = "de";

  users.users.gideon = {
    isNormalUser = true;
    description = "gideon";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "power" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
    gcc
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "24.11";
}
