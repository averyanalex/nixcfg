{
  config,
  lib,
  ...
}: let
  inputs = config.nixcfg.inputs;

  overlay-stable = final: prev: {
    stable = inputs.nixpkgs-stable.legacyPackages.${prev.system};
  };
  overlay-unstable = final: prev: {
    unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
  };
  overlay-master = final: prev: {
    master = inputs.nixpkgs-master.legacyPackages.${prev.system};
  };
in {
  nixpkgs.overlays =
    lib.optional (inputs ? nixpkgs-stable) overlay-stable
    ++ lib.optional (inputs ? nixpkgs-unstable) overlay-unstable
    ++ lib.optional (inputs ? nixpkgs-master) overlay-master
    ++ lib.optional (inputs ? nur) inputs.nur.overlay;
}
