import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle
{
    id: container
    color: "#d7d7d7"

    Rectangle
    {
        id: rect_logo
        width: parent.width
        height: 100
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
        id: inbox_outbox_rtl
        height: 20
        width: 300
        anchors.top: search.bottom
        anchors.left: parent.left
        color: "#c8c8c8"
        visible: root.rtl

        Text
        {
            id: inbox_rtl
            text: qsTr("دریافتی")
            anchors.right: parent.right
            anchors.rightMargin: 41
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontSansRegular.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color:
            {
                if( root.email_mode===con.id_EMAIL_MODE_INBOX )
                {
                    "#3c598c"
                }
                else if( inbox_rtl.isHovered )
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
                    inbox_rtl.isHovered = true
                }

                onExited:
                {
                    inbox_rtl.isHovered = false
                }

                onClicked:
                {
                    root.email_mode = con.id_EMAIL_MODE_INBOX
                }

            }
        }

        Text
        {
            id: outbox_rtl
            text: qsTr("ارسالی")
            anchors.right: inbox_rtl.left
            anchors.rightMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontSansRegular.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color:
            {
                if( root.email_mode===con.id_EMAIL_MODE_OUTBOX )
                {
                    "#3c598c"
                }
                else if( outbox_rtl.isHovered )
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
                    outbox_rtl.isHovered = true
                }

                onExited:
                {
                    outbox_rtl.isHovered = false
                }

                onClicked:
                {
                    root.email_mode = con.id_EMAIL_MODE_OUTBOX
                }

            }
        }

    }

    Rectangle
    {
        id: inbox_outbox
        height: 20
        width: 300
        anchors.top: search.bottom
        anchors.left: parent.left
        color: "#c8c8c8"
        visible: !root.rtl

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
        anchors.top:
        {
            if( root.rtl )
            {
                inbox_outbox_rtl.bottom
            }
            else
            {
                inbox_outbox.bottom
            }
        }
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
            isActive: case_number===email_content.case_number || case_number===email_content_rtl.case_number
            id_email_in_emails_table: idEmail
            isRead: emailOpened
            text_filepath: docFilepath

            onEmailClicked:
            {
                root.createNewEmail = false
                var obj = email_content
                if( root.rtl )
                {
                    obj = email_content_rtl
                }

                if( obj.case_number===case_number )
                {
                    obj.case_number = con.id_NO_SELECTED_ITEM
                }
                else
                {
                    obj.case_number = case_number
                    obj.text_name = name
                    obj.text_time = time
                    obj.doc_status = docStatus
                    obj.download_filepath = docFilepath
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
        for(var i=0; i<listmodel_sidebar.count; i++)
        {
            if( root.case_number>listmodel_sidebar.get(i).caseNumber )
            {
                listmodel_sidebar.insert(i, {"docSubject" : root.subject,
                                             "name" : root.sender_name,
                                             "caseNumber" : root.case_number,
                                             "docStatus" : root.doc_status,
                                             "time" : root.r_email_date,
                                             "docFilepath" : root.filepath,
                                             "emailOpened" : root.email_opened,
                                             "idEmail" : root.id_email_in_emails_table})
                return
            }
        }
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
