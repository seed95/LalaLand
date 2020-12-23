import QtQuick 2.0

Item
{
    id: container

    Rectangle
    {
        id: rect_logo
        width: parent.width
        height: 100 * scale_height
        color: "#243554"
        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmSearchDialog
    {
        id: search
        anchors.left: parent.left
        anchors.top: rect_logo.bottom
    }

    ListView
    {
        id: listview_sidebar
        width: parent.width
        anchors.left: parent.left
        anchors.top: search.bottom
        anchors.bottom: parent.bottom
        model: ListModel
        {
            id: listmodel_sidebar
        }

        delegate: HhmSideBarElement
        {
            width: container.width
            text_name: name
            text_content: emailTitle
            text_time: time
        }

    }

    function receivedNewEmail()
    {
        listmodel_sidebar.append({"name" : root.r_email_sender_name,
                                  "emailTitle" : root.r_email_title,
                                  "time" : root.r_email_date})
    }

}
