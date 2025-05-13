# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix  # Include the results of the hardware scan.
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Home Manager
  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  # home-manager.users.gideon = import /home/gideon/.config/home-manager/home.nix;

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
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.lib.getExe config.programs.hyprland.package} --config ${builtins.readFile ./greetd/hyprland.conf}";
        user = "greeter";
      };
    };
  };

  security.pam.services.hyprlock = {};

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  console.keyMap = "de";

  users.users.gideon = {
    isNormalUser = true;
    description = "gideon";
    extraGroups = [ "wheel" "networkmanager" "power" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
    gcc
    vim
  ];

  programs.regreet = {
    enable = true;
    theme.name = "Adwaita-dark";
    settings = {
      GTK = {
        cursor_theme_name = "Adwaita";
      };
      background = {
        path = "/usr/share/backgrounds/regreet-bg.jpeg";
        fit = "Cover";
      };
      appearance.greeting_msg = "NixOs, btw";
      "widget.clock".format = "%H:%M";
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  system.stateVersion = "24.11"; # Did you read the comment?
}
