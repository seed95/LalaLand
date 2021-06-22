import QtQuick 2.0

Item
{
    HhmTab
    {
        id: admin_tab

        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmAdminPermissions
    {
        anchors.left: parent.left
        anchors.top: parent.top

        visible: admin_tab.active_tab===1
    }


}
