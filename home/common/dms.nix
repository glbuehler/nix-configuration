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
}
