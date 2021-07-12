import QtQuick 2.0

Item
{
    height: childrenRect.height
    width: 905

    signal crteDepartments(string text_value)
    signal rmvDepartments(int department_indx)
    signal addDepartmentGrp()
    signal removeDepartmentGrp(int department_indx, string tg_name)

    property int row_number: 0
    property string next_tag_text: ""

    ListModel
    {
        id: lm_department
    }

    Component
    {
           id: departmentsRowDelegate

           HhmDTableRow
           {
               id_number: list_number
               id_name: list_dname

               addTagFlag: tag_flag

               onAddDepartmentGroup:
               {
                   addDepartmentGrp(ar2en(id_number)) //signal send to c++
                   row_number = ar2en(id_number) - 1;
               }

               onClkedBtn:
                         {
                            removeDepartment(ar2en(id_number));
                         }

               onRemoveDepartmentGroup:
                                       {
                                           removeDepartmentGrp(ar2en(id_number), tg_name)
                                       }
           }
    }

    ListView
    {
        id: lv_department

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height
        interactive: false

        model: lm_department
        delegate: departmentsRowDelegate
    }

    HhmDTableNewRow
    {
        anchors.right: parent.right
        anchors.top: lv_department.bottom

        is_odd: (lm_department.count)%2

        onCreateDepartments:
        {
            crteDepartments(text_value);
            addDepartmentsUser(text_value);
        }
    }

    function addDepartmentsUser(d_name)
    {
        lm_department.append({list_number: en2ar(lm_department.count+1),
                              list_dname: d_name ,tag_flag: 0})
    }

    function addDepartmentTagF(index)
    {
        lm_department.get(index).tag_flag = 1;
        lm_department.get(index).tag_flag = 0;
    }

    function removeDepartment(index)
    {
        lm_department.remove(index-1);
        rmvDepartments(index);

        var count = lm_department.count;

        for( var i=0 ; i<count ; i++ )
        {
            lm_department.get(i).list_number = en2ar(i+1);
        }
    }

    function removeGroups(g_name)
    {
        next_tag_text = g_name;
        var i=0;
        console.log( "g_name= " + g_name);

        for( i=0 ; i<lm_department.count ; i++ )
        {
            lm_department.get(i).tag_flag = -1;
        }

        for( i=0 ; i<lm_department.count ; i++ )
        {
            lm_department.get(i).tag_flag = 0;
        }
    }

    function isDeparmentExist(d_name)
    {
        for( var i=0 ; i<lm_department.count ; i++ )
        {
            if( lm_department.get(i).list_dname===d_name )
            {
                return true;
            }
        }

        return false;
    }

    function isDeparmentValid(d_name)
    {
        if( lm_department.get(row_number).list_dname===d_name )
        {
            return false;
        }

        return true;
    }
}
