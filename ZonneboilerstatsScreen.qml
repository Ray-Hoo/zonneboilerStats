import QtQuick 2.1
import SimpleXmlListModel 1.0
import qb.components 1.0
import qb.base 1.0

Screen {
	id: root

// title
	screenTitleIconUrl: "qrc:/tsc/zonneboiler.png"
	screenTitle: "Zonneboiler Stats"

// Open settings screen when empty settingsfile detected
	onShown: {
		addCustomTopRightButton("Instellingen");
		if (app.connectionPath.length < 5) {
			 app.zonneboilerSettings.show();
		}
	}
// Open settings screen
	onCustomButtonClicked: {
		if (app.zonneboilerSettings) {
			 app.zonneboilerSettings.show();
		}
	}

// Refresh button
	Item {
		id: header
		height: isNxt ? 55 : 45
		width: parent.width
// refresh icon
		IconButton {
			id: refreshButton
			anchors.right: parent.right
			anchors.rightMargin: isNxt ? 20 : 16
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 5
			leftClickMargin: 3
			bottomClickMargin: 5
			iconSource: "qrc:/tsc/refresh.svg"
			onClicked: app.refreshScreen()
		}
	}

// header
		Text {
			id: headerText
			text: "Zonneboiler live statistieken:" 
			font.family: qfont.semiBold.name
			font.pixelSize: isNxt ? 25 : 20
			anchors {
				left: parent.left
				leftMargin: isNxt ? 62 : 50
			}
		}

// block
		Rectangle {
			id: backgroundRect
            visible: true
            anchors {
                top: header.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: isNxt ? 5 : 5
                leftMargin: isNxt ? 20 : 16
                rightMargin: isNxt ? 20 : 16
				bottomMargin: isNxt ? 20 : 16
            }
			
// line 1 text
			Text {
				id: line1text
				text: "Temperatuur: "
				font.family: qfont.italic.name
				font.pixelSize: isNxt ? 23 : 18
				anchors {
					left: parent.left
					leftMargin: isNxt ? 62 : 50
					topMargin: isNxt ? 13 : 10
				}
			}
// line 1 value
			Text {
				id: line1value
				text: app.zonneboilerConfigJSON['Temperature'];
				color: colors.clockTileColor
				font.family: qfont.italic.name
				font.pixelSize: isNxt ? 23 : 18
				anchors {
					top: line1text.top
					right: parent.right
					rightMargin:  isNxt ? 125 : 100 
				}
			}
	
// line 2 text
			Text {
				id: line2text
				text: "Gemeten op: "
				font.family: qfont.italic.name
				font.pixelSize: isNxt ? 23 : 18
				anchors {
					left: parent.left
					leftMargin: isNxt ? 62 : 50
					top: line1text.bottom
					topMargin: isNxt ? 13 : 10
				}
			}
// line 2 value
			Text {
				id: line2value
				text: app.zonneboilerConfigJSON['Date'] + " @ " + app.zonneboilerConfigJSON['Time'];
				color: colors.clockTileColor
				font.family: qfont.italic.name
				font.pixelSize: isNxt ? 23 : 18
				anchors {
					top: line2text.top
					left: line1value.left
				}
			}

// end lines
		color: colors.addDeviceBackgroundRectangle
		}

// closing tag
}
