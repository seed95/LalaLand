import QtQuick 2.0

Item
{
    height: 500
    width: 800

    ListModel
    {
        id: departmentsListModel

        ListElement
        {
            list_number: "۱"
            list_username: "قسم الهندسة"
        }

        ListElement
        {
            list_number: "۲"
            list_username: "قسم التقنیه معلومات"
        }

        ListElement
        {
            list_number: "٣"
            list_username: "قسم الحسابات"
        }
    }

    Component
    {
           id: departmentsRowDelegate

           HhmDepartmentsTableRow
           {
               id_number: list_number
               id_username: list_username
           }
    }

    ListView
    {
        id: departmentsListView

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: childrenRect.height

        model: departmentsListModel
        delegate: departmentsRowDelegate
    }

    HhmDepartmentsTableNewRow
    {
        anchors.left: parent.left
        anchors.top: departmentsListView.bottom

        is_odd: (departmentsListModel.count)%2

        onCreateDepartments:
        {
            addDepartmentsUser(text_value);
        }
    }

    function addDepartmentsUser(username)
    {
        departmentsListModel.append({list_number: en2ar(departmentsListModel.count+1),list_username: username})
    }
}
