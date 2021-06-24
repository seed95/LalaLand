import QtQuick 2.0

Item
{
    HhmTab
    {
        id: admin_tab

        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmAdminUser
    {
        anchors.left: parent.left
        anchors.top: parent.top

        visible: admin_tab.active_tab===1
    }

    HhmAdminPermissions
    {
        anchors.left: parent.left
        anchors.top: parent.top

        visible: admin_tab.active_tab===2
    }

    HhmAdminDepartments
    {
        anchors.left: parent.left
        anchors.top: parent.top

        visible: admin_tab.active_tab===3
    }
}
