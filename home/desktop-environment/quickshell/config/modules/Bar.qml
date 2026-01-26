import Quickshell

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 30

            ClockWidget {
                anchors.centerIn: parent
                time: Time.time
            }
        }
    }
}

