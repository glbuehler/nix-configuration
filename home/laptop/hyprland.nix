{ config, pkgs, lib, ... }:
{

  imports = [
    ../common/hyprland.nix
  ];
  
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@60,0x0,1"
    ];

    input = {
      accel_profile = "flat";
      sensitivity = 0.0;
      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.7;
      };
    };
  };

  programs.waybar.settings.mainBar = {
    layer = "top";
    reload_style_on_change = true;
    position = "top";
    modules-left = [ "hyprland/workspaces" ];
    modules-center = [ "clock" ];
    modules-right = [ "custom/mic" "pulseaudio" "battery" "bluetooth" "network" ];
  };

  services.hypridle.settings.listener = [
    {
      timeout = 180;
      on-timeout = "hyprlock";
    }
    # on ac power
    {
      timeout = 300;
      on-timeout = "systemd-ac-power && brightnessctl -s set 10";
      on-resume = "brightnessctl -r";
    }
    # on battery
    {
      timeout = 120;
      on-timeout = "systemd-ac-power || brightnessctl -s set 10";
      on-resume = "brightnessctl -r";
    }
    {
      timeout = 240;
      on-timeout = "systemd-ac-power || hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
    }
    {
      timeout = 1800;
      on-timeout = "systemd-ac-power || systemctl suspend";
    }
  ];
  
}
