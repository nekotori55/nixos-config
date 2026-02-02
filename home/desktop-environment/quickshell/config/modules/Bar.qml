import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            color: Qt.color("gray")
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 30

            ClockWidget {
                id: clock
                anchors.centerIn: parent
            }

            SystemTrayWidget {
                anchors.bottom: parent.bottom
                padding: 16
            }
        }
    }
}
