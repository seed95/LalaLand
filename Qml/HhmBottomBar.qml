import QtQuick 2.0

Rectangle
{
    property string text_status: "Updated from server 10:43AM"
    property string text_user: "Admin"

    height: 25
    color: "#2c374c"

    Rectangle
    {
        id: rect_rtl
        anchors.fill: parent
        color: "transparent"
        visible: root.rtl

        Text
        {
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text: text_status
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
            color: "#c3c5cd"
        }

        Text
        {
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text: text_user
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
            color: "#c3c5cd"
        }

    }

    Rectangle
    {
        id: rect_ltr
        anchors.fill: parent
        color: "transparent"
        visible: !root.rtl

        Text
        {
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text: text_status
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
            color: "#c3c5cd"
        }

        Text
        {
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text: text_user
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
            color: "#c3c5cd"
        }

    }

}
