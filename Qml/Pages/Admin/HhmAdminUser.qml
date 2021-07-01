import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    property string user_name: ""
    property string user_username: ""
    property string role: ""
    signal setUserRole (int user_id, int user_role)
    signal addUserRole(int user_id)

    height: childrenRect.height
    color: "transparent"

    HhmUTableTitle
    {
        id: utable_title
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Flickable
    {
        id: flickable_user
        anchors.left: utable_title.left
        anchors.top: utable_title.bottom
        anchors.bottom: parent.bottom
        width: 900

        clip: true
        contentHeight: u_table.height+50
        ScrollBar.vertical: users_scrollbar

        HhmUTable
        {
            id: u_table

            anchors.left: parent.left
            anchors.top: parent.top

            onAddUsrRole:
                        {
                              hover_select.visible = true;
                        }
        }
    }

    HhmHoverSelect
    {
        id: hover_select
        anchors.fill: parent

        visible: false
        onClickedBtn:
                    {
                        addUserRole(value)
                        visible = false;
                        console.log(value)
                    }
    }

    ScrollBar
    {
        id: users_scrollbar
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

    function addUser()
    {
        u_table.addUser(user_name, user_username)
    }

    function addRole()
    {
        hover_select.addItem(role)
    }

    function addRle()
    {
        u_table.addRole(role);
    }
}
