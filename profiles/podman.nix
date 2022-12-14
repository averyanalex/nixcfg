{ pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    defaultNetwork.dnsname.enable = true;
  };

  home-manager.users.alex = {
    home.packages = [
      pkgs.x11docker
    ];
  };

  persist.state.homeDirs = [
    { directory = ".local/share/containers"; mode = "u=rwx,g=,o="; }
  ];
}
