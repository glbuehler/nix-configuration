{
  config,
  pkgs,
  inputs,
  ...
}:
{

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    package = inputs.pkgs-unstable.firefox;
  };

}
