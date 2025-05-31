{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
  in {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./configuration.nix ];
    };
  };
}
