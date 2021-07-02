import QtQuick 2.0

Rectangle
{
    property color color_bg:
                           {
                                if( is_hovered )
                                {
                                    "#427EC2"
                                }
                                else
                                {
                                    "#3D628B"
                                }
                           }

    property color text_color:
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
    property bool is_hovered: false
    property string b_text: ""

    signal clcked()
    signal clickedDwnBottom()

    height: 40
    border.width: 1
    color: color_bg


    Rectangle
    {
        id: downButton
        width: 26
        height: 24
        color: color_bg
        radius: 5
        border.color: "#969696"

        anchors.centerIn: parent

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onClicked:
                     {
                        clickedDwnBottom();
                     }
            onEntered:
                     {
                        is_hovered = true;
                     }
            onExited:
                    {
                       is_hovered = false;
                    }
        }

        Text
        {
            id: downButtonIcon
            text: "\uf107"
            color: text_color
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: fontAwesomeSolid.name
            font.pixelSize: 15
        }

        Rectangle
        {
            id: downButton01
            width: 5
            height: 22
            color: color_bg
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: downButton.right

            Rectangle
            {
                id: downButton02
                width: 1
                height: 24
                color: "#969696"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
            }
        }
    }
}

