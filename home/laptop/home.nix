{ config, pkgs, ... }:
{
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  news.display = "silent";

  home.stateVersion = "24.05";

  imports = [ ./hyprland.nix ];

  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./dotfiles/config.fish;
  };

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

  programs.git = {
    enable = true;
    userName = "Gideon Bühler";
    userEmail = "gideonbuehler18@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "${pkgs.nvim-pkg}/bin/nvim";
      diff.tool = "nvim";
      difftool.nvim.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      difftool.prompt = false;
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";
    extraConfig = builtins.readFile ./dotfiles/tmux.conf;
  };

  programs.ghostty.enable = true;
  programs.ghostty.enableFishIntegration = true;
  programs.ghostty.settings = {
    font-size = 18;
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
