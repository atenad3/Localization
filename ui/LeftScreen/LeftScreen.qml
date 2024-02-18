import QtQuick 2.15

Rectangle {
    id: leftscreen
    anchors{
        left: parent.left
        right: rightScreen.left
        bottom: bottomBar.top
        top: parent.top
    }

    color: "orange"
    Image {
        id:logo
        anchors.centerIn: parent
        width: parent.width * .75
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/marker.jpg"
    }
}

