import QtQuick 2.0

Rectangle
{
    height: 500
    width: 800
    color: "transparent"

    HhmDepartmentsTableTitle
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 90
    }

    HhmDepartmentsTable
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 120
    }

}
