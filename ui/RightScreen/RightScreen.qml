import QtQuick 2.15

Rectangle {
    id: rightscreen
    anchors{
        top: parent.top
        bottom: bottomBar.top
        right: parent.right
    }
    color: "gray"
    width: parent.width * 2/3
}
