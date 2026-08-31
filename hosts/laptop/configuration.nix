{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/users/gideon.nix
  ];

  modules = {
    amdgpu = {
      enable = true;
      amd_kernelparams = true;
    };
    bluetooth.enable = true;
    boot.enable = true;
    greeter = {
      enable = true;
      background = ../../pictures/power-line-1920x1080-simple-nighttime-landscape-26998.jpg;
    };
    hyprland.system.enable = true;
    locale.enable = true;
    networking.enable = true;
    power = {
      enable = true;
      tlp = true;
      aspm = true;
    };
    tmpfs.enable = true;
    users.gideon.enable = true;
  };

  # Networking
  networking.hostName = "nixos-laptop";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
