import QtQuick 2.0

Rectangle
{

    width: 1280
    height: 70
    color: "#f0f0f0"

    Item
    {
        width: 180
        anchors.left: parent.left
        anchors.leftMargin: 114
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 4

        Text
        {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Republic of Iraq"
            font.family: fontRobotoBold.name
            font.weight: Font.Bold
            font.pixelSize: 25
        }

        Text
        {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Basrah Governorate"
            font.family: fontRobotoRegular.name
            font.weight: Font.Normal
            font.italic: true
            font.pixelSize: 20
        }

    }

    Image
    {
        width: 115
        height: 65
        anchors.centerIn: parent
        source: "qrc:/logo.png"
    }

    Item
    {
        width: 200
        anchors.right: parent.right
        anchors.rightMargin: 115
        anchors.top: parent.top
        anchors.topMargin: -4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1

        Text
        {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "جمهورية العراق"
            font.family: fontDroidKufiBold.name
            font.weight: Font.Bold
            font.pixelSize: 25
        }

        Text
        {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: "ديوان محافظة البصرة"
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 20
            elide: Text.ElideLeft
        }

    }

}
