{colors, ...}: let
  c = colors;
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
      url_color = c.accent;

      # Window / tab bar
      active_tab_foreground   = c.bgPanel;
      active_tab_background   = c.accent;
      inactive_tab_foreground = c.fgSubtle;
      inactive_tab_background = c.bgPanel;
      tab_bar_background      = c.bgDeeper;

      # Borders
      active_border_color   = c.accent;
      inactive_border_color = c.comment;

      # Bell
      bell_border_color = c.number;

      # Backgrounds / foregrounds
      foreground           = c.fg;
      background           = c.bg;
      selection_foreground = "none";
      selection_background = c.bgVisual;

      # Appearance
      background_opacity      = "0.75";
      window_padding_width    = 4;
      confirm_os_window_close = 0;
      tab_bar_style           = "powerline";
      tab_powerline_style     = "slanted";
      enable_audio_bell       = "no";

      # ANSI colors
      color0  = c.ansiBlack;
      color8  = c.ansiBrightBlack;
      color1  = c.ansiRed;
      color9  = c.ansiBrightRed;
      color2  = c.ansiGreen;
      color10 = c.ansiBrightGreen;
      color3  = c.ansiYellow;
      color11 = c.ansiBrightYellow;
      color4  = c.ansiBlue;
      color12 = c.ansiBrightBlue;
      color5  = c.ansiMagenta;
      color13 = c.ansiBrightMagenta;
      color6  = c.ansiCyan;
      color14 = c.ansiBrightCyan;
      color7  = c.ansiWhite;
      color15 = c.ansiBrightWhite;
    };
  };
}
