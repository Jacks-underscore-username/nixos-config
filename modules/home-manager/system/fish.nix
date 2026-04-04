{colors, ...}: let
  c = colors;

  # Fish expects hex colors WITHOUT the # prefix
  strip = hex: builtins.substring 1 (builtins.stringLength hex - 1) hex;
in {
  # Fish is enabled at the NixOS level (modules/nixos/fish.nix).
  # We drop the colors into conf.d via home.file so we don't need
  # programs.fish.enable here (which triggers a slow man-cache rebuild).
  xdg.configFile."fish/conf.d/tokyo-night-colors.fish".text = ''
    # Tokyo Night color scheme — generated from lib/colors.nix
    set -g fish_color_normal ${strip c.fg_dark}
    set -g fish_color_command ${strip c.blue}
    set -g fish_color_keyword ${strip c.magenta}
    set -g fish_color_quote ${strip c.green}
    set -g fish_color_redirection ${strip c.cyan}
    set -g fish_color_end ${strip c.orange}
    set -g fish_color_error ${strip c.red}
    set -g fish_color_param ${strip c.fg_dark}
    set -g fish_color_comment ${strip c.comment}
    set -g fish_color_selection --background=${strip c.bg_visual}
    set -g fish_color_search_match --background=${strip c.bg_highlight}
    set -g fish_color_operator ${strip c.cyan}
    set -g fish_color_escape ${strip c.magenta}
    set -g fish_color_autosuggestion ${strip c.dark5}
    set -g fish_color_cancel ${strip c.red}

    # Pager (tab completion menu)
    set -g fish_pager_color_progress ${strip c.comment}
    set -g fish_pager_color_prefix ${strip c.blue}
    set -g fish_pager_color_completion ${strip c.fg_dark}
    set -g fish_pager_color_description ${strip c.dark5}
    set -g fish_pager_color_selected_background --background=${strip c.bg_highlight}
  '';
}
