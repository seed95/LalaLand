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
    property string id_number: "number"
    property string id_username: "name"
    property bool is_odd: ar2en(id_number)%2


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
        id: numberRect
        width: 100
        height: parent.height
        color: "transparent"
        anchors.left: usernameRect.right
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
        id: usernameRect
        width: 190
        height: parent.height
        color: "transparent"
        anchors.left: groupRect.right
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_username
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    Rectangle
    {
        id: groupRect
        width: 500
        height: parent.height
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        Rectangle
        {
            width: 400
            height: 24
            color: "#E6E6E6"
            radius: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 55
            anchors.left: parent.left
            border.color: "#969696"
        }
    }

    HhmAddBtn
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

}
