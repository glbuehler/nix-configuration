{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    theme.name = "Adwaita-dark";
    extraCss = ''
    '';
    settings = {
      GTK = {
        cursor_theme_name = "Adwaita";
      };
      background = {
        path = "/usr/share/backgrounds/regreet-bg.jpeg";
        fit = "Cover";
      };
      appearance.greeting_msg = "NixOs, btw";
      widget.clock.format = "%H:%M";
    };
  };
}
