import QtQuick 2.0

Rectangle
{

    property string icon: "\uf024"
    property string action: "New"

    property bool isHovered: false

    width: childrenRect.width
    color:
    {
        if(isHovered)
        {
            "#718dc1"
        }
        else
        {
            "transparent"
        }
    }

    Text
    {
        id: label_icon
        text: icon
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.family: fontAwesomeSolid.name
        font.pixelSize: 15
        color: "#d8dbe0"
    }

    Text
    {
        id: label_action
        text: action
        anchors.left: label_icon.right
        anchors.leftMargin: 5 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        font.family: fontRobotoMedium.name
        font.weight: Font.Medium
        font.pixelSize: 15
        color: "#d8dbe0"
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
            console.log("Action:", action)
        }
    }

}
