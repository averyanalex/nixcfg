{
  config,
  pkgs,
  lib,
  ...
}: {
  options.nixcfg.gnome = {
    enable = lib.mkEnableOption "the GNOME desktop configurations";
  };

  config = lib.mkIf config.nixcfg.gnome.enable {
    nixcfg.desktop = true;

    services.xserver = {
      enable = lib.mkDefault true;

      displayManager.gdm.enable = lib.mkDefault true;
      desktopManager.gnome.enable = lib.mkDefault true;

      xkb.layout = lib.mkIf (config.i18n.defaultLocale == "ru_RU.UTF-8") (lib.mkDefault "us,ru");
      xkb.options = lib.mkDefault "grp:win_space_toggle";
    };

    services.xserver.excludePackages = lib.mkDefault [pkgs.xterm];

    environment.gnome.excludePackages = lib.mkDefault (with pkgs; [
      gnome-tour
      epiphany
    ]);

    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = lib.mkDefault "1";
      NIXOS_OZONE_WL = lib.mkDefault "1";
    };
  };
}
