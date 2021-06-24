import QtQuick 2.0

Rectangle
{
    id: container

    property string icon: "\uf024"
    property string action: "New"

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
        id: rect_rtl
        height: parent.height
        width: childrenRect.width
        anchors.centerIn: parent
        color: "transparent"
        visible: root.rtl

        Text
        {
            id: label_icon_rtl
            text: icon
            anchors.left: label_action_rtl.right
            anchors.leftMargin: 7
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontAwesomeSolid.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color: color_label
        }

        Text
        {
            id: label_action_rtl
            text: action
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            font.family: fontArialRegular.name
//            font.weight: Font.Normal
            font.pixelSize: 18
            color: color_label
        }
    }

    Rectangle
    {
        id: rect_ltr
        height: parent.height
        width: childrenRect.width
        anchors.centerIn: parent
        color: "transparent"
        visible: !root.rtl

        Text
        {
            id: label_icon_ltr
            text: icon
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontAwesomeSolid.name
            font.pixelSize: 14
            color: color_label
        }

        Text
        {
            id: label_action_ltr
            text: action
            anchors.left: label_icon_ltr.right
            anchors.leftMargin: 7
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontRobotoMedium.name
            font.weight: Font.Medium
            font.pixelSize: 17
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
