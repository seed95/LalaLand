import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    property string permission_name: ""
    property bool cpp_permission1: false
    property bool cpp_permission2: false
    property bool cpp_permission3: false
    property bool cpp_permission4: false
    property bool cpp_permission5: false
    property bool cpp_permission6: false
    property bool cpp_permission7: false
    property bool cpp_permission8: false
    property bool cpp_permission9: false
    property int permission_row: 0
    property int permission_column: 0

    height: childrenRect.height
    color: "transparent"
    signal createPermission(string text_value)
    signal removePermission(int permission_index)
    signal chkBoxChanged(int row_id, int col_id, int val)

    HhmPTableTitles
    {
        id: pTableTitle

        anchors.left: parent.left
        anchors.leftMargin: 90
        anchors.top: parent.top
        anchors.topMargin: 40
        height: 150
        width: 800
    }

    Flickable
    {
        id: flickable_permisson
        anchors.left: pTableTitle.left
        anchors.top: pTableTitle.bottom
        anchors.bottom: parent.bottom
        width: 900

        clip: true
        contentHeight: permission_table.height+50
        ScrollBar.vertical: permission_scrollbar

        HhmPTable
        {
            id: permission_table
            anchors.left: parent.left
            anchors.top: parent.top

            onCheckBoxChanged:
            {
                chkBoxChanged(row_id, col_id, value);
            }

            onCrtePermission:
            {
                createPermission(text_value);
            }

            onRmvPermission:
            {
                removePermission(permission_indx);
            }
        }

    }

    ScrollBar
    {
        id: permission_scrollbar
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

    function addPermission()
    {
        permission_table.addPermissionUser(
                    permission_name, cpp_permission1, cpp_permission2,
                    cpp_permission3, cpp_permission4, cpp_permission5,
                    cpp_permission6, cpp_permission7, cpp_permission8,
                    cpp_permission9);
    }

    function setPermission()
    {
        //console.log("set permissin:" + permission_row + " " + permission_column)
    }
}
