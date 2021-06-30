import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle
{
    id: container

    property int    emailState:         con.hhm_SIDEBAR_NONE_STATE
    property int    selectedEmailId:    con.hhm_NO_SELECTED_ITEM

    property string last_searched_text: ""
    property bool   search_mode: false

    property color color_email_mode_normal:    "#505050"
    property color color_email_mode_hovered:   "#6e6e6e"
    property color color_email_mode_select:    "#3c598c"

    //Cpp Signals
    signal syncInbox()
    signal syncOutbox()
    signal syncEmails()

    //Qml Signals
    signal inboxClicked()
    signal outboxClicked()
    signal emailClicked(int idSelectedEmail, int idItem)

    color: "#d7d7d7"
    width: 300
    height: 675

    onEmailStateChanged:
    {
        container.selectedEmailId = con.hhm_NO_SELECTED_ITEM
        if( search_mode )
        {
            searchText(last_searched_text)
        }
    }

    HhmSearchDialog
    {
        id: search
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top

        onRefreshClicked:
        {
            syncEmails()
        }

        onSearchDocument:
        {
            if( text==="" )
            {
                search_mode = false
            }
            else
            {
                search_mode = true
                searchText(text)
            }
        }
    }

    Rectangle
    {
        id: inbox_outbox
        height: 20
        width: parent.width
        anchors.top: search.bottom
        anchors.left: parent.left
        color: "#c8c8c8"

        Text
        {
            id: inbox
            text: qsTr("الواردة")
            anchors.right: parent.right
            anchors.rightMargin: 34
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 11
            color:
            {
                if( container.emailState===con.hhm_SIDEBAR_INBOX_STATE )
                {
                    color_email_mode_select
                }
                else if( inbox.isHovered )
                {
                    color_email_mode_hovered
                }
                else
                {
                    color_email_mode_normal
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
                    if( container.emailState!==con.hhm_SIDEBAR_INBOX_STATE )
                    {
                        inboxClicked()
                    }
                }

            }
        }

        Text
        {
            id: outbox
            text: qsTr("الصادرة")
            anchors.right: inbox.left
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 11
            color:
            {
                if( container.emailState===con.hhm_SIDEBAR_OUTBOX_STATE )
                {
                    color_email_mode_select
                }
                else if( outbox.isHovered )
                {
                    color_email_mode_hovered
                }
                else
                {
                    color_email_mode_normal
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
                    if( container.emailState!==con.hhm_SIDEBAR_OUTBOX_STATE )
                    {
                        outboxClicked()
                    }
                }

            }
        }

    }

    HhmEmailList
    {
        id: inbox_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        selectedId: container.selectedEmailId
        objectName: "InboxList"
        visible: container.emailState===con.hhm_SIDEBAR_INBOX_STATE && !search_mode

        onClickEmail:
        {
            if( container.selectedEmailId===idEmail )
            {
                container.selectedEmailId = con.hhm_NO_SELECTED_ITEM
            }
            else
            {
                container.selectedEmailId = idEmail
            }
            emailClicked(container.selectedEmailId, idItem)
        }
    }

    HhmEmailList
    {
        id: outbox_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        selectedId: container.selectedEmailId
        objectName: "OutboxList"
        visible: container.emailState===con.hhm_SIDEBAR_OUTBOX_STATE && !search_mode

        onClickEmail:
        {
            if( container.selectedEmailId===idEmail )
            {
                container.selectedEmailId = con.hhm_NO_SELECTED_ITEM
            }
            else
            {
                container.selectedEmailId = idEmail
            }
            emailClicked(container.selectedEmailId, idItem)
        }
    }

    HhmEmailList
    {
        id: search_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        selectedId: container.selectedEmailId
        objectName: "SearchList"
        visible: search_mode

        onClickEmail:
        {
            if( container.selectedEmailId===idEmail )
            {
                container.selectedEmailId = con.hhm_NO_SELECTED_ITEM
            }
            else
            {
                container.selectedEmailId = idEmail
            }
            emailClicked(container.selectedEmailId, idItem)
            clickSearchedItem()
        }
    }

    /*** Call this function from cpp ***/    
    function finishSync()
    {
        search.finishSync()
    }

    /*** Call this function from qml ***/
    function syncSidebar()
    {
        if( container.emailState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            syncInbox()
        }
        else if( container.emailState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            syncOutbox()
        }
    }

    function searchText(text)
    {
        last_searched_text = text
        var match_emails = []
        if( container.emailState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            match_emails = inbox_list.searchObject(root.ar2en(text))
        }
        else if( container.emailState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            match_emails = outbox_list.searchObject(root.ar2en(text))
        }
        search_list.addObjects(match_emails)
    }

    function clickSearchedItem()
    {
        if( container.emailState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            inbox_list.clickSearchedItem(container.selectedEmailId)
        }
        else if( container.emailState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            outbox_list.clickSearchedItem(container.selectedEmailId)
        }
    }

    function clearSelectedItem()
    {
        container.selectedEmailId = con.hhm_NO_SELECTED_ITEM
    }

    function signOut()
    {
        selectedEmailId = con.hhm_NO_SELECTED_ITEM
        inbox_list.clearList()
        outbox_list.clearList()
        search_list.clearList()
    }
}
