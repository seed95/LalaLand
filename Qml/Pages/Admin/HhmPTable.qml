import QtQuick 2.0

Item
{
    signal checkBoxChanged(int col_id, int row_id, int value)
    signal crtePermission(string text_value)

    height: childrenRect.height
    width: 800

    ListModel
    {
        id: permissionListModel
    }

    Component
    {
           id: permissionRowDelegate

           HhmPTableRow
           {
               id_number: list_number
               id_name: list_name
               onChkBoxChanged:
               {
                   checkBoxChanged(id, ar2en(list_number), val);
               }
           }
    }

    ListView
    {
        id: permissionListView

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height
        interactive: false

        model: permissionListModel
        delegate: permissionRowDelegate
    }

    HhmPTableNewRow
    {
        anchors.left: parent.left
        anchors.top: permissionListView.bottom

        is_odd: (permissionListModel.count+1)%2

        onCreatePermission:
        {
            addPermissionUser(text_value);
            crtePermission(text_value);
        }
    }

    function addPermissionUser(username)
    {
        permissionListModel.append({list_number: en2ar(permissionListModel.count+1),list_name: username })
    }
}
