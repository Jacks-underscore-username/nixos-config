{colors, ...}: let
  c = colors;

  # Generate the custom Tokyo Night theme JSON from colors.nix
  themeJson = builtins.toJSON {
    "$schema" = "https://opencode.ai/theme.json";

    defs = {
      # Background shades
      bg = c.bg;
      bgPanel = c.bg_dark;
      bgElement = c.bg_highlight;

      # Foreground
      fg = c.fg;
      fgDark = c.fg_dark;
      fgMuted = c.dark5;

      # Core palette
      blue = c.blue;
      cyan = c.cyan;
      magenta = c.magenta;
      purple = c.purple;
      orange = c.orange;
      yellow = c.yellow;
      green = c.green;
      green1 = c.green1;
      green2 = c.green2;
      red = c.red;
      red1 = c.red1;

      # Structural
      comment = c.comment;
      dark3 = c.dark3;
      dark5 = c.dark5;

      # Git
      gitAdd = c.git_add;
      gitDelete = c.git_delete;

      # Diff backgrounds
      diffAddedBg = c.diff_added_bg;
      diffRemovedBg = c.diff_removed_bg;
      diffAddedLineNumberBg = c.diff_added_line_number_bg;
      diffRemovedLineNumberBg = c.diff_removed_line_number_bg;

      # Light variant
      lightBg = c.day.bg;
      lightBgPanel = c.day.bg_dark;
      lightBgElement = c.day.bg_highlight;
      lightFg = c.day.fg;
      lightFgDark = c.day.fg_dark;
      lightFgMuted = c.day.comment;
      lightBlue = c.day.blue;
      lightCyan = c.day.cyan;
      lightMagenta = c.day.magenta;
      lightPurple = c.day.purple;
      lightOrange = c.day.orange;
      lightYellow = c.day.yellow;
      lightGreen = c.day.green;
      lightRed = c.day.red;
      lightRed1 = c.day.red1;
      lightGitAdd = c.day.git_add;
      lightGitDelete = c.day.git_delete;
      lightDiffAddedBg = c.day.diff_added_bg;
      lightDiffRemovedBg = c.day.diff_removed_bg;
      lightDiffAddedLineNumberBg = c.day.diff_added_line_number_bg;
      lightDiffRemovedLineNumberBg = c.day.diff_removed_line_number_bg;
    };

    theme = {
      primary = {
        dark = "blue";
        light = "lightBlue";
      };
      secondary = {
        dark = "purple";
        light = "lightPurple";
      };
      accent = {
        dark = "orange";
        light = "lightOrange";
      };
      error = {
        dark = "red";
        light = "lightRed";
      };
      warning = {
        dark = "orange";
        light = "lightOrange";
      };
      success = {
        dark = "green";
        light = "lightGreen";
      };
      info = {
        dark = "cyan";
        light = "lightCyan";
      };
      text = {
        dark = "fg";
        light = "lightFg";
      };
      textMuted = {
        dark = "comment";
        light = "lightFgMuted";
      };
      background = {
        dark = "bg";
        light = "lightBg";
      };
      backgroundPanel = {
        dark = "bgPanel";
        light = "lightBgPanel";
      };
      backgroundElement = {
        dark = "bgElement";
        light = "lightBgElement";
      };
      border = {
        dark = "dark5";
        light = "lightFgMuted";
      };
      borderActive = {
        dark = "fgMuted";
        light = "lightFgDark";
      };
      borderSubtle = {
        dark = "dark3";
        light = "lightFgMuted";
      };

      # Diff
      diffAdded = {
        dark = "green2";
        light = "lightGitAdd";
      };
      diffRemoved = {
        dark = "red1";
        light = "lightRed1";
      };
      diffContext = {
        dark = "comment";
        light = "lightFgMuted";
      };
      diffHunkHeader = {
        dark = "comment";
        light = "lightFgMuted";
      };
      diffHighlightAdded = {
        dark = "green";
        light = "lightGreen";
      };
      diffHighlightRemoved = {
        dark = "red";
        light = "lightRed";
      };
      diffAddedBg = {
        dark = "diffAddedBg";
        light = "lightDiffAddedBg";
      };
      diffRemovedBg = {
        dark = "diffRemovedBg";
        light = "lightDiffRemovedBg";
      };
      diffContextBg = {
        dark = "bgPanel";
        light = "lightBgPanel";
      };
      diffLineNumber = {
        dark = "bgElement";
        light = "lightBgElement";
      };
      diffAddedLineNumberBg = {
        dark = "diffAddedLineNumberBg";
        light = "lightDiffAddedLineNumberBg";
      };
      diffRemovedLineNumberBg = {
        dark = "diffRemovedLineNumberBg";
        light = "lightDiffRemovedLineNumberBg";
      };

      # Markdown
      markdownText = {
        dark = "fg";
        light = "lightFg";
      };
      markdownHeading = {
        dark = "magenta";
        light = "lightMagenta";
      };
      markdownLink = {
        dark = "blue";
        light = "lightBlue";
      };
      markdownLinkText = {
        dark = "cyan";
        light = "lightCyan";
      };
      markdownCode = {
        dark = "green";
        light = "lightGreen";
      };
      markdownBlockQuote = {
        dark = "yellow";
        light = "lightYellow";
      };
      markdownEmph = {
        dark = "yellow";
        light = "lightYellow";
      };
      markdownStrong = {
        dark = "orange";
        light = "lightOrange";
      };
      markdownHorizontalRule = {
        dark = "comment";
        light = "lightFgMuted";
      };
      markdownListItem = {
        dark = "blue";
        light = "lightBlue";
      };
      markdownListEnumeration = {
        dark = "cyan";
        light = "lightCyan";
      };
      markdownImage = {
        dark = "blue";
        light = "lightBlue";
      };
      markdownImageText = {
        dark = "cyan";
        light = "lightCyan";
      };
      markdownCodeBlock = {
        dark = "fg";
        light = "lightFg";
      };

      # Syntax
      syntaxComment = {
        dark = "comment";
        light = "lightFgMuted";
      };
      syntaxKeyword = {
        dark = "magenta";
        light = "lightMagenta";
      };
      syntaxFunction = {
        dark = "blue";
        light = "lightBlue";
      };
      syntaxVariable = {
        dark = "red";
        light = "lightRed";
      };
      syntaxString = {
        dark = "green";
        light = "lightGreen";
      };
      syntaxNumber = {
        dark = "orange";
        light = "lightOrange";
      };
      syntaxType = {
        dark = "yellow";
        light = "lightYellow";
      };
      syntaxOperator = {
        dark = "cyan";
        light = "lightCyan";
      };
      syntaxPunctuation = {
        dark = "fg";
        light = "lightFg";
      };
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
