import QtQuick 2.0

Rectangle
{
    id: container

    property string text_button: "Sign In"
    property bool isHovered: false

    signal signInClicked()

    color: "transparent"

    property color color_background:
    {
        if(isHovered)
        {
            "#e2d6de"
        }
        else
        {
            "#cbb4c4"
        }
    }

    Rectangle
    {
        id: rnd1
        width: parent.width
        height: parent.height * 0.33
        anchors.top: parent.top
        anchors.left: parent.left
        color: color_background
    }

    Rectangle
    {
        id: rnd2
        width: parent.width
        height: parent.height * 0.88
        anchors.bottom: parent.bottom
        radius: 5
        color: color_background
    }

    Text
    {
        id: text_button_login
        text: text_button
        anchors.centerIn: parent
        font.pixelSize: 15
        font.family: fontRobotoMedium.name
        font.weight: Font.Medium
        color: "#333"
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
