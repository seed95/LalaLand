import QtQuick 2.0

Rectangle
{
    property string permission_name: ""
    height: 500
    width: 800
    color: "transparent"
    signal createPermission(string text_value)
    signal chkBoxChanged(int row_id, int col_id, int val)

    HhmPTableTitles
    {
        id: pTableTitle
        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmPTable
    {
        anchors.left: parent.left
        anchors.leftMargin: 85
        anchors.top: pTableTitle.bottom

        onCheckBoxChanged:
        {
            chkBoxChanged(row_id, col_id, value);
        }

        onCrtePermission:
        {
            createPermission(text_value);
        }
    }


    function addPermission()
    {
        console.log( permission_name );
    }
}
