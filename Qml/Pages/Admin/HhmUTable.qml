import QtQuick 2.0

Rectangle
{
    width: 850
    height: childrenRect.height
    signal stUserRole (int user_id, int user_role)
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

    function addUser(username)
    {
        userListModel.append({list_number: en2ar(userListModel.count+1),list_username: username,list_name:"lolo"})
    }
}
