# Tokyo Night color palette
# https://github.com/enkia/tokyo-night-vscode-theme
#
# Usage: access via `colors` in any module (passed through specialArgs).
# Example: colors.bg or colors.blue
{
  # Absolute black / white
  none = "#ffffff00";
  white = "#ffffff";
  black = "#000000";

  # Background shades (darkest to lightest)
  bg_window = "#0d0f17";
  bg_input_border = "#0f0f14";
  bg_deeper = "#101014";
  bg_input = "#14141b";
  bg_dark = "#16161e";
  bg = "#1a1b26";
  bg_sidebar = "#16161e";
  bg_float = "#16161e";
  bg_popup = "#16161e";
  bg_statusline = "#16161e";
  bg_highlight = "#292e42";
  bg_visual = "#283457";
  bg_search = "#3d59a1";
  bg_surface = "#1c1d29";
  bg_elevated = "#1e202e";
  bg_tab_modified = "#1f202e";
  bg_overlay = "#20222c";
  bg_active = "#202330";
  bg_tab_pinned = "#222333";
  bg_menu_selection_border = "#1b1e2e";
  bg_fold = "#1111174a";
  bg_diff_unchanged = "#282a3b";
  bg_button_secondary = "#3b3e52";

  # Terminal / ANSI
  terminal_black = "#414868";
  ansi_black = "#363b54";

  # Foreground shades
  fg = "#c0caf5";
  fg_dark = "#a9b1d6";
  fg_gutter = "#3b4261";
  fg_sidebar = "#a9b1d6";

  # Muted / subdued foregrounds
  fg_muted = "#515670";
  fg_comment = "#51597d";
  fg_comment_doc = "#5a638c";
  fg_comment_emphasis = "#646e9c";
  fg_preformat = "#9699a8";
  fg_token = "#9aa5ce";
  fg_badge = "#acb0d0";
  fg_info = "#bbc2e0";
  fg_param = "#d9d4cd";

  # Comments & subtle text
  comment = "#565f89";
  dark3 = "#545c7e";
  dark5 = "#737aa2";

  # Core palette
  blue0 = "#3d59a1";
  blue1 = "#2ac3de";
  blue2 = "#0db9d7";
  blue5 = "#89ddff";
  blue6 = "#b4f9f8";
  blue = "#7aa2f7";
  cyan = "#7dcfff";
  magenta = "#bb9af7";
  magenta2 = "#ff007c";
  purple = "#9d7cd8";
  orange = "#ff9e64";
  yellow = "#e0af68";
  green = "#9ece6a";
  green1 = "#73daca";
  green2 = "#41a6b5";
  teal = "#1abc9c";
  red = "#f7768e";
  red1 = "#db4b4b";

  # Indent guides / structural lines
  indent_guide = "#232433";
  indent_guide_active = "#363b54";
  tree_guide = "#2b2b3b";
  sash = "#29355a";
  bracket_border = "#42465d";

  # Selection base (used with alpha suffixes)
  selection = "#515c7e";

  # Badge
  badge_bg = "#7e83b2";

  # Scrollbar base (used with alpha suffixes)
  scrollbar = "#868bc4";

  # Bracket pair colors
  bracket1 = "#698cd6";
  bracket2 = "#68b3de";
  bracket3 = "#9a7ecc";
  bracket4 = "#25aac2";
  bracket5 = "#80a856";
  bracket6 = "#c49a5a";

  # Search / highlight
  search_highlight = "#668ac4";

  # Git diff colors
  git_add = "#449dab";
  git_change = "#6183bb";
  git_delete = "#914c54";

  # Gutter diff (darker, muted versions)
  gutter_modified = "#394b70";
  gutter_added = "#164846";
  gutter_deleted = "#703438";
  gutter_deleted_bg = "#823c41";

  # Inline diff backgrounds (dark, blended tints for diff viewers)
  diff_added_bg = "#1a2b32";
  diff_removed_bg = "#32212a";
  diff_added_line_number_bg = "#1b2b34";
  diff_removed_line_number_bg = "#2d1f26";

  # Minimap gutter diff
  minimap_modified = "#425882";
  minimap_added = "#1C5957";
  minimap_deleted = "#944449";

  # Merge
  merge_current = "#007a75";

  # Diagnostics / info / warning / error shades
  info = "#0da0ba";
  error_muted = "#bb616b";
  error_bg = "#85353e";
  error_border = "#963c47";
  warning_muted = "#bba461";
  warning_bg = "#c2985b";
  invalid_fg = "#c97018";
  filter_no_match = "#a6333f";

  # Syntax token colors
  invalid = "#ff5370";
  tag_custom = "#de5971";
  tag_punctuation = "#ba3c97";
  css_id = "#fc7b7b";
  css_punctuation = "#9abdf5";
  md_raw_punctuation = "#4e5579";
  md_h2 = "#61bdf2";
  md_h4 = "#6d91de";
  md_h6 = "#747ca1";
  markup_table = "#c0cefc";
  token_warn = "#ffdb69";
  token_debug = "#b267e6";

  # Debug
  breakpoint_disabled = "#414761";
  breakpoint_unverified = "#c24242";
  stack_frame_highlight = "#E2BD3A";

  # Border / UI chrome
  border_highlight = "#27a1b9";
  border = "#1a1b26";

  # Storm variant overrides (commonly used)
  storm = {
    bg = "#24283b";
    bg_dark = "#1f2335";
    bg_highlight = "#292e42";
    bg_sidebar = "#1f2335";
    bg_float = "#1f2335";
    bg_popup = "#1f2335";
    bg_statusline = "#1f2335";
    bg_visual = "#2e3c64";
    border = "#24283b";
  };

  # Light variant (Tokyo Night Day)
  day = {
    bg = "#e1e2e7";
    bg_dark = "#d5d6db";
    bg_highlight = "#c4c8da";
    bg_sidebar = "#d5d6db";
    bg_float = "#d5d6db";
    bg_popup = "#d5d6db";
    bg_statusline = "#d5d6db";
    bg_visual = "#b6bfe2";
    bg_search = "#7890dd";

    fg = "#3760bf";
    fg_dark = "#6172b0";
    fg_gutter = "#a8aecb";
    fg_sidebar = "#6172b0";
    comment = "#848cb5";

    blue = "#2e7de9";
    cyan = "#007197";
    magenta = "#9854f1";
    purple = "#7847bd";
    orange = "#b15c00";
    yellow = "#8c6c3e";
    green = "#587539";
    green1 = "#387068";
    green2 = "#38919f";
    teal = "#118c74";
    red = "#f52a65";
    red1 = "#c64343";

    git_add = "#399a96";
    git_change = "#6482bd";
    git_delete = "#c47981";

    diff_added_bg = "#d5e5d5";
    diff_removed_bg = "#f7d8db";
    diff_added_line_number_bg = "#c5d5c5";
    diff_removed_line_number_bg = "#e7c8cb";

    border_highlight = "#2496ac";
    border = "#e1e2e7";
  };
}
