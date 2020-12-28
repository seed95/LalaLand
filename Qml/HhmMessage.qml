import QtQuick 2.5

Rectangle
{
    id: container

    property color rect_bg_color: "#1e1e1e"
    property color rect_border_color: "#9f9f29"
    property int rect_radius: 10
    property int rect_border_width: 1

    property string text_message: "error message"
    property color text_color: "#dbdb6f"

    property int timer_interval: 100

    width: label_message.width + 50
    height: label_message.height + 35
    color: rect_bg_color
    radius: rect_radius
    border.color: rect_border_color
    border.width: rect_border_width
    opacity: 0
    visible: opacity != 0

    Text
    {
        id: label_message
        text: text_message
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -3
        font.pixelSize: 16
        font.family: fontRobotoLight.name
        color: text_color
    }

    NumberAnimation
    {
       id: animate_message
       targets: [container, label_message]
       properties: "opacity"
       duration: 700
    }

    Timer
    {
        id: timer_message
        interval: timer_interval
        repeat: false

        onTriggered:
        {
            if(!running)
            {
                animate_message.to = 0
                animate_message.start()
            }
        }
    }

    function showMessage(txt, interval)
    {
        timer_message.stop()
        animate_message.stop()
        text_message = txt
        timer_interval = interval
        container.opacity = 1
        label_message.opacity = 1
        timer_message.start()
    }

}
