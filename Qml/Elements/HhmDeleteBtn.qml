import QtQuick 2.0

Rectangle
{
    signal clickedBtn()
    property color backcolor_Plus:
                                 {
                                        if( is_hovered )
                                        {
                                            "#EFF0F1"
                                        }
                                        else
                                        {
                                            "#E5E6E7"
                                        }
                                 }
    property color bordercolor_Plus:
                                   {
                                            if( is_hovered )
                                            {
                                                "#CC6060"
                                            }
                                            else
                                            {
                                                "#969696"
                                            }

                                   }

    property bool is_hovered: false

    width: 23
    height: 23
    color: "transparent"

    Rectangle
    {
        id: deleteButton
        width: 23
        height: 23
        color: backcolor_Plus
        radius: 6
        anchors.centerIn: parent
        border.color: bordercolor_Plus
    }

    Text
    {
        id: deleteButtonIcon
        text: "X"
        color: bordercolor_Plus
        anchors.verticalCenter: deleteButton.verticalCenter
        anchors.horizontalCenter: deleteButton.horizontalCenter
        font.family: fontAwesomeSolid.name
        font.pixelSize: 10
    }

    MouseArea
    {
        anchors.fill: deleteButton
        hoverEnabled: true
        onClicked: clickedBtn();
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
