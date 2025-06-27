{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.11";
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
