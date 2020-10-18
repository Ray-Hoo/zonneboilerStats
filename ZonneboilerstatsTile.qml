import QtQuick 2.1
import qb.components 1.0


Tile {
	id: zonneboilerTile
	property bool dimState: screenStateController.dimmedColors

	onClicked: {
		stage.openFullscreen(app.zonneboilerScreenUrl);
	}

// Title
	Text {
		id: tiletitle
		text: "Zonneboiler Stats"
		anchors {
			baseline: parent.top
			baselineOffset: isNxt ? 30 : 24
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.bold.name
			pixelSize: isNxt ? 25 : 20
		}
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.waTileTextColor : colors.waTileTextColor
	}
// line 1 text
	Text {
		id: tileline1
		text: "Temperatuur: "
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: tiletitle.bottom
			left: parent.left
			leftMargin:  isNxt ? 10 : 8  
		}
		font.pixelSize: isNxt ? 25 : 20
		font.family: qfont.italic.name
	}

// line 2 text
	Text {
		id: tileline2
		text: app.temperature
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			left: tileline1.left
			top: tileline1.bottom 
		}
		font.pixelSize: isNxt ? 25 : 20
		font.family: qfont.italic.name
	}

// line 3 text
	Text {
		id: tileline3
		text: "Gemeten op: "
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			left: tileline2.left
			top: tileline2.bottom 
		}
		font.pixelSize: isNxt ? 25 : 20
		font.family: qfont.italic.name
	}

// line 4 text
	Text {
		id: tileline4
		text: app.measuretimestamp
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			left: tileline3.left
			top: tileline3.bottom 
		}
		font.pixelSize: isNxt ? 25 : 20
		font.family: qfont.italic.name
	}
}
