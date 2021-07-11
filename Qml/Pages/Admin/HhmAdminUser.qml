import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    // begin cpp variables
    property string user_name: ""
    property string user_username: ""
    property int user_index: 0
    property string tag_name: ""
    property string department_name: ""
    // end of cpp varibles
    property string role: ""

    signal setUserRole(int role_index, int user_index)
    signal removeUserRole(int user_index, string role_name)
    signal setUserDepartment(int user_index, int department_index)

    height: childrenRect.height
    color: "transparent"

    HhmUTableTitle
    {
        id: utable_title
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Flickable
    {
        id: flickable_user
        anchors.left: utable_title.left
        anchors.top: utable_title.bottom
        anchors.bottom: parent.bottom
        width: 905

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

            onClickedDownBottom:
                               {
                                    drop_dialog.visible = !drop_dialog.visible;
                                    unselect_hover.visible = true;
                               }

            onRemoveUsrRole:
                           {
                                removeUserRole(user_index, tg_name)
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
                        visible = false;
                        if( sel_txt )
                        {
                            setUserRole(u_table.row_number, value);
                            u_table.next_tag_text = sel_txt;
                            u_table.addRoleTagF(u_table.row_number);
                        }
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

    Rectangle
    {
        id: unselect_hover
        anchors.fill: parent
        color: "black"
        opacity: 0.02
        visible: false

        MouseArea
        {
            anchors.fill: parent
            onClicked:
                     {
                         unselect_hover.visible = false;
                         drop_dialog.visible = false;
                     }
        }
    }

    HhmDropDialog
    {
        id: drop_dialog
        visible: false
        anchors.left: parent.left
        anchors.leftMargin: 400
        anchors.top: parent.top
        anchors.topMargin: 30*u_table.row_number + 68

        onClickedBtn:
                    {
                        drop_dialog.visible = false;
                        unselect_hover.visible = false;
                        u_table.setUserDepartment(u_table.row_number, sel_text)
                        setUserDepartment(u_table.row_number, value);
                    }
    }

    function addUser()
    {
        u_table.addUser(user_name, user_username, department_name)
    }

    function addRole()
    {
        hover_select.addItem(role)
    }

    function removeRole()
    {
        hover_select.removeItem(role)
    }

    function addRle()
    {
        u_table.addRole(role);
    }

    function addTag() //From c++
    {
        u_table.next_tag_text = tag_name;
        u_table.row_number = user_index;
        u_table.addRoleTagF(u_table.row_number);
    }

    function addDeprtment()
    {
        drop_dialog.addItem(department_name);
    }

    function setUserDepartmentQ()
    {
        u_table.setUserDepartment(user_index, department_name);
    }
}
