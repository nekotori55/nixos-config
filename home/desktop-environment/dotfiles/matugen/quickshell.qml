// pragma Singleton
import QtQuick
// import Quickshell

QtObject {
	<* for name, value in colors *>
	readonly property color {{name}}: "{{value.default.hex}}"
	<* endfor *>
}
