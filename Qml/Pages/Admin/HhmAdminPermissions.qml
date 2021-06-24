import QtQuick 2.0

Rectangle
{
    height: 500
    width: 800
    color: "transparent"

    HhmAdminPermissionsTitles
    {
        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmTablePermissions
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 250
    }

}
