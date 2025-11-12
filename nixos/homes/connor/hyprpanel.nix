{
  enable = true;
  settings = {
    menus.dashboard.powermenu.avatar.image = "/home/connor/Pictures/profilePic.jpg";
    theme = {
      font = {
        name = "JetBrainsMono Nerd Font";
        label = "JetBrainsMono Nerd Font Medium";
        size = "16px";
      };
      bar = {
        floating = true;
	transparent = true;
	menus.monochrome = true;
	buttons.monochrome = true;
      };
    };
    menus.clock = {
      weather.location = "Eindhoven";
      weather.unit = "metric";
      time.military = true;
   };
    bar.customModules = {
      storage.paths = [ "/" ];
      weather.unit = "metric";
      worldclock.format = "%H:%M:%S %Z";
      worldclock.formatDiffDate = "%a %b %d %H:%M:%S %Z";
      worldclock.tz = [ "Europe/Amsterdam" "Europe/London" ];
    };
    bar = {
      layouts = {
        "*" = {
          "left" = [ "dashboard" "workspaces" "windowtitle" ];
	  "middle" = [ "media" ];
	  "right" = [ "volume" "network" "custom/mac-battery" "clock" "bluetooth" "notifications" ];
        };
      };
      network = {
        showWifiInfo = true;
	truncation = false;
      };
      launcher.autoDetectIcon = true;
      bluetooth = {
        label = false;
      };
    };
    scalingPriority = "hyprland";
  };
}
