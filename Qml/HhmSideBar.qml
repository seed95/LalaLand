import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle
{
    id: container
    color: "#d7d7d7"

    property string last_searched_text: ""

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

        onChangedFocus:
        {
            if( text==="" )
            {
                email_list.visible = true
                email_search_list.visible = false
            }
            else
            {
                email_list.visible = false
                email_search_list.visible = true
            }
        }

        onSearchDocument:
        {
            if( text==="" )
            {
                email_list.visible = true
                email_search_list.visible = false
            }
            else
            {
                email_list.visible = false
                email_search_list.visible = true
                searchDoc(text)
            }
        }
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
            text: qsTr("الواردة")
            anchors.right: parent.right
            anchors.rightMargin: 28
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontArialBold.name
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
                    if( root.email_mode!==con.id_EMAIL_MODE_INBOX )
                    {
                        root.email_mode = con.id_EMAIL_MODE_INBOX
                        root.selected_doc_case_number = con.id_NO_SELECTED_ITEM
                        searchDoc(last_searched_text)
                    }
                }

            }
        }

        Text
        {
            id: outbox_rtl
            text: qsTr("الصادرة")
            anchors.right: inbox_rtl.left
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontArialBold.name
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
                    if( root.email_mode!==con.id_EMAIL_MODE_OUTBOX )
                    {
                        root.email_mode = con.id_EMAIL_MODE_OUTBOX
                        root.selected_doc_case_number = con.id_NO_SELECTED_ITEM
                        searchDoc(last_searched_text)
                    }
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
                    if( root.email_mode!==con.id_EMAIL_MODE_INBOX )
                    {
                        root.email_mode = con.id_EMAIL_MODE_INBOX
                        root.selected_doc_case_number = con.id_NO_SELECTED_ITEM
                        searchDoc(last_searched_text)
                    }
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
                    if( root.email_mode!==con.id_EMAIL_MODE_OUTBOX )
                    {
                        root.email_mode = con.id_EMAIL_MODE_OUTBOX
                        root.selected_doc_case_number = con.id_NO_SELECTED_ITEM
                        searchDoc(last_searched_text)
                    }
                }

            }
        }

    }

    HhmEmailList
    {
        id: email_list
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
    }

    HhmEmailList
    {
        id: email_search_list
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
        visible: false
    }

    function searchDoc(text)
    {
        last_searched_text = text
        email_search_list.clearEmails()
        email_search_list.addObjects(email_list.searchObject(root.ar2en(text)))
    }

    function addToBox()
    {
        email_list.addToList()
    }

    function finishSync()
    {
        search.finishSync()
    }

    function clearEmails()
    {
        email_list.clearEmails()
        email_search_list.clearEmails()
    }

}
