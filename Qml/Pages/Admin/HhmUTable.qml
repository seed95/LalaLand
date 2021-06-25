import QtQuick 2.0

Item
{
    width: 850
    height: 420

    ListModel
    {
        id: contactModel
        ListElement
        {
            list_number: "۱"
            list_username: "m.ebrahim"
            list_name: "ابراهيم محمد"
            list_odd: false
        }
        ListElement
        {
            list_number: "٢"
            list_username: "e.mohammad"
            list_name: "محمد ابراهيم"
            list_odd: true
        }
        ListElement
        {
            list_number: "٣"
            list_username: "m.ebrahim"
            list_name: "تاريخ الوارد"
            list_odd: false
        }
    }

    Component
    {
        id: contactDelegate

        HhmUTableRow
        {
            width: parent.parent.width
            height: 30
            id_number: list_number
            id_username: list_username
            id_name: list_name
            is_odd: list_odd
        }
    }

    Rectangle
    {
        width: parent.width
        height: 500
        anchors.left: topTable.left
        anchors.top: topTable.top
        anchors.topMargin: 30
        color: "transparent"

        ListView
        {
            anchors.fill: parent
            model: contactModel
            delegate: contactDelegate
            interactive: false
        }
    }
}
