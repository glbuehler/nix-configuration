{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.bluetooth;
in
{

  options.modules.bluetooth = {
    enable = lib.mkEnableOption "enable bluetooth along with bluetui";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    environment.systemPackages = [
      pkgs.bluetui
    ];
  };
}
