# lib/colors.nix — Single source of truth for all theme colors.
#
# ALL color values are hardcoded here. Nothing is computed anywhere else.
# Consumers receive this attrset via `specialArgs.colors` and reference
# named tokens — no raw hex values live outside this file.
#
# Active theme: inkglow (dark, gel-pen neons on black).
# All 9 inkglow themes by creationix are available; change `active` below.
#
# Semantic token names (what every module uses):
#
#   Backgrounds (darkest → lightest)
#     bg            main editor / window background
#     bgPanel       sidebar, activity bar, status bar
#     bgDeeper      borders, tab-bar background (slightly darker than bgPanel)
#     bgElevated    line highlight, widgets, slightly raised surfaces
#     bgHighlight   selection, bracket-match, hover backgrounds
#     bgVisual      active selection / focused list item
#
#   Foregrounds
#     fg            main text
#     fgSubtle      dimmed text (line numbers active, panel titles)
#     fgMuted       very dimmed (inactive line numbers, placeholders)
#     comment       code comments
#
#   Accent palette
#     accent        primary accent — cursor, active borders, links (blue family)
#     accentAlt     secondary accent — workspace indicator fill (slightly darker accent)
#     keyword       storage / declaration keywords
#     control       control-flow keywords (if/for/return)
#     func          function names
#     string        string literals
#     type          type names
#     number        numeric literals
#     constant      constants / booleans
#     operator      operators
#     parameter     function parameters
#     variable      variable references
#     property      object properties / keys
#     tag           HTML/JSX tag names
#     special       escape sequences, interpolation punctuation
#
#   Semantic UI
#     success       added / inserted (git green)
#     warning       modified / changed (git yellow/orange)
#     error         deleted / errors (git red / error red)
#     errorBright   unmatched bracket, critical notification border
#
#   Diff backgrounds
#     diffAddedBg        inline diff added line
#     diffRemovedBg      inline diff removed line
#
#   Rainbow brackets (6 rotating colors + 1 bad-bracket color)
#     bracket1 … bracket6
#     bracketBad
#
#   Terminal ANSI
#     ansiBlack ansiRed ansiGreen ansiYellow ansiBlue ansiMagenta ansiCyan ansiWhite
#     ansiBrightBlack … ansiBrightWhite
#
#   Structural
#     indentGuide       inactive indent guide lines
#     indentGuideActive active indent guide line
#
#   Spicetify (resolved per theme)
#     spicetifyTheme        spicetify theme name string
#     spicetifyColorScheme  spicetify color scheme string
#
#   Meta
#     themeName   human label
#     themeIsDark bool — true for dark themes

