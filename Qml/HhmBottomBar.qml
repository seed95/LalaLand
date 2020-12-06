import QtQuick 2.0

Rectangle
{
    property string text_status: "Updated from server 10:43AM"

    height: 25 * scale_height
    color: "#2c374c"

    Text
    {
        text: text_status
        color: "#c3c5cd"
        font.family: fontRobotoRegular.name
        font.pixelSize: 15
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.verticalCenter: parent.verticalCenter
    }

}
