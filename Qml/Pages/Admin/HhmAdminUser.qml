import QtQuick 2.0

Rectangle
{
    property string user_name: ""
    signal setUserRole (int user_id, int user_role)

    height: 500
    width: 800
    color: "transparent"

    HhmUTableTitle
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 90
    }

    HhmUTable
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: parent.top
        anchors.topMargin: 90
    }

    function addUser()
    {
        console.log( user_name );
    }

}
