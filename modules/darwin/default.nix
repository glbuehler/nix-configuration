{
  imports = [
    ./input
    ./dock
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.aerospace.enable = true;

}
