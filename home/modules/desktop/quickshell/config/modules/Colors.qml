pragma Singleton
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Singleton {

	id: root

	// TODO somehow extract and/or hide home path
	property string generatedColorsPath: `file:///home/nekotori55/.cache/matugen/quickshell/Colors_gen.qml`;

	FileView {
		id: colorFile
		path: `${generatedColorsPath}`
		watchChanges: true
		// preload: true
		blockLoading: true

		onFileChanged: {
			this.reload()
			console.log("Colors changed, reloading...")
		}

	}

	function getColors(){
	 if (colorFile.text() == null)
	 {
		return DefaultColors;
	 }
	 else
	 {
	    return Qt.createQmlObject(colorFile.text(), root, "Colors_gen");
	 }
	}

	property var colors_gen: getColors()
	
	readonly property color background: colors_gen.background
	
	readonly property color error: colors_gen.error
	
	readonly property color error_container: colors_gen.error_container
	
	readonly property color inverse_on_surface: colors_gen.inverse_on_surface
	
	readonly property color inverse_primary: colors_gen.inverse_primary
	
	readonly property color inverse_surface: colors_gen.inverse_surface
	
	readonly property color on_background: colors_gen.on_background
	
	readonly property color on_error: colors_gen.on_error
	
	readonly property color on_error_container: colors_gen.on_error_container
	
	readonly property color on_primary: colors_gen.on_primary
	
	readonly property color on_primary_container: colors_gen.on_primary_container
	
	readonly property color on_primary_fixed: colors_gen.on_primary_fixed
	
	readonly property color on_primary_fixed_variant: colors_gen.on_primary_fixed_variant
	
	readonly property color on_secondary: colors_gen.on_secondary
	
	readonly property color on_secondary_container: colors_gen.on_secondary_container
	
	readonly property color on_secondary_fixed: colors_gen.on_secondary_fixed
	
	readonly property color on_secondary_fixed_variant: colors_gen.on_secondary_fixed_variant
	
	readonly property color on_surface: colors_gen.on_surface
	
	readonly property color on_surface_variant: colors_gen.on_surface_variant
	
	readonly property color on_tertiary: colors_gen.on_tertiary
	
	readonly property color on_tertiary_container: colors_gen.on_tertiary_container
	
	readonly property color on_tertiary_fixed: colors_gen.on_tertiary_fixed
	
	readonly property color on_tertiary_fixed_variant: colors_gen.on_tertiary_fixed_variant
	
	readonly property color outline: colors_gen.outline
	
	readonly property color outline_variant: colors_gen.outline_variant
	
	readonly property color primary: colors_gen.primary
	
	readonly property color primary_container: colors_gen.primary_container
	
	readonly property color primary_fixed: colors_gen.primary_fixed
	
	readonly property color primary_fixed_dim: colors_gen.primary_fixed_dim
	
	readonly property color scrim: colors_gen.scrim
	
	readonly property color secondary: colors_gen.secondary
	
	readonly property color secondary_container: colors_gen.secondary_container
	
	readonly property color secondary_fixed: colors_gen.secondary_fixed
	
	readonly property color secondary_fixed_dim: colors_gen.secondary_fixed_dim
	
	readonly property color shadow: colors_gen.shadow
	
	readonly property color source_color: colors_gen.source_color
	
	readonly property color surface: colors_gen.surface
	
	readonly property color surface_bright: colors_gen.surface_bright
	
	readonly property color surface_container: colors_gen.surface_container
	
	readonly property color surface_container_high: colors_gen.surface_container_high
	
	readonly property color surface_container_highest: colors_gen.surface_container_highest
	
	readonly property color surface_container_low: colors_gen.surface_container_low
	
	readonly property color surface_container_lowest: colors_gen.surface_container_lowest
	
	readonly property color surface_dim: colors_gen.surface_dim
	
	readonly property color surface_tint: colors_gen.surface_tint
	
	readonly property color surface_variant: colors_gen.surface_variant
	
	readonly property color tertiary: colors_gen.tertiary
	
	readonly property color tertiary_container: colors_gen.tertiary_container
	
	readonly property color tertiary_fixed: colors_gen.tertiary_fixed
	
	readonly property color tertiary_fixed_dim: colors_gen.tertiary_fixed_dim
	
}
