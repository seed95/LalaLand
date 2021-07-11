import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    // begin cpp variables
    property string department_name: ""
    property int department_index: 0
    property string group_name: ""
    // end of cpp varibles

    height: childrenRect.height
    color: "transparent"
    signal createDepartments(string text_value)
    signal removeDepartmentC(int department_index)
    signal addDepartmentGroup(int department_index, int group_index)
    signal removeDepartmentGroup(int department_index, string group_name)

    HhmDTableTitle
    {
        id:dtable_title
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Flickable
    {
        id: flickable_department
        anchors.left: dtable_title.left
        anchors.top: dtable_title.bottom
        anchors.bottom: parent.bottom
        width: 905

        clip: true
        contentHeight: d_table.height+50
        ScrollBar.vertical: departments_scrollbar

        HhmDTable
        {
            id: d_table
            anchors.left: parent.left
            anchors.top: parent.top
            onCrteDepartments:
            {
                createDepartments(text_value);
                dhover_select.addItem(text_value); //add to select dialog
            }

            onAddDepartmentGrp:
            {
                dhover_select.visible = true;
            }

            onRmvDepartments:
            {
                removeDepartmentC(department_indx);
                dhover_select.removeItem(department_indx); //add to select dialog
            }

            onRemoveDepartmentGrp:
            {
                removeDepartmentGroup(department_indx, tg_name)
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
                        if( sel_txt )
                        {
                            addDepartmentGroup(d_table.row_number, value);
                            d_table.next_tag_text = sel_txt;
                            d_table.addDepartmentTagF(d_table.row_number);
                        }
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
        d_table.addDepartmentsUser(department_name)
    }

    function cppRemoveDepartment() //called from cpp
    {
        d_table.removeGroups(department_name)
    }

    function addSelectGroup()
    {
        dhover_select.addItem(group_name)
    }

    function setGroup() //From c++
    {
        d_table.next_tag_text = group_name;
        d_table.row_number = department_index;
        d_table.addDepartmentTagF(d_table.row_number);
    }
}
