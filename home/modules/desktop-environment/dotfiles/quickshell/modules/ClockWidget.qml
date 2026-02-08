import QtQuick
import Quickshell

Rectangle {
    property var showSeconds: false

    implicitHeight: 20 * (2 + showSeconds)
    implicitWidth: parent.width - 4
    color: Colors.background
    radius: 8

    Text {
        text: Qt.formatDateTime(clock.date, `hh\nmm${showSeconds ? "\nss" : ""}`)

        anchors.centerIn: parent

        color: Colors.on_background
        font.family: Config.fontFamily

        // font.bold: true
        font.pixelSize: 16

        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }
}
