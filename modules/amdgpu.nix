{ config, lib, ... }:
let
  cfg = config.modules.amdgpu;
in
{

  options.modules.amdgpu = {
    enable = lib.mkEnableOption "enable amd gpu graphics";
    amd_kernelparams = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "add kernel params amdgpu.noretry and amdgpu.gpu_recovery";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.kernelParams = [
      "amdgpu.noretry=0"
      "amdgpu.gpu_recovery=1"
    ];
  };
}
