import QtQuick 2.0

Rectangle
{
    property string user_name: ""
    signal setUserRole (int user_id, int user_role)

    height: childrenRect.height
    width: 800
    color: "transparent"

    HhmUTableTitle
    {
        id: utable_title
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    HhmUTable
    {
        id: u_table

        anchors.left: utable_title.left
        anchors.top: utable_title.bottom
    }

    function addUser()
    {
        u_table.addUser(user_name)
    }
}
