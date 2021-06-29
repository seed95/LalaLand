import QtQuick 2.0

Rectangle
{
    width:350
    color: "transparent"
    height: 30
    Rectangle
    {
        id: userTableRowPosition
        width: 296
        height: 24
        color: "#e6e6e6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 47
        anchors.left: parent.left
        border.color: "#969696"
    }

    HhmTag
    {
        tag_text: "الموظف"

        height: 22
        anchors.verticalCenter: userTableRowPosition.verticalCenter
        anchors.right: userTableRowPosition.right
        anchors.rightMargin: 4
    }

    HhmAddBtn
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
//        onSetUserRole:
//        {
//            stUserRole (int user_id, int user_role);
//        }
    }

}
