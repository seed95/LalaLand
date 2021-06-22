import QtQuick 2.0

Rectangle
{
    property string id_number: "number"
    property string id_name: "name"
    property bool is_odd: false

    height: 30
    width: 800
    color:
         {
            if( is_odd )
            {
                "#BEBEBE"
            }
            else
            {
                "#D2D2D2"
            }
         }

    Rectangle
    {
        id: rect1
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect2
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect1.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect3
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect2.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect4
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect3.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect5
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect4.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect6
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect5.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect7
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect6.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect8
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect7.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect9
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect8.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        id: rect10
        width: 180
        height: parent.height
        color: "transparent"
        anchors.left: rect9.right
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
             anchors.right: parent.right
             anchors.rightMargin: 28.5
             anchors.verticalCenter: parent.verticalCenter

             text: id_name
             font.family: fontDroidKufiRegular.name
             font.pixelSize: 17
             color: "#464646"
        }
    }
    Rectangle
    {
        id: rect11
        width: 54
        height: parent.height
        color: "transparent"
        anchors.left: rect10.right
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
             anchors.centerIn: parent

             text: id_number
             font.family: fontDroidKufiRegular.name
             font.pixelSize: 17
             color: "#464646"
        }
    }
}
