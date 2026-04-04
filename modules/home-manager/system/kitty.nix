{...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    settings = {
      # Catppuccin Mocha colors
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";
      url_color = "#F5E0DC";

      # black
      color0 = "#45475A";
      color8 = "#585B70";
      # red
      color1 = "#F38BA8";
      color9 = "#F38BA8";
      # green
      color2 = "#A6E3A1";
      color10 = "#A6E3A1";
      # yellow
      color3 = "#F9E2AF";
      color11 = "#F9E2AF";
      # blue
      color4 = "#89B4FA";
      color12 = "#89B4FA";
      # magenta
      color5 = "#F5C2E7";
      color13 = "#F5C2E7";
      # cyan
      color6 = "#94E2D5";
      color14 = "#94E2D5";
      # white
      color7 = "#BAC2DE";
      color15 = "#A6ADC8";

      # Appearance
      background_opacity = "0.85";
      background_blur = 64;
      window_padding_width = 12;
      confirm_os_window_close = 0;

      # Tab bar
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_foreground = "#1E1E2E";
      active_tab_background = "#B4BEFE";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#181825";
      tab_bar_background = "#11111B";

      # Misc
      enable_audio_bell = false;
      scrollback_lines = 10000;
      copy_on_select = true;
      strip_trailing_spaces = "smart";
    };
  };
}
