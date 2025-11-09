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
    interactiveShellInit = ''
      function nswitch
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
      end
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland.extraConfig = import ./hyprland.nix;
  programs.hyprpanel = import ./hyprpanel.nix;
  home.stateVersion = "25.05";
}
