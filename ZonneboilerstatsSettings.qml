import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0

Screen {
	id:zonneboilerConfigScreen
	screenTitle: qsTr("Zonneboiler Instellingen")
	screenTitleIconUrl: "qrc:/tsc/zonneboiler.png"

	property bool messageShown : false

// Save button
	onShown: {
		addCustomTopRightButton("Opslaan");
		showAppIconToggle.isSwitchedOn = app.showAppIcon;
		ipadresLabel.inputText = app.ipadres;
		refreshrateLabel.inputText = app.refreshrate;
		messageShown = false;
	}

	onCustomButtonClicked: {
		app.saveSettings();
		app.firstTimeShown = true; 
		app.ZonneboilerDataRead = false;
		app.readzonneboilerPHPData();
		hide();
	}

// Save IP Address
	function saveIpadres(text) {
		if (text) {
			ipadresLabel.inputText = text;
			app.ipadres = text;
     
		}
	}

// Save Refresh rate
	function saveRefreshRate(text) {
		if (text) {
			refreshrateLabel.inputText = text;
			app.refreshrate = text;
		}
	}
	
// systray icon toggle
	Text {
		id: systrayText
		anchors {
			left: parent.left
			leftMargin: isNxt ? 62 : 50
            		top: parent.top
            		topMargin: isNxt ? 19 : 15
		}
		font {
			pixelSize: isNxt ? 25 : 20
			family: qfont.bold.name
		}
		wrapMode: Text.WordWrap
		text: "Zonneboiler icoon zichtbaar in systray?"
	}
	
	OnOffToggle {
		id: showAppIconToggle
		height: 36
		anchors {
			right: parent.right
			rightMargin: isNxt ? 125 : 100
			top: systrayText.top
		}
		leftIsSwitchedOn: false
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				app.showAppIcon = true;
			} else {
				app.showAppIcon = false;
			}
                }
	}

// IP address
	EditTextLabel4421 {
		id: ipadresLabel
		height: editipAdresButton.height
		width: isNxt ? 800 : 600
		leftText: qsTr("IP-adres Zonneboiler:")
		leftTextAvailableWidth: isNxt ? 600 : 480
		anchors {
			left:parent.left
			leftMargin: isNxt ? 62 : 50
			top: systrayText.bottom
			topMargin: isNxt ? 25 : 20
		}
	}
			
	IconButton {
		id: editipAdresButton
		width: isNxt ? 50 : 40
		anchors {
			left:ipadresLabel.right
			leftMargin: isNxt ? 12 : 10
			top: ipadresLabel.top
		}
		iconSource: "qrc:/tsc/edit.png"
		onClicked: {
			qkeyboard.open("Voer hier het ip-adres van de Zonneboiler in", ipadresLabel.inputText, saveIpadres);
                        //qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}

// refresh rate
	EditTextLabel4421 {
		id: refreshrateLabel
		height: editRefreshRateButton.height
		width: isNxt ? 800 : 600
		leftTextAvailableWidth: isNxt ? 600 : 480
		leftText: qsTr("Refresh rate in minutes (default is 15)")
		anchors {
			left:parent.left
			leftMargin: isNxt ? 62 : 50
			top: ipadresLabel.bottom
			topMargin: isNxt ? 25 : 20
		}
	}
	
	IconButton {
		id: editRefreshRateButton
		width: isNxt ? 50 : 40
		anchors {
			left:refreshrateLabel.right
			leftMargin: isNxt ? 12 : 10
			top: refreshrateLabel.top
		}
		iconSource: "qrc:/tsc/edit.png"
			onClicked: {
			qkeyboard.open("Voer hier de refresh rate in", refreshrateLabel.inputText, saveRefreshRate);
                        qkeyboard.maxTextLength = 2;
                        //qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}
// end refresh rate	
}
