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
        palette = "inkglow";

        palettes.inkglow = {
          # Core accent palette mapped to starship color names
          blue    = c.accent;
          cyan    = c.type;
          green   = c.string;
          magenta = c.constant;
          purple  = c.constant;
          orange  = c.keyword;
          yellow  = c.number;
          red     = c.error;
          teal    = c.func;
          white   = c.fgSubtle;
          black   = c.bg;

          # Bright variants (used by jetpack preset)
          bright-blue    = c.accentAlt;
          bright-cyan    = c.type;
          bright-green   = c.func;
          bright-magenta = c.constant;
          bright-purple  = c.constant;
          bright-red     = c.errorBright;
          bright-yellow  = c.number;
          bright-white   = c.fg;
          bright-black   = c.bgHighlight;

          # Muted / structural
          fg      = c.fg;
          fg_dark = c.fgSubtle;
          comment = c.comment;
          dark5   = c.fgSubtle;
        };
      }
    ];
  };
}
