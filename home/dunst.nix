{ config, pkgs, ...}:
{
  services.dunst = {
    enable = true;
    
    settings = {
      global = {
        frame_color = "#8caaee";
        separator_color = "frame"; 
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
}
