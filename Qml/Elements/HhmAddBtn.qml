import QtQuick 2.0

Rectangle


{
    signal clickedBtn()
    property color backcolor_Plus:
                           {
                                if( is_active )
                                {
                                    if( is_hovered )
                                    {
                                        "#477FBD"
                                    }
                                    else
                                    {
                                        "#3D628B"
                                    }
                                }
                                else
                                {
                                    if( is_hovered )
                                    {
                                        "#E6E6E6"
                                    }
                                    else
                                    {
                                        "#DCDCDC"
                                    }
                                }
                           }
    property color bordercolor_Plus:
                               {
                                    if( is_active )
                                    {
                                        if( is_hovered )
                                        {
                                            "#477FBD"
                                        }
                                        else
                                        {
                                            "#3D628B"
                                        }
                                    }
                                    else
                                    {
                                        if( is_hovered )
                                        {
                                            "#3D7FC7"
                                        }
                                        else
                                        {
                                            "#3D628B"
                                        }
                                    }
                               }

    property bool is_active: false
    property bool is_hovered: false

    Rectangle
    {
        id: addButton
        width: 23
        height: 23
        color: backcolor_Plus
        radius: 6
        anchors.centerIn: parent
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
