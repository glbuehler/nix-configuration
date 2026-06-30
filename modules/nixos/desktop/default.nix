{ config, lib, ... }:
let
  cfg = config.modules.desktop;
in
{

  options.modules.desktop = {
    enable = lib.mkEnableOption "enable desktop services";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    services.seatd.enable = true;
    services.dbus.enable = true;
  };
}
