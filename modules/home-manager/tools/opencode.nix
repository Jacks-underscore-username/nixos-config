{
  lib,
  colors,
  ...
}: let
  c = colors;

  # Generate the custom Tokyo Night theme JSON from colors.nix
  themeJson = builtins.toJSON {
    "$schema" = "https://opencode.ai/theme.json";

    defs = {
      # Background shades (darkest to lightest)
      bg = c.bg; # #1a1b26
      bgPanel = c.bg_dark; # #16161e
      bgElement = c.bg_highlight; # #292e42

      # Foreground
      fg = c.fg; # #c0caf5
      fgDark = c.fg_dark; # #a9b1d6
      fgMuted = c.dark5; # #737aa2

      # Core palette
      blue = c.blue; # #7aa2f7
      cyan = c.cyan; # #7dcfff
      magenta = c.magenta; # #bb9af7
      purple = c.purple; # #9d7cd8
      orange = c.orange; # #ff9e64
      yellow = c.yellow; # #e0af68
      green = c.green; # #9ece6a
      green1 = c.green1; # #73daca
      green2 = c.green2; # #41a6b5
      red = c.red; # #f7768e
      red1 = c.red1; # #db4b4b

      # Structural
      comment = c.comment; # #565f89
      dark3 = c.dark3; # #545c7e
      dark5 = c.dark5; # #737aa2
      fgGutter = c.fg_gutter; # #3b4261

      # Git
      gitAdd = c.git_add; # #449dab
      gitDelete = c.git_delete; # #914c54

      # Light variant
      lightBg = c.day.bg; # #e1e2e7
      lightBgPanel = c.day.bg_dark; # #d5d6db
      lightBgElement = c.day.bg_highlight; # #c4c8da
      lightFg = c.day.fg; # #3760bf
      lightFgDark = c.day.fg_dark; # #6172b0
      lightFgMuted = c.day.comment; # #848cb5
      lightBlue = c.day.blue; # #2e7de9
      lightCyan = c.day.cyan; # #007197
      lightMagenta = c.day.magenta; # #9854f1
      lightPurple = c.day.purple; # #7847bd
      lightOrange = c.day.orange; # #b15c00
      lightYellow = c.day.yellow; # #8c6c3e
      lightGreen = c.day.green; # #587539
      lightGreen1 = c.day.green1; # #387068
      lightRed = c.day.red; # #f52a65
      lightRed1 = c.day.red1; # #c64343
      lightGitAdd = c.day.git_add; # #399a96
      lightGitDelete = c.day.git_delete; # #c47981
    };

    theme = {
      primary = {dark = "blue"; light = "lightBlue";};
      secondary = {dark = "purple"; light = "lightPurple";};
      accent = {dark = "orange"; light = "lightOrange";};
      error = {dark = "red"; light = "lightRed";};
      warning = {dark = "orange"; light = "lightOrange";};
      success = {dark = "green"; light = "lightGreen";};
      info = {dark = "cyan"; light = "lightCyan";};
      text = {dark = "fg"; light = "lightFg";};
      textMuted = {dark = "comment"; light = "lightFgMuted";};
      background = {dark = "bg"; light = "lightBg";};
      backgroundPanel = {dark = "bgPanel"; light = "lightBgPanel";};
      backgroundElement = {dark = "bgElement"; light = "lightBgElement";};
      border = {dark = "dark5"; light = "lightFgMuted";};
      borderActive = {dark = "fgMuted"; light = "lightFgDark";};
      borderSubtle = {dark = "dark3"; light = "lightFgMuted";};

      # Diff colors
      diffAdded = {dark = "green2"; light = "lightGitAdd";};
      diffRemoved = {dark = "red1"; light = "lightRed1";};
      diffContext = {dark = "comment"; light = "lightFgMuted";};
      diffHunkHeader = {dark = "comment"; light = "lightFgMuted";};
      diffHighlightAdded = {dark = "green"; light = "lightGreen";};
      diffHighlightRemoved = {dark = "red"; light = "lightRed";};
      diffAddedBg = {dark = "#1a2b32"; light = "#d5e5d5";};
      diffRemovedBg = {dark = "#32212a"; light = "#f7d8db";};
      diffContextBg = {dark = "bgPanel"; light = "lightBgPanel";};
      diffLineNumber = {dark = "bgElement"; light = "lightBgElement";};
      diffAddedLineNumberBg = {dark = "#1b2b34"; light = "#c5d5c5";};
      diffRemovedLineNumberBg = {dark = "#2d1f26"; light = "#e7c8cb";};

      # Markdown rendering
      markdownText = {dark = "fg"; light = "lightFg";};
      markdownHeading = {dark = "magenta"; light = "lightMagenta";};
      markdownLink = {dark = "blue"; light = "lightBlue";};
      markdownLinkText = {dark = "cyan"; light = "lightCyan";};
      markdownCode = {dark = "green"; light = "lightGreen";};
      markdownBlockQuote = {dark = "yellow"; light = "lightYellow";};
      markdownEmph = {dark = "yellow"; light = "lightYellow";};
      markdownStrong = {dark = "orange"; light = "lightOrange";};
      markdownHorizontalRule = {dark = "comment"; light = "lightFgMuted";};
      markdownListItem = {dark = "blue"; light = "lightBlue";};
      markdownListEnumeration = {dark = "cyan"; light = "lightCyan";};
      markdownImage = {dark = "blue"; light = "lightBlue";};
      markdownImageText = {dark = "cyan"; light = "lightCyan";};
      markdownCodeBlock = {dark = "fg"; light = "lightFg";};

      # Syntax highlighting
      syntaxComment = {dark = "comment"; light = "lightFgMuted";};
      syntaxKeyword = {dark = "magenta"; light = "lightMagenta";};
      syntaxFunction = {dark = "blue"; light = "lightBlue";};
      syntaxVariable = {dark = "red"; light = "lightRed";};
      syntaxString = {dark = "green"; light = "lightGreen";};
      syntaxNumber = {dark = "orange"; light = "lightOrange";};
      syntaxType = {dark = "yellow"; light = "lightYellow";};
      syntaxOperator = {dark = "cyan"; light = "lightCyan";};
      syntaxPunctuation = {dark = "fg"; light = "lightFg";};
    };
  };

  tuiConfig = builtins.toJSON {
    "$schema" = "https://opencode.ai/tui.json";
    theme = "tokyo-night-nix";
    scroll_speed = 3;
    scroll_acceleration = {enabled = true;};
    diff_style = "auto";
  };

  opencodeConfig = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    model = "anthropic/claude-opus-4-6";
    permission = {"*" = "ask";};
  };
in {
  home.file.".config/opencode/themes/tokyo-night-nix.json".text = themeJson;
  home.file.".config/opencode/tui.jsonc".text = tuiConfig;
  home.file.".config/opencode/opencode.jsonc".text = opencodeConfig;
}
