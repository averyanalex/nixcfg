{
  lib,
  config,
  options,
  ...
}: let
  username = config.nixcfg.username;
  isHM = options ? home-manager;
in {
  options = {
    hm = lib.mkOption {
      type =
        if isHM
        then options.home-manager.users.type.functor.wrapped
        else lib.types.any;
      default = {};
    };
  };

  config =
    {}
    // lib.optionalAttrs isHM {
      home-manager.users.${username} = lib.mkAliasDefinitions options.hm;
    };

  imports = [
    {
      config = lib.mkIf isHM {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.${username} = {
            programs.home-manager.enable = true;

            home = {
              username = username;
              homeDirectory = "/home/${username}";
              stateVersion = config.system.stateVersion;
            };
          };
        };
      };
    }
  ];
}
