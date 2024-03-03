import QtQuick 2.15
import QtQuick.Controls 2.15

// Rectangle {
//     id: leftscreen
//     anchors{
//         left: parent.left
//         right: rightScreen.left
//         bottom: bottomBar.top
//         top: parent.top
//     }

//     color: "orange"
//     // Image {
//     //     id:logo
//     //     anchors.centerIn: parent
//     //     width: parent.width * .75
//     //     fillMode: Image.PreserveAspectFit
//     //     source: "qrc:/ui/assets/marker.jpg"
//     // }


// }


ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Table of TextInput Boxes"

    Column {
        anchors.fill: parent
        spacing: 10


            // model: 2 // Number of rows
            Row {
                id: rowLayout
                spacing: 10

                Repeater {
                    model: 1 // Number of columns
                    Rectangle {
                        width: 100
                        height: 50
                        color: "lightblue"
                        radius: 5

                        TextInput {
                            anchors.fill: parent
                            font.pixelSize: 16
                            color: "black"
                            // Use placeholderText property here
                            text: "test"
                        }
                    }
                }
            }

    }
}
