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

  function close(): void {
    root.showing = false;
    root.searchText = "";
    searchInput.text = "";
  }

  function launch(entry): void {
    entry.execute();
    root.close();
  }

  IpcHandler {
    target: "launcher"

    function toggle(): void {
      if (root.showing) {
        root.close();
      } else {
        root.searchText = "";
        searchInput.text = "";
        root.showing = true;
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

            Keys.onEscapePressed: root.close()
            Keys.onReturnPressed: {
              if (resultsList.currentIndex >= 0 && resultsList.currentIndex < root.filteredEntries.length) {
                root.launch(root.filteredEntries[resultsList.currentIndex]);
              }
            }
            Keys.onDownPressed: {
              resultsList.currentIndex = Math.min(resultsList.currentIndex + 1, root.filteredEntries.length - 1);
            }
            Keys.onUpPressed: {
              resultsList.currentIndex = Math.max(resultsList.currentIndex - 1, 0);
            }
          }
        }

        // Results list
        ListView {
          id: resultsList
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true
          model: root.filteredEntries
          spacing: 4
          currentIndex: 0
          highlightFollowsCurrentItem: false

          // Reset selection when results change
          onCountChanged: currentIndex = 0

          delegate: Rectangle {
            required property var modelData
            required property int index
            width: ListView.view.width
            height: 40
            radius: 8
            color: index === resultsList.currentIndex ? Theme.bgVisual
              : delegateMouse.containsMouse ? Theme.bgHighlight : "transparent"

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
                color: index === resultsList.currentIndex ? Theme.fg : Theme.fgDark
                elide: Text.ElideRight
              }
            }

            MouseArea {
              id: delegateMouse
              anchors.fill: parent
              hoverEnabled: true
              onClicked: root.launch(modelData)
            }
          }
        }
      }
    }
  }
}
