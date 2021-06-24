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

    Text
    {
        id: toptableup_03
        text: "عدد"
        anchors.verticalCenter: parent
        anchors.leftMargin: 720
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }

    Text
    {
        id: toptableup_04
        text: "اسم القسم"
        anchors.verticalCenter: parent
        anchors.leftMargin: 550
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }
    Text

    {
        id: toptableup_05
        text: "مجموعات فرعية"
        anchors.verticalCenter: parent
        anchors.leftMargin: 200
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }
}



