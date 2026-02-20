import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    id: root

    height: workspaceName.length * text.font.pointSize + 32
    color: Colors.background

    property string workspaceName: "loading..."

    Text {
        id: text

        property string workspaceIcon: ""

        text: parent.workspaceName + "  " + workspaceIcon

        font.capitalization: Font.AllUppercase
        font.pointSize: 12
        font.weight: 400

        anchors.centerIn: parent

        rotation: -90

        color: Colors.primary

        Process {
            id: wsFetcher
            command: ["sh", "-c", script.text()]
            running: true

            stdout: StdioCollector {
                onStreamFinished: root.workspaceName = this.text.trim().split(";").filter(str => str != "")[0]
            }
        }

        FileView {
            id: script
            path: Qt.resolvedUrl("./script.sh")
        }

        Timer {
            interval: 100
            running: true
            repeat: true
            onTriggered: wsFetcher.running = true
        }
    }
}
