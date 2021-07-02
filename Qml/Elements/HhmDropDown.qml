import QtQuick 2.0

Rectangle
{
    property bool is_hovered: false
    signal clickedDownBottom()

    Rectangle
    {
        id: section
        width: 149
        height: 24
        color: "#e6e6e6"
        radius: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 360
        anchors.left: parent.left
        border.color: "#969696"
    }

    HhmDownBtn
    {
        id: downButton
        anchors.verticalCenter: section.verticalCenter
        anchors.left: section.left

        onClickedDwnBottom:
                          {
                            clickedDownBottom()
                          }
    }
}
