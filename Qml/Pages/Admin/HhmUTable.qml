import QtQuick 2.0

Rectangle
{
    signal stUserRole(int user_id, int user_role)
    signal addUsrRole(int user_id)
    signal removeUsrRole(int user_index, string tg_name)
    signal clickedDownBottom()

    property int row_number: 0
    property string next_tag_text: ""

    width: 905
    height: childrenRect.height

    color: "transparent"


    ListModel
    {
        id: userListModel
    }

    Component
    {
        id: userDelegate

        HhmUTableRow
        {
            id: utable_row
            width: parent.parent.width
            height: 30
            id_number: list_number
            id_username: list_username
            id_name: list_name
            drop_text: dropdown_text
            addTagFlag: tag_flag

            onAddUserRole:
                         {
                            addUsrRole(id_number); //signal send to c++
                            row_number = ar2en(id_number) - 1;
                         }

            onClickedDnBottom:
                             {
                                clickedDownBottom();
                                row_number = id_number;
                             }
            onRemoveUserRole:
                            {
                                removeUsrRole(ar2en(id_number), tg_name);
                            }
        }
    }

    ListView
    {
        anchors.left: parent.left
        anchors.top: parent.top

        width: parent.width
        height: childrenRect.height

        model: userListModel
        delegate: userDelegate
        interactive: false
    }

    function addUser(name, username, department)
    {
        userListModel.append({list_number: en2ar(userListModel.count+1),
                              list_username: username,list_name: name,
                              dropdown_text: department, tag_flag: 0})
    }

    function addRoleTagF(index)
    {
        var flag = userListModel.get(index).tag_flag;

        if( flag )
        {
            userListModel.get(index).tag_flag = 0;
        }
        else
        {
            userListModel.get(index).tag_flag = 1;
        }
    }

    function setUserDepartment(user_index, user_department)
    {
        userListModel.get(user_index-1).dropdown_text = user_department;
    }
}
