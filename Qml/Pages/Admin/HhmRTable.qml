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
        id: lm_role
    }

    Component
    {
           id: ld_role

           HhmRTableRow
           {
               row_index: list_number
               row_rname: list_name
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
                   checkBoxChanged(id, ar2en(row_index), val);
               }

               onClkedBtn:
                         {
                            removePermissionUser(ar2en(row_index));
                         }
           }
    }

    ListView
    {
        id: lv_role

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height
        interactive: false

        model: lm_role
        delegate: ld_role
    }

    HhmRTableNewRow
    {
        anchors.left: parent.left
        anchors.top: lv_role.bottom

        is_odd: (lm_role.count+1)%2

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
        lm_role.append({list_number: en2ar(lm_role.count+1),list_name: p_name,
                            permission1: permission_1, permission2: permission_2,
                            permission3: permission_3, permission4: permission_4,
                            permission5: permission_5, permission6: permission_6,
                            permission7: permission_7, permission8: permission_8,
                            permission9: permission_9})
    }

    function removePermissionUser(index)
    {
        lm_role.remove(index-1);
        rmvPermission(index);

        var count = lm_role.count;

        for( var i=0 ; i<count ; i++ )
        {
            lm_role.get(i).list_number = en2ar(i+1);
        }
    }

    function isPermissionExist(p_name)
    {
        for( var i=0 ; i<lm_role.count ; i++ )
        {
            if( lm_role.get(i).list_name===p_name )
            {
                return true;
            }
        }

        return false;
    }
}
