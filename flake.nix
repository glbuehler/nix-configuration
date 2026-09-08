{
  description = "System and home configuration of gideon";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    nixpkgs-darwin = {
      url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    };
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
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-darwin,
      nix-darwin,
      home-manager,
      kickstart-nix,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      mainUser = "gideon";

      # Linux (nixos-rebuild) hosts
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

      # macOS (nix-darwin) hosts — same shape as `hosts`, just built with darwinSystem.
      # Rename "macbook" / hosts/macbook to whatever you'd like the host to be called.
      darwinHosts = {
        "darwin-macbook" = {
          dir = "macbook";
          system = "aarch64-darwin";
        };
      };

      systems = lib.unique (
        map (h: h.system) (builtins.attrValues hosts)
        ++ map (h: h.system) (builtins.attrValues darwinHosts)
      );
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
      pkgs-darwin = forAllSystems (
        system:
        import nixpkgs-darwin {
          inherit system;
          config.allowUnfree = true;
          overlays = [ kickstart-nix.overlays.default ];
        }
      );


      nixosConfig =
        dir: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgs-unstable.${system};
          };
          modules = [
            ./hosts/${dir}/configuration.nix
          ];
        };

      # Mirrors nixosConfig, but built with nix-darwin's darwinSystem and with
      # home-manager wired in as a darwin module (rather than a standalone
      # `homeConfigurations` entry) so `darwin-rebuild switch` manages both
      # system and home config in one activation, matching typical Darwin usage.
      darwinConfig =
        dir: system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgs-unstable.${system};
          };
          modules = [
            ./hosts/${dir}/configuration.nix
            { nixpkgs.pkgs = pkgs-darwin.${system}; }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs system;
                pkgs-unstable = pkgs-unstable.${system};
              };
              home-manager.users.${mainUser} = import ./hosts/${dir}/home.nix;
            }
          ];
        };

      homeConfig =
        dir: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.${system};
          extraSpecialArgs = {
            inherit inputs system;
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

      # Build with: $ darwin-rebuild build --flake .#macbook
      darwinConfigurations = builtins.mapAttrs (
        _name: cfg: darwinConfig cfg.dir cfg.system
      ) darwinHosts;
    };
}
