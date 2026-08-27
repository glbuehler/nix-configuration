{
  description = "System and home configuration of gideon";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kickstart-nix = {
      url = "github:glbuehler/kickstart-nix.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-material-shell = {
      url = "github:avengemedia/dankmaterialshell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      kickstart-nix,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;

      mainUser = "gideon";
      hosts = {
        "nixos-desktop" = {
          dir = "tower";
          system = "x86_64-linux";
        };
        "nixos-laptop" = {
          dir = "laptop";
          system = "x86_64-linux";
        };
      };

      systems = lib.unique (map (h: h.system) (builtins.attrValues hosts));
      forAllSystems = nixpkgs.lib.genAttrs systems;

      pkgs = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ kickstart-nix.overlays.default ];
        }
      );
      pkgs-unstable = forAllSystems (
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        }
      );

      nixosConfig =
        dir: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            pkgs-unstable = pkgs-unstable.${system};
          };
          modules = [
            ./hosts/${dir}/configuration.nix
          ];
        };
      homeConfig =
        dir: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.${system};

          extraSpecialArgs = {
            inherit inputs;
            pkgs-unstable = pkgs-unstable.${system};
          };

          modules = [ ./hosts/${dir}/home.nix ];
        };
    in
    {
      nixosConfigurations = builtins.mapAttrs (_name: cfg: nixosConfig cfg.dir cfg.system) hosts;
      homeConfigurations = lib.mapAttrs' (name: cfg: {
        name = "${mainUser}@${name}";
        value = homeConfig cfg.dir cfg.system;
      }) hosts;
    };
}
