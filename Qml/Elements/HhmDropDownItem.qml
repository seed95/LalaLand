import QtQuick 2.12
import QtQuick.Window 2.12

Item
{
    property string text_val: "English"
    property bool is_hovered: false
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

    width: 180
    height: 30

    Rectangle
    {
        anchors.fill: parent

        color: color_bg
        border.color: color_border
    }

    Text
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10

        text: text_val
        color: text_color
    }

    MouseArea
    {
        anchors.fill: parent

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
