{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
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
