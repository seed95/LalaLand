import QtQuick 2.0


Rectangle
{
    width: 800
    height: 30
    color: "#464646"
    radius: 10

    Rectangle
    {
        width: parent.width
        height: parent.height/2
        color: "#464646"
        anchors.top: parent.verticalCenter
    }

    Rectangle
    {
        id: toptableup_01
        width: 100
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.left: toptableup_02.right
        anchors.rightMargin: 15
        Text
        {
            text: "عدد"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: toptableup_02
        width: 190
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.left: toptableup_03.right

        Text
        {
            text: "اسم القسم"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: toptableup_03
        width: 500
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        Text

        {
            text: "مجموعات فرعية"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

}



