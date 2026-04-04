{
  config,
  lib,
  pkgs,
  home,
  ...
}: {
  home.packages = with pkgs; [
    legcord
  ];

  # Catppuccin Mocha theme for Legcord
  xdg.configFile."legcord/themes/catppuccin-mocha.css".text = ''
    /**
     * @name Catppuccin Mocha
     * @description Catppuccin Mocha theme for Discord/Legcord
     */

    :root {
      --background-primary: #1e1e2e;
      --background-secondary: #181825;
      --background-secondary-alt: #11111b;
      --background-tertiary: #11111b;
      --background-accent: #b4befe;
      --background-floating: #181825;
      --background-modifier-hover: rgba(49, 50, 68, 0.4);
      --background-modifier-active: rgba(49, 50, 68, 0.6);
      --background-modifier-selected: rgba(49, 50, 68, 0.5);
      --background-modifier-accent: rgba(69, 71, 90, 0.48);
      --channeltextarea-background: #313244;
      --text-normal: #cdd6f4;
      --text-muted: #6c7086;
      --text-link: #89b4fa;
      --interactive-normal: #bac2de;
      --interactive-hover: #cdd6f4;
      --interactive-active: #f5e0dc;
      --interactive-muted: #585b70;
      --header-primary: #cdd6f4;
      --header-secondary: #a6adc8;
      --channels-default: #bac2de;
      --scrollbar-thin-thumb: #313244;
      --scrollbar-thin-track: transparent;
      --scrollbar-auto-thumb: #45475a;
      --scrollbar-auto-track: #181825;
      --brand-experiment: #b4befe;
    }
  '';
}
