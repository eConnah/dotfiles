# Home Manger Setup For Connor
{ pkgs, ... }: {

  home.packages = with pkgs; [ 
    atool
    httpie
    vicinae
    vesktop
    ncspot
    waypaper
    hyprpaper
    nerd-fonts.jetbrains-mono
  ];
  
  programs.kitty.enable = true;
  programs.fish = {
    enable = true;
    functions = {
      # simplifies nixos-rebuild
      nswitch = ''
        argparse "u/upgrade" "t/trace" -- $argv
        
	set upgrade 0
	set trace 0

	if set -q _flag_upgrade
	  set upgrade 1
	end
	if set -q _flag_trace
	  set trace 1
	end

	if test $upgrade -eq 0 -a $trace -eq 0
	  sudo nixos-rebuild switch -I nixos-config=/home/connor/Documents/dotfiles/nixos/configuration.nix
	else if test $upgrade -eq 1 -a $trace -eq 0
	  sudo nixos-rebuild switch -I nixos-config=/home/connor/Documents/dotfiles/nixos/configuration.nix --upgrade
	else if test $upgrade -eq 0 -a $trace -eq 1
	  sudo nixos-rebuild switch -I nixos-config=/home/connor/Documents/dotfiles/nixos/configuration.nix --show-trace
	else if test $upgrade -eq 1 -a $trace -eq 1
	  sudo nixos-rebuild switch -I nixos-config=/home/connor/Documents/dotfiles/nixos/configuration.nix --upgrade --show-trace
	end
      '';

      hyprbattery = ''
	set realCharge (cat /sys/class/power_supply/macsmc-battery/capacity)
	set charge (math "10 * round($realCharge / 10)")
	set state (cat /sys/class/power_supply/macsmc-battery/status)
	set iconKey "$state$charge"
	echo "{ 
	\"charge\": \"$realCharge\",
	\"state\": \"$state\",
	\"alt\": \"$iconKey\" 
}"
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland = {
    extraConfig = import ./hyprland.nix; 
    systemd.enable = false;
  };
  programs.hyprpanel = import ./hyprpanel.nix;
  home.file.".config/hyprpanel/modules.json".text = ''
  {
    "custom/mac-battery": {
      "icon": {
        "Discharging100": "󰁹",
        "Discharging90": "󰂂",
        "Discharging80": "󰂁",
        "Discharging70": "󰂀",
        "Discharging60": "󰁿",
        "Discharging50": "󰁾",
        "Discharging40": "󰁽",
        "Discharging30": "󰁼",
        "Discharging20": "󰁺",
        "Discharging10": "󰁺",
	"Discharging0": "󰂎",
        "Charging100": "󰂅",
        "Charging90": "󰂋",
        "Charging80": "󰂊",
        "Charging70": "󰢞",
        "Charging60": "󰂉",
        "Charging50": "󰢝",
        "Charging40": "󰂈",
        "Charging30": "󰂇",
        "Charging20": "󰂆",
        "Charging10": "󰢜",
	"Charging0": "󰢟",
        "default": "󰂑"
      },
      "label": "{charge}%",
      "tooltip": "{charge}% - {state}",
      "execute": "fish -c hyprbattery",
      "executeOnAction": "",
      "interval": 10000
    }
  }'';

  home.stateVersion = "25.05";
}
