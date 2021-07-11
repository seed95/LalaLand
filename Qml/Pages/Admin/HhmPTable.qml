import QtQuick 2.0

Item
{
    signal checkBoxChanged(int col_id, int row_id, int value)
    signal crtePermission(string text_value)
    signal rmvPermission(int permission_indx)

    height: childrenRect.height
    width: 800

    ListModel
    {
        id: lm_permission
    }

    Component
    {
           id: permissionRowDelegate

           HhmPTableRow
           {
               id_number: list_number
               id_name: list_name
               permission_1: permission1
               permission_2: permission2
               permission_3: permission3
               permission_4: permission4
               permission_5: permission5
               permission_6: permission6
               permission_7: permission7
               permission_8: permission8
               permission_9: permission9

               onChkBoxChanged:
               {
                   checkBoxChanged(id, ar2en(list_number), val);
               }

               onClkedBtn:
                         {
                            removePermissionUser(ar2en(id_number));
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

        model: lm_permission
        delegate: permissionRowDelegate
    }

    HhmPTableNewRow
    {
        anchors.left: parent.left
        anchors.top: permissionListView.bottom

        is_odd: (lm_permission.count+1)%2

        onCreatePermission:
        {
            addPermissionUser(text_value, false, false, false, false,
                              false, false, false, false, false);
            crtePermission(text_value);
        }
    }

    function addPermissionUser(p_name, permission_1, permission_2, permission_3, permission_4,
                               permission_5, permission_6, permission_7, permission_8,
                               permission_9)
    {
        lm_permission.append({list_number: en2ar(lm_permission.count+1),list_name: p_name,
                            permission1: permission_1, permission2: permission_2,
                            permission3: permission_3, permission4: permission_4,
                            permission5: permission_5, permission6: permission_6,
                            permission7: permission_7, permission8: permission_8,
                            permission9: permission_9})
    }

    function removePermissionUser(index)
    {
        lm_permission.remove(index-1);
        rmvPermission(index);

        var count = lm_permission.count;

        for( var i=0 ; i<count ; i++ )
        {
            lm_permission.get(i).list_number = en2ar(i+1);
        }
    }
}
