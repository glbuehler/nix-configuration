{ pkgs, config, lib, ... }:
let
  cfg = config.modules.tmux;
in
{

  options.modules.tmux = {
    enable = lib.mkEnableOption "enable tmux module";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      shell = "${pkgs.fish}/bin/fish";
      keyMode = "vi";
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
