{
  enable = true;
  settings = {
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
	layouts = ''
          "*": {
            "left": [
              "dashboard",
              "workspaces",
              "windowtitle"
            ],
            "middle": [
              "media"
            ],
            "right": [
              "volume",
              "network",
              "bluetooth",
              "battery",
              "systray",
              "clock",
              "notifications"
            ]
          }
	'';
      };
    };
    menus.clock = {
      weather.location = "Eindhoven";
      weather.unit = "metric";
      time.military = true;
    };
    bar.customModules = {
      weather.unit = "metric";
      worldclock.format = "%H:%M:%S %Z";
      worldclock.formatDiffDate = "%a %b %d %H:%M:%S %Z";
      worldclock.tz = [ "Europe/Amsterdam" "Europe/London" ];
    };
    scalingPriority = "hyprland";
  };
}
