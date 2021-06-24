import QtQuick 2.0

Item
{
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

           HhmTablePermissionsRow
           {
               id_number: list_number
               id_name: list_name
           }
    }

    ListView
    {
        id: permissionListView

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height

        model: permissionListModel
        delegate: permissionRowDelegate
    }

    HhmTablePermissionsNewRow
    {
        anchors.left: parent.left
        anchors.top: permissionListView.bottom

        is_odd: (permissionListModel.count+1)%2

        onCreatePermission:
        {
            addPermissionUser(text_value);
        }
    }

    function addPermissionUser(username)
    {
        permissionListModel.append({list_number: en2ar(permissionListModel.count+1),list_name: username,list_odd: true})
    }
}
