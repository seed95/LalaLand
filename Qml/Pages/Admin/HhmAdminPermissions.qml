import QtQuick 2.0

Rectangle
{
    height: 500
    width: 800
    color: "transparent"
    signal createPermission(string text_value)
    signal chkBoxChanged(int col_id, int row_id, int val)

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
    }

}
