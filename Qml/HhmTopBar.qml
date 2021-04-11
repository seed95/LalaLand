import QtQuick 2.0

Item
{

    width: 980
    height: childrenRect.height

    HhmNews
    {
        id: news
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }

    HhmActionBox
    {
        id: actions
        width: parent.width
        height: 50
        anchors.left: parent.left
        anchors.top: news.bottom
    }

}
