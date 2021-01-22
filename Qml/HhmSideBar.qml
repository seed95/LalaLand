import QtQuick 2.0
import QtQuick.Controls 2.0

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
                if( root.email_mode===con.id_EMAIL_MODE_INBOX )
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
                    root.email_mode = con.id_EMAIL_MODE_INBOX
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
                if( root.email_mode===con.id_EMAIL_MODE_OUTBOX )
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
                    root.email_mode = con.id_EMAIL_MODE_OUTBOX
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
            text_subject: docSubject
            text_name: name
            case_number: caseNumber
            doc_status: docStatus
            text_time: time
            isActive: case_number===email_content.case_number
            id_email_in_emails_table: idEmail
            isRead: emailOpened
            text_filepath: docFilepath

            onEmailClicked:
            {
                root.createNewEmail = false
                if( email_content.case_number===case_number )
                {
                    email_content.case_number = con.id_NO_SELECTED_ITEM
                }
                else
                {
                    email_content.case_number = case_number
                    email_content.text_name = name
                    email_content.text_time = time
                    email_content.doc_status = docStatus
                    email_content.download_filepath = docFilepath
                }
                emailOpened = true
                root.openEmail(idEmail)
            }
        }

        ScrollBar.vertical: ScrollBar
        {
            background: Rectangle
            {
                width: 6
                anchors.right: parent.right
                anchors.top: parent.top
                color: "#b4b4b4"
            }

            contentItem: Rectangle
            {
                anchors.right: parent.right
                radius: 3
                implicitWidth: 6
                implicitHeight: 400
                color: "#646464"
            }

            policy: ScrollBar.AsNeeded
        }

    }

    function addToBox()
    {
        listmodel_sidebar.append({"docSubject" : root.subject,
                                  "name" : root.sender_name,
                                  "caseNumber" : root.case_number,
                                  "docStatus" : root.doc_status,
                                  "time" : root.r_email_date,
                                  "docFilepath" : root.filepath,
                                  "emailOpened" : root.email_opened,
                                  "idEmail" : root.id_email_in_emails_table})
    }

    function finishSync()
    {
        search.finishSync()
    }

    function clearEmails()
    {
        listmodel_sidebar.clear()
    }

}
