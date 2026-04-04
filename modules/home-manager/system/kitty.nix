{colors, ...}: let
  c = colors;
  # Kitty uses hex colors with # prefix, same as our colors.nix
in {
  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };

    settings = {
      # Cursor
      cursor = c.fg;
      cursor_text_color = c.bg;

      # URL
      url_color = c.blue;

      # Window / tab bar
      active_tab_foreground = c.bg_dark;
      active_tab_background = c.blue;
      inactive_tab_foreground = c.dark5;
      inactive_tab_background = c.bg_dark;
      tab_bar_background = c.bg_deeper;

      # Borders
      active_border_color = c.blue;
      inactive_border_color = c.comment;

      # Bell
      bell_border_color = c.yellow;

      # Backgrounds / foregrounds
      foreground = c.fg_dark;
      background = c.bg;
      selection_foreground = c.none;
      selection_background = c.bg_visual;

      # Appearance
      background_opacity = "0.75";
      window_padding_width = 4;
      confirm_os_window_close = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      enable_audio_bell = "no";

      # ANSI colors
      # Black
      color0 = c.ansi_black;
      color8 = c.terminal_black;

      # Red
      color1 = c.red;
      color9 = c.red;

      # Green
      color2 = c.green;
      color10 = c.green;

      # Yellow
      color3 = c.yellow;
      color11 = c.yellow;

      # Blue
      color4 = c.blue;
      color12 = c.blue;

      # Magenta
      color5 = c.magenta;
      color13 = c.magenta;

      # Cyan
      color6 = c.cyan;
      color14 = c.cyan;

      # White
      color7 = c.fg_dark;
      color15 = c.fg;
    };
  };
}
