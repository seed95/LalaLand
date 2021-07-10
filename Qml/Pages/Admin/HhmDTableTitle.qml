import QtQuick 2.0


Rectangle
{
    width: 905
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
        width: 60
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 47
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
        width: 280
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.right: toptableup_01.left

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
        width: 460
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.right: toptableup_02.left

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



