import QtQuick 2.0

Rectangle
{
    signal clickedBtn(int value)

    property bool is_active: false
    property bool is_hovered: false

    color: "transparent"

    property color m01: "#d2d2d2"
    property color m02: "#8d9286"
    property int arcRadius: 10

    Rectangle
    {
        width: 200
        height: 125
        color: "transparent"

        Canvas
        {
            anchors.fill: parent
            id: dropDownBox01
            onPaint:
            {
                var ctx = getContext("2d");
                ctx.fillStyle = m01;
                ctx.lineWidth = 1;
                ctx.strokeStyle = m02;
                ctx.beginPath();
                ctx.moveTo(arcRadius,15);
                ctx.arc(arcRadius,15+arcRadius,arcRadius,3*Math.PI/2,Math.PI,true)
                ctx.lineTo(0,height-arcRadius);
                ctx.arc(arcRadius,height-arcRadius,arcRadius,Math.PI,Math.PI/2,true)
                ctx.lineTo(width-arcRadius,height);
                ctx.arc(width-arcRadius,height-arcRadius,arcRadius,Math.PI/2,0,true)
                ctx.lineTo(width,15+arcRadius);
                ctx.arc(width-arcRadius,15+arcRadius,arcRadius,0,3*Math.PI/2,true)
                ctx.lineTo(width/2+15,15);
                ctx.lineTo(width/2,0);
                ctx.lineTo(width/2-15,15);
                ctx.lineTo(arcRadius,15);
                ctx.closePath();
                ctx.fill();
                ctx.stroke();
            }
        }
    }


    Rectangle
    {
        width: childrenRect.width
        height: 120
        color: "green"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 25

        ListModel
        {
            id: sectionDropDownList

            ListElement
            {
                list_item: "English"
            }
            ListElement
            {
                list_item: "French"
            }
            ListElement
            {
                list_item: "Italian"
            }
        }

        Component
        {
            id: meli01

            HhmDropDownItem
            {
                text_val: list_item
                width: 180
                height: 30
            }
        }

        ListView
        {
            anchors.fill: parent
            model: sectionDropDownList
            delegate: meli01
        }

    }

    HhmSelect
    {
        id: select
        anchors.centerIn: parent
        width: 240

        onClicked:
                 {
                    clickedBtn(val)
                 }
    }

    function addItem(i_item)
    {
        select.addItem(i_item)
    }

}
