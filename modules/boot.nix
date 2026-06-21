{ config, lib, ... }:
let
  cfg = config.modules.boot;
in
{

  options.modules.boot = {
    enable = lib.mkEnableOption "enable grub boot loader";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
      useOSProber = true;
      configurationLimit = 10;
    };
  };

}
