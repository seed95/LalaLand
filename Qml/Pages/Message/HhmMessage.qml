import QtQuick 2.0
import Qt.labs.settings 1.0

Item
{
    id: container

    property int messageState:  con.hhm_MESSAGE_NONE_STATE
    property int sidebarState:  con.hhm_SIDEBAR_NONE_STATE

    //Cpp Signals
    signal messageClicked(string idMessage)

    Settings
    {
        property alias messageSidebar: container.sidebarState
    }

    HhmMessageAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -10
        anchors.left: parent.left
        objectName: "MessageAction"

        onSendMessageClicked: new_message.sendMessage()

        onViewBackClicked:
        {
            container.messageState = con.hhm_MESSAGE_NONE_STATE
            sidebar.clearSelectedItem()
        }
    }

    HhmMessageSidebar
    {
        id: sidebar
        anchors.top: actions.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        boxState: container.sidebarState
        objectName: "MessageSidebar"

        onInboxClicked:
        {
            container.sidebarState = con.hhm_SIDEBAR_INBOX_STATE
            if( container.messageState!==con.hhm_MESSAGE_NEW_STATE )
            {
                container.messageState = con.hhm_MESSAGE_NONE_STATE
            }
        }

        onOutboxClicked:
        {
            container.sidebarState = con.hhm_SIDEBAR_OUTBOX_STATE
            if( container.messageState!==con.hhm_MESSAGE_NEW_STATE )
            {
                container.messageState = con.hhm_MESSAGE_NONE_STATE
            }
        }

        onSelectMessage:
        {
            messageClicked(idMessage)
        }

        onDeselectMessage:
        {
            container.messageState = con.hhm_MESSAGE_NONE_STATE
        }

    }

    HhmMessageNew
    {
        id: new_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageNew"
        visible: container.messageState===con.hhm_MESSAGE_NEW_STATE
    }

    HhmMessageView
    {
        id: view_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageView"
        visible: container.messageState===con.hhm_MESSAGE_VIEW_STATE
    }

    /*** Call this function from cpp ***/
    function successfullySend()
    {
        //Check if a message selected, state changed to hhm_MESSAGE_VIEW_STATE
        container.messageState = con.hhm_MESSAGE_NONE_STATE
    }

    function showMessage()
    {
        container.messageState = con.hhm_MESSAGE_VIEW_STATE
    }

    /*** Call this functions from qml ***/
    function signOut()
    {
        container.messageState = con.hhm_MESSAGE_NONE_STATE
        sidebar.signOut()
    }


}
