import QtQuick 2.10
//import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

Item
{
    id: container

    property string text_username:      "علي عدنان"
    property bool   separator_visible:  false//Separator is visible

    property bool isHovered: false

    signal clickUsername()

    height: 30
    width: 86

    Text
    {
        anchors.left: parent.left
        anchors.leftMargin: 7
        color: "#5790d5"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
        text: ","
        visible: separator_visible
    }

    Rectangle
    {
        id: rect_username
        height: 25
        width: 70
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
            anchors.centerIn: parent
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
            font.pixelSize: 13
            text: ""
        }
    }

    TextMetrics
    {
        id: text_metrics
        font.family: label_username.font.family
        font.pixelSize: label_username.font.pixelSize
        text: text_username

        onTextChanged:
        {
            if( text_metrics.width>rect_username.width )
            {
                label_username.text = root.sliceString(text_username, 7)
            }
            else
            {
                label_username.text = text_username
            }
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
            clickUsername()
        }
    }

}
