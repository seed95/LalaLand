import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    property string department_name: ""

    height: childrenRect.height
    color: "transparent"
    signal createDepartments(string text_value)
    signal addDepartmentGroup()

    HhmDTableTitle
    {
        id:dtable_title
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Flickable
    {
        id: flickable_department
        anchors.left: dtable_title.left
        anchors.top: dtable_title.bottom
        anchors.bottom: parent.bottom
        width: 900

        clip: true
        contentHeight: department_table.height+50
        ScrollBar.vertical: departments_scrollbar

        HhmDTable
        {
            id: department_table
            anchors.left: parent.left
            anchors.top: parent.top
            onCrteDepartments:
            {
                createDepartments(text_value);
            }

            onAddDepartmentGrp:
            {
                addDepartmentGroup();
                dhover_select.visible = true;
            }
        }
    }

    HhmHoverSelect
    {
        id: dhover_select
        anchors.fill: parent

        visible: false
        onClickedBtn:
                    {
                        visible = false;
                        console.log(value)
                    }
    }

    ScrollBar
    {
        id: departments_scrollbar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        background: Rectangle
        {
            width: 6
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#b4b4b4"
        }

        contentItem: Rectangle
        {
            anchors.left: parent.left
            radius: 3
            implicitWidth: 6
            implicitHeight: 50
            color: "#646464"
        }

        policy: ScrollBar.AsNeeded
    }

    function addDepartment()
    {
        department_table.addDepartmentsUser(department_name)
    }

}
