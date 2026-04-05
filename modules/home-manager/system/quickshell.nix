{
  pkgs,
  inputs,
  colors,
  ...
}: let
  c = colors;

  # Build all QML files into a single directory derivation so quickshell
  # can resolve sibling types (Bar, Notifications, Launcher, Theme) correctly.
  # Individual writeText files end up in separate /nix/store paths, breaking
  # QML type resolution when quickshell follows the symlink.
  quickshellConfig = pkgs.runCommandLocal "quickshell-config" {} ''
    mkdir -p $out

    # Theme.qml — Singleton with all Tokyo Night colors from colors.nix
    cat > $out/Theme.qml << 'THEMEEOF'
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
    THEMEEOF

    # shell.qml — entry point
    cat > $out/shell.qml << 'SHELLEOF'
    import Quickshell

    ShellRoot {
      Bar {}
      Notifications {}
      Launcher {}
    }
    SHELLEOF

    # Bar.qml — status bar
    cat > $out/Bar.qml << 'BAREOF'
    import Quickshell
    import Quickshell.Hyprland
    import QtQuick
    import QtQuick.Layouts

    Scope {
      id: root

      readonly property string time: Qt.formatDateTime(clock.date, "HH:mm")
      readonly property string dateStr: Qt.formatDateTime(clock.date, "ddd MMM d")

      SystemClock {
        id: clock
        precision: SystemClock.Minutes
      }

      Variants {
        model: Quickshell.screens

        PanelWindow {
          required property var modelData
          screen: modelData

          anchors {
            top: true
            left: true
            right: true
          }
          implicitHeight: 38
          color: "transparent"

          Rectangle {
            anchors.fill: parent
            color: Theme.bgDark
            opacity: 0.85

            RowLayout {
              anchors.fill: parent
              anchors.leftMargin: 12
              anchors.rightMargin: 12
              spacing: 0

              // Left: workspaces
              RowLayout {
                Layout.alignment: Qt.AlignLeft
                spacing: 4

                Repeater {
                  model: Hyprland.workspaces

                  delegate: Rectangle {
                    required property var modelData
                    width: 28; height: 22
                    radius: 6
                    color: modelData.id === Hyprland.focusedMonitor?.activeWorkspace?.id
                      ? Theme.blue0 : "transparent"

                    Text {
                      anchors.centerIn: parent
                      text: modelData.name ?? modelData.id.toString()
                      font.family: Theme.fontFamily
                      font.pixelSize: Theme.fontSizeSmall
                      color: modelData.id === Hyprland.focusedMonitor?.activeWorkspace?.id
                        ? Theme.fg : Theme.comment
                    }

                    MouseArea {
                      anchors.fill: parent
                      onClicked: Hyprland.dispatch("workspace " + modelData.id)
                    }
                  }
                }
              }

              // Center: clock
              Item { Layout.fillWidth: true }
              Text {
                Layout.alignment: Qt.AlignCenter
                text: root.time
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                color: Theme.blue
              }
              Item { Layout.fillWidth: true }

              // Right: date
              RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 16

                Text {
                  text: root.dateStr
                  font.family: Theme.fontFamily
                  font.pixelSize: Theme.fontSizeSmall
                  color: Theme.fgDark
                }
              }
            }
          }
        }
      }
    }
    BAREOF

    # Notifications.qml — notification popups
    cat > $out/Notifications.qml << 'NOTIFEOF'
    import Quickshell
    import Quickshell.Services.Notifications
    import QtQuick
    import QtQuick.Layouts

    Scope {
      id: root

      property list<Notification> popups: []

      NotificationServer {
        id: server
        bodySupported: true
        bodyMarkupSupported: true
        imageSupported: true
        actionsSupported: true
        keepOnReload: false

        onNotification: (notification) => {
          notification.tracked = true;
          let newList = [notification];
          for (let i = 0; i < root.popups.length && newList.length < 5; i++) {
            newList.push(root.popups[i]);
          }
          root.popups = newList;

          // Auto-dismiss non-critical after 5 seconds
          if (notification.urgency !== NotificationUrgency.Critical) {
            dismissTimer.createObject(root, {
              notification: notification,
              interval: 5000
            });
          }
        }
      }

      Component {
        id: dismissTimer
        Timer {
          required property Notification notification
          running: true
          repeat: false
          onTriggered: {
            notification.tracked = false;
            let filtered = [];
            for (let i = 0; i < root.popups.length; i++) {
              if (root.popups[i] !== notification) filtered.push(root.popups[i]);
            }
            root.popups = filtered;
            this.destroy();
          }
        }
      }

      Variants {
        model: Quickshell.screens

        PanelWindow {
          required property var modelData
          screen: modelData

          anchors {
            top: true
            right: true
          }
          implicitWidth: 380
          implicitHeight: notifColumn.implicitHeight + 16
          color: "transparent"
          exclusionMode: ExclusionMode.Ignore

          margins {
            top: 44
            right: 8
          }

          ColumnLayout {
            id: notifColumn
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            Repeater {
              model: root.popups

              delegate: Rectangle {
                required property var modelData
                Layout.fillWidth: true
                Layout.preferredHeight: notifContent.implicitHeight + 24
                radius: 10
                color: Theme.bgDark
                border.width: 1
                border.color: modelData.urgency === NotificationUrgency.Critical
                  ? Theme.red : Theme.bgHighlight

                ColumnLayout {
                  id: notifContent
                  anchors.fill: parent
                  anchors.margins: 12
                  spacing: 4

                  Text {
                    Layout.fillWidth: true
                    text: modelData.summary ?? ""
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    font.bold: true
                    color: Theme.fg
                    elide: Text.ElideRight
                  }

                  Text {
                    Layout.fillWidth: true
                    text: modelData.body ?? ""
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.fgDark
                    wrapMode: Text.WordWrap
                    maximumLineCount: 3
                    elide: Text.ElideRight
                    textFormat: Text.PlainText
                  }
                }

                MouseArea {
                  anchors.fill: parent
                  onClicked: {
                    modelData.tracked = false;
                    let filtered = [];
                    for (let i = 0; i < root.popups.length; i++) {
                      if (root.popups[i] !== modelData) filtered.push(root.popups[i]);
                    }
                    root.popups = filtered;
                  }
                }
              }
            }
          }
        }
      }
    }
    NOTIFEOF

    # Launcher.qml — app launcher triggered via IPC
    cat > $out/Launcher.qml << 'LAUNCHEOF'
    import Quickshell
    import Quickshell.Io
    import QtQuick
    import QtQuick.Layouts

    Scope {
      id: root
      property bool showing: false
      property string searchText: ""

      property var filteredEntries: {
        let apps = DesktopEntries.applications.values;
        let query = searchText.toLowerCase();
        if (query === "") return apps;
        let result = [];
        for (let i = 0; i < apps.length; i++) {
          let name = apps[i].name ?? "";
          if (name.toLowerCase().indexOf(query) !== -1) result.push(apps[i]);
        }
        return result;
      }

      IpcHandler {
        target: "launcher"

        function toggle(): void {
          root.showing = !root.showing;
          if (root.showing) {
            root.searchText = "";
          }
        }
      }

      FloatingWindow {
        visible: root.showing
        color: "transparent"
        implicitWidth: 500
        implicitHeight: 450

        Rectangle {
          anchors.fill: parent
          radius: 12
          color: Theme.bgDark
          border.width: 2
          border.color: Theme.bgHighlight

          ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            // Search input
            Rectangle {
              Layout.fillWidth: true
              Layout.preferredHeight: 40
              radius: 8
              color: Theme.bg
              border.width: 1
              border.color: searchInput.activeFocus ? Theme.blue : Theme.bgHighlight

              TextInput {
                id: searchInput
                anchors.fill: parent
                anchors.margins: 10
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                color: Theme.fg
                clip: true
                focus: root.showing

                onTextChanged: root.searchText = text

                Text {
                  anchors.fill: parent
                  text: "Search..."
                  font: searchInput.font
                  color: Theme.comment
                  visible: !searchInput.text && !searchInput.activeFocus
                }

                Keys.onEscapePressed: root.showing = false
                Keys.onReturnPressed: {
                  if (root.filteredEntries.length > 0) {
                    root.filteredEntries[0].execute();
                    root.showing = false;
                  }
                }
              }
            }

            // Results list
            ListView {
              Layout.fillWidth: true
              Layout.fillHeight: true
              clip: true
              model: root.filteredEntries
              spacing: 4

              delegate: Rectangle {
                required property var modelData
                required property int index
                width: ListView.view.width
                height: 40
                radius: 8
                color: delegateMouse.containsMouse ? Theme.bgVisual : "transparent"

                RowLayout {
                  anchors.fill: parent
                  anchors.leftMargin: 12
                  anchors.rightMargin: 12
                  spacing: 10

                  Text {
                    Layout.fillWidth: true
                    text: modelData.name ?? ""
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                    color: Theme.fg
                    elide: Text.ElideRight
                  }
                }

                MouseArea {
                  id: delegateMouse
                  anchors.fill: parent
                  hoverEnabled: true
                  onClicked: {
                    modelData.execute();
                    root.showing = false;
                  }
                }
              }
            }
          }
        }
      }
    }
    LAUNCHEOF
  '';
in {
  home.packages = [
    inputs.quickshell.packages.x86_64-linux.default
  ];

  # Symlink the entire directory so quickshell sees all QML files as siblings
  xdg.configFile."quickshell".source = quickshellConfig;
}
