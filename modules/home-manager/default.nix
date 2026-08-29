{ pkgs, inputs, ... }:
{
  imports = [
    ./browser
    ./fish
    ./ghostty
    ./git
    ./hyprland
    ./theme
    ./tmux
    inputs.dank-material-shell.homeModules.dank-material-shell
  ];

  programs.dank-material-shell.enable = true;

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
