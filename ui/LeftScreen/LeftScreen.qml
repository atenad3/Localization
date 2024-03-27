import QtQuick 2.15
import QtQuick.Controls 2.15

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


    // TableView {
    //     id: tableView
    //     anchors.fill: parent
    //     model: model

    //     delegate: Item {
    //         Row {
    //             Repeater {
    //                 model: Object.keys(model)
    //                 Text {
    //                     text: modelData + ": " + model[modelData]
    //                     width: tableView.columnWidthProvider(modelData, column)
    //                     wrapMode: Text.WordWrap
    //                 }
    //             }
    //         }
    //     }

    //     // Populate TableView columns dynamically
    //     Component.onCompleted: {
    //         for (var i = 0; i < model.columnCount(); ++i) {
    //             tableView.addColumn({title: myModel.headerData(i, Qt.Horizontal)});
    //         }
    //     }
    // }


}
