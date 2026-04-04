{pkgs, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        grace = 3;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 4;
          blur_size = 8;
          noise = 0.01;
          contrast = 0.8;
          brightness = 0.6;
          vibrancy = 0.2;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "280, 50";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.2;
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgba(b4befe88)";
          inner_color = "rgba(1e1e2ecc)";
          font_color = "rgb(cdd6f4)";
          fade_on_empty = true;
          fade_timeout = 2000;
          placeholder_text = "<span foreground=\"##6c7086\">Password...</span>";
          hide_input = false;
          rounding = 16;
          check_color = "rgba(a6e3a1ee)";
          fail_color = "rgba(f38ba8ee)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "rgba(f9e2afee)";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          color = "rgba(b4befeff)";
          font_size = 96;
          font_family = "FiraCode Nerd Font";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = "cmd[update:60000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(cdd6f4cc)";
          font_size = 20;
          font_family = "FiraCode Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        # Greeting
        {
          monitor = "";
          text = "Hi, $USER";
          color = "rgba(cdd6f488)";
          font_size = 14;
          font_family = "FiraCode Nerd Font";
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # Dim screen after 5 minutes
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 30%";
          on-resume = "brightnessctl -r";
        }
        # Lock after 10 minutes
        {
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen after 15 minutes
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
