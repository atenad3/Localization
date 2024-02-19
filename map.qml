import QtLocation
import QtPositioning
import QtQuick.Controls 2.15
import QtQuick.Controls 2.2 as Modern
// import MyTypes 1.0
import QtQuick


// import Monty 1.0
// import QtLocation
// import QtPositioning

// Rectangle{
//     id: rect
//     property double oldLat: 35.73661
//     property double oldLng: 51.29013

//     Plugin {
//         id: mapPlugin
//         name: "osm"
//     }

//     // Map {
//     //     id: mapView
//     //     anchors.fill: parent
//     //     plugin: mapPlugin
//     //     center: QtPositioning.coordinate(oldLat, oldLng);
//     //     zoomLevel: 15
//     //     Component.onCompleted:addMarker(oldLat, oldLng)
//     // }

//     Map {
//         id: map
//         anchors.fill: parent
//         plugin: mapPlugin
//         center: QtPositioning.coordinate(35.73661, 51.29013) // Initial map center (San Francisco)
//         zoomLevel: 12

//         MapItemView {
//             model: ListModel {
//                 ListElement { coordinate: QtPositioning.coordinate(35.73661, 51.29013) }
//                 // Add more ListElements for additional markers
//             }

//             delegate: MapQuickItem {
//                 anchorPoint.x: image.width / 2
//                 anchorPoint.y: image.height
//                 coordinate: model.coordinate
//                 sourceItem: Image {
//                     id: image
//                     source: "qrc:/resources/img/marker.jpg" // Replace with your marker image
//                 }
//             }
//         }
//     }


//     // MapQuickItem {
//     //     id: marker
//     //     anchorPoint.x: 0.5
//     //     anchorPoint.y: 0.5
//     //     coordinate: QtPositioning.coordinate(35.73661, 51.29013)
//     //     // sourceItem: Rectangle {
//     //     //     width: 5 // Adjust the width of the point as needed
//     //     //     height: 10 // Adjust the height of the point as needed
//     //     //     color: "red" // Set the color of the point
//     //     //     radius: width / 2 // Make the rectangle a circle by setting the radius
//     //     // }

//     //     sourceItem: Column {
//     //         Image { id: image; source: "icons/markerIcon.png" }
//     //         // Text { text: title; font.bold: true }
//     //     }


//     // }


//     MapCircle {
//         radius: 1000
//         color: "red"
//         opacity: 0.4
//         center {
//             latitude: oldLat
//             longitude: oldLng
//         }
//     }


//     // function addMarker(latitude, longitude)
//     // {
//     //     var Component = Qt.createComponent("qrc:/resources/img/marker.jpg")
//     //     var item = Component.createObject(rect, {
//     //                                           coordinate: QtPositioning.coordinate(latitude, longitude)
//     //                                       })
//     //     mapView.addMapItem(item)
//     // }


//     // MapQuickItem {
//     //     anchorPoint.x: 0.5
//     //     anchorPoint.y: 1.0
//     //     sourceItem: Image {
//     //         source: ":/resources/img/marker.jpg" // Replace with the path to your marker image
//     //     }
//     // }



//     function setCenter(lat,lng){
//         mapView.center = QtPositioning.coordinate(lat, lng);
//         mapView.pan(oldLat-lat,oldLng - lng)
//         oldLat = lat
//         oldLng = lng
//     }
// }



// import QtLocation 5.6

// Item {
//     width: 800
//     height: 600

//     Plugin {
//         id: mapPlugin
//         name: "osm"
//     }

//     Map {
//         id: map
//         anchors.fill: parent
//         plugin: mapPlugin
//         center: QtPositioning.coordinate(37.7749, -122.4194) // Initial map center (San Francisco)
//         zoomLevel: 20
//     }

//     Rectangle {
//         width: map.width/3
//         height: map.height/3

//     // Create marker
//     MapQuickItem {
//         anchorPoint.x: 0.5
//         anchorPoint.y: 0.5
//         coordinate: QtPositioning.coordinate(37.7749, -122.4194) // Marker position (San Francisco)
//         sourceItem: Rectangle {
//             width: 10
//             height: 10
//             color: "red" // Set the color of the marker
//         }
//     }

// }



// import QtQuick 2.7
// // import QtQuick.Controls 1.4
// import QtQuick.Window 2.0
// import QtLocation 5.6
// import QtPositioning 5.6


// Rectangle {
//     id: mainWindow
//     width: 512
//     height: 512
//     visible: true

//     ListModel{
//         id:dummyModel
//         ListElement {
//             Latitude: 47.212047
//             Longitude: -1.551647
//             Label: "something"
//             Orientation: 0
//             Color:"transparent"
//         }
//    }

//     Plugin {
//         id: mapPlugin
//         name: "googlemaps"
//         PluginParameter { name: "API key 1"; value: "AIzaSyAh5r2uQ_j1hylcUNkDOWc1imCRh7fPCgg" }
//     }

