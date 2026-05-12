{
  pkgs,
  inputs,
  colors,
  ...
}: let
  c = colors;
  qmlDir = ./quickshell;

  themeQml = pkgs.writeText "Theme.qml" ''
    pragma Singleton
    import Quickshell
    import QtQuick

    Singleton {
      readonly property color bg: "${c.bg}"
      readonly property color bgPanel: "${c.bgPanel}"
      readonly property color bgDeeper: "${c.bgDeeper}"
      readonly property color bgElevated: "${c.bgElevated}"
      readonly property color bgHighlight: "${c.bgHighlight}"
      readonly property color bgVisual: "${c.bgVisual}"

      readonly property color fg: "${c.fg}"
      readonly property color fgDark: "${c.fgSubtle}"
      readonly property color fgMuted: "${c.fgMuted}"
      readonly property color comment: "${c.comment}"

      readonly property color accent: "${c.accent}"
      readonly property color accentAlt: "${c.accentAlt}"
      readonly property color keyword: "${c.keyword}"
      readonly property color func: "${c.func}"
      readonly property color string: "${c.string}"
      readonly property color type: "${c.type}"
      readonly property color number: "${c.number}"
      readonly property color constant: "${c.constant}"
      readonly property color operator: "${c.operator}"
      readonly property color special: "${c.special}"

      readonly property color success: "${c.success}"
      readonly property color warning: "${c.warning}"
      readonly property color error: "${c.error}"
      readonly property color errorBright: "${c.errorBright}"

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
