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
    signal sampleSignal()
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





        MapItemView {
            model: ListModel {
                id: markerModel
            }

        // MapItemView {
        //     model: ListModel {
        //         ListElement { coordinate: QtPositioning.coordinate(35.73661, 51.29013) }
        //         // Add more ListElements for additional markers
        //     }


            delegate: MapQuickItem {
                anchorPoint.x: 0.5
                anchorPoint.y: 0.5
                coordinate: QtPositioning.coordinate(35.73661, 51.29013)
                sourceItem: Rectangle {
                    width: 10
                    height: 10
                    color: "red"
                }
            }

            // Create marker
            MapQuickItem {
                anchorPoint.x: 0.5
                anchorPoint.y: 0.5
                coordinate: QtPositioning.coordinate(35.73661, 51.29013) // Marker position (San Francisco)
                sourceItem: Rectangle {
                    width: 10
                    height: 10
                    color: "red" // Set the color of the marker
                }
            }
                // coordinate: QtPositioning.coordinate(35.73661, 51.29013)

            Modern.Button {
                x: 0
                y: 208*2
                id: botton
                text:"Click to add gnode id"

                onClicked: {
                    sampleSignal()
                    // sampleSignal2()

                }
            }
        }

        Connections {
                target: mapObj

                function onSample_Sig(txt) {
                    console.log("text is: ", txt)
                }

                // function onMySignal() {
                //     console.log("name of first TestType in list: " + list[0]);
                // }
        }

        Connections {
                target: mapObj

                function onMySignal(latList, longList){
                    console.log("latList: ", latList)
                    console.log("latList: ", longList)
                }
        }



    MouseArea {
        anchors.fill: parent
        acceptedButtons:  Qt.RightButton

        onClicked: {
            // Use a JavaScript function with formal parameters
            console.log("Right mouse button clicked at coordinates:");
            handleRightButtonClick(mouseX, mouseY);
        }

        function handleRightButtonClick(mouseX, mouseY) {
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


    Button{
        id:buttonMap
        text:"Click to add name"
        onClicked: {
            if(buttonMap.text == "Click to add name")
            {
                buttonMap.text = "Click to cancel name"
                map.activeMapType = map.supportedMapTypes[3]
            }
            else
            {
                buttonMap.text = "Click to add name"
                map.activeMapType = map.supportedMapTypes[1]
            }
        }
    }

    // Modern.Button {
    //     x: 0
    //     y: 208*2
    //     id: botton
    //     text:"Click to add gnode id"
    //     onClicked: {
    //         // Use a JavaScript function with formal parameters
    //         console.log("button clicked at coordinates:");
    //         systemHandler.callMe()
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
}
