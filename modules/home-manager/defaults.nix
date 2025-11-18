{ pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      diffview-nvim
      neogit
      catppuccin-nvim
      {
        plugin = oil-nvim;
        config = ''
          packadd! oil.nvim
          lua << EOF
require("oil").setup()
EOF
        '';
      }
    ];
    extraConfig = ''
      colorscheme catppuccin-mocha
    '';
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "always";
    enableFishIntegration = true;
    colors = "always";
    theme = builtins.fromJSON (builtins.readFile ./theme-eza.json);
  };
}
