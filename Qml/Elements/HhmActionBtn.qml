import QtQuick 2.0

Rectangle
{
    id: container

    property string icon_text: "\uf024"
    property int    icon_left_margin: 3
    property string action_text: "New"
    property int    action_vertical_offset: -4
    property int    action_left_margin: 2

    property bool isHovered: false

    property color color_label_normal: "#353b43"
    property color color_label_hovered: "#474e59"
    property color color_label:
    {
        if(isHovered)
        {
            color_label_hovered
        }
        else
        {
            color_label_normal
        }
    }

    signal buttonClicked()

    color:
    {
        if(isHovered)
        {
            "#e6e6e6"
        }
        else
        {
            "transparent"
        }
    }

    Rectangle
    {
        height: parent.height
        width: childrenRect.width
        anchors.centerIn: parent
        color: "transparent"

        Text
        {
            id: label_action
            text: action_text
            anchors.left: parent.left
            anchors.leftMargin: action_left_margin
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: action_vertical_offset
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 15
            color: color_label
        }

        Text
        {
            id: label_icon
            text: icon_text
            anchors.left: label_action.right
            anchors.leftMargin: icon_left_margin
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontAwesomeSolid.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color: color_label
        }


    }

    MouseArea
    {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
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
            buttonClicked()
        }
    }

}
