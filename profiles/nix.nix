{
  nix = {
    settings = {
      auto-optimise-store = true;

      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ "@users" ];
      trusted-users = [ "@wheel" ];

      experimental-features = "nix-command flakes";
    };

    gc = {
      automatic = true;
      dates = "04:15";
      options = "--delete-older-than 7d";
    };

    daemonIOSchedClass = "best-effort";
    daemonIOSchedPriority = 5;
    daemonCPUSchedPolicy = "batch";
  };
}
