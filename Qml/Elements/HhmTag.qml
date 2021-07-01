import QtQuick 2.10
//import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

Rectangle
{
    id: container

    property string tag_text:  "علي عدنان"
    property bool   separator_visible:  false//Separator is visible

    property bool   isHovered: false

    signal clickTag()

    height: 30
    width: rect_username.width + 10

    color: "transparent"

    Text
    {
        anchors.left: parent.left
        anchors.leftMargin: 3
        color: "#5790d5"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: parent.height/2
        text: ","
        visible: separator_visible
    }

    Rectangle
    {
        id: rect_username
        height: parent.height*5/6
        width: label_username.width + 10
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color:
        {
            if( isHovered )
            {
                "#fafafa"
            }
            else
            {
                "#eff0f1"
            }
        }
        border.width: 1
        border.color:
        {
            if( isHovered )
            {
                "#679bd9"
            }
            else
            {
                "#5790d5"
            }
        }

        radius: 5

        Text
        {
            id: label_username
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            color:
            {
                if( isHovered )
                {
                    "#679bd9"
                }
                else
                {
                    "#5790d5"
                }
            }
            font.family: fontDroidKufiRegular.name
            font.pixelSize: parent.height/1.8
            text: tag_text
        }
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true

        onEntered:
        {
            isHovered = true
        }

        onExited:
        {
            isHovered = false
        }

        onClicked:
        {
            container.forceActiveFocus()
            clickTag()
        }
    }

}
