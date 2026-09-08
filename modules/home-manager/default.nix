{ pkgs, inputs, ... }:
{
  imports = [
    ./aerospace
    ./browser
    ./fish
    ./ghostty
    ./git
    ./hyprland
    ./theme
    ./tmux
    inputs.dank-material-shell.homeModules.dank-material-shell
  ];

  news.display = "silent";

  home.packages = with pkgs; [
    discord

    yazi
    yaziPlugins.drag

    pulseaudio
    pulsemixer

    fastfetch
    htop
    libnotify

    nvim-pkg

    zip
    unzip
    gnutar

    # fonts
  ];

  services.dunst.enable = true;
  fonts.fontconfig.enable = true;
}
