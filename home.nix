{ config, pkgs, ... }:
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
  home.username = "meow";
  home.homeDirectory = "/home/meow";
  home.stateVersion = "25.05";
  home.packages = [
    pkgs.home-manager
  ];
  programs.home-manager.enable = true;
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
  };
  
  services.dunst = {
    enable = true;
    
    settings = {
      global = {
        frame_color = "#8caaee";
        separator_color = "frame"; # dunstrc의 'frame' 값은 문자열로
        highlight = "#8caaee";
      };
      "urgency_low" = {
        background = "#303446";
        foreground = "#c6d0f5";
      };
      "urgency_normal" = {
        background = "#303446";
        foreground = "#c6d0f5";
      };
      "urgency_critical" = {
        background = "#303446";
        foreground = "#c6d0f5";
        frame_color = "#ef9f76";
      };
      "skip-rule" = {
        appname = "discord";
        skip_display = true;
      };

    };
  };


  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
