{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.dank-material-shell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = false;
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [ "dms run" ];
    bind = [
      "$mod, d, exec, dms ipc call spotlight toggle"
    ];
  };
}
