{
  description = "Home Manager configuration of gideon";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kickstart-nix = {
      url = "github:glbuehler/kickstart-nix.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell-config = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, kickstart-nix, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      localSystem = { inherit system; };
      config.allowUnfree = true;
      overlays = [ kickstart-nix.overlays.default ];
    };
  in {
    homeConfigurations."gideon@nixos-desktop" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit inputs;
      };

      modules = [ ./desktop/home.nix ];
    };
    homeConfigurations."gideon@nixos-laptop" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit inputs;
      };

      modules = [
        ./laptop/home.nix
        inputs.quickshell-config.homeManagerModules.default
      ];
    };
  };
}
