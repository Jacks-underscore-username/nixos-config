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
