{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1680x1050@60,0x0,1"
    ];
    exec-once = [
      "[workspace 10 silent] ${pkgs.discord}/bin/discord"
    ];

    input = {
      accel_profile = "flat";
      sensitivity = -0.75;
    };
  };

  programs.waybar.settings.mainBar = {
    reload_style_on_change = true;
    layer = "top";
    position = "top";
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ "clock" ];
    modules-right = [ "custom/mic" "pulseaudio" "network" ];
  };

  services.hypridle.settings.listener = [
    {
      timeout = 590;
      on-timeout = "brightnessctl -s set 10";
      on-resume = "brightnessctl -r";
    }
    {
      timeout = 600;
      on-timeout = "hyprlock";
    }
    {
      timeout = 1800;
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
    }
  ];
  
}
