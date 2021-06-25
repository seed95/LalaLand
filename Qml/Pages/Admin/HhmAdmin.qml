import QtQuick 2.0

Item
{
    signal checkBoxChanged(int col_id, int row_id, int value)
    signal crtePermission(string text_value)

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

        onChkBoxChanged:
        {
            checkBoxChanged(col_id, row_id, value);
            console.log(col_id + " hello " + row_id + " row " + value);
        }

        onCreatePermission:
        {
            crtePermission(text_value);
        }

        visible: admin_tab.active_tab===2
    }

    HhmAdminDepartments
    {
        anchors.left: parent.left
        anchors.top: parent.top

        visible: admin_tab.active_tab===3
    }
}
