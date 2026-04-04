{
  colors,
  lib,
  ...
}: let
  c = colors;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 8;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = [
          "pulseaudio"
          "network"
          "backlight"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y  %H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='${c.blue}'><b>{}</b></span>";
              days = "<span color='${c.fg}'>{}</span>";
              weeks = "<span color='${c.green}'><b>W{}</b></span>";
              weekdays = "<span color='${c.orange}'><b>{}</b></span>";
              today = "<span color='${c.red}'><b><u>{}</u></b></span>";
            };
          };
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "  Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n{essid}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "  Muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        backlight = {
          format = "{icon}  {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: "FiraCode Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: ${c.fg};
      }

      tooltip {
        background: ${c.bg_float};
        border: 1px solid ${c.bg_highlight};
        border-radius: 8px;
        color: ${c.fg};
      }

      #workspaces {
        background: ${c.bg_dark};
        border-radius: 10px;
        margin: 4px 0 4px 8px;
        padding: 0 4px;
      }

      #workspaces button {
        color: ${c.comment};
        padding: 2px 8px;
        border-radius: 8px;
        margin: 3px 2px;
      }

      #workspaces button:hover {
        background: ${c.bg_highlight};
        color: ${c.fg};
      }

      #workspaces button.active {
        background: ${c.blue0};
        color: ${c.fg};
      }

      #workspaces button.urgent {
        background: ${c.red};
        color: ${c.bg};
      }

      #clock,
      #battery,
      #network,
      #pulseaudio,
      #backlight,
      #tray {
        background: ${c.bg_dark};
        border-radius: 10px;
        padding: 4px 14px;
        margin: 4px 0;
      }

      #clock {
        margin-left: 0;
        margin-right: 0;
        color: ${c.blue};
      }

      #battery {
        color: ${c.green};
      }

      #battery.warning {
        color: ${c.yellow};
      }

      #battery.critical {
        color: ${c.red};
      }

      #battery.charging {
        color: ${c.green1};
      }

      #network {
        color: ${c.cyan};
      }

      #network.disconnected {
        color: ${c.comment};
      }

      #pulseaudio {
        color: ${c.magenta};
      }

      #pulseaudio.muted {
        color: ${c.comment};
      }

      #backlight {
        color: ${c.yellow};
      }

      #tray {
        margin-right: 8px;
      }
    '';
  };
}
