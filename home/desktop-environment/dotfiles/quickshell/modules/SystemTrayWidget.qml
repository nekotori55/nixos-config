import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick
import Quickshell.Services.SystemTray

Column {
    id: root

    spacing: 16

    anchors.horizontalCenter: parent.horizontalCenter

    Repeater {
        model: SystemTray.items

        // anchors.fill: parent

        delegate: MouseArea {
            implicitHeight: 16
            implicitWidth: 16

            required property SystemTrayItem modelData

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: event => {
                if (event.button === Qt.LeftButton)
                    modelData.activate();
                else
                    modelData.secondaryActivate();
            }

            IconImage {
                id: iconimage

                anchors.fill: parent

                source: {
                    // console.log(Qt.resolvedUrl(parent.modelData.icon));
                    return (parent.modelData.icon);
                }
            }
        }

        // delegate: IconImage {
        //     required property var modelData

        //     source: modelData.icon
        // }
    }
}
