import QtQuick 2.0

Rectangle
{
    id: container

    property string text_icon:  "\uf0e0"
    property color  color_icon: "#b7b1b1"

    property bool isHovered:    false
    property bool isActive:     false

    property color color_background_normal:     "#2b303a"
    property color color_background_hovered:    "#394255"
    property color color_background_active:     "#415073"

    width: 50
    height: 50
    color:
    {
        if( isActive )
        {
            color_background_active
        }
        else if( isHovered )
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }

    signal buttonClicked()

    Rectangle
    {
        width: parent.width
        height: 1
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#7a8db2"
    }

    Text
    {
        text: text_icon
        anchors.centerIn: parent
        font.family: fontAwesomeSolid.name
        font.pixelSize: 25
        color: color_icon
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
            buttonClicked()
        }
    }

}
