{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
        "[workspace 1 silent] $terminal"
        "[workspace 2 silent] firefox"
      ];
      "$terminal" = "wezterm";
      animations = {
        enabled = true;
        animation = [
          "global, 1, 2, ease-in-out"
        ];
        bezier = [
          "ease-in-out, 0.42, 0, 0.58, 1"
        ];
      };
      env = [
        "XCURSOR_SIZE, 16"
        "HYPRCURSOR_SIZE,6"
      ];
      bind = [
        "$mod, return, exec, $terminal"
        "$mod, q, killactive"
        "$mod, d, exec, wofi --show drun"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "SHIFT $mod, h, movewindow, l"
        "SHIFT $mod, l, movewindow, r"
        "SHIFT $mod, k, movewindow, u"
        "SHIFT $mod, j, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "SHIFT $mod, 1, movetoworkspace, 1"
        "SHIFT $mod, 2, movetoworkspace, 2"
        "SHIFT $mod, 3, movetoworkspace, 3"
        "SHIFT $mod, 4, movetoworkspace, 4"
        "SHIFT $mod, 5, movetoworkspace, 5"
        "SHIFT $mod, 6, movetoworkspace, 6"
        "SHIFT $mod, 7, movetoworkspace, 7"
        "SHIFT $mod, 8, movetoworkspace, 8"
        "SHIFT $mod, 9, movetoworkspace, 9"
        "SHIFT $mod, 0, movetoworkspace, 10"

        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n1 set +8%"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n1 set 8%-"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", switch:Lid Switch, exec, hyprlock"
      ];
      input = {
        kb_layout = "de";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.7;
        };
      };
      general = {
        allow_tearing = false;
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(808080ff)";
        "col.inactive_border" = "rgba(595959ff)";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master.new_status = "master";
      windowrule = [
        "suppressevent maximize, class:.*"
      ];
      misc.force_default_wallpaper = 1;
      misc.vfr = true;
      decoration = {
        blur.enabled = false;
        rounding = 6;
        inactive_opacity = 0.7;
      };
    };
  };

  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      reload_style_on_change = true;
      position = "top";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "custom/mic" "pulseaudio" "battery" "bluetooth" "network" ];
      "hyprland/workspaces" = {
        format = "{name}";
      };
      "clock" = {
        interval = 60;
        format = "{:%d/%m/%Y - %H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
      };
      "custom/mic" = {
        format = "{}";
        exec = "~/.config/waybar/scripts/mic_watcher.sh";
        return-type = "json";
      };
      "pulseaudio" = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
          "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          phone-muted = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        scroll-step = 1;
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        ignored-sinks = [ "Easy Effects Sink" ];
      };
      "battery" = {
        interval = 30;
        states = {
          good = 95;
          warning = 30;
          critical = 20;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% 󰂄";
        format-plugged = "{capacity}% 󰂄";
        format-alt = "{time} {icon}";
        format-icons = [ "󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
      };
      "bluetooth" = {
	format = "";
	format-disabled = "";
	format-connected = "{num_connections} ";
	tooltip-format = "{controller_alias}\t{controller_address}";
	tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
	tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
      };
      "network" = {
        interval = 30;
        format-wifi = "{icon}";
        format-icons = [ "󰤟" "󰤢" "󰤨" ];
        format-ethernet ="";
        format-disconnected = "";
        tooltip-format-disconnected = "no connection";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        tooltip-format-ethernet = "{ifname} 🖧 ";
        on-click = "wezterm --command=nmtui";
      };
    };
  };

  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general.hide_cursor = true;
    input-field = {
      size = "250, 60";
      fade_on_empty = false;
      outline_thickness = 0;
    };
    background = {
      path = "~/Pictures/hyprlock-bg.jpeg";
    };
    label = [ 
      {
        text = "<b>$TIME</b>";
        font_size = 80;
        position = "0, 180";
      }
      {
        text = "Hi <span color='##32a877'>$USER</span> :)";
        font_size = 20;
        position = "0, 80";
      }
    ];
  };

  programs.wofi.enable = true;
  programs.wofi.settings = {
    allow_images = true;
    key-exit = "Ctrl c";
  };
  programs.wofi.style = ''
    #outer-box {
      border-radius: 6px;
    }
    #window, #input {
      background-color: #222222;
      color: white;
    }
  '';

  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "~/wallpapers/ship_1920x1080.png" ];
    wallpaper = [ ", ~/wallpapers/ship_1920x1080.png" ];
  };

  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "pidof hyprlock || hyprlock";
    };
    listener = [
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
  };
}
