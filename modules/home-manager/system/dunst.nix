{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Appearance
        width = 350;
        height = 150;
        offset = "15x15";
        origin = "top-right";
        notification_limit = 5;
        progress_bar = true;
        indicate_hidden = true;
        transparency = 10;
        separator_height = 2;
        padding = 16;
        horizontal_padding = 16;
        frame_width = 2;
        gap_size = 6;
        separator_color = "frame";
        sort = true;

        # Text
        font = "FiraCode Nerd Font 11";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        show_indicators = true;

        # Icons
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 64;

        # Behavior
        sticky_history = true;
        history_length = 20;
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        mouse_middle_click = "do_action";

        # Corners
        corner_radius = 14;

        # Catppuccin Mocha frame color
        frame_color = "#b4befe";
        highlight = "#b4befe";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#313244";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#b4befe";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}
