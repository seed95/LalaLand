import QtQuick 2.0

Rectangle
{
    property string permission_name: ""
    height: childrenRect.height
    width: 800
    color: "transparent"
    signal createPermission(string text_value)
    signal chkBoxChanged(int row_id, int col_id, int val)

    HhmPTableTitles
    {
        id: pTableTitle

        height: 150
        width: 800
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    HhmPTable
    {
        id: permission_table
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: pTableTitle.bottom

        onCheckBoxChanged:
        {
            chkBoxChanged(row_id, col_id, value);
        }

        onCrtePermission:
        {
            createPermission(text_value);
        }
    }

    function addPermission()
    {
        permission_table.addPermissionUser(permission_name)
    }
}

//    ScrollBar
//    {
//        id: scrollbar
//        anchors.left: parent.left
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        visible: root.rtl
//        background: Rectangle
//        {
//            width: 6
//            anchors.left: parent.left
//            anchors.top: parent.top
//            color: "#b4b4b4"
//        }

//        contentItem: Rectangle
//        {
//            anchors.left: parent.left
//            radius: 3
//            implicitWidth: 6
//            implicitHeight: 400
//            color: "#646464"
//        }

//        policy: ScrollBar.AsNeeded
//    }
