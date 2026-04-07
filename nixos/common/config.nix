{ config, pkgs, lib, ... }:
{
  imports = [
    ./greet.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  boot.kernelParams = [
    "amdgpu.noretry=0"
    "amdgpu.gpu_recovery=1"
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    useOSProber = true;
  };

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # Time/Locale
  console.keyMap = "de";
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
  security.pam.services.hyprlock = {};
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
  };

  programs.fish.enable = true;
  users.users.gideon = {
    isNormalUser = true;
    description = "gideon";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "power" ];
  };

  environment.systemPackages = with pkgs; [
    home-manager
    gcc
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  system.stateVersion = "24.11";
}
