{ config, lib, ... }:
let
  cfg = config.modules.darwin.dock;
in
{

  options.modules.darwin.dock = {
    enable = lib.mkEnableOption "enable dock options";
  };

  config = lib.mkIf cfg.enable {
    system.defaults.dock = {
      autohide = true;
      autohide-delay = 0.1;
    };
  };

}
