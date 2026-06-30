{ config, lib, ... }:
let
  cfg = config.modules.power;
in
{
  options.modules.power = {
    enable = lib.mkEnableOption "power management";
    tlp = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable tlp daemon";
    };
    aspm = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "turn pcie aspm power saving on/off";
    };
  };

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
    services.tlp.enable = cfg.tlp;

    boot.kernelParams = [
      ("pcie_aspm=" + (if cfg.aspm then "on" else "off"))
    ];
  };
}
