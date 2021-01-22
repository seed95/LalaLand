import QtQuick 2.0

Rectangle
{
    id: container

    property string text_button: "Sign In"
    property bool isHovered: false

    signal signInClicked()

    color:
    {
        if(isHovered)
        {
            "#4d66b7"
        }
        else
        {
            "#3d5298"
        }
    }
    radius: 5
    border.width: 1
    border.color:
    {
        if(isHovered)
        {
            "#24242c"
        }
        else
        {
            "#09090b"
        }
    }

    Text
    {
        id: text_button_login
        text: text_button
        anchors.centerIn: parent
        font.pixelSize: 15
        font.family: fontRobotoMedium.name
        font.weight: Font.Medium
        color:
        {
            if(isHovered)
            {
                "#ffffff"
            }
            else
            {
                "#c0c8d0"
            }
        }
    }

    MouseArea
    {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked:
        {
            signInClicked()
        }

        onEntered:
        {
            isHovered = true
        }

        onExited:
        {
            isHovered = false
        }
    }

}
