{colors, ...}: let
  c = colors;

  strip = hex: builtins.substring 1 (builtins.stringLength hex - 1) hex;
in {
  xdg.configFile."fish/conf.d/inkglow-colors.fish".text = ''
    # Inkglow color scheme — generated from lib/colors.nix
    set -g fish_color_normal        ${strip c.fg}
    set -g fish_color_command       ${strip c.func}
    set -g fish_color_keyword       ${strip c.constant}
    set -g fish_color_quote         ${strip c.string}
    set -g fish_color_redirection   ${strip c.type}
    set -g fish_color_end           ${strip c.keyword}
    set -g fish_color_error         ${strip c.error}
    set -g fish_color_param         ${strip c.fgSubtle}
    set -g fish_color_comment       ${strip c.comment}
    set -g fish_color_selection     --background=${strip c.bgVisual}
    set -g fish_color_search_match  --background=${strip c.bgHighlight}
    set -g fish_color_operator      ${strip c.type}
    set -g fish_color_escape        ${strip c.constant}
    set -g fish_color_autosuggestion ${strip c.fgMuted}
    set -g fish_color_cancel        ${strip c.error}

    # Pager (tab completion menu)
    set -g fish_pager_color_progress             ${strip c.comment}
    set -g fish_pager_color_prefix               ${strip c.accent}
    set -g fish_pager_color_completion           ${strip c.fgSubtle}
    set -g fish_pager_color_description          ${strip c.fgSubtle}
    set -g fish_pager_color_selected_background  --background=${strip c.bgHighlight}
  '';
}
