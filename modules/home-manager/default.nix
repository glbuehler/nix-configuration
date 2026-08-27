{ pkgs, ... }:
{
  imports = [
    ./browser
    ./fish
    ./ghostty
    ./git
    ./hyprland
    ./theme
    ./tmux
  ];

  news.display = "silent";

  home.packages = with pkgs; [
    discord
    gimp
    kdePackages.dolphin

    yazi
    yaziPlugins.drag

    pulseaudio
    pulsemixer

    fastfetch
    htop
    libnotify
    wl-clipboard

    nvim-pkg

    zip
    unzip
    gnutar

    # fonts
    font-awesome
    nerd-fonts.droid-sans-mono
  ];

  services.dunst.enable = true;
  fonts.fontconfig.enable = true;
}
