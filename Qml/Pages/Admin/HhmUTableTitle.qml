import QtQuick 2.0

Rectangle
{
    width: 905
    height: 30
    color: "transparent"

    Rectangle
    {
        id: toptableup
        width: parent.width
        height: parent.height
        color: "#464646"
        radius: 10
    }

    Rectangle
    {
        width: toptableup.width
        height: 15
        color: "#464646"
        anchors.top: toptableup.verticalCenter
    }

    Rectangle
    {
        id: numberBackTitleRec
        width: 75
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            id: toptableup_01
            text: "عدد"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: usernameTitleBackRec
        width: 140
        height: parent.height
        color: "transparent"
        anchors.right: numberBackTitleRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            id: toptableup_02
            text: "اسم المستخدم"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: nameTitleBackRec
        width: 140
        height: parent.height
        color: "transparent"
        anchors.right: usernameTitleBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            id: toptableup_03
            text: "اسم"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: groupTitleBackRec
        width: 180
        height: parent.height
        color: "transparent"
        anchors.right: nameTitleBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            id: toptableup_04
            text: "قسم"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: roleTitleBackRec
        width: 330
        height: parent.height
        color: "transparent"
        anchors.right: groupTitleBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            id: toptableup_05
            text: "منصب"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#dcdcdc"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }
}

