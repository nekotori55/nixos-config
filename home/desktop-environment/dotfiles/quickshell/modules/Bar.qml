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
