import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    property int id_active_email: -1

    Rectangle
    {
        id: rect_logo
        width: parent.width
        height: 100 * scale_height
        color: "#243554"
        anchors.left: parent.left
        anchors.top: parent.top

        Image
        {
            id: image_logo
            anchors.centerIn: parent
            source: "qrc:/logo.png"
        }

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
        clip: true

        delegate: HhmSideBarElement
        {
            width: container.width
            text_subject: subject
            text_name: name
            case_number: caseNumber
            doc_status: docStatus
            text_time: time
            isActive: case_number === id_active_email

            onEmailClicked:
            {
                id_active_email = case_number
                root.showEmailContent(text_name, text_time, doc_status)
            }
        }

        ScrollBar.vertical: ScrollBar
        {
            policy: ScrollBar.AsNeeded
        }

    }

    function addToInbox()
    {
        listmodel_sidebar.append({"subject" : root.subject,
                                  "name" : root.sender_name,
                                  "caseNumber" : root.case_number,
                                  "docStatus" : root.doc_status,
                                  "time" : root.r_email_date})
    }

    function isEmailSelected()
    {
        return id_active_email !== -1
    }

    function finishSync()
    {
        search.finishSync()
    }

}
