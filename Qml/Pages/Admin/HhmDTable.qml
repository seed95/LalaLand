import QtQuick 2.0

Item
{
    height: childrenRect.height
    width: 905

    signal crteDepartments(string text_value)
    signal addDepartmentGrp()

    property int row_number: 0
    property string next_tag_text: ""

    ListModel
    {
        id: departmentsListModel
    }

    Component
    {
           id: departmentsRowDelegate

           HhmDTableRow
           {
               id_number: list_number
               id_username: list_username

               addTagFlag: tag_flag

               onAddDepartmentGroup:
               {
                   addDepartmentGrp(id_number) //signal send to c++
                   row_number = ar2en(id_number) - 1;
               }
           }
    }

    ListView
    {
        id: departmentsListView

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height
        interactive: false

        model: departmentsListModel
        delegate: departmentsRowDelegate
    }

    HhmDTableNewRow
    {
        anchors.left: parent.left
        anchors.top: departmentsListView.bottom

        is_odd: (departmentsListModel.count)%2

        onCreateDepartments:
        {
            crteDepartments(text_value);
            addDepartmentsUser(text_value);
        }
    }

    function addDepartmentsUser(username)
    {
        departmentsListModel.append({list_number: en2ar(departmentsListModel.count+1),
                                     list_username: username ,tag_flag: 0})
    }

    function addDepartmentTagF(index)
    {
        var flag = departmentsListModel.get(index).tag_flag;

        if( flag )
        {
            departmentsListModel.get(index).tag_flag = 0;
        }
        else
        {
            departmentsListModel.get(index).tag_flag = 1;
        }
    }

}
