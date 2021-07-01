import QtQuick 2.0

Rectangle
{
    signal clickedBtn(int value)

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
            onClicked: clickedBtn(-1);
        }
    }

    Rectangle
    {
        width: 275
        height: childrenRect.height+40
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
                        clickedBtn(val)
                     }
        }

    }

    function addRole()
    {
        select.addRole(role)
    }

}
