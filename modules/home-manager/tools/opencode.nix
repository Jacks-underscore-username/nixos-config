{
  pkgs,
  lib,
  config,
  colors,
  ...
}: let
  c = colors;
  # light counterpart: use inkglow-storm (the light blue/orange theme)
  l = colors.themes.storm;
  jq = "${pkgs.jq}/bin/jq";

  nixRepoDir = "/persist/nixos";
  opencodeDir = "${config.home.homeDirectory}/.config/opencode";

  # Paths in the Nix repo (saved runtime state)
  savedTuiPath = "${nixRepoDir}/configs/opencode-tui.json";
  savedConfigPath = "${nixRepoDir}/configs/opencode-config.json";

  # Runtime paths
  runtimeTuiPath = "${opencodeDir}/tui.json";
  runtimeConfigPath = "${opencodeDir}/opencode.json";

  # Nix-managed keys for tui.json (theme always wins)
  # Written to files in the Nix store to avoid shell quoting issues
  nixManagedTuiFile = pkgs.writeText "opencode-nix-managed-tui.json" (builtins.toJSON {
    "$schema" = "https://opencode.ai/tui.json";
    theme = "inkglow-nix";
  });

  # Nix-managed keys for opencode.json (model/permission always win)
  nixManagedConfigFile = pkgs.writeText "opencode-nix-managed-config.json" (builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    model = "anthropic/claude-opus-4-6";
    permission = {"*" = "ask";};
  });

  # The theme file is fully Nix-generated (immutable, symlink is fine)
  themeJson = builtins.toJSON {
    "$schema" = "https://opencode.ai/theme.json";

    defs = {
      # Backgrounds
      bg = c.bg;
      bgPanel = c.bgPanel;
      bgElement = c.bgHighlight;

      # Foregrounds
      fg = c.fg;
      fgDark = c.fgSubtle;
      fgMuted = c.fgMuted;

      # Core palette
      accent = c.accent;
      type = c.type;
      constant = c.constant;
      keyword = c.keyword;
      number = c.number;
      string = c.string;
      func = c.func;
      error = c.error;
      errorBright = c.errorBright;

      # Semantic
      comment = c.comment;
      success = c.success;
      warning = c.warning;

      # Git / diff
      gitAdd = c.success;
      gitDelete = c.error;

      diffAddedBg = c.diffAddedBg;
      diffRemovedBg = c.diffRemovedBg;

      # Light variant (inkglow-storm)
      lightBg = l.bg;
      lightBgPanel = l.bgPanel;
      lightBgElement = l.bgHighlight;
      lightFg = l.fg;
      lightFgDark = l.fgSubtle;
      lightFgMuted = l.comment;
      lightAccent = l.accent;
      lightType = l.type;
      lightConstant = l.constant;
      lightKeyword = l.keyword;
      lightString = l.string;
      lightFunc = l.func;
      lightError = l.error;
      lightSuccess = l.success;
      lightWarning = l.warning;
      lightGitAdd = l.success;
      lightGitDelete = l.error;
      lightDiffAddedBg = l.diffAddedBg;
      lightDiffRemovedBg = l.diffRemovedBg;
    };

    theme = {
      primary = {
        dark = "accent";
        light = "lightAccent";
      };
      secondary = {
        dark = "constant";
        light = "lightConstant";
      };
      accent = {
        dark = "keyword";
        light = "lightKeyword";
      };
      error = {
        dark = "error";
        light = "lightError";
      };
      warning = {
        dark = "warning";
        light = "lightWarning";
      };
      success = {
        dark = "success";
        light = "lightSuccess";
      };
      info = {
        dark = "type";
        light = "lightType";
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
        dark = "fgMuted";
        light = "lightFgMuted";
      };
      borderActive = {
        dark = "fgDark";
        light = "lightFgDark";
      };
      borderSubtle = {
        dark = "comment";
        light = "lightFgMuted";
      };

      diffAdded = {
        dark = "success";
        light = "lightSuccess";
      };
      diffRemoved = {
        dark = "errorBright";
        light = "lightError";
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
        dark = "func";
        light = "lightFunc";
      };
      diffHighlightRemoved = {
        dark = "error";
        light = "lightError";
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
        dark = "diffAddedBg";
        light = "lightDiffAddedBg";
      };
      diffRemovedLineNumberBg = {
        dark = "diffRemovedBg";
        light = "lightDiffRemovedBg";
      };

      markdownText = {
        dark = "fg";
        light = "lightFg";
      };
      markdownHeading = {
        dark = "constant";
        light = "lightConstant";
      };
      markdownLink = {
        dark = "accent";
        light = "lightAccent";
      };
      markdownLinkText = {
        dark = "type";
        light = "lightType";
      };
      markdownCode = {
        dark = "string";
        light = "lightString";
      };
      markdownBlockQuote = {
        dark = "number";
        light = "lightWarning";
      };
      markdownEmph = {
        dark = "number";
        light = "lightWarning";
      };
      markdownStrong = {
        dark = "keyword";
        light = "lightKeyword";
      };
      markdownHorizontalRule = {
        dark = "comment";
        light = "lightFgMuted";
      };
      markdownListItem = {
        dark = "accent";
        light = "lightAccent";
      };
      markdownListEnumeration = {
        dark = "type";
        light = "lightType";
      };
      markdownImage = {
        dark = "accent";
        light = "lightAccent";
      };
      markdownImageText = {
        dark = "type";
        light = "lightType";
      };
      markdownCodeBlock = {
        dark = "fg";
        light = "lightFg";
      };

      syntaxComment = {
        dark = "comment";
        light = "lightFgMuted";
      };
      syntaxKeyword = {
        dark = "constant";
        light = "lightConstant";
      };
      syntaxFunction = {
        dark = "func";
        light = "lightFunc";
      };
      syntaxVariable = {
        dark = "error";
        light = "lightError";
      };
      syntaxString = {
        dark = "string";
        light = "lightString";
      };
      syntaxNumber = {
        dark = "keyword";
        light = "lightKeyword";
      };
      syntaxType = {
        dark = "number";
        light = "lightWarning";
      };
      syntaxOperator = {
        dark = "type";
        light = "lightType";
      };
      syntaxPunctuation = {
        dark = "fg";
        light = "lightFg";
      };
    };
  };
