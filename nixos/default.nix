{
  lib,
  config,
  ...
}: {
  imports = [
    ./gnome.nix
    ./home.nix
    ./nix.nix
    ./overlays.nix
    ./pipewire.nix
    ./plymouth.nix
  ];

  options = {
    nixcfg = {
      username = lib.mkOption {
        type = lib.types.str;
        description = "Your username";
      };

      desktop = lib.mkEnableOption "the desktop configurations";

      inputs = lib.mkOption {
        default = {};
        description = "List of additional flakes";
      };
    };
  };

  config = {
    boot.initrd.systemd.enable = lib.mkDefault (
      !config.boot.swraid.enable
      && !config.boot.isContainer
      && !config.boot.growPartition
      && !config.services.lvm.boot.thin.enable
    );

    documentation.info.enable = false;

    console = {
      earlySetup = true;
      font = "cyr-sun16";
      keyMap = "us";
    };

    users.users.${config.nixcfg.username}.extraGroups =
      lib.optional config.programs.wireshark.enable "wireshark";
  };
}
