{
  description = "Home Manager configuration of gideon";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    local-config.url = "path:/home/gideon/system/local-config";
    kickstart-nix = {
      url = "github:glbuehler/kickstart-nix.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, kickstart-nix, local-config, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ kickstart-nix.overlays.default ];
    };

    variants = {
      laptop = [ ./laptop/home.nix ];
      desktop = [ ./desktop/home.nix ];
    };
  in {
    homeConfigurations."gideon" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit inputs;
      };

      modules = variants.${local-config.variant};
    };
  };
}
