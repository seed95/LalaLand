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


    width: 850
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
        width: 74
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    Text
    {
        text: id_number
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: numberBackRec.horizontalCenter
        color: "#464646"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }

    Rectangle
    {
        id: usernameBackRec
        width: 134
        height: parent.height
        color: "transparent"
        anchors.right: numberBackRec.left
        anchors.verticalCenter: parent.verticalCenter
    }

    Text
    {
        text: id_username
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: usernameBackRec.horizontalCenter
        color: "#464646"
        font.family: fontRobotoRegular.name
        font.pixelSize: 15
    }

    Rectangle
    {
        id: nameBackRec
        width: 133
        height: parent.height
        color: "transparent"
        anchors.right: usernameBackRec.left
        anchors.verticalCenter: parent.verticalCenter
    }

    Text
    {
        text: id_name
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: nameBackRec.horizontalCenter
        color: "#464646"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
    }

    HhmDropDown
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

    Rectangle
    {
        id: userTableRowPosition
        width: 296
        height: 24
        color: "#e6e6e6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 47
        anchors.left: parent.left
        border.color: "#969696"
    }

    Rectangle
    {
        id: userTableRowPosition01
        width: 55
        height: 19
        color: "transparent"
        radius: 5
        anchors.verticalCenter: userTableRowPosition.verticalCenter
        anchors.leftMargin: 285
        anchors.left: parent.left
        border.color: "#5790d5"
    }

    Text
    {
        id: userTableRowPositionTitle
        text: "الموظف"
        color: "#5790d5"
        anchors.verticalCenter: userTableRowPosition01.verticalCenter
        anchors.horizontalCenter: userTableRowPosition01.horizontalCenter
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 10
    }

    HhmAddBtn
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

}
