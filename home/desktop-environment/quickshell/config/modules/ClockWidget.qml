import QtQuick
import Quickshell

Text {
    text: Qt.formatDateTime(clock.date, "hh\nmm\nss")
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
