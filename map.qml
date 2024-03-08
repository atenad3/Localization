import QtLocation
import QtPositioning
import QtQuick.Controls 2.15
import QtQuick.Controls 2.2 as Modern
// import MyTypes 1.0
import QtQuick
import "ui/BottomBar"
import "ui/RightScreen"
import "ui/LeftScreen"
import QtQuick.Layouts
// import system 1.0
// import "point.h"
Rectangle {
    signal sampleSignal(string id)
    signal sampleSignal2()
    Window {
        width: 1280
        height: 720
        visible: true
        title: qsTr("test ..")

        LeftScreen{
            id: leftScreen
        }


        RightScreen{
            id: rightScreen
        }

        BottomBar{
            id: bottomBar
        }
    }
    width: 1280
    height: 720


    Plugin {
        id: mapPlugin
        name: "googlemaps"
        PluginParameter { name: "API key 1"; value: "AIzaSyAh5r2uQ_j1hylcUNkDOWc1imCRh7fPCgg" }
    }


    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(35.73661, 51.29013) // Initial center
        // Zoom level can be adjusted as needed
        zoomLevel: 15 // Adjust the zoom level according to your preference

        // property string latitude: "" // Define a property for latitude
        // property string longitude: "" // Define a property for longitude
        // var coordinate: coordinate

        property var coordinate: null

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                map.bearing -= delta
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }


        // Define the model to hold coordinates
        ListModel {
            id: locationModel
            // ListElement { latitude: 35.73661; longitude: 51.29013;} // Example coordinates // Additional coordinates
            ListElement { latitude: 35.73661; longitude: 51.29013; sigPow: -60; sigQual:-13; sigQualName:"Fair";}
            // Add more ListElements for additional locations
        }

        MapItemView {
            model: locationModel

            TextField {
                id: textField
                validator: IntValidator {bottom: 1; top: 1000}
                anchors {
                    horizontalCenter: botton.horizontalCenter
                    bottom: botton.top
                    bottomMargin: 1
                }
                // width: button.width
                height: implicitHeight
            }

            // coordinate: QtPositioning.coordinate(35.73661, 51.29013)
            Modern.Button {
                x: 0
                y: 208*2
                id: botton
                text:"Click to add Node Id"

                onClicked: {
                    var enteredText = textField.text;
                    console.log("Entered text: " + enteredText);
                    sampleSignal(enteredText)
                    // sampleSignal2()
                }
            }

        Connections {
            target: mapObj
            function onSample_Sig(txt) {
                console.log("text is: ", txt)
            }
        }

        //main connection
        Connections {
            target: mapObj
            function onMySignal(latList, longList, sigPowList, sigQualList, sigQualNameList){
                for (var i = 0; i < latList.length; i++) {
                    locationModel.append({ latitude: latList[i], longitude: longList[i], sigPow: sigPowList[i], sigQual: sigQualList[i], sigQualName: sigQualNameList[i]});
                }
            }
        }

        delegate: MapQuickItem {
            anchorPoint.x: 0.5
            anchorPoint.y: 0.5
            coordinate: QtPositioning.coordinate(model.latitude, model.longitude)
            sourceItem: Rectangle {
                width: 10
                height: 10
                color: "blue"
            }
        }

        }//mapitemview


    Menu{
        id: contextMenu
        MenuItem {
            // onTriggered: {
            //   console.log("hello");
            //   // Need Mouse absolute position
            // }
            // text: "Latitude: " + arg(parent.coordinate.latitude)
            // text: "lat: %1".arg(parent.coordinate.latitude)
        }
        MenuItem {
            text: "Longitude: "
            // shortcut: "Ctrl+X"
        }

    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        propagateComposedEvents: true
        id: mouseArea
        hoverEnabled: true
        property var coordinate: map.toCoordinate(Qt.point(mouseX, mouseY))
        Label
        {
            x: parent.mouseX - width
            y: parent.mouseY - height - 5
            text: "lat: %1; lon:%2".arg(parent.coordinate.latitude).arg(parent.coordinate.longitude)
        }


        onClicked: (mouse)=> {
            console.log("Right mouse button clicked at coordinates:");
            // var coord = map.toCoordinate(Qt.point(mouse.x, mouse.y));
            // contextMenu.popup()
            handleRightButtonClick(mouse.x, mouse.y,locationModel)
        }


        ListModel {
            id: mousePoints
            ListElement { latitude: 35.73661; longitude: 51.29013 } // Example coordinates // Additional coordinates
            // Add more ListElements for additional locations
        }
        
        property var somthing: 0.0;

        Popup {
            id: popup

            property string title : ""
            property double lat: 0.0
            property double lng: 0.0
            property double sigP: 0.0
            property double sigQ: 0.0
            property string sigQN: ""

            x: 100
            y: 100
            width: 200
            height: 200
            modal: true
            focus: true
            palette.window: "#edf3f8"

            contentData: Text {
                id: inner_text;
            }

            ColumnLayout {
                Label{
                    text: popup.title
                    font.bold: true
                }


                Rectangle {
                    width: popup.width -2
                    height: 2
                    color: "gray" // Separator color
                }

                Label {
                    text: popup.lat
                }


                Label {
                    text: popup.lng
                }

                Label {
                    text: popup.sigP
                }


                Label {
                    text: popup.sigQ
                }

                Label {
                    text: popup.sigQN

                }


                Rectangle {
                    width: popup.width -2
                    height: 2
                    color: "gray" // Separator color
                }


                Button {
                    text: "OK!";
                    onClicked: {
                        popup.close();
                    }
                }


                // Label {
                //     text: console.log("rect.height = " )
                // }

                // Switch {
                //     text: qsTr("... and so will this")
                // }
            }

            Component.onCompleted: {
                // contentItem.objectName = "foo"
                print("testtttt")
            }

            // ColumnLayout {
            //         anchors.fill: parent
            //         // CheckBox { text: qsTr("Calendar") }
            //         // CheckBox { text: qsTr("Contacts") }
            // }
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        }



        function searchValue(model, lat, lng) {
            for (var i = 0; i < model.count; ++i) {
                var element = model.get(i);
                console.log(element.latitude,element.longitude);
                if (element.latitude === lat && element.longitude === lng) {
                    // Found the value, do something
                    console.log("Value found at index", i);
                    return i; // or return the index, or the element itself, depending on your requirements
                }
            }
            // Value not found
            console.log("Value not found");
            return -1;
        }


        function handleRightButtonClick(mouseX, mouseY, mymodel) {
            console.log("Right2 mouse button clicked at coordinates:");
            var coordinate = map.toCoordinate(Qt.point(mouseX, mouseY));
            var latitude = coordinate.latitude;
            var longitude = coordinate.longitude;
            console.log("Latitude:", latitude);
            console.log("Longitude:", longitude);
            contextMenu.popup()
            mousePoints.append({ latitude: latitude, longitude: longitude });
            // inner_text.text = latitude
            // inner_text.text =longitude
            var lastIndex = mousePoints.count-1;
            var lastLatitude = mousePoints.get(lastIndex).latitude;
            var lastLongitude = mousePoints.get(lastIndex).longitude;

            console.log("lt is", lastLatitude)
            //check the ponit is one of points that we have information about it.
            if(mymodel.count > 1){
                var found = searchValue(mymodel, lastLatitude, lastLongitude);
                if (found>=0) {
                    popup.sigP = mymodel.get(i).sigPow
                    popup.sigQ = mymodel.get(i).sigQual
                    popup.sigQN = mymodel.get(i).sigQualName
                }
                // else {
                // }
            }

            var lt = mousePoints.latitude

            popup.title ="Node Information"
            popup.lat = latitude
            popup.lng = longitude

            popup.open()
            // // Append data to the model
            // dummyModel.append({
            //    "Latitude": latitude,
            //    "Longitude": longitude
            // });
        }


    } //MouseArea

    }//map

    PositionSource {
        onPositionChanged: {
            // center the map on the current position
            map.center = position.coordinate
        }
    }



}
