import QtQuick 2.0

Rectangle
{
    width: 850
    height: 30
    color: "transparent"

    Rectangle
    {
        id: toptableup
        width: 850
        height: parent.height
        color: "#464646"
        radius: 10
    }

    Rectangle
    {
        width: 850
        height: 15
        color: "#464646"
        anchors.top: toptableup.verticalCenter
    }

    Text
    {
        id: toptableup_01
        text: "عدد"
        anchors.verticalCenter: toptableup.verticalCenter
        anchors.leftMargin: 798
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontRobotoRegular.name
        font.pixelSize: 15
    }
    Text
    {
        id: toptableup_02
        text: "اسم المستخدم"
        anchors.verticalCenter: toptableup.verticalCenter
        anchors.leftMargin: 661
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }
    Text
    {
        id: toptableup_03
        text: "اسم"
        anchors.verticalCenter: toptableup.verticalCenter
        anchors.leftMargin: 557
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }
    Text
    {
        id: toptableup_04
        text: "قسم"
        anchors.verticalCenter: toptableup.verticalCenter
        anchors.leftMargin: 417
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }
    Text
    {
        id: toptableup_05
        text: "منصب"
        anchors.verticalCenter: toptableup.verticalCenter
        anchors.leftMargin: 186
        anchors.left: parent.left
        color: "#dcdcdc"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }
}

