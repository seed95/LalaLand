import QtQuick 2.0

Rectangle
{
    signal stUserRole(int user_id, int user_role)
    signal addUsrRole(int user_id)

    width: 850
    height: childrenRect.height

    color: "blue"


    ListModel
    {
        id: userListModel
    }

    Component
    {
        id: userDelegate

        HhmUTableRow
        {
            width: parent.parent.width
            height: 30
            id_number: list_number
            id_username: list_username
            id_name: list_name

            onAddUserRole:
                         {
                            addUsrRole(id_number)
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

    function addUser(name, username)
    {
        userListModel.append({list_number: en2ar(userListModel.count+1),list_username: username,list_name: name})
    }
}
