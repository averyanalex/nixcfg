{
  pkgs,
  lib,
  config,
  ...
}: {
  home-manager.users.alex = {
    home.packages = [pkgs.swaynotificationcenter];
    xdg.configFile."swaync/config.json".source = pkgs.writeText "swaync-config.json" (builtins.toJSON {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      scripts = {
        # example-script = {
        #   exec = "echo 'Do something...'";
        #   urgency = "Normal";
        # };
        # example-action-script = {
        #   exec = "echo 'Do something actionable!'";
        #   urgency = "Normal";
        #   run-on = "action";
        # };
      };
      notification-visibility = {
        # example-name = {
        #   state = "muted";
        #   urgency = "Low";
        #   app-name = "Spotify";
        # };
      };
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    });
    wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
      "${config.home-manager.users.alex.wayland.windowManager.sway.config.modifier}+n" = "exec swaync-client -t -sw";
    };
    # wayland.windowManager.hyprland.extraConfig = ''
    #   exec-once=swaync
    #   bind=SUPER,N,exec,swaync-client -t -sw
    # '';
  };
}
