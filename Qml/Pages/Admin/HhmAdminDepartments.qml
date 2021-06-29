import QtQuick 2.0

Rectangle
{
    property string department_name: ""

    height: childrenRect.height
    width: 800
    color: "transparent"
    signal createDepartments(string text_value)

    HhmDTableTitle
    {
        id:dtable_title
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    HhmDTable
    {
        id: department_table
        anchors.left: dtable_title.left
        anchors.top: dtable_title.bottom
        onCrteDepartments:
        {
            createDepartments(text_value);
        }
    }

    function addDepartment()
    {
        department_table.addDepartmentsUser(department_name)
    }

}
