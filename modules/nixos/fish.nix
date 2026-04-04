{
  lib,
  pkgs,
  colors,
  ...
}: let
  c = colors;
in {
  users.users.jackc.shell = pkgs.fish;

  programs.nix-index.enableFishIntegration = true;

  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
      set fish_greeting "🐟"
    '';
  };

  programs.starship = {
    enable = true;
    settings = lib.mkMerge [
      (builtins.fromTOML
        (
          builtins.readFile "${pkgs.starship}/share/starship/presets/jetpack.toml"
        ))
      {
        palette = "tokyo_night";

        palettes.tokyo_night = {
          # Core palette for starship modules
          blue = c.blue;
          cyan = c.cyan;
          green = c.green;
          magenta = c.magenta;
          purple = c.purple;
          orange = c.orange;
          yellow = c.yellow;
          red = c.red;
          teal = c.teal;
          white = c.fg_dark;
          black = c.bg;

          # Bright variants (used by jetpack preset)
          bright-blue = c.blue5;
          bright-cyan = c.blue1;
          bright-green = c.green1;
          bright-magenta = c.magenta;
          bright-purple = c.magenta;
          bright-red = c.red;
          bright-yellow = c.yellow;
          bright-white = c.fg;
          bright-black = c.terminal_black;

          # Muted / structural
          fg = c.fg;
          fg_dark = c.fg_dark;
          comment = c.comment;
          dark5 = c.dark5;
        };
      }
    ];
  };
}
