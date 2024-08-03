{
  config,
  lib,
  ...
}: {
  security.rtkit.enable = lib.mkDefault config.services.pipewire.enable;

  services.pipewire = {
    enable = lib.mkDefault config.nixcfg.desktop;
    alsa.enable = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
  };

  hardware.pulseaudio.enable = lib.mkIf config.services.pipewire.enable false;

  hm.services.mpd.extraConfig =
    lib.mkIf
    config.services.pipewire.enable ''
      audio_output {
        type "pipewire"
        name "PipeWire"
      }
    '';
}
