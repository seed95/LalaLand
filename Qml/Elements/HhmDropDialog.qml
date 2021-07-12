import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    signal clickedBtn(int value, string sel_text)

    property bool is_active: false
    property bool is_hovered: false

    color: "transparent"

    property color m01: "#d2d2d2"
    property color m02: "#8d9286"
    property int arcRadius: 10

    Rectangle
    {
        width: 200
        height:flickable_departments.height+30
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
        width: 180
        height: flickable_departments.height
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 22

        ListModel
        {
            id: lm_department
        }

        Component
        {
            id: ud_department

            HhmDropDownItem
            {
                text_val: item_list
                width: 180
                height: 30

                onClcked:
                        {
                            clickedBtn(item_id, text_val)
                        }
            }
        }

        Flickable
        {
            id: flickable_departments
            anchors.left: parent.left
            anchors.top: parent.top

            width: parent.width
            height:
                  {
                     if( lm_department.count>10 )
                     {
                         300
                     }
                     else
                     {
                         lm_department.count*30
                     }
                  }

            clip: true
            contentHeight: lv_dropdialog.height
            ScrollBar.vertical: departments_scrollbar

            ListView
            {
                id: lv_dropdialog

                width: parent.width
                height: childrenRect.height

                model: lm_department
                delegate: ud_department
            }
        }

        ScrollBar
        {
            id: departments_scrollbar
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            background: Rectangle
            {
                width: 6
                anchors.left: parent.left
                anchors.top: parent.top
                color: "#b4b4b4"
            }

            contentItem: Rectangle
            {
                anchors.left: parent.left
                radius: 3
                implicitWidth: 6
                implicitHeight: 50
                color: "#646464"
            }

            policy: ScrollBar.AsNeeded
        }
    }

    function addItem(i_item)
    {
        lm_department.append({item_id: lm_department.count, item_list: i_item});
    }

    function removeItem(d_name)
    {
        var i=0;

        for( i=0 ; i<lm_department.count ; i++ )
        {
            if( lm_department.get(i).item_list===d_name )
            {
                lm_department.remove(i);
            }
        }
    }
}
