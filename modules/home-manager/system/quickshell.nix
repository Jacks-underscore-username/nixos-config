{
  pkgs,
  inputs,
  colors,
  ...
}: let
  c = colors;
  qmlDir = ./quickshell;

  # Theme.qml is the only file that needs Nix interpolation (colors).
  # All other QML files are copied verbatim from ./quickshell/.
  themeQml = pkgs.writeText "Theme.qml" ''
    pragma Singleton
    import Quickshell
    import QtQuick

    Singleton {
      // Background shades
      readonly property color bgWindow: "${c.bg_window}"
      readonly property color bgDark: "${c.bg_dark}"
      readonly property color bg: "${c.bg}"
      readonly property color bgFloat: "${c.bg_float}"
      readonly property color bgHighlight: "${c.bg_highlight}"
      readonly property color bgVisual: "${c.bg_visual}"
      readonly property color bgSearch: "${c.bg_search}"
      readonly property color bgSurface: "${c.bg_surface}"
      readonly property color bgElevated: "${c.bg_elevated}"
      readonly property color bgOverlay: "${c.bg_overlay}"
      readonly property color bgActive: "${c.bg_active}"

      // Foreground
      readonly property color fg: "${c.fg}"
      readonly property color fgDark: "${c.fg_dark}"
      readonly property color fgMuted: "${c.fg_muted}"
      readonly property color fgComment: "${c.fg_comment}"

      // Core palette
      readonly property color blue: "${c.blue}"
      readonly property color blue0: "${c.blue0}"
      readonly property color blue1: "${c.blue1}"
      readonly property color cyan: "${c.cyan}"
      readonly property color magenta: "${c.magenta}"
      readonly property color purple: "${c.purple}"
      readonly property color orange: "${c.orange}"
      readonly property color yellow: "${c.yellow}"
      readonly property color green: "${c.green}"
      readonly property color green1: "${c.green1}"
      readonly property color teal: "${c.teal}"
      readonly property color red: "${c.red}"
      readonly property color red1: "${c.red1}"

      // Misc
      readonly property color comment: "${c.comment}"
      readonly property color borderHighlight: "${c.border_highlight}"
      readonly property color border: "${c.border}"
      readonly property color selection: "${c.selection}"
      readonly property color terminalBlack: "${c.terminal_black}"

      // Font
      readonly property string fontFamily: "FiraCode Nerd Font"
      readonly property int fontSize: 13
      readonly property int fontSizeSmall: 11
    }
  '';

  quickshellConfig = pkgs.runCommandLocal "quickshell-config" {} ''
    mkdir -p $out
    cp ${themeQml} $out/Theme.qml
    cp ${qmlDir}/shell.qml $out/shell.qml
    cp ${qmlDir}/Bar.qml $out/Bar.qml
    cp ${qmlDir}/Notifications.qml $out/Notifications.qml
    cp ${qmlDir}/Launcher.qml $out/Launcher.qml
  '';
in {
  home.packages = [
    inputs.quickshell.packages.x86_64-linux.default
  ];

  xdg.configFile."quickshell".source = quickshellConfig;
}
