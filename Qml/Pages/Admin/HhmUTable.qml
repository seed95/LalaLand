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
        id: lm_user
    }

    Component
    {
        id: ld_user

        HhmUTableRow
        {
            id: utable_row

            width: parent.parent.width
            height: 30
            row_index: list_number
            row_user: list_username
            row_name: list_name
            drop_text: dropdown_text
            addTagFlag: tag_flag

            onAddUserRole:
                         {
                            addUsrRole(row_index); //signal send to c++
                            row_number = ar2en(row_index) - 1;
                         }

            onClickedDnBottom:
                             {
                                clickedDownBottom();
                                row_number = row_index;
                             }
            onRemoveUserRole:
                            {
                                removeUsrRole(ar2en(row_index), tg_name);
                            }
        }
    }

    ListView
    {
        anchors.left: parent.left
        anchors.top: parent.top

        width: parent.width
        height: childrenRect.height

        model: lm_user
        delegate: ld_user
        interactive: false
    }

    function addUser(name, username, department)
    {
        lm_user.append({list_number: en2ar(lm_user.count+1),
                              list_username: username,list_name: name,
                              dropdown_text: department, tag_flag: 0});
    }

    function addRoleTagF(index)
    {
        lm_user.get(index).tag_flag = 1;
        lm_user.get(index).tag_flag = 0;
    }

    function setUserDepartment(user_index, user_department)
    {
        lm_user.get(user_index-1).dropdown_text = user_department;
    }

    function removeUserRole(role_name)
    {
        next_tag_text = role_name;

        for( var i=0 ; i<lm_user.count ; i++ )
        {
            lm_user.get(i).tag_flag = -1;
        }

        for( var i=0 ; i<lm_user.count ; i++ )
        {
            lm_user.get(i).tag_flag = 0;
        }
    }
}
