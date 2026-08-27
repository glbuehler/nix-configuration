{ pkgs, config, lib, ... }:
let
  cfg = config.modules.git;
in
{

  options.modules.git = {
    enable = lib.mkEnableOption "enable git module";
    userName = lib.mkOption {
      description = "git user name";
      type = lib.types.str;
    };
    userEmail = lib.mkOption {
      description = "git user email address";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = cfg.userName;
        user.email = cfg.userEmail;
        init.defaultBranch = "main";
        core.editor = "${pkgs.nvim-pkg}/bin/nvim";
      };
    };
  };
}
