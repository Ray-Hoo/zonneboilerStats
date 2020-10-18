import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import FileIO 1.0

App {
	id: root

	property url trayUrl : "ZonneboilerstatsTray.qml";
	property url thumbnailIcon: "qrc:/tsc/zonneboiler.png"
	property url menuScreenUrl : "ZonneboilerstatsSettings.qml"
	property url zonneboilerScreenUrl : "ZonneboilerstatsScreen.qml"
	property url zonneboilerTileUrl : "ZonneboilerstatsTile.qml"
	property ZonneboilerstatsSettings zonneboilerSettings
	property ZonneboilerstatsScreen zonneboilerScreen
	property bool dialogShown : false  //shown when changes have been. Shown only once.
	
	property SystrayIcon zonneboilerTray
	property bool showAppIcon : true
	property bool firstTimeShown : true
	property variant zonneboilerConfigJSON
	property bool zonneboilerDataRead: false
	
// app settings
	property string connectionPath
	property string ipadres
        property int refreshrate  : 15	// interval to retrieve data

//data vars
	property string temperature
	property string measuretimestamp

// user settings from config file
	property variant userSettingsJSON : {
		'connectionPath': [],
		'ShowTrayIcon': "",
		'refreshrate': ""
	}

// location of settings file
	FileIO {
		id: userSettingsFile
		source: "file:///mnt/data/tsc/zonneboilerstats.userSettings.json"
 	}

	function init() {
		registry.registerWidget("systrayIcon", trayUrl, this,"zonneboilerTray");
		registry.registerWidget("screen", zonneboilerScreenUrl, this, "zonneboilerScreen");
		registry.registerWidget("screen", menuScreenUrl, this, "zonneboilerSettings");
		registry.registerWidget("menuItem", null, this, null, {objectName: "AppMenuItem", label: qsTr("Zonneboiler"), image: thumbnailIcon, screenUrl: menuScreenUrl, weight: 120});
		registry.registerWidget("tile", zonneboilerTileUrl, this, null, {thumbLabel: "Zonneboiler", thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, thumbIconVAlignment: "center"});
	}

//this function needs to be started after the app is booted.
	Component.onCompleted: {
		// read user settings
		try {
			userSettingsJSON = JSON.parse(userSettingsFile.read());
			showAppIcon  = (userSettingsJSON['ShowTrayIcon'] == "yes") ? true : false
			connectionPath = userSettingsJSON['connectionPath'];
			var splitVar = connectionPath.split(":")
			ipadres = splitVar[0];
			refreshrate = userSettingsJSON['refreshrate'];
		} catch(e) {
		}
		refreshScreen();
	}

// refresh screen
	function refreshScreen() {
		zonneboilerDataRead = false;
		readzonneboilerPHPData();
	}

// save user settings
	function saveSettings(){
		connectionPath = ipadres ;

 		var tmpUserSettingsJSON = {
			"connectionPath" : ipadres,
			"refreshrate" : refreshrate,
			"ShowTrayIcon" : (showAppIcon) ? "yes" : "no"
		}

  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///mnt/data/tsc/zonneboilerstats.userSettings.json");
   		doc3.send(JSON.stringify(tmpUserSettingsJSON));
	}

// read json file
    function readzonneboilerPHPData()  {
//		console.log("*****Zonneboiler connection Path:" + connectionPath);
		if ( connectionPath.length > 4 ) {
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.open("GET", "http://"+connectionPath+"/get-temperature.php", true);
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == XMLHttpRequest.DONE) {

					if (xmlhttp.status === 200) {
//					console.log("*****Zonneboiler response:" + xmlhttp.responseText);
//       	         saveJSON(xmlhttp.responseText);
					zonneboilerConfigJSON = JSON.parse(xmlhttp.responseText);
					
					temperature = zonneboilerConfigJSON['Temperature'] +" ºC";
//					console.log("*****Zonneboiler temperature: " + temperature);
					measuretimestamp =  zonneboilerConfigJSON['Date'] + " @ "+ zonneboilerConfigJSON['Time']
//					console.log("*****Zonneboiler measuretimestamp: " + measuretimestamp);
					} else {
					temperature = "server incorrect";
//					console.log("*****Zonneboiler temperature: "+ temperature);
					measuretimestamp = "server incorrect";
//					console.log("*****Zonneboiler measuretimestamp: "+ measuretimestamp);

					}
				}
			}
		} else {
			temperature = "empty settings";
//			console.log("*****Zonneboiler temperature: "+ temperature);
			measuretimestamp = "empty settings";
//			console.log("*****Zonneboiler measuretimestamp: "+ measuretimestamp);
		}
        xmlhttp.send();
    }

// save json data in json file. Optional, see readzonneboilerPHPData
	function saveJSON(text) {
		
  		var doc3 = new XMLHttpRequest();
   		doc3.open("PUT", "file:///var/volatile/tmp/zonneboiler_retrieved_data.json");
   		doc3.send(text);
	}
	
// Timer in s * 60000
	Timer {
		id: datetimeTimer
		interval: refreshrate * 60000;
		running: true
		repeat: true
		onTriggered: refreshScreen()
	}
}
