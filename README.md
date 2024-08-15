# Nixcfg

## Useful links

- <https://search.nixos.org/packages> - packages search
- <https://search.nixos.org/options> - system options search
- <https://home-manager-options.extranix.com/> - home manager options search
- <https://noogle.dev/> - Nix language functions search

## What to read

- <https://nixos.org/guides/nix-pills/04-basics-of-language> and <https://nixos.org/guides/nix-pills/05-functions-and-imports> - introduction to Nix language

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

## Useful commands

```shell
# nix repl with your config (i.e. type config.networking.hostName after launching repl)
nix --extra-experimental-features repl-flake repl ".#nixosConfigurations.$(hostname)"

# update flake.lock (use --commit-lock-file for automatic commit)
nix flake update
# update certain input
nix flake lock --update-input nixpkgs
```
