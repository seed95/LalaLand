import QtQuick 2.0

Rectangle
{
    Rectangle
    {
        id: addButton
        width: 23
        height: 23
        color: backcolor_Plus
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 17
        anchors.left: parent.left
        border.color: bordercolor_Plus
    }

    Text
    {
        id: addButtonIcon
        text: "\uf067"
        color: bordercolor_Plus
        anchors.verticalCenter: addButton.verticalCenter
        anchors.horizontalCenter: addButton.horizontalCenter
        font.family: fontAwesomeSolid.name
        font.pixelSize: 10
    }

    MouseArea
    {
        anchors.fill: addButton
        hoverEnabled: true
        onEntered:
                 {
                   is_hovered = true;
                 }
        onExited:
                 {
                   is_hovered = false;
                 }
    }
}
