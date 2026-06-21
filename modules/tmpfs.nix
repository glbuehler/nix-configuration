{ config, lib, ... }:
let
  cfg = config.modules.tmpfs;
in
{

  options.modules.tmpfs = {
    enable = lib.mkEnableOption "mount /tmp on tmpfs";
    size = lib.mkOption {
      type = lib.types.int;
      default = 8;
      description = "size in GB";
    };
  };

  config = lib.mkIf cfg.enable {
    fileSystems."/tmp" = {
      fsType = "tmpfs";
      options = [
        "mode=1777"
        "size=${toString cfg.size}G"
      ];
    };
  };
}
