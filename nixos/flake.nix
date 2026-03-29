{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
  in {
    nixosConfigurations."nixos-desktop" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [ 
        ./desktop/configuration.nix
      ];
    };
    nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [ 
        ./laptop/configuration.nix
      ];
    };
  };
}
