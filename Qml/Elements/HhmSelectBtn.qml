import QtQuick 2.0

Rectangle
{
    property color color_bg:
                           {
                                if( is_hovered )
                                {
                                    "#ffffff"
                                }
                                else
                                {
                                    "#f0f0f0"
                                }
                           }
    property color color_border:
                               {
                                    if( is_hovered )
                                    {
                                        "#babdb6"
                                    }
                                    else
                                    {
                                        "#8d9286"
                                    }
                               }
    property color text_color:
                             {
                                  if( is_hovered )
                                  {
                                      "#464646"
                                  }
                                  else
                                  {
                                      "#5a5a5a"
                                  }
                             }
    property bool is_hovered: false
    property string b_text: ""

    signal clcked()

    height: 40
    border.width: 1
    border.color: color_border
    color: color_bg

    Text
    {
        anchors.centerIn: parent
        text: b_text
        font.family: fontRobotoRegular.name
        font.pixelSize: 12
        color: text_color
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onClicked:
                 {
                    clcked()
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
}

