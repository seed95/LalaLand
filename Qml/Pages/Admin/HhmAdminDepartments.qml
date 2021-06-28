import QtQuick 2.0

Rectangle
{
    property string department_name: ""

    height: 500
    width: 800
    color: "transparent"
    signal createDepartments(string text_value)

    HhmDTableTitle
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 90
    }

    HhmDTable
    {
        id: department_table
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 120
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
