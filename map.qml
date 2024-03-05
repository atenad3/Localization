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
            ListElement { latitude: 35.73661; longitude: 51.29013 } // Example coordinates // Additional coordinates
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


        Connections {
            target: mapObj
            function onMySignal(latList, longList){
                for (var i = 0; i < latList.length; i++) {
                    locationModel.append({ latitude: latList[i], longitude: longList[i] });
                }
            }
        }

        // ListView {
        //     anchors {
        //         left: parent.left
        //         top: parent.top
        //         margins: 10
        //     }
        //     width: 200
        //     height: 300
        //     model: locationModel
        //     delegate: Text {
        //         text: "Latitude: " + model.latitude + ", Longitude: " + model.longitude
        //     }
        // }

        delegate: MapQuickItem {
            anchorPoint.x: 0.5
            anchorPoint.y: 0.5
            coordinate: QtPositioning.coordinate(model.latitude, model.longitude)
            sourceItem: Rectangle {
                width: 10
                height: 10
                color: "red"
            }
        }

        }//mapitemview


    // Menu {
    //     id: menu
    //     MenuItem {
    //       onTriggered: {
    //         var absolutePos = getAbsolutePosition(menu);
    //         console.log(absolutePos.x);
    //         // Need Mouse absolute position
    //       }
    //     }
    // }
    Menu{
        id: contextMenu
        MenuItem {
            onTriggered: {
              console.log("hello");
              var absolutePos = getAbsolutePosition();
              console.log(absolutePos.x);
              text: "Longitude: "+ absolutePos.x
              text: "Longitude: "+ absolutePos.y
              // Need Mouse absolute position
            }
            // text: "Latitude: " + arg(parent.coordinate.latitude)
            // text: "lat: %1".arg(parent.coordinate.latitude)
        }
        // MenuItem {
        //     text: "Longitude: "+ absolutePos.x
        // }
        // MenuItem {
        //     text: "Longitude: "+ absolutePos.y
        // }

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

            var coord = map.toCoordinate(Qt.point(mouse.x, mouse.y));
            // markermodel.append({"position_marker": coord, "type": bar.currentIndex})
            // contextMenu.popup()

            handleRightButtonClick(mouse.x, mouse.y)
            // handleRightButtonClick(coord.latitude, coord.longitude)

                     // Use latitude and longitude to position the popup
            // console.log("lat: %1; lon:%2".arg(parent.coordinate.latitude).arg(parent.coordinate.longitude));
        }


        // property var coordinate : map.toCoordinate(Qt.point(mouseX, mouseY))


        // var latitude = coordinate.latitude;
        // var longitude = coordinate.longitude;

        // Menu{
        //     id: contextMenu
        //     MenuItem {
        //         // text: "Latitude: " + arg(parent.coordinate.latitude)
        //         text: "lat: %1".arg(parent.coordinate.latitude)
        //     }
        //     MenuItem {
        //         text: "Longitude: "+ MouseArea.coordinate.longitude
        //     }

        // }







        // function showPopup() {


        //     // Create a popup menu


        //     var menu = Menu {
        //         MenuItem {
        //             text: "Latitude: " + latitude + "; Longitude: " + longitude
        //         }
        //     };

        //     // Open the popup menu at the mouse position
        //     menu.popup(mouseX, mouseY);
        // }





        function handleRightButtonClick(mouseX, mouseY) {
            console.log("Right2 mouse button clicked at coordinates:");

            // Check if the right mouse button was clicked
            // if (Qt.mouseButtons === Qt.RightButton) {
            console.log("Right3 mouse button clicked at coordinates:");

            var coordinate = map.toCoordinate(Qt.point(mouseX, mouseY));
            var latitude = coordinate.latitude;
            var longitude = coordinate.longitude;
            console.log("Latitude:", latitude);
            // // Append data to the model
            // dummyModel.append({
            //    "Latitude": latitude,
            //    "Longitude": longitude
            // });
            // console.log("Latitude:", latitude);
            // console.log("Longitude:", longitude);


        }



        function getAbsolutePosition() {
            console.log("getAbsolutePosition");
            var returnPos = {};
            var coordinate = map.toCoordinate(Qt.point(mouseX, mouseY))
            returnPos.x = coordinate.latitude;
            returnPos.y = coordinate.longitude;
              //   if(node !== undefined && node !== null) {
              //      var parentValue = getAbsolutePosition(node.parent);
              //     returnPos.x = parentValue.x + node.x;
              //     returnPos.y = parentValue.y + node.y;
              // }
            return returnPos;
        }

    } //MouseArea

    // function showPopup(latitude, longitude) {
    //     // Use latitude and longitude to display the popup at the correct position
    //     // Example: display a Google Maps InfoWindow at the specified position
    //     var contentString = 'Latitude: ' + latitude + ', Longitude: ' + longitude;
    //     var infowindow = new google.maps.InfoWindow({
    //         content: contentString,
    //         position: {lat: latitude, lng: longitude}
    //     });
    //     infowindow.open(map);
    // }





    }//map

    PositionSource {
        onPositionChanged: {
            // center the map on the current position
            map.center = position.coordinate
        }
    }


    // Button{
    //     id:buttonMap
    //     text:"Click to add name"
    //     onClicked: {
    //         if(buttonMap.text == "Click to add name")
    //         {
    //             buttonMap.text = "Click to cancel name"
    //             map.activeMapType = map.supportedMapTypes[3]
    //         }
    //         else
    //         {
    //             buttonMap.text = "Click to add name"
    //             map.activeMapType = map.supportedMapTypes[1]
    //         }
    //     }
    // }

    function handleButtonClickID(mouseX, mouseY) {
            // Check if the right mouse button was clicked
            if (Qt.mouseButtons === Qt.RightButton) {
                // Print a sentence
                console.log("Right mouse button clicked at coordinates:");

                // Append data to the model
                dummyModel.append({
                    "Latitude": map.toCoordinate(Qt.point(mouseX, mouseY)).latitude,
                    "Longitude": map.toCoordinate(Qt.point(mouseX, mouseY)).longitude,
                    "Label": "abc",
                    "Color": "red",
                    "Orientation": 3
                });
            }
    }

}
