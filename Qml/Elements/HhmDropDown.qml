import QtQuick 2.0

Rectangle
{
    Rectangle
    {
        id: section
        width: 149
        height: 24
        color: "#e6e6e6"
        radius: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 360
        anchors.left: parent.left
        border.color: "#969696"
    }

    Rectangle
    {
        id: downButton
        width: 26
        height: 24
        color: "#3d628b"
        radius: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: section.left
        border.color: "#969696"
    }

    Rectangle
    {
        id: downButton01
        width: 13
        height: 22
        color: "#3d628b"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: downButton.horizontalCenter

    }

    Rectangle
    {
        id: downButton02
        width: 1
        height: 24
        color: "#969696"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: downButton01.right

    }

    Text
    {
        id: downButtonIcon
        text: "\uf107"
        color: "#e5e6e7"
        anchors.verticalCenter: downButton.verticalCenter
        anchors.horizontalCenter: downButton.horizontalCenter
        font.family: fontAwesomeSolid.name
        font.pixelSize: 15
    }
}
