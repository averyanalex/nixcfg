# Nixcfg

## Example flake.nix

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcfg.url = "github:averyanalex/nixcfg";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixcfg,
    ...
  }: {
    nixosConfigurations.hostname_changeme = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        home-manager.nixosModule
        nixcfg.nixosModules.default
        ({inputs, ...}: {
          nixcfg = {
            username = "username_changeme";
            desktop = true;
            inherit inputs;
          };
        })
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
```
