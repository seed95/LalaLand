import QtQuick 2.0

Rectangle
{
    property string text_tab: "المستخدمين"
    property color color_bg:
                           {
                                if( is_active )
                                {
                                    if( is_hovered )
                                    {
                                        "#FFFFFF"
                                    }
                                    else
                                    {
                                        "#F0F0F0"
                                    }
                                }
                                else
                                {
                                    if( is_hovered )
                                    {
                                        "#F0F0F0"
                                    }
                                    else
                                    {
                                        "#DCDCDC"
                                    }
                                }
                           }
    property color color_border:
                           {
                                if( is_active )
                                {
                                    if( is_hovered )
                                    {
                                        "#5F89B9"
                                    }
                                    else
                                    {
                                        "#53769D"
                                    }
                                }
                                else
                                {
                                    if( is_hovered )
                                    {
                                        "#969696"
                                    }
                                    else
                                    {
                                        "#646464"
                                    }
                                }
                           }

    property color text_color: color_border

    property bool is_active: false
    property bool is_hovered: false

    signal clickedTab()
    color: "transparent"
    width: 140
    height: 35

    Canvas
    {
        anchors.fill: parent
        id: mycanvas
        onPaint:
        {
            var ctx = getContext("2d");
            ctx.fillStyle = color_bg;
            ctx.lineWidth = 1;
            ctx.strokeStyle = color_border;
            ctx.beginPath();
            ctx.moveTo(20,0);
            ctx.lineTo(width-20,0);
            ctx.lineTo(width, 35);
            ctx.lineTo(0, 35);
            ctx.lineTo(20,0);
            ctx.closePath();
            ctx.fill();
            ctx.stroke();
        }
    }

    Text
    {
        anchors.centerIn: parent
        text: text_tab
        color: text_color
        font.pixelSize: 14
        font.family: fontDroidKufiRegular.name
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: clickedTab();
        onEntered:
                 {
                    is_hovered = true;
                    mycanvas.requestPaint();
                 }
        onExited:
                {
                   is_hovered = false;
                   mycanvas.requestPaint();
                }
    }

    function updateCanvas()
    {
        mycanvas.requestPaint();
    }
}
