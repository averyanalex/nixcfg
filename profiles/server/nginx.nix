{ pkgs, ... }:
{
  services.nginx = {
    enable = true;
    package = pkgs.nginxQuic;
    additionalModules = [ pkgs.nginxModules.brotli ];

    clientMaxBodySize = "4G";

    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
  };

  users.users.nginx.extraGroups = [ "acme" ];

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };
}
