import QtQuick 2.1

import qb.components 1.0
import qb.base 1.0

SystrayIcon {
	id: zonneboilerSystrayIcon
	visible: app.showAppIcon
	posIndex: 7000
	property string objectName: "zonneboilerSystrayIcon"  

	
	onClicked: {
		stage.openFullscreen(app.zonneboilerScreenUrl);
	}

	Image {
		id: imgZonneboiler
		anchors.centerIn: parent
		source: "qrc:/tsc/zonneboiler.png"
	}
}