let

  # ── All themes ─────────────────────────────────────────────────────────────

  themes = {

    # ── Inkglow  (dark  — gel-pen neons on black) ───────────────────────────
    inkglow = {
      themeName   = "Inkglow";
      themeIsDark = true;

      bg           = "#080808";
      bgPanel      = "#050505";
      bgDeeper     = "#000000";
      bgElevated   = "#151518";
      bgHighlight  = "#3d3d4a";
      bgVisual     = "#3d3d4a";

      fg       = "#e8e6e3";
      fgSubtle = "#8a8a95";
      fgMuted  = "#4a4a55";
      comment  = "#8877aa";

      accent    = "#77bbff";
      accentAlt = "#44aaee";
      keyword   = "#ff9944";
      control   = "#77bbff";
      func      = "#a6e22e";
      string    = "#55cc99";
      type      = "#66ccdd";
      number    = "#eebb55";
      constant  = "#9988ff";
      operator  = "#ff7755";
      parameter = "#44aaee";
      variable  = "#99ccff";
      property  = "#99ccff";
      tag       = "#55cc99";
      special   = "#77bbff";

      success     = "#a6e22e";
      warning     = "#ff9944";
      error       = "#ff7755";
      errorBright = "#ff4444";

      diffAddedBg   = "#151518";
      diffRemovedBg = "#151518";

      indentGuide       = "#2a2a30";
      indentGuideActive = "#4a4a55";

      bracket1   = "#ff9944";
      bracket2   = "#44aaee";
      bracket3   = "#cc88ee";
      bracket4   = "#55cc99";
      bracket5   = "#ff6644";
      bracket6   = "#9988ff";
      bracketBad = "#ff4444";

      ansiBlack         = "#2a2a30";
      ansiRed           = "#ff7755";
      ansiGreen         = "#55cc99";
      ansiYellow        = "#eebb55";
      ansiBlue          = "#77bbff";
      ansiMagenta       = "#cc88ee";
      ansiCyan          = "#66ccdd";
      ansiWhite         = "#8a8a95";
      ansiBrightBlack   = "#4a4a55";
      ansiBrightRed     = "#ff7755";
      ansiBrightGreen   = "#a6e22e";
      ansiBrightYellow  = "#eebb55";
      ansiBrightBlue    = "#77bbff";
      ansiBrightMagenta = "#cc88ee";
      ansiBrightCyan    = "#66ccdd";
      ansiBrightWhite   = "#e8e6e3";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Forest";
    };

    # ── Inkglow Blaze  (dark  — PICO-8 game palette) ───────────────────────
    blaze = {
      themeName   = "Inkglow Blaze";
      themeIsDark = true;

      bg           = "#000000";
      bgPanel      = "#000000";
      bgDeeper     = "#000000";
      bgElevated   = "#0d1525";
      bgHighlight  = "#1d2b53";
      bgVisual     = "#1d2b53";

      fg       = "#fff1e8";
      fgSubtle = "#c2c3c7";
      fgMuted  = "#5f574f";
      comment  = "#83769c";

      accent    = "#29adff";
      accentAlt = "#1d2b53";
      keyword   = "#ffa300";
      control   = "#29adff";
      func      = "#00e436";
      string    = "#00e436";
      type      = "#29adff";
      number    = "#ffec27";
      constant  = "#ff77a8";
      operator  = "#ff004d";
      parameter = "#29adff";
      variable  = "#c2c3c7";
      property  = "#c2c3c7";
      tag       = "#00e436";
      special   = "#29adff";

      success     = "#00e436";
      warning     = "#ffa300";
      error       = "#ff004d";
      errorBright = "#ff004d";

      diffAddedBg   = "#0d1525";
      diffRemovedBg = "#0d1525";

      indentGuide       = "#5f574f";
      indentGuideActive = "#83769c";

      bracket1   = "#ffa300";
      bracket2   = "#29adff";
      bracket3   = "#00e436";
      bracket4   = "#ffec27";
      bracket5   = "#ff77a8";
      bracket6   = "#83769c";
      bracketBad = "#ff004d";

      ansiBlack         = "#5f574f";
      ansiRed           = "#ff004d";
      ansiGreen         = "#00e436";
      ansiYellow        = "#ffec27";
      ansiBlue          = "#29adff";
      ansiMagenta       = "#ff77a8";
      ansiCyan          = "#29adff";
      ansiWhite         = "#c2c3c7";
      ansiBrightBlack   = "#83769c";
      ansiBrightRed     = "#ff004d";
      ansiBrightGreen   = "#00e436";
      ansiBrightYellow  = "#ffec27";
      ansiBrightBlue    = "#29adff";
      ansiBrightMagenta = "#ff77a8";
      ansiBrightCyan    = "#29adff";
      ansiBrightWhite   = "#fff1e8";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Forest";
    };

    # ── Inkglow Charm  (dark  — Sweetie-16 retro palette) ──────────────────
    charm = {
      themeName   = "Inkglow Charm";
      themeIsDark = true;

      bg           = "#080810";
      bgPanel      = "#050508";
      bgDeeper     = "#020204";
      bgElevated   = "#101320";
      bgHighlight  = "#29366f";
      bgVisual     = "#3b5dc9";

      fg       = "#f4f4f4";
      fgSubtle = "#94b0c2";
      fgMuted  = "#566c86";
      comment  = "#566c86";

      accent    = "#41a6f6";
      accentAlt = "#29366f";
      keyword   = "#ef7d57";
      control   = "#41a6f6";
      func      = "#a7f070";
      string    = "#38b764";
      type      = "#73eff7";
      number    = "#ffcd75";
      constant  = "#c04870";
      operator  = "#b13e53";
      parameter = "#41a6f6";
      variable  = "#94b0c2";
      property  = "#94b0c2";
      tag       = "#38b764";
      special   = "#41a6f6";

      success     = "#a7f070";
      warning     = "#ffcd75";
      error       = "#b13e53";
      errorBright = "#b13e53";

      diffAddedBg   = "#101320";
      diffRemovedBg = "#101320";

      indentGuide       = "#333c57";
      indentGuideActive = "#566c86";

      bracket1   = "#ef7d57";
      bracket2   = "#41a6f6";
      bracket3   = "#a7f070";
      bracket4   = "#ffcd75";
      bracket5   = "#73eff7";
      bracket6   = "#38b764";
      bracketBad = "#b13e53";

      ansiBlack         = "#333c57";
      ansiRed           = "#b13e53";
      ansiGreen         = "#38b764";
      ansiYellow        = "#ffcd75";
      ansiBlue          = "#41a6f6";
      ansiMagenta       = "#c04870";
      ansiCyan          = "#73eff7";
      ansiWhite         = "#94b0c2";
      ansiBrightBlack   = "#566c86";
      ansiBrightRed     = "#b13e53";
      ansiBrightGreen   = "#a7f070";
      ansiBrightYellow  = "#ffcd75";
      ansiBrightBlue    = "#41a6f6";
      ansiBrightMagenta = "#c04870";
      ansiBrightCyan    = "#73eff7";
      ansiBrightWhite   = "#f4f4f4";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Forest";
    };

    # ── Inkglow Dusk  (dark  — NA16 retro palette) ──────────────────────────
    dusk = {
      themeName   = "Inkglow Dusk";
      themeIsDark = true;

      bg           = "#080408";
      bgPanel      = "#050305";
      bgDeeper     = "#020104";
      bgElevated   = "#140e12";
      bgHighlight  = "#321a2c";
      bgVisual     = "#46374f";

      fg       = "#f7f1c8";
      fgSubtle = "#a3a5be";
      fgMuted  = "#46374f";
      comment  = "#a3a5be";

      accent    = "#98d0cd";
      accentAlt = "#46374f";
      keyword   = "#e9a961";
      control   = "#98d0cd";
      func      = "#cdd267";
      string    = "#cdd267";
      type      = "#5d9db1";
      number    = "#dfaf97";
      constant  = "#db838d";
      operator  = "#b15962";
      parameter = "#98d0cd";
      variable  = "#f7f1c8";
      property  = "#f7f1c8";
      tag       = "#cdd267";
      special   = "#98d0cd";

      success     = "#cdd267";
      warning     = "#e9a961";
      error       = "#b15962";
      errorBright = "#b15962";

      diffAddedBg   = "#140e12";
      diffRemovedBg = "#140e12";

      indentGuide       = "#321a2c";
      indentGuideActive = "#46374f";

      bracket1   = "#e9a961";
      bracket2   = "#98d0cd";
      bracket3   = "#cdd267";
      bracket4   = "#db838d";
      bracket5   = "#8d5f99";
      bracket6   = "#5d9db1";
      bracketBad = "#b15962";

      ansiBlack         = "#321a2c";
      ansiRed           = "#b15962";
      ansiGreen         = "#cdd267";
      ansiYellow        = "#e9a961";
      ansiBlue          = "#98d0cd";
      ansiMagenta       = "#db838d";
      ansiCyan          = "#5d9db1";
      ansiWhite         = "#a3a5be";
      ansiBrightBlack   = "#46374f";
      ansiBrightRed     = "#b15962";
      ansiBrightGreen   = "#cdd267";
      ansiBrightYellow  = "#e9a961";
      ansiBrightBlue    = "#98d0cd";
      ansiBrightMagenta = "#db838d";
      ansiBrightCyan    = "#5d9db1";
      ansiBrightWhite   = "#f7f1c8";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Forest";
    };

    # ── Inkglow Frost  (light — Sweetie-16 retro palette) ──────────────────
    frost = {
      themeName   = "Inkglow Frost";
      themeIsDark = false;

      bg           = "#f4f4f4";
      bgPanel      = "#e8eef2";
      bgDeeper     = "#dde4e8";
      bgElevated   = "#e8eef2";
      bgHighlight  = "#94b0c2";
      bgVisual     = "#94b0c2";

      fg       = "#1a1c2c";
      fgSubtle = "#566c86";
      fgMuted  = "#94b0c2";
      comment  = "#566c86";

      accent    = "#3b5dc9";
      accentAlt = "#29366f";
      keyword   = "#b13e53";
      control   = "#3b5dc9";
      func      = "#38b764";
      string    = "#257179";
      type      = "#257179";
      number    = "#b13e53";
      constant  = "#5d275d";
      operator  = "#5d275d";
      parameter = "#3b5dc9";
      variable  = "#333c57";
      property  = "#333c57";
      tag       = "#257179";
      special   = "#3b5dc9";

      success     = "#38b764";
      warning     = "#ef7d57";
      error       = "#b13e53";
      errorBright = "#b13e53";

      diffAddedBg   = "#e8eef2";
      diffRemovedBg = "#e8eef2";

      indentGuide       = "#94b0c2";
      indentGuideActive = "#566c86";

      bracket1   = "#b13e53";
      bracket2   = "#29366f";
      bracket3   = "#257179";
      bracket4   = "#5d275d";
      bracket5   = "#3b5dc9";
      bracket6   = "#38b764";
      bracketBad = "#b13e53";

      ansiBlack         = "#94b0c2";
      ansiRed           = "#b13e53";
      ansiGreen         = "#38b764";
      ansiYellow        = "#ef7d57";
      ansiBlue          = "#3b5dc9";
      ansiMagenta       = "#5d275d";
      ansiCyan          = "#257179";
      ansiWhite         = "#566c86";
      ansiBrightBlack   = "#94b0c2";
      ansiBrightRed     = "#b13e53";
      ansiBrightGreen   = "#38b764";
      ansiBrightYellow  = "#ef7d57";
      ansiBrightBlue    = "#3b5dc9";
      ansiBrightMagenta = "#5d275d";
      ansiBrightCyan    = "#257179";
      ansiBrightWhite   = "#1a1c2c";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Default";
    };

    # ── Inkglow Gilt  (light — NA16 retro palette) ──────────────────────────
    gilt = {
      themeName   = "Inkglow Gilt";
      themeIsDark = false;

      bg           = "#f5edba";
      bgPanel      = "#ede3a0";
      bgDeeper     = "#d79b7d";
      bgElevated   = "#e8e0a8";
      bgHighlight  = "#d79b7d";
      bgVisual     = "#9a6348";

      fg       = "#1f0e1c";
      fgSubtle = "#584563";
      fgMuted  = "#9a6348";
      comment  = "#584563";

      accent    = "#17434b";
      accentAlt = "#34859d";
      keyword   = "#9d303b";
      control   = "#17434b";
      func      = "#647d34";
      string    = "#647d34";
      type      = "#34859d";
      number    = "#9a6348";
      constant  = "#9d303b";
      operator  = "#70377f";
      parameter = "#34859d";
      variable  = "#3e2137";
      property  = "#3e2137";
      tag       = "#647d34";
      special   = "#17434b";

      success     = "#647d34";
      warning     = "#9a6348";
      error       = "#9d303b";
      errorBright = "#9d303b";

      diffAddedBg   = "#e8e0a8";
      diffRemovedBg = "#e8e0a8";

      indentGuide       = "#d79b7d";
      indentGuideActive = "#9a6348";

      bracket1   = "#9d303b";
      bracket2   = "#17434b";
      bracket3   = "#647d34";
      bracket4   = "#70377f";
      bracket5   = "#34859d";
      bracket6   = "#584563";
      bracketBad = "#9d303b";

      ansiBlack         = "#d79b7d";
      ansiRed           = "#9d303b";
      ansiGreen         = "#647d34";
      ansiYellow        = "#9a6348";
      ansiBlue          = "#17434b";
      ansiMagenta       = "#70377f";
      ansiCyan          = "#34859d";
      ansiWhite         = "#584563";
      ansiBrightBlack   = "#9a6348";
      ansiBrightRed     = "#9d303b";
      ansiBrightGreen   = "#647d34";
      ansiBrightYellow  = "#9a6348";
      ansiBrightBlue    = "#17434b";
      ansiBrightMagenta = "#70377f";
      ansiBrightCyan    = "#34859d";
      ansiBrightWhite   = "#1f0e1c";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Default";
    };

    # ── Inkglow Hearth  (light — PICO-8 game palette) ───────────────────────
    hearth = {
      themeName   = "Inkglow Hearth";
      themeIsDark = false;

      bg           = "#fff1e8";
      bgPanel      = "#ffccaa";
      bgDeeper     = "#f0c090";
      bgElevated   = "#ffe8d0";
      bgHighlight  = "#ffccaa";
      bgVisual     = "#c2c3c7";

      fg       = "#000000";
      fgSubtle = "#5f574f";
      fgMuted  = "#83769c";
      comment  = "#83769c";

      accent    = "#1d2b53";
      accentAlt = "#1d2b53";
      keyword   = "#ab5236";
      control   = "#1d2b53";
      func      = "#008751";
      string    = "#008751";
      type      = "#1d2b53";
      number    = "#ab5236";
      constant  = "#7e2553";
      operator  = "#7e2553";
      parameter = "#1d2b53";
      variable  = "#5f574f";
      property  = "#5f574f";
      tag       = "#008751";
      special   = "#1d2b53";

      success     = "#008751";
      warning     = "#ab5236";
      error       = "#ff004d";
      errorBright = "#ff004d";

      diffAddedBg   = "#ffe8d0";
      diffRemovedBg = "#ffe8d0";

      indentGuide       = "#c2c3c7";
      indentGuideActive = "#83769c";

      bracket1   = "#ab5236";
      bracket2   = "#1d2b53";
      bracket3   = "#008751";
      bracket4   = "#7e2553";
      bracket5   = "#5f574f";
      bracket6   = "#83769c";
      bracketBad = "#ff004d";

      ansiBlack         = "#c2c3c7";
      ansiRed           = "#ff004d";
      ansiGreen         = "#008751";
      ansiYellow        = "#ab5236";
      ansiBlue          = "#1d2b53";
      ansiMagenta       = "#7e2553";
      ansiCyan          = "#1d2b53";
      ansiWhite         = "#5f574f";
      ansiBrightBlack   = "#83769c";
      ansiBrightRed     = "#ff004d";
      ansiBrightGreen   = "#008751";
      ansiBrightYellow  = "#ab5236";
      ansiBrightBlue    = "#1d2b53";
      ansiBrightMagenta = "#7e2553";
      ansiBrightCyan    = "#1d2b53";
      ansiBrightWhite   = "#000000";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Default";
    };

    # ── Inkglow Quill  (light — warm earthtone inks) ────────────────────────
    quill = {
      themeName   = "Inkglow Quill";
      themeIsDark = false;

      bg           = "#faf8f5";
      bgPanel      = "#f5f3f0";
      bgDeeper     = "#f0ede8";
      bgElevated   = "#f0ede8";
      bgHighlight  = "#d4e5ff";
      bgVisual     = "#d4e5ff";

      fg       = "#2d2a26";
      fgSubtle = "#606060";
      fgMuted  = "#a0a0a0";
      comment  = "#8a7b99";

      accent    = "#1a6b9a";
      accentAlt = "#2868a0";
      keyword   = "#c45020";
      control   = "#1a6b9a";
      func      = "#6b6020";
      string    = "#2a7a50";
      type      = "#b35900";
      number    = "#9a6a20";
      constant  = "#5050a0";
      operator  = "#0d7377";
      parameter = "#8b6b00";
      variable  = "#2a5580";
      property  = "#2a5580";
      tag       = "#2a7a50";
      special   = "#1a6b9a";

      success     = "#2a7a50";
      warning     = "#9a6a20";
      error       = "#cc3333";
      errorBright = "#cc3333";

      diffAddedBg   = "#f0ede8";
      diffRemovedBg = "#f0ede8";

      indentGuide       = "#e0ddd8";
      indentGuideActive = "#c0bdb8";

      bracket1   = "#8b6914";
      bracket2   = "#2868a0";
      bracket3   = "#7b4b90";
      bracket4   = "#2a7a50";
      bracket5   = "#a04050";
      bracket6   = "#407080";
      bracketBad = "#cc3333";

      ansiBlack         = "#e0ddd8";
      ansiRed           = "#cc3333";
      ansiGreen         = "#2a7a50";
      ansiYellow        = "#9a6a20";
      ansiBlue          = "#1a6b9a";
      ansiMagenta       = "#8b4580";
      ansiCyan          = "#0d7377";
      ansiWhite         = "#606060";
      ansiBrightBlack   = "#c0bdb8";
      ansiBrightRed     = "#cc3333";
      ansiBrightGreen   = "#2a7a50";
      ansiBrightYellow  = "#9a6a20";
      ansiBrightBlue    = "#1a6b9a";
      ansiBrightMagenta = "#8b4580";
      ansiBrightCyan    = "#0d7377";
      ansiBrightWhite   = "#2d2a26";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Default";
    };

    # ── Inkglow Storm  (light — blue/orange contrast) ───────────────────────
    storm = {
      themeName   = "Inkglow Storm";
      themeIsDark = false;

      bg           = "#faf8f5";
      bgPanel      = "#f5f3f0";
      bgDeeper     = "#f0ede8";
      bgElevated   = "#f0ede8";
      bgHighlight  = "#d4e5ff";
      bgVisual     = "#d4e5ff";

      fg       = "#2d2a26";
      fgSubtle = "#606060";
      fgMuted  = "#a0a0a0";
      comment  = "#887799";

      accent    = "#2255aa";
      accentAlt = "#2266aa";
      keyword   = "#cc6622";
      control   = "#2255aa";
      func      = "#338833";
      string    = "#228855";
      type      = "#227799";
      number    = "#996622";
      constant  = "#5544aa";
      operator  = "#bb5533";
      parameter = "#2266aa";
      variable  = "#335588";
      property  = "#335588";
      tag       = "#228855";
      special   = "#2255aa";

      success     = "#228855";
      warning     = "#996622";
      error       = "#cc2222";
      errorBright = "#cc2222";

      diffAddedBg   = "#f0ede8";
      diffRemovedBg = "#f0ede8";

      indentGuide       = "#e0ddd8";
      indentGuideActive = "#c0bdb8";

      bracket1   = "#cc6622";
      bracket2   = "#2266aa";
      bracket3   = "#884488";
      bracket4   = "#228855";
      bracket5   = "#cc4422";
      bracket6   = "#5544aa";
      bracketBad = "#cc2222";

      ansiBlack         = "#e0ddd8";
      ansiRed           = "#cc2222";
      ansiGreen         = "#228855";
      ansiYellow        = "#996622";
      ansiBlue          = "#2255aa";
      ansiMagenta       = "#884488";
      ansiCyan          = "#227799";
      ansiWhite         = "#606060";
      ansiBrightBlack   = "#c0bdb8";
      ansiBrightRed     = "#cc2222";
      ansiBrightGreen   = "#228855";
      ansiBrightYellow  = "#996622";
      ansiBrightBlue    = "#2255aa";
      ansiBrightMagenta = "#884488";
      ansiBrightCyan    = "#227799";
      ansiBrightWhite   = "#2d2a26";

      spicetifyTheme       = "starryNight";
      spicetifyColorScheme = "Default";
    };

  };

  # ── Active theme selection ──────────────────────────────────────────────────
  # Change this to any key in `themes` to switch the active theme:
  #   inkglow  blaze  charm  dusk  frost  gilt  hearth  quill  storm
  active = themes.inkglow;

in
  active // { inherit themes; }
