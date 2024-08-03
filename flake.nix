{
  inputs = {
    srvos = {
      url = "github:nix-community/srvos";
      flake = false;
    };
  };

  outputs = inputs @ {srvos, ...}: {
    nixosModules.default = {
      imports = let
        common = name: "${srvos}/nixos/common/${name}.nix";
      in [
        (common "openssh")
        (common "serial")
        (common "sudo")
        (common "upgrade-diff")
        (common "well-known-hosts")
        ./nixos
      ];
    };
  };
}