//     Map {
//         id: myMap
//         anchors.fill: parent
//         plugin: googleMaps
//         activeMapType: supportedMapTypes[1]

//         center: QtPositioning.coordinate(59.91, 10.75) // Oslo
//         zoomLevel: 14

//         MapItemView{
//             id:dynamicMapObject
//             model: dummyModel
//             delegate: MapQuickItem {
//                 coordinate: QtPositioning.coordinate(Latitude,Longitude)
//                 sourceItem:  Text{
//                     width: 100
//                     height: 50
//                     text: model.Label
//                     rotation: model.Orientation
//                     opacity: 0.6
//                     color: model.Color
//                 }
//             }
//         }

//         MapPolyline {
//                 line.width: 3
//                 line.color: 'green'
//                 path: [
//                     { latitude: 59.92, longitude: 10.77 },
//                     { latitude: 59.96, longitude: 10.78 },
//                     { latitude: 59.99, longitude: 10.76 },
//                     { latitude: 59.95, longitude: 10.74 }
//                 ]
//         }

//         MapCircle {
//           //a static item (fixed real dimension) always at 100m east of the map center
//           id:prova
//           center: myMap.center.atDistanceAndAzimuth(100,90)
//           opacity:0.8
//           color:"red"
//           radius:30

//         }
//     }



//     GroupBox{
//            title:"map types"
//            ComboBox{
//                model:myMap.supportedMapTypes
//                textRole:"description"
//                onCurrentIndexChanged: myMap.activeMapType = myMap.supportedMapTypes[currentIndex]
//            }
//      }
// }

import "ui/BottomBar"
import "ui/RightScreen"
import "ui/LeftScreen"

Rectangle {
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

    // // Define LatList and LongList as properties
    // required property QVector<double> latList
    // required property QVector<double> longList





    // ListModel{
    //     id:dummyModel
    //     ListElement {
    //         Latitude: 35.73661
    //         Longitude: 51.29013
    //         Label: "something"
    //         Orientation: 0
    //         Color:"transparent"
    //     }
    // }




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
        }

        // MapPolyline {
        //     line.width: 3
        //     line.color: 'green'
        //     path: [
        //         { latitude: 35.73661, longitude: 51.29013 },
        //         { latitude: 35.73662, longitude: 51.29013 },
        //         { latitude: 35.73663, longitude: 51.29013 },
        //         { latitude: 35.73664, longitude: 51.29013 }
        //     ]
        // }

        // Component.onCompleted: {
        //     // Access latList and longList here and append markers
        //     for (var i = 0; i < latList.length; i++) {
        //         markerModel.append({ latitude: latList[i], longitude: longList[i] });
        //     }
        // }
    }


    // LocationDataWrapper {
    //         id: locationData
    //     }

        // ListView {
        //     width: parent.width
        //     height: parent.height

        //     model: ListModel {
        //         id: listModel
        //         Component.onCompleted: {
        //             for (var i = 0; i < locationData.latitudeList.length; ++i) {
        //                 listModel.append({ lat: locationData.latitudeList[i], lng: locationData.longitudeList[i] });
        //             }
        //         }
        //     }

        //     delegate: Item {
        //         width: parent.width
        //         height: 40
        //         Text {
        //             anchors.centerIn: parent
        //             text: "Latitude: " + lat + ", Longitude: " + lng
        //         }
        //     }
        // }




    // ListView to display latitude and longitude
    // ListView {
    //     width: 200
    //     height: 400
    //     model: locationDataWrapper.latitudeList.length > 0 ? locationDataWrapper.latitudeList : ListModel  // Check if data is available
    //     delegate: Item {
    //         width: parent.width
    //         height: 40
    //         Text {
    //             anchors.centerIn: parent
    //             text: "Latitude: " + modelData + ", Longitude: " + locationDataWrapper.longitudeList[index]
    //         }
    //     }
    // }



    // //*/ Create ListView to display latitude and longitude values
    // ListView {
    //     id: listView
    //     anchors.left: parent.left
    //     anchors.top: parent.top
    //     width: 200
    //     height: 400
    //     model: longList // Use LongList as model

    //     delegate: Item {
    //         width: listView.width
    //         height: 50
    //         Text {
    //             text: "Latitude: " + latList[index] + ", Longitude: " + modelData
    //             anchors.centerIn: parent
    //         }
    //     }
    // }*/



    MouseArea {
        anchors.fill: parent
        acceptedButtons:  Qt.RightButton

        onClicked: {
            // Use a JavaScript function with formal parameters
            console.log("Right mouse button clicked at coordinates:");
            handleRightButtonClick(mouseX, mouseY);
        }

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

    Modern.Button {
        x: 0
        y: 208*2
        id: botton
        text:"Click to add gnode id"
        onClicked: {
            // Use a JavaScript function with formal parameters
            console.log("button clicked at coordinates:");
            systemHandler.callMe()
        }

    }


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
