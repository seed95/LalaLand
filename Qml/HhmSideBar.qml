import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    property int id_active_email: -1

    property bool inboxActive: true

    onInboxActiveChanged:
    {
        listmodel_sidebar.clear()
        if(inboxActive)
        {
            root.inboxClicked()
        }
        else
        {
            root.outboxClicked()
        }
    }

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

    Rectangle
    {
        id: inbox_outbox
        height: 20
        width: 300
        anchors.top: search.bottom
        anchors.left: parent.left
        color: "#c8c8c8"

        Text
        {
            id: inbox
            text: "Inbox"
            anchors.left: parent.left
            anchors.leftMargin: 41
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontRobotoBold.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color:
            {
                if(container.inboxActive)
                {
                    "#3c598c"
                }
                else if(inbox.isHovered)
                {
                    "#6e6e6e"
                }
                else
                {
                    "#505050"
                }
            }

            property bool isHovered: false

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered:
                {
                    inbox.isHovered = true
                }

                onExited:
                {
                    inbox.isHovered = false
                }

                onClicked:
                {
                    container.inboxActive = true
                }


            }
        }

        Text
        {
            id: outbox
            text: "Outbox"
            anchors.left: inbox.right
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontRobotoBold.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color:
            {
                if(!container.inboxActive)
                {
                    "#3c598c"
                }
                else if(outbox.isHovered)
                {
                    "#6e6e6e"
                }
                else
                {
                    "#505050"
                }
            }

            property bool isHovered: false

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered:
                {
                    outbox.isHovered = true
                }

                onExited:
                {
                    outbox.isHovered = false
                }

                onClicked:
                {
                    container.inboxActive = false
                }


            }
        }

    }

    ListView
    {
        id: listview_sidebar
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
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
