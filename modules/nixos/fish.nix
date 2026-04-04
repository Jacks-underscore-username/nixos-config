{
  lib,
  pkgs,
  ...
}: {
  users.users.jackc.shell = pkgs.fish;

  programs.nix-index.enableFishIntegration = true;

  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source

      # Catppuccin LS_COLORS via vivid
      if command -q vivid
        set -gx LS_COLORS (vivid generate catppuccin-mocha)
      end

      # Replace greeting with fastfetch
      function fish_greeting
        if command -q fastfetch
          fastfetch
        end
      end

      # Catppuccin Mocha fish syntax highlighting
      set -g fish_color_normal cdd6f4
      set -g fish_color_command 89b4fa
      set -g fish_color_keyword cba6f7
      set -g fish_color_quote a6e3a1
      set -g fish_color_redirection f5c2e7
      set -g fish_color_end fab387
      set -g fish_color_error f38ba8
      set -g fish_color_param f2cdcd
      set -g fish_color_comment 6c7086
      set -g fish_color_selection --background=313244
      set -g fish_color_search_match --background=313244
      set -g fish_color_operator 94e2d5
      set -g fish_color_escape eba0ac
      set -g fish_color_autosuggestion 6c7086
      set -g fish_pager_color_progress 6c7086
      set -g fish_pager_color_prefix 89b4fa
      set -g fish_pager_color_completion cdd6f4
      set -g fish_pager_color_description 6c7086
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
        palette = lib.mkForce "catppuccin_mocha";
        palettes.catppuccin_mocha = {
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
        };
      }
    ];
  };
}
