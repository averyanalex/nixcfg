{lib, ...}: {
  networking.nameservers = lib.mkDefault ["1.1.1.1#cloudflare-dns.com" "8.8.8.8#dns.google"];
  services.resolved = {
    enable = lib.mkDefault true;
    dnsovertls = lib.mkDefault "true";
    dnssec = lib.mkDefault "true";
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  systemd.services.systemd-networkd.stopIfChanged = false;
  systemd.services.systemd-resolved.stopIfChanged = false;
}
