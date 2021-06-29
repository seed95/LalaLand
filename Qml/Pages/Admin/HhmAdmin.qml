import QtQuick 2.0
import QtQuick.Controls 2.10

Item
{
    HhmTab
    {
        id: admin_tab

        anchors.left: parent.left
        anchors.top: parent.top
    }

    ScrollView
    {
        width: 950
        clip: true

        anchors.left: parent.left
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom
        visible: admin_tab.active_tab===1
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        contentHeight: admin_user.height+50

        HhmAdminUser
        {
            id: admin_user

            objectName: "AdminUsers"
        }
    }


    ScrollView
    {
        width: 900
        clip: true

        anchors.left: parent.left
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom
        visible: admin_tab.active_tab===3
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        contentHeight: admin_department.height+50

        HhmAdminDepartments
        {
            id: admin_department

            objectName: "AdminDepartments"
        }
    }

    Flickable
    {
        width: 900
        clip: true

        anchors.left: parent.left
        anchors.top: admin_tab.bottom
        anchors.bottom: parent.bottom
        visible: admin_tab.active_tab===2

        contentHeight: admin_permission.height+50

        HhmAdminPermissions
        {
            id: admin_permission

            objectName: "AdminRoles"
        }
        ScrollBar.vertical: permission_scrollbar
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
            implicitHeight: 400
            color: "#646464"
        }

        policy: ScrollBar.AsNeeded
    }
}
