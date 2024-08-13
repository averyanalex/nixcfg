{
  config,
  lib,
  ...
}: let
  inputs = config.nixcfg.inputs;
in {
  nixpkgs.overlays =
    lib.concatLists (lib.mapAttrsToList (name: input:
      lib.optional (lib.hasPrefix "nixpkgs-" name) (final: prev: {
        ${lib.removePrefix "nixpkgs-" name} = import input {
          system = prev.system;
          config = config.nixpkgs.config;
        };
      }))
    inputs)
    ++ lib.optional (inputs ? nur) inputs.nur.overlay;
}
