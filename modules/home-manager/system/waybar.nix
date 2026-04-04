{pkgs, ...}: let
  # Catppuccin Mocha palette
  rosewater = "#f5e0dc";
  flamingo = "#f2cdcd";
  pink = "#f5c2e7";
  mauve = "#cba6f7";
  red = "#f38ba8";
  maroon = "#eba0ac";
  peach = "#fab387";
  yellow = "#f9e2af";
  green = "#a6e3a1";
  teal = "#94e2d5";
  sky = "#89dceb";
  sapphire = "#74c7ec";
  blue = "#89b4fa";
  lavender = "#b4befe";
  text = "#cdd6f4";
  subtext1 = "#bac2de";
  subtext0 = "#a6adc8";
  overlay2 = "#9399b2";
  overlay1 = "#7f849c";
  overlay0 = "#6c7086";
  surface2 = "#585b70";
  surface1 = "#45475a";
  surface0 = "#313244";
  base = "#1e1e2e";
  mantle = "#181825";
  crust = "#11111b";
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 38;
        spacing = 8;
        margin-top = 6;
        margin-left = 10;
        margin-right = 10;

        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "battery" "tray"];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 40;
          rewrite = {
            "(.*) - Google Chrome" = " $1";
            "(.*) - Visual Studio Code" = " $1";
          };
        };

        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%A, %B %d, %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            format = {
              months = "<span color='${peach}'><b>{}</b></span>";
              days = "<span color='${text}'><b>{}</b></span>";
              weeks = "<span color='${teal}'><b>W{}</b></span>";
              weekdays = "<span color='${lavender}'><b>{}</b></span>";
              today = "<span color='${red}'><b><u>{}</u></b></span>";
            };
          };
        };

        cpu = {
          format = "  {usage}%";
          tooltip = true;
          interval = 2;
        };

        memory = {
          format = "  {}%";
          interval = 2;
        };

        temperature = {
          format = " {temperatureC}°C";
          critical-threshold = 80;
          format-critical = " {temperatureC}°C";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
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
          format-linked = "  No IP";
          format-disconnected = "  Offline";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n{essid}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = " {volume}%";
          format-muted = "  muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "FiraCode Nerd Font";
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: transparent;
        color: ${text};
      }

      window#waybar > box {
        background: alpha(${base}, 0.85);
        border: 2px solid ${surface0};
        border-radius: 16px;
        padding: 2px 8px;
      }

      tooltip {
        background: ${mantle};
        border: 1px solid ${surface0};
        border-radius: 12px;
        color: ${text};
      }

      #workspaces button {
        padding: 0 6px;
        color: ${overlay0};
        border-radius: 10px;
        margin: 3px 2px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: ${lavender};
        background: alpha(${lavender}, 0.15);
      }

      #workspaces button:hover {
        color: ${text};
        background: alpha(${surface1}, 0.5);
      }

      #window {
        color: ${subtext0};
        padding: 0 12px;
      }

      #clock {
        color: ${lavender};
        font-weight: bold;
      }

      #battery {
        color: ${green};
      }

      #battery.charging {
        color: ${green};
      }

      #battery.warning:not(.charging) {
        color: ${yellow};
      }

      #battery.critical:not(.charging) {
        color: ${red};
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to { color: ${surface0}; }
      }

      #cpu {
        color: ${sapphire};
      }

      #memory {
        color: ${mauve};
      }

      #temperature {
        color: ${teal};
      }

      #temperature.critical {
        color: ${red};
      }

      #backlight {
        color: ${yellow};
      }

      #network {
        color: ${sky};
      }

      #network.disconnected {
        color: ${overlay0};
      }

      #pulseaudio {
        color: ${peach};
      }

      #pulseaudio.muted {
        color: ${overlay0};
      }

      #tray {
        margin-right: 4px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: alpha(${red}, 0.2);
      }

      #cpu, #memory, #temperature, #backlight, #battery,
      #network, #pulseaudio, #tray, #clock {
        padding: 0 10px;
        margin: 3px 0;
      }
    '';
  };
}
