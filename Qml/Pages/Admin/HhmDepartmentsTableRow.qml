import QtQuick 2.0

Rectangle
{
    property bool is_hovered: false
    property color bordercolor_Plus:
                                  {
                                        if( is_hovered )
                                        {
                                            "#71a4e3"
                                        }
                                        else
                                        {
                                            "#5790d5"
                                        }
                                  }
    property color backcolor_Plus:
                                  {
                                        if( is_hovered )
                                        {
                                            "#eef0f2"
                                        }
                                        else
                                        {
                                            "#e5e6e7"
                                        }
                                  }
    property string id_number: "۱"
    property string id_username: "m.ebrahim"
    property string id_name: "ابراهيم محمد"
    property bool is_odd: false


    width: 800
    height: 30
    color:
         {
               if( is_odd )
               {
                   "#d2d2d2"
               }
               else
               {
                   "#bebebe"
               }
         }


    Rectangle
    {
        id: numberBackRec
        width: 100
        height: parent.height
        color: "transparent"
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 735
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_number
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }

    }

    Rectangle
    {
        id: usernameBackRec
        width: 150
        height: parent.height
        color: "transparent"
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 587
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_username
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
        }
    }


    Rectangle
    {
        id: userTableRowPosition
        width: 400
        height: 24
        color: "#E6E6E6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 55
        anchors.left: parent.left
        border.color: "#969696"
    }

    HhmAddBtn
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

}
