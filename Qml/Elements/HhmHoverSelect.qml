import QtQuick 2.0

Rectangle
{
    signal clickedBtn(int value, string sel_txt)

    property bool is_active: false
    property bool is_hovered: false

    color: "transparent"

    Rectangle
    {
        anchors.fill: parent
        color: "black"
        opacity: 0.7

        MouseArea
        {
            anchors.fill: parent
            onClicked: clickedBtn(-1, "");
        }
    }

    Rectangle
    {
        width: 275
        height: select.height+40
        color: "#d2d2d2"
        border.width: 1
        border.color: "#8d9286"
        radius: 7
        anchors.centerIn: parent

        HhmSelect
        {
            id: select
            anchors.centerIn: parent
            width: 240

            onClicked:
                     {
                        clickedBtn(val, sel_text)
                     }
        }

    }

    function addItem(i_item)
    {
        select.addItem(i_item)
    }

    function removeItem(i_item)
    {
        select.removeItem(i_item)
    }

}
