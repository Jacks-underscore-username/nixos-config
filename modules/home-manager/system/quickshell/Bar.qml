import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Scope {
  id: root

  readonly property string time: Qt.formatDateTime(clock.date, "HH:mm:ss")
  readonly property string dateStr: Qt.formatDateTime(clock.date, "ddd MMM d")

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar
      required property var modelData
      screen: modelData

      property var monitorWorkspaces: {
        let all = Hyprland.workspaces.values;
        let screenName = bar.screen.name;
        let result = [];
        for (let i = 0; i < all.length; i++)
          if (all[i].monitor !== null && all[i].monitor.name === screenName)
            result.push(all[i]);
          return result;
        }

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

            RowLayout {
              Layout.alignment: Qt.AlignLeft
              spacing: 4

              Repeater {
                model: bar.monitorWorkspaces

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

            Item { Layout.fillWidth: true }
            Text {
              Layout.alignment: Qt.AlignCenter
              text: root.time
              font.family: Theme.fontFamily
              font.pixelSize: Theme.fontSize
              color: Theme.blue
            }
            Item { Layout.fillWidth: true }

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
