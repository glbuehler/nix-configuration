{ config, pkgs, ... }:

{
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.stateVersion = "24.05";

  imports = [ ./hyprland.nix ];

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
    nvim-pkg

    # fonts
    font-awesome
    nerd-fonts.droid-sans-mono
  ];

  programs.git = {
    enable = true;
    userName = "Gideon Bühler";
    userEmail = "gideonbuehler18@gmail.com";
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    shell = "${pkgs.bash}/bin/bash";
    keyMode = "vi";
    extraConfig = builtins.readFile ./dotfiles/tmux.conf;
  };

  programs.wezterm.enable = true;
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    font-size = 18;
    mouse-hide-while-typing = true;
    background = "#1a1b26";
    window-decoration = "none";
    app-notifications = "no-clipboard-copy";
    theme = "tokyonight";
  };

  services.dunst.enable = true;

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".bashrc".source = ./dotfiles/bashrc;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gideon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
