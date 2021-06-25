import QtQuick 2.0

Item
{
    signal checkBoxChanged(int col_id, int row_id, int value)
    signal crtePermission(string text_value)

    height: 500
    width: 800

    ListModel
    {
        id: permissionListModel
        ListElement
        {
            list_number: "۱"
            list_name: "المدير التنفيذي"
        }
        ListElement
        {
            list_number: "۲"
            list_name: "مدير الإدارة"
        }
        ListElement
        {
            list_number: "٣"
            list_name: "مدير مجموعة"
        }
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
