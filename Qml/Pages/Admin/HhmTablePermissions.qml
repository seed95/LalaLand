import QtQuick 2.0

Item
{
    height: 500
    width: 800

    ListModel
    {
        id: contactModel
        ListElement
        {
            list_number: "۱"
            list_name: "المدير التنفيذي"
            list_odd: true
        }
        ListElement
        {
            list_number: "۲"
            list_name: "مدير الإدارة"
            list_odd: false
        }
        ListElement
        {
            list_number: "٣"
            list_name: "مدير مجموعة"
            list_odd: true
        }
    }

    Component
    {
           id: contactDelegate

           HhmTablePermissionsRow
           {
               id_number: list_number
               id_name: list_name
               is_odd: list_odd
           }
    }

    ListView
    {
       anchors.fill: parent
       model: contactModel
       delegate: contactDelegate
   }
}
