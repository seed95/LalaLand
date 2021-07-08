import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle
{
    id: container

    property int    boxState:           con.hhm_SIDEBAR_NONE_STATE
    property string selectedMessageId:  con.hhm_NO_SELECTED_MESSAGE//The Qml does not support int64

    property string last_searched_text: ""
    property bool   search_mode: false

    property color color_email_mode_normal:    "#505050"
    property color color_email_mode_hovered:   "#6e6e6e"
    property color color_email_mode_select:    "#3c598c"

    //Cpp Signals
    signal syncInbox()
    signal syncOutbox()
    signal syncMessages()

    //Qml Signals
    signal inboxClicked()
    signal outboxClicked()
    signal selectMessage(string idMessage)
    signal deselectMessage()

    color: "#d7d7d7"
    width: 300
    height: 675

    onBoxStateChanged:
    {
        container.selectedMessageId = con.hhm_NO_SELECTED_MESSAGE
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
            syncMessages()
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
            text: "الواردة"
            anchors.right: parent.right
            anchors.rightMargin: 34
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 11
            color:
            {
                if( container.boxState===con.hhm_SIDEBAR_INBOX_STATE )
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
                    inbox.forceActiveFocus()
                    inboxClicked()
                }

            }
        }

        Text
        {
            id: outbox
            text: "الصادرة"
            anchors.right: inbox.left
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 11
            color:
            {
                if( container.boxState===con.hhm_SIDEBAR_OUTBOX_STATE )
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
                    outbox.forceActiveFocus()
                    outboxClicked()
                }

            }
        }

    }

    HhmMessageList
    {
        id: inbox_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        selectedId: container.selectedMessageId
        objectName: "InboxList"
        visible: container.boxState===con.hhm_SIDEBAR_INBOX_STATE && !search_mode

        onClickMessage:
        {
            handleClickMessage(idMessage)
        }
    }

    HhmMessageList
    {
        id: outbox_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        selectedId: container.selectedMessageId
        objectName: "OutboxList"
        visible: container.boxState===con.hhm_SIDEBAR_OUTBOX_STATE && !search_mode

        onClickMessage:
        {
            handleClickMessage(idMessage)
        }
    }

    HhmMessageList
    {
        id: search_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        selectedId: container.selectedMessageId
        objectName: "SearchList"
        visible: search_mode

        onClickMessage:
        {
            handleClickMessage(idMessage)
            if( container.selectedMessageId!==con.hhm_NO_SELECTED_MESSAGE )
            {
                clickSearchedItem()
            }
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
        if( container.boxState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            syncInbox()
        }
        else if( container.boxState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            syncOutbox()
        }
    }

    function handleClickMessage(idMessage)
    {
        if( container.selectedMessageId===idMessage )
        {
            container.selectedMessageId = con.hhm_NO_SELECTED_MESSAGE
            deselectMessage()
        }
        else
        {
            container.selectedMessageId = idMessage
            selectMessage(idMessage)
        }
    }

    function searchText(text)
    {
        last_searched_text = text
        var match_emails = []
        if( container.boxState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            match_emails = inbox_list.searchObject(root.ar2en(text))
        }
        else if( container.boxState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            match_emails = outbox_list.searchObject(root.ar2en(text))
        }
        search_list.addObjects(match_emails)
    }

    function clickSearchedItem()
    {
        if( container.boxState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            inbox_list.clickItemOnSearch(container.selectedMessageId)
        }
        else if( container.boxState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            outbox_list.clickItemOnSearch(container.selectedMessageId)
        }
    }

    function clearSelectedItem()
    {
        container.selectedMessageId = con.hhm_NO_SELECTED_MESSAGE
    }

    function signOut()
    {
        clearSelectedItem()
        inbox_list.clearList()
        outbox_list.clearList()
        search_list.clearList()
    }
}
