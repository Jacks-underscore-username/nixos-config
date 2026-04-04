{colors, ...}: let
  c = colors;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "FiraCode Nerd Font 11";
        frame_width = 2;
        frame_color = c.bg_highlight;
        separator_color = "frame";
        corner_radius = 10;
        offset = "8x8";
        origin = "top-right";
        width = "(200, 400)";
        height = 300;
        padding = 12;
        horizontal_padding = 14;
        text_icon_padding = 12;
        icon_corner_radius = 4;
        gap_size = 4;
        background = c.bg_dark;
        foreground = c.fg;
        highlight = c.blue;
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        mouse_middle_click = "do_action";
      };

      urgency_low = {
        background = c.bg_dark;
        foreground = c.fg_dark;
        frame_color = c.bg_highlight;
        timeout = 5;
      };

      urgency_normal = {
        background = c.bg_dark;
        foreground = c.fg;
        frame_color = c.blue0;
        timeout = 10;
      };

      urgency_critical = {
        background = c.bg_dark;
        foreground = c.fg;
        frame_color = c.red;
        timeout = 0;
      };
    };
  };
}