in {
  home.file.".config/opencode/themes/inkglow-nix.json".text = themeJson;

  home.activation.opencodeSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    merge_config() {
      local saved="$1" nix_file="$2" runtime="$3"

      if [ -f "$saved" ]; then
        base=$(cat "$saved")
      else
        base='{}'
      fi

      merged=$(echo "$base" | ${jq} --argjson nix "$(cat "$nix_file")" '. * $nix')

      # Remove existing symlink if home-manager left one
      [ -L "$runtime" ] && rm -f "$runtime"

      mkdir -p "$(dirname "$runtime")"
      echo "$merged" | ${jq} '.' > "$runtime"
    }

    merge_config "${savedTuiPath}" "${nixManagedTuiFile}" "${runtimeTuiPath}"
    merge_config "${savedConfigPath}" "${nixManagedConfigFile}" "${runtimeConfigPath}"
  '';

  systemd.user.services.opencode-settings-save = {
    Unit = {
      Description = "Save OpenCode configs back to Nix repo on shutdown";
      DefaultDependencies = false;
      Before = ["shutdown.target"];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/true";
      ExecStop = pkgs.writeShellScript "opencode-settings-save" ''
        save_config() {
          local runtime="$1" saved="$2"
          if [ -f "$runtime" ] && [ ! -L "$runtime" ]; then
            ${jq} '.' "$runtime" > "$saved.tmp" && mv "$saved.tmp" "$saved"
          fi
        }

        save_config "${runtimeTuiPath}" "${savedTuiPath}"
        save_config "${runtimeConfigPath}" "${savedConfigPath}"
      '';
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
