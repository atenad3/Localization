import QtQuick 2.0
import QtLocation 6.6
import QtPositioning 6.5


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



import QtLocation 5.6

Item {
    width: 800
    height: 600

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(37.7749, -122.4194) // Initial map center (San Francisco)
        zoomLevel: 20
    }

    // Rectangle {
    //     width: map.width/3
    //     height: map.height/3

    // Create marker
    MapQuickItem {
        anchorPoint.x: 0.5
        anchorPoint.y: 0.5
        coordinate: QtPositioning.coordinate(37.7749, -122.4194) // Marker position (San Francisco)
        sourceItem: Rectangle {
            width: 10
            height: 10
            color: "red" // Set the color of the marker
        }
    }

}
