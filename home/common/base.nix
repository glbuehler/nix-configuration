{ config, pkgs, ... }:
{

  news.display = "silent";

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    iconTheme.name = "Yaru";
    cursorTheme.name = "Adwaita";
  };

  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 16;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 16;
  };

  home.packages = with pkgs; [ 
    brightnessctl
    discord
    firefox
    gimp
    kdePackages.dolphin
    libnotify
    pulseaudio
    pulsemixer
    nvim-pkg
    rustup
    zip
    unzip
    gnutar
    htop
    fastfetch
    wl-clipboard

    # fonts
    font-awesome
    nerd-fonts.droid-sans-mono
  ];

  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;
  };

  programs.git = {
    enable = true;
    userName = "Gideon Bühler";
    userEmail = "gideonbuehler18@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "${pkgs.nvim-pkg}/bin/nvim";
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";
    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      mouse-hide-while-typing = true;
      background = "#1a1b26";
      window-decoration = "none";
      app-notifications = "no-clipboard-copy";
      theme = "tokyonight";
      keybind = [
        "clear"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+plus=increase_font_size:2"
        "ctrl+minus=decrease_font_size:2"
      ];
      confirm-close-surface = false;
    };
  };

  services.dunst.enable = true;

  fonts.fontconfig.enable = true;

}
