{
  flake.secretModules = {
    connor = {
      security.nix-secrets.secrets = {
        "connor/halloy" = {
          group = "connor";
          owner = "connor";
          recipients = [
            "ACE"
            "cookie"
            "lenix"
            "murtle"
            "onyx"
            "turtle"
            "yubikey"
          ];
        };
        "connor/linux" = {
          neededForUsers = true;
          recipients = [
            "ACE"
            "cookie"
            "lenix"
            "murtle"
            "onyx"
            "turtle"
            "yubikey"
          ];
        };
      };
    };
    connor-eduroam = {
      security.nix-secrets.secrets."connor/wifi/eduroam".recipients = ["lenix" "yubikey"];
    };
  };
}
