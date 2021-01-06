import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle
{
    id: container

    property string text_placeholder: "username"
    property string font_name: fontRobotoMedium.name
    property int font_weight: Font.Medium
    property int font_size: 15
    property bool password_type: false

    property string text_icon: "\uf007"
    property int animate_x_to
    property int animate_x_from
    property int animate_duration: 500

    radius: 5
    color: "transparent"
    border.width: 1
    border.color: "#512DA8"

    NumberAnimation
    {
        id: animateX
        properties: "x"
        duration: animate_duration
        target: container
        from: animate_x_from
        to: animate_x_to
    }

    Rectangle
    {
        anchors.fill: parent
        z: -3
        color: "white"
        opacity: 0.45
        radius: 5
    }

    Rectangle
    {
        id: rect_icon
        width: 40
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
        radius: 5
        color: "#512DA8"

        Rectangle
        {
            id: rnd2
            width: parent.radius*2
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.right
            color: parent.color
        }

        Text
        {
            id: icon
            text: text_icon
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontAwesomeSolid.name
            font.pixelSize: 15
            color: "#ccc"
        }
    }

    TextField
    {
        id: text_input
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: rect_icon.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        font.pixelSize: font_size
        font.family: font_name
        font.weight: Font.Bold
        textColor: "#222"
        selectByMouse: true
        placeholderText: text_placeholder
        echoMode: password_type? TextInput.Password : TextInput.Normal
        style: TextFieldStyle
        {
            background: Rectangle
            {
                color: "transparent"
            }
        }
    }

    Keys.onEscapePressed:
    {
        text_input.focus = false
    }

    MouseArea
    {
        anchors.fill: parent
        z: -1

        onClicked:
        {
            text_input.forceActiveFocus()
        }
    }

    function animateTextInput(from, to)
    {
        animate_x_from = from
        animate_x_to = to
        animateX.start()
    }

    function focusOnTextInput()
    {
        text_input.forceActiveFocus()
    }

    function getText()
    {
        return text_input.text
    }

}
