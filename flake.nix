{
  description = "System configuration of gideon";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kickstart-nix = {
      url = "github:glbuehler/kickstart-nix.nvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-material-shell = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      kickstart-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        localSystem = { inherit system; };
        config.allowUnfree = true;
        overlays = [ kickstart-nix.overlays.default ];
      };
      nixosConfig = host: {
        inherit system;

        modules = [
          ./nixos/${host}/configuration.nix
        ];
      };
      homeConfig = host: {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [ ./home/${host}/home.nix ];
      };
    in
    {
      homeConfigurations."gideon@nixos-desktop" = home-manager.lib.homeManagerConfiguration (
        homeConfig "desktop"
      );
      homeConfigurations."gideon@nixos-laptop" = home-manager.lib.homeManagerConfiguration (
        homeConfig "laptop"
      );
      nixosConfigurations."nixos-desktop" = nixpkgs.lib.nixosSystem (nixosConfig "desktop");
      nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem (nixosConfig "laptop");
    };
}
