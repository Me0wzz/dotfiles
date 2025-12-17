{ config, pkgs, inputs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    ghostty = "ghostty";
    waybar = "waybar"; 
    colors = "colors";
  };
in
{
  imports = [
    ./home/dunst.nix
  ];

  home.username = "meow";
  home.homeDirectory = "/home/meow";
  home.stateVersion = "25.05";
  home.packages = [
    pkgs.home-manager
  ];
  programs.home-manager.enable = true;
  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "half-life";
    };
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    catppuccin.enable = false;
  };
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
