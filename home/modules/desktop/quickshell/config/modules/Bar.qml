import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            color: Colors.background
            
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 30

            WorkspaceIndicator {
                // anchors.top: parent.top
                // anchors.left: parent.left
                // anchors.right: parent.right
                anchors.fill: parent
            }

            ClockWidget {
                id: clock
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 16
            }

            SystemTrayWidget {
                id: tray
                anchors.bottom: clock.top
                padding: 16
            }
        }
    }
}
