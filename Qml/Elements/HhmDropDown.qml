import QtQuick 2.0

Rectangle
{
    property bool is_hovered: false
    property string text_val: "تدليك"
    signal clickedDownBottom()
    color: "transparent"

    width: 149
    height: 24

    Rectangle
    {
        id: section
        width: 149
        height: 24
        color: "#e6e6e6"
        radius: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        border.color: "#969696"
    }

    Text
    {
        anchors.horizontalCenter: section.horizontalCenter
        anchors.verticalCenter: section.verticalCenter

        text: text_val
        color: "#5a5a5a"
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
