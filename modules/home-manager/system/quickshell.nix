{
  pkgs,
  inputs,
  colors,
  ...
}: let
  c = colors;

  # Generate Theme.qml singleton with all colors from colors.nix
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

  # shell.qml — entry point
  shellQml = pkgs.writeText "shell.qml" ''
    import Quickshell

    ShellRoot {
      Bar {}
      Notifications {}
    }
  '';

  # Bar.qml — status bar (replaces waybar)
  barQml = pkgs.writeText "Bar.qml" ''
    import Quickshell
    import Quickshell.Hyprland
    import Quickshell.Services.Pipewire
    import Quickshell.Services.UPower
    import QtQuick
    import QtQuick.Layouts

    Scope {
      id: root

      readonly property string time: Qt.formatDateTime(clock.date, "HH:mm")
      readonly property string date_: Qt.formatDateTime(clock.date, "ddd MMM d")

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
            anchors.margins: 0
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
                      text: modelData.name ?? modelData.id
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

              // Right: status indicators
              RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 16

                // Date
                Text {
                  text: root.date_
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
  '';

  # Notifications.qml — notification display (replaces dunst)
  notificationsQml = pkgs.writeText "Notifications.qml" ''
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
          root.popups = [notification, ...root.popups].slice(0, 5);

          // Auto-dismiss based on urgency
          let timeout = notification.urgency === NotificationUrgency.Critical ? 0 : 5000;
          if (timeout > 0) {
            Qt.callLater(() => {
              dismissTimer.createObject(root, {
                notification: notification,
                interval: timeout
              });
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
            root.popups = root.popups.filter(n => n !== notification);
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
          aboveWindows: true

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
                    root.popups = root.popups.filter(n => n !== modelData);
                  }
                }
              }
            }
          }
        }
      }
    }
  '';

  # Launcher.qml — app launcher (replaces wofi)
  # Triggered via quickshell IPC from a keybind
  launcherQml = pkgs.writeText "Launcher.qml" ''
    import Quickshell
    import Quickshell.Io
    import Quickshell.Hyprland
    import QtQuick
    import QtQuick.Layouts

    Scope {
      id: root
      property bool visible: false
      property string searchText: ""
      property var allEntries: DesktopEntries.applications
      property var filteredEntries: {
        let query = searchText.toLowerCase();
        if (query === "") return allEntries;
        return allEntries.filter(entry =>
          (entry.name ?? "").toLowerCase().includes(query)
        );
      }

      IpcHandler {
        target: "launcher"
        onMessage: (msg, responder) => {
          root.visible = !root.visible;
          if (root.visible) {
            root.searchText = "";
          }
          responder.respond("");
        }
      }

      FloatingWindow {
        visible: root.visible
        color: "transparent"
        width: 500
        height: 450

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
                focus: root.visible

                onTextChanged: root.searchText = text

                Text {
                  anchors.fill: parent
                  text: "Search..."
                  font: searchInput.font
                  color: Theme.comment
                  visible: !searchInput.text && !searchInput.activeFocus
                }

                Keys.onEscapePressed: root.visible = false
                Keys.onReturnPressed: {
                  if (root.filteredEntries.length > 0) {
                    root.filteredEntries[0].execute();
                    root.visible = false;
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
                    root.visible = false;
                  }
                }
              }
            }
          }
        }
      }
    }
  '';
in {
  home.packages = [
    inputs.quickshell.packages.x86_64-linux.default
  ];

  xdg.configFile = {
    "quickshell/shell.qml".source = shellQml;
    "quickshell/Theme.qml".source = themeQml;
    "quickshell/Bar.qml".source = barQml;
    "quickshell/Notifications.qml".source = notificationsQml;
    "quickshell/Launcher.qml".source = launcherQml;
  };
}
